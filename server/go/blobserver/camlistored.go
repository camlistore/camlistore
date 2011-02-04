// Copyright 2010 Brad Fitzpatrick <brad@danga.com>
//
// See LICENSE.

package main

import (
	"camli/auth"
	"camli/httputil"
	"camli/webserver"
	"camli/blobserver"
	"camli/blobserver/localdisk"
	"camli/blobserver/handlers"
	"flag"
	"fmt"
	"http"
	"log"
	"strings"
	"os"
)

var flagStorageRoot *string = flag.String("root", "/tmp/camliroot", "Root directory to store files")
var flagRequestLog *bool = flag.Bool("reqlog", false, "Log incoming requests")

var storage blobserver.Storage

const camliPrefix = "/camli/"
const partitionPrefix = "/partition-"

var InvalidCamliPath = os.NewError("Invalid Camlistore request path")

func parseCamliPath(path string) (partition blobserver.Partition, action string, err os.Error) {
	camIdx := strings.Index(path, camliPrefix)
	if camIdx == -1 {
		err = InvalidCamliPath
		return
	}
	action = path[camIdx+len(camliPrefix):]
	if camIdx == 0 {
		return
	}
	if !strings.HasPrefix(path, partitionPrefix) {
		err = InvalidCamliPath
		return
	}
	name := path[len(partitionPrefix):camIdx]
	if !isValidPartitionName(name) {
		err = InvalidCamliPath
		return
	}
	partition = blobserver.Partition(name)
	return
}

func pickPartitionHandlerMaybe(req *http.Request) (handler http.HandlerFunc, intercept bool) {
	if !strings.HasPrefix(req.URL.Path, partitionPrefix) {
		intercept = false
		return
	}
	return http.HandlerFunc(handleCamli), true
}

func unsupportedHandler(conn http.ResponseWriter, req *http.Request) {
        httputil.BadRequestError(conn, "Unsupported camlistore path or method.")
}

func handleCamli(conn http.ResponseWriter, req *http.Request) {
	partition, action, err := parseCamliPath(req.URL.Path)
	if err != nil {
		log.Printf("Invalid request for method %q, path %q", 
			req.Method, req.URL.Path)
		unsupportedHandler(conn, req)
		return
	}

	handler := unsupportedHandler
	if *flagRequestLog {
		log.Printf("method %q; partition %q; action %q", req.Method, partition, action)
	}
	switch req.Method {
	case "GET":
		switch action {
		case "enumerate-blobs":
			handler = auth.RequireAuth(handlers.CreateEnumerateHandler(storage, partition))
		default:
			handler = handlers.CreateGetHandler(storage)
		}
	case "POST":
		switch action {
		case "preupload":
			handler = auth.RequireAuth(handlers.CreatePreUploadHandler(storage))
		case "upload":
			handler = auth.RequireAuth(handlers.CreateUploadHandler(storage))
		case "remove":
			// Currently only allows removing from a non-main partition.
			handler = auth.RequireAuth(handlers.CreateRemoveHandler(storage, partition))
		}
	case "PUT": // no longer part of spec
		handler = auth.RequireAuth(handlers.CreateNonStandardPutHandler(storage))
	}
	handler(conn, req)
}

func handleRoot(conn http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(conn, "<html><body>This is camlistored, a <a href='http://camlistore.org'>Camlistore</a> storage daemon.</body></html>\n")
}

func exitFailure(pattern string, args ...interface{}) {
	if !strings.HasSuffix(pattern, "\n") {
		pattern = pattern + "\n"
	}
	fmt.Fprintf(os.Stderr, pattern, args...)
	os.Exit(1)
}

func main() {
	flag.Parse()

	auth.AccessPassword = os.Getenv("CAMLI_PASSWORD")
	if len(auth.AccessPassword) == 0 {
		exitFailure("No CAMLI_PASSWORD environment variable set.")
	}

	rootPrefix := func(s string) bool {
		return strings.HasPrefix(*flagStorageRoot, s)
	}

	switch {
	case *flagStorageRoot == "":
		exitFailure("No storage root specified in --root")
	case rootPrefix("s3:"):
		// TODO: support Amazon, etc.
	default:
		var err os.Error
		storage, err = localdisk.New(*flagStorageRoot)
		if err != nil {
			exitFailure("Error for --root of %q: %v", *flagStorageRoot, err)
		}
	}

	if storage == nil {
		exitFailure("Unsupported storage root type %q", *flagStorageRoot)
	}

	ws := webserver.New()
	ws.RegisterPreMux(webserver.HandlerPicker(pickPartitionHandlerMaybe))
	ws.HandleFunc("/", handleRoot)
	ws.HandleFunc("/camli/", handleCamli)
	ws.Handle("/js/", http.FileServer("../../clients/js", "/js/"))
	ws.Serve()
}

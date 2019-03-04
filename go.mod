module perkeep.org

require (
	bazil.org/fuse v0.0.0-20160811212531-371fbbdaa898
	cloud.google.com/go v0.0.0-20161006024015-b70ccc799b9d
	github.com/FiloSottile/b2 v0.0.0-20170207175032-b197f7a2c317
	github.com/aws/aws-sdk-go v1.14.31
	github.com/bradfitz/latlong v0.0.0-20140711231157-b74550508561
	github.com/cznic/fileutil v0.0.0-20180108211300-6a051e75936f
	github.com/cznic/internal v0.0.0-20170905175358-4747030f7cf2
	github.com/cznic/kv v0.0.0-20170515202733-892ccf731fb7
	github.com/cznic/lldb v1.1.0
	github.com/cznic/mathutil v0.0.0-20180214153908-5455a562bccb
	github.com/cznic/sortutil v0.0.0-20150617083342-4c7342852e65
	github.com/cznic/zappy v0.0.0-20160723133515-2533cb5b45cc
	github.com/edsrzf/mmap-go v0.0.0-20170320065105-0bce6a688712
	github.com/fsnotify/fsnotify v1.4.2
	github.com/garyburd/go-oauth v0.0.0-20180319155456-bca2e7f09a17
	github.com/go-ini/ini v1.38.1
	github.com/go-sql-driver/mysql v1.4.1-0.20180719071942-99ff426eb706
	github.com/golang/protobuf v1.0.0
	github.com/golang/snappy v0.0.0-20170215233205-553a64147049
	github.com/googleapis/gax-go v0.0.0-20161107002406-da06d194a00e
	github.com/gorilla/websocket v1.2.0
	github.com/hjfreyer/taglib-go v0.0.0-20151027170453-0ef8bba9c41b
	github.com/inconshreveable/mousetrap v1.0.0
	github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8
	github.com/kardianos/osext v0.0.0-20151222153229-29ae4ffbc9a6
	github.com/kisielk/gotool v0.0.0-20161130080628-0de1eaf82fa3
	github.com/kr/fs v0.1.0
	github.com/lib/pq v0.0.0-20130607063955-9afcd9aa7931
	github.com/mailgun/mailgun-go v0.0.0-20171127222028-17e8bd11e87c
	github.com/mattn/go-mastodon v0.0.0-20180129050910-2ccbcfe14d7a
	github.com/mattn/go-sqlite3 v1.6.0
	github.com/miekg/dns v0.0.0-20161003181808-3f1f7c8ec9ea
	github.com/neelance/astrewrite v0.0.0-20160511093645-99348263ae86
	github.com/neelance/sourcemap v0.0.0-20151028013722-8c68805598ab
	github.com/nf/cr2 v0.0.0-20140528043846-05d46fef4f2f
	github.com/pkg/errors v0.8.0
	github.com/pkg/sftp v0.0.0-20180419200840-5bf2a174b604
	github.com/plaid/plaid-go v0.0.0-20161222051224-02b6af68061b
	github.com/russross/blackfriday v2.0.0+incompatible
	github.com/rwcarlsen/goexif v0.0.0-20180518182100-8d986c03457a
	github.com/shurcooL/httpfs v0.0.0-20171119174359-809beceb2371
	github.com/shurcooL/sanitized_anchor_name v0.0.0-20150515002706-11a20b799bf2
	github.com/spf13/cobra v0.0.0-20160322171042-c678ff029ee2
	github.com/spf13/pflag v0.0.0-20151218134703-7f60f83a2c81
	github.com/syndtr/goleveldb v0.0.0-20180608030153-db3ee9ee8931
	github.com/tgulacsi/picago v0.0.0-20171229130838-9e1ac2306c70
	github.com/tomnomnom/linkheader v0.0.0-20160328204959-6953a30d4443
	go4.org v0.0.0-20190218023631-ce4c26f7be8e
	golang.org/x/crypto v0.0.0-20180723164146-c126467f60eb
	golang.org/x/image v0.0.0-20171214225156-12117c17ca67
	golang.org/x/net v0.0.0-20171212005608-d866cfc389ce
	golang.org/x/oauth2 v0.0.0-20171226133531-197281d4e0ec
	golang.org/x/sync v0.0.0-20171101214715-fd80eb99c8f6
	golang.org/x/sys v0.0.0-20180115085844-fff93fa7cd27
	golang.org/x/text v0.0.0-20171102192421-88f656faf3f3
	golang.org/x/time v0.0.0-20160202183820-a4bde1265759
	golang.org/x/tools v0.0.0-20170915040203-e531a2a1c15f
	google.golang.org/api v0.0.0-20170327174102-48e49d1645e2
	google.golang.org/appengine v1.0.0
	google.golang.org/genproto v0.0.0-20161115011420-08f135d1a31b
	google.golang.org/grpc v1.14.0 // indirect
	gopkg.in/mgo.v2 v2.0.0-20160818020120-3f83fa500528
	honnef.co/go/js/dom v0.0.0-20160310112645-24aa052bc5c6
	rsc.io/pdf v0.0.0-20170302045715-1d34785eb915
	rsc.io/qr v0.1.0
)

replace google.golang.org/grpc v1.14.0 => github.com/bradfitz/grpc-go v0.0.0-20170203184515-188a132adcfba339f1f2d5da52498451341f9ee8

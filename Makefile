# Name of the binary
BINARY=example

# Build Information
VERSION=0.0.1
BUILD=$(shell date -u '+%Y-%m-%d')

# Some Paths
CWD=$(shell pwd)
GOAPP=$(CWD)/server
SERVER=github.com/sstutz/go-elm-example/server
ELMAPP=$(CWD)/client
DISTDIR=$(CWD)/dist
RELEASE=$(BINARY).$(BUILD).tar.gz

# interpolate variable values
LDFLAGS=-ldflags "-X $(SERVER)/commands.Version=$(VERSION) -X $(SERVER)/commands.Build=$(BUILD)"

.PHONY: client server

all: client server release checksums

deps:
	go get -u github.com/GeertJohan/go.rice
	go get -u github.com/GeertJohan/go.rice/rice
	go get -u github.com/wellington/wellington/wt

server:
	cd $(GOAPP) && rice embed-go
	GOOS=linux	GOARCH=amd64	go build $(LDFLAGS) -o $(DISTDIR)/linux/amd64/$(BINARY)		$(SERVER)
	GOOS=darwin	GOARCH=amd64	go build $(LDFLAGS) -o $(DISTDIR)/darwin/amd64/$(BINARY)	$(SERVER)

release:
	tar zcvf $(DISTDIR)/linux/amd64/$(RELEASE)	LICENSE README.md -C $(DISTDIR)/linux/amd64/	$(BINARY)
	tar zcvf $(DISTDIR)/darwin/amd64/$(RELEASE)	LICENSE README.md -C $(DISTDIR)/darwin/amd64/	$(BINARY)

client:
	cd $(ELMAPP) && mkdir -p dist/js  && elm-make src/Main.elm --output dist/js/elm.js
	cd $(ELMAPP) && mkdir -p dist/css && wt -b dist/css compile assets/scss/style.scss
	cp -r client/assets/images/ client/dist/

checksums:
	cd $(DISTDIR)/linux/amd64/	&& sha256sum $(RELEASE) > $(BINARY).sha256
	cd $(DISTDIR)/darwin/amd64/	&& sha256sum $(RELEASE) > $(BINARY).sha256

clean:
	if [ -d $(ELMAPP)/dist ]; then rm -rf $(ELMAPP)/dist; fi
	if [ -d $(DISTDIR) ]; then rm -rf $(DISTDIR); fi

todo:
	grep --color=always -rwn "TODO" $(GOAPP) $(ELMAPP)/src

fixme:
	grep --color=always -rwn "FIXME" $(GOAPP) $(ELMAPP)/src

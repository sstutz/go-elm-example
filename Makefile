# Name of the binary
BINARY=example

# Build Information
VERSION=0.0.1
BUILD=$(shell date -u '+%Y-%m-%d')

# Some Paths
CWD=$(shell pwd)
GOAPP=$(CWD)/server
ELMAPP=$(CWD)/client
DISTDIR=$(CWD)/dist
RELEASE=$(BINARY).$(BUILD).tar.gz

# extend gopath to include our server
GOPATH:=$(GOPATH):$(GOAPP)

# interpolate variable values
LDFLAGS=-ldflags "-X main.Version=$(VERSION) -X main.Build=$(BUILD)"

.PHONY: client server

all: client server release checksums

deps:
	go get -u github.com/GeertJohan/go.rice
	go get -u github.com/GeertJohan/go.rice/rice
	go get -u github.com/wellington/wellington/wt

server:
	cd $(GOAPP) && rice embed-go
	GOOS=linux	GOARCH=amd64	go build $(LDFLAGS) -o $(DISTDIR)/linux/amd64/$(BINARY) github.com/sstutz/go-elm-example/server
	GOOS=darwin	GOARCH=amd64	go build $(LDFLAGS) -o $(DISTDIR)/darwin/amd64/$(BINARY) github.com/sstutz/go-elm-example/server

release:
	tar zcvf $(DISTDIR)/linux/amd64/$(RELEASE) LICENSE README.md -C $(DISTDIR)/linux/amd64/ $(BINARY)
	tar zcvf $(DISTDIR)/darwin/amd64/$(RELEASE) LICENSE README.md -C $(DISTDIR)/darwin/amd64/ $(BINARY)

client:
	cd $(ELMAPP) && mkdir -p dist/js  && elm-make src/Main.elm --output dist/js/elm.js
	cd $(ELMAPP) && mkdir -p dist/css && wt -b dist/css compile assets/scss/style.scss
	cp -r client/assets/images/ client/dist/

checksums:
	cd $(DISTDIR)/linux/amd64/ && sha256sum $(RELEASE) > $(BINARY).sha256
	cd $(DISTDIR)/darwin/amd64/ && sha256sum $(RELEASE) > $(BINARY).sha256

clean:
	if [ -f $(GOAPP)/$(BINARY) ]; then rm $(GOAPP)/$(BINARY); fi
	if [ -d $(ELMAPP)/dist ]; then rm -rf $(ELMAPP)/dist; fi
	if [ -d $(DISTDIR) ]; then rm -rf $(DISTDIR); fi

todo:
	grep -rwn "TODO" $(GOAPP) $(ELMAPP)

fixme:
	grep -rwn "FIXME" $(GOAPP) $(ELMAPP)

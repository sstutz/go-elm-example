# Name of the binary
BINARY=example

# Build Information
VERSION=0.0.1
BUILD=$(shell date -u '+%Y-%m-%d_%I%M%S')

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

all: client server release

server:
	cd $(GOAPP) && GOPATH=$(GOPATH) go build $(LDFLAGS) -o $(BINARY)

release:
	mkdir -p $(DISTDIR)
	cp -r $(GOAPP)/$(BINARY) $(DISTDIR)/$(BINARY)
	cp -r $(GOAPP)/public $(GOAPP)/templates $(DISTDIR)/
	cp LICENSE README.md $(DISTDIR)/
	tar zcvf $(RELEASE) $(DISTDIR)
	mv $(RELEASE) $(DISTDIR)

client:
	mkdir -p $(GOAPP)/public/js
	cd $(ELMAPP) && elm-make src/elm/Main.elm --output $(GOAPP)/public/js/elm.js

clean:
	if [ -f $(GOAPP)/$(BINARY) ]; then rm $(GOAPP)/$(BINARY); fi
	if [ -d $(GOAPP)/public ]; then rm -rf $(GOAPP)/public; fi
	if [ -d $(DISTDIR) ]; then rm -rf $(DISTDIR); fi

todo:
	grep -rwn "TODO" $(GOAPP) $(ELMAPP)

fixme:
	grep -rwn "FIXME" $(GOAPP) $(ELMAPP)

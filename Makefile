CF_FLAGS=--verbose
DOCKER=docker
BUILDFLAGS+=--build-arg VCS_REF=`git rev-parse --short HEAD`
BUILDFLAGS+=--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

RUNFLAGS=--rm
VERSION=$(shell git describe --tags --abbrev=0)
OWNER=bahamat
IMAGE=authenticated-proxy

all: build

build:
	docker build $(BUILDFLAGS) -t="$(OWNER)/$(IMAGE):$(VERSION)" .

run: build
	docker run $(RUNFLAGS) -p 8080:80 "${OWNER}/$(IMAGE):$(VERSION)"

shell: build
	docker run $(RUNFLAGS) -it -e TERM=xterm --entrypoint /bin/ash "${OWNER}/$(IMAGE):$(VERSION)"

runv: build
	docker run $(RUNFLAGS) -p 8080:80 -v `pwd`:/data "$(OWNER)/$(IMAGE):$(VERSION)"

publish: build
	docker tag bahamat/authenticated-proxy:$(VERSION) bahamat/authenticated-proxy:latest
	docker push bahamat/authenticated-proxy:$(VERSION)
	docker push bahamat/authenticated-proxy:latest

kill:
	docker kill `docker ps -q` || echo nothing to kill
	docker rm -f `docker ps -a -q` || echo nothing to clean

clean: kill
	docker rmi "$(OWNER)/$(IMAGE):$(VERSION)" || echo no image to remove

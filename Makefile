CF_FLAGS=--verbose
DOCKER=docker
BUILDFLAGS=
RUNFLAGS=--rm
VERSION=0.1
OWNER=bahamat
IMAGE=authenticated-proxy
WITH_MASTERFILES=
WITH_SKETCHES=

ifneq ($(WITH_MASTERFILES),)
	RUNFLAGS:=$(RUNFLAGS) -e WITH_MASTERFILES=$(WITH_MASTERFILES) -v $(WITH_MASTERFILES):/var/cfengine/masterfiles
endif

ifneq ($(WITH_SKETCHES),)
	RUNFLAGS:=$(RUNFLAGS) -e WITH_SKETCHES=$(WITH_SKETCHES) -v $(WITH_SKETCHES):/var/cfengine/design-center/sketches
endif

RUNFLAGS:=$(RUNFLAGS) -e CF_FLAGS=$(CF_FLAGS)

all: build

build:
	docker build $(BUILDFLAGS) -t="$(OWNER)/$(IMAGE):$(VERSION)" .

run: build
	docker run $(RUNFLAGS) -p 8080:80 "${OWNER}/$(IMAGE):$(VERSION)"

shell: build
	docker run $(RUNFLAGS) -it "${OWNER}/$(IMAGE):$(VERSION)" /bin/bash

runv: build
	docker run $(RUNFLAGS) -v `pwd`:/data "$(OWNER)/$(IMAGE):$(VERSION)"

kill:
	docker kill `docker ps -q` || echo nothing to kill
	docker rm -f `docker ps -a -q` || echo nothing to clean

clean: kill
	docker rmi "$(OWNER)/$(IMAGE):$(VERSION)" || echo no image to remove

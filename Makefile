.PHONY: build push run FORCE dub all

RUNAS = root
LOCALPORT = 80
BUILD = release
TAG = lionello/vibeweb
SOURCE = $(wildcard source/* public/* views/*)

dub:
	dub

build: Dockerfile dub.json $(SOURCE)
	docker build --build-arg RUNAS=$(RUNAS) --build-arg BUILD=$(BUILD) --tag $(TAG) .

public/GITHEAD: FORCE
	git describe --match=NeVeRmAtCh --always --abbrev=40 --dirty >$@

run: build
	docker run --env DEBUG=1 --env HTTP_PLATFORM_PORT=$(LOCALPORT) --publish 8080:$(LOCALPORT) $(TAG)

push: build
	docker push $(TAG)

FORCE:

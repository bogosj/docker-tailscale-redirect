check-env:
ifndef TS_VERSION
	$(error TS_VERSION is undefined)
endif

build: check-env
	docker build -t ghcr.io/bogosj/tailscale-redirect:$(TS_VERSION) --build-arg TS_VERSION=$(TS_VERSION) .
	docker tag ghcr.io/bogosj/tailscale-redirect:$(TS_VERSION) ghcr.io/bogosj/tailscale-redirect:latest

deploy: build
	docker push ghcr.io/bogosj/tailscale-redirect:$(TS_VERSION)
	docker push ghcr.io/bogosj/tailscale-redirect:latest
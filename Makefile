include .env
export

SHELL := /bin/bash

.PHONY: build release

build:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--push \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

release: build


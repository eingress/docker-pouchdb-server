include .env
export

SHELL := /bin/bash

.PHONY: build release

build:
	docker buildx build \
		--build-arg NODE_IMAGE_VERSION=$$NODE_IMAGE_VERSION \
		--load \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

release:
	docker buildx build \
		--build-arg NODE_IMAGE_VERSION=$$NODE_IMAGE_VERSION \
		--platform linux/amd64,linux/arm64 \
		--push \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "  1. make run         - start aosp9 docker image"
	@echo "  2. make build       - build the aosp9 image"
	@echo "  3. make release     - release the aosp9 image"

build:
	@docker build --tag=erwinchang/aosp-900 .

release:
	@docker build --tag=erwinchang/aosp-900:$(shell cat VERSION) .


.PHONY: all dependencies install test dev

MAIN := $(PWD)/src/application.cr

all: install

dependencies:
	crystal deps install

install: dependencies
	crystal build $(MAIN)

	mv application bin/firegrid

test:
	crystal spec
	crystal tool format --check src spec

dev:
	crystal run $(MAIN)

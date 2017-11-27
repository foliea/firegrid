.PHONY: all dependencies install dev

MAIN := $(PWD)/src/application.cr

all: install

dependencies:
	crystal deps update

install: dependencies
	crystal build $(MAIN)

	mv application bin/firegrid

dev:
	crystal run $(MAIN)

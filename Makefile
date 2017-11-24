.PHONY: all install build dev

VENDOR_PATH := $(PWD)/vendor/voidcsfml

CONFIG_TARGET_PATH := $(HOME)/.config/firegrid

MAIN := $(PWD)/src/application.cr

crystal := LIBRARY_PATH=$(VENDOR_PATH) LD_LIBRARY_PATH=$(VENDOR_PATH) crystal

all: install build

install:
	rm -rf $(CONFIG_TARGET_PATH)
	ln -s $(PWD)/config $(CONFIG_TARGET_PATH)

build:
	$(crystal) build $(MAIN)

	mv application bin/firegrid

dev:
	$(crystal) run $(MAIN)

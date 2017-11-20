.PHONY: all install run

VENDOR_PATH := $(PWD)/vendor/voidcsfml

CONFIG_TARGET_PATH := $(HOME)/.config/firegrid

all: install run

install:
	rm -rf $(CONFIG_TARGET_PATH)
	ln -s $(PWD)/config $(CONFIG_TARGET_PATH)

run:
	scrot -e 'mv $$f /tmp/firegrid.png'
	LIBRARY_PATH=$(VENDOR_PATH) \
	LD_LIBRARY_PATH=$(VENDOR_PATH) \
	crystal run src/application.cr

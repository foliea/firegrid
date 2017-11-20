.PHONY: all run

VENDOR_PATH := $(PWD)/vendor/voidcsfml

all: run

run:
	scrot -e 'mv $$f /tmp/firegrid.png'
	LIBRARY_PATH=$(VENDOR_PATH) \
	LD_LIBRARY_PATH=$(VENDOR_PATH) \
	crystal run src/application.cr

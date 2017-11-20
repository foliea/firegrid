.PHONY: all run

LIBRARY_PATH := $(PWD)/vendor/voidcsfml

LD_LIBRARY_PATH := $(LIBRARY_PATH)

all: run

run:
	scrot -e 'mv $$f /tmp/firegrid.png'
	crystal run src/application.cr

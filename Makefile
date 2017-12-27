.PHONY: all re clean dependencies install test dev

MAIN := $(PWD)/src/firegrid.cr

BINARY := bin/firegrid

all: dependencies install

re: clean all

dependencies:
	crystal deps install

install:
	crystal build --release $(MAIN) -o $(BINARY)

test:
	crystal spec
	crystal tool format --check src spec

dev:
	crystal run $(MAIN)

clean:
	rm -f $(BINARY)

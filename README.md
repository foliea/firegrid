## Firegrid
[![Build Status](https://travis-ci.org/foliea/firegrid.svg?branch=master)](https://travis-ci.org/foliea/firegrid)

Click anywhere with only a few keystrokes!

## Installation

### On Archlinux

Firegrid is available in the AUR: [firegrid](https://aur.archlinux.org/packages/firegrid)

You can install it using `makepkg` like this:

    $ git clone https://aur.archlinux.org/firegrid.git
    $ cd firegrid
    $ makepkg -si
    $ cd ..
    $ rm -r firegrid

Or you could use an AUR helper:

    $ yaourt -S firegrid

### Build from sources

To build firegrid from sources, you only need [Docker](https://www.docker.com).

Run the following command:

    $ sh scripts/build.sh

You will then find the firegrid binary in the `bin` directory:

    $ ./bin/firegrid

## Development

To hack on firegrid, you can run a [Docker](https://www.docker.com) container
with every dependency required to build, run the application and launch the test
suite:

    $ sh scripts/hack.sh

> N.b: If you get the following error: `QXcbConnection: Could not connect to display`,
you need to install [xhost](https://www.x.org/archive/X11R6.8.1/doc/xhost.1.html) and run
the following command: `xhost +` before running the script.

Inside the container you can:
* Build the binary with: `make`
* Compile and run the application with: `make dev`
* Launch the test suite with: `make test`

## Contributing

Before sending a pull request, please checkout the contribution
[guidelines](/CONTRIBUTING.md).

## Authors
* [Adrien Folie](https://github.com/foliea) - Creator / Maintainer.

## Licensing

Firegrid is licensed under the MIT License. See [LICENSE](LICENSE) for full
license text.

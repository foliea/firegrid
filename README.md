## Firegrid
[![Build Status](https://travis-ci.org/foliea/firegrid.svg?branch=master)](https://travis-ci.org/foliea/firegrid)

Firegrid strives to make pointer-driven interfaces easier and faster for users to operate.
It allows you to move the pointer and click quickly to most points on the screen with only a few key strokes.

### How so?
You select a piece of the screen. The sceen is initialy entirely covered with a grid. Each key will
select a square of the grid and create another grid inside. Once a selected square is precise enough,
the mouse pointer will move to the square center and a mouse click will be triggered.

<img src="/images/grid-large.png" width="350"/>

More images [here](/images).

### Is it fast?
On most screens, three key strokes will trigger a click. The initial grid format is calculated
according to the screen ratio, which means that two screens with the same ratio will get the same
grid (e.g a 1080p and a 4k screen) and the same number of required key strokes.

### Supported platforms
Firegrid only works on Linux in X11. Firegrid is written with [Qt 5](https://www.qt.io/) so it should not be hard to port it in Wayland or even over MacOS / Windows.

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

e.g: With [yaourt](https://archlinux.fr/yaourt-en)

    $ yaourt -S firegrid

### Build from sources

To build firegrid from sources, you only need [Docker](https://www.docker.com).

Run the following command:

    $ sh scripts/build.sh

You will then find the firegrid binary in the `bin` directory:

    $ ./bin/firegrid

## Configuration

Firegrid configuration file resides either in `$HOME/.config/firegrid/firegrid.toml` or `$HOME/.firegrid.toml`.

A sample of the configuration file is available [here](/config/firegrid.toml).

This file must follow the [TOML](https://github.com/toml-lang/toml) specification.

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
* Install crystal shards: `make dependencies`
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

#!/bin/sh
set -e

image_name="firegrid-hack"

docker build -t $image_name .

docker run -ti \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $PWD:/firegrid \
    -e DISPLAY=unix$DISPLAY \
    $image_name

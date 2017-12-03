#!/bin/sh
set -e

image_name="firegrid-build"

docker build -t $image_name .
docker run -ti $image_name /bin/sh -c "make"

container_id=$(docker ps -l -q)

docker cp $container_id:/firegrid/bin/firegrid ./bin/

#!/bin/bash
set -e
cd "$(dirname "$0")/.."

IMG="ghcr.io/mpepping/dotfiles:latest"

docker build . -t $IMG -f tests/Dockerfile.test --force-rm
docker run --rm -it $IMG
docker rmi $IMG

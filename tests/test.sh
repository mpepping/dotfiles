#!/bin/bash
set -e
cd "$(dirname "$0")/.."

docker build . -t dotfiles -f tests/Dockerfile.test --force-rm
docker run --rm -it dotfiles
docker rmi dotfiles

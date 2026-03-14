#!/bin/bash
set -e
REPO="$(git rev-parse --show-toplevel)"

CRT="docker"
IMG="ghcr.io/mpepping/dotfiles:latest"

cd "$REPO"

"$CRT" build . -t $IMG -f tests/Dockerfile.test --force-rm
"$CRT" run --rm -it $IMG
"$CRT" rmi $IMG

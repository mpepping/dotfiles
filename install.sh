#!/bin/bash

# Bash
ln -sf ~/dotfiles/cfg/.bashrc ~ 
ln -sf ~/dotfiles/cfg/.bash ~

# Git
ln -sf ~/dotfiles/cfg/.gitconfig ~
ln -sf ~/dotfiles/cfg/.gitignore ~

# APT
echo
echo "** Installing apt packages"
sudo -n apt-get update
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends fzf vim jq

# GitHub CLI
echo
echo "** Downloading GitHub CLI"
curl -s https://api.github.com/repos/cli/cli/releases/latest \
  | jq '.assets[] | select(.name | endswith("_linux_amd64.deb")).browser_download_url' \
  | xargs curl -O -L

sudo -n dpkg -i ./gh_*.deb
rm ./gh_*.deb

echo
echo "** Done"
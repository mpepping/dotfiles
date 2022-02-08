#!/bin/bash

DOTPATH="/workspaces/.codespaces/.persistedshare/dotfiles"

# Bash
ln -sf "${DOTPATH}/cfg/.bash" ~
ln -sf "${DOTPATH}/cfg/.bashrc" ~/.bash_aliases # Cheating a bit here to inject my stuff
ln -sf "${DOTPATH}/cfg/.fzf.bash" ~

# Git
ln -sf "${DOTPATH}/cfg/.gitconfig" ~
ln -sf "${DOTPATH}/cfg/.gitignore" ~

# APT
echo
echo "** Installing apt packages"
sudo -n apt-get update
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends bat colordiff fzf jq vim

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

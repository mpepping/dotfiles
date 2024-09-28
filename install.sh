#!/bin/bash

set -eo pipefail

# shellcheck source=/dev/null
source /etc/os-release

# Check the container type
if [[ -n $CODESPACES ]]; then
  echo "** Running in Codespaces"
  DOTPATH="/workspaces/.codespaces/.persistedshare/dotfiles"
else
  echo "** Running in a Dev Container or test env."
  DOTPATH="${HOME}/dotfiles"
fi

# Link dotfiles
ln -sf "${DOTPATH}/cfg/.bashrc.d" ~
ln -sf "${DOTPATH}/cfg/.bashrc" ~/.bash_aliases # Cheating a bit here to inject stuff on ubuntu
ln -sf "${DOTPATH}/cfg/.fzf.bash" ~

# Link these dotfiles only if running in Codespaces
if [[ -n $CODESPACES ]]; then
  ln -sf "${DOTPATH}/cfg/.gitconfig" ~
  ln -sf "${DOTPATH}/cfg/.gitignore" ~
fi

# Setup and install packages for Debian/Ubuntu, Alpine, or EL

setup_debian() {
  echo
  echo "** Installing apt packages"
  sudo -n apt-get update
  sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends bat colordiff fzf jq vim

  # GitHub CLI
  echo
  echo "** Downloading GitHub CLI"

  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
}

setup_alpine() {
  echo
  echo "** Installing apk packages"
  sudo -n apk --no-cache add bash bat colordiff fzf jq vim
}

setup_redhat() {
  echo
  echo "** Installing rpm packages"
  sudo -n dnf install -y bat colordiff fzf jq vim

  # GitHub CLI
  echo
  echo "** Downloading GitHub CLI"
  sudo dnf install 'dnf-command(config-manager)'
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install -y gh
}

# Run the setup function for the current OS
case "$ID" in
  debian|ubuntu)
    setup_debian
    ;;
  alpine)
    setup_alpine
    ;;
  redhat|centos|fedora)
    setup_redhat
    ;;
  *)
    echo
    echo "No configuration for $PRETTY_NAME ($ID)"
    ;;
esac

echo
echo "** Done"

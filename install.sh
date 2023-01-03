#!/bin/bash

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
ln -sf "${DOTPATH}/cfg/.bash" ~
ln -sf "${DOTPATH}/cfg/.bashrc" ~/.bash_aliases # Cheating a bit here to inject my stuff
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
  curl -s https://api.github.com/repos/cli/cli/releases/latest \
    | jq '.assets[] | select(.name | endswith("_linux_amd64.deb")).browser_download_url' \
    | xargs curl -O -L

  sudo -n dpkg -i ./gh_*.deb
  rm -f ./gh_*.deb
}

setup_alpine() {
  echo
  echo "** Installing apk packages"
  sudo -n apk --no-cache add bat colordiff fzf jq vim
}

setup_el() {
  echo
  echo "** Installing rpm packages"
  sudo -n dnf install -y bat colordiff fzf jq vim

  # GitHub CLI
  echo
  echo "** Downloading GitHub CLI"
  curl -s https://api.github.com/repos/cli/cli/releases/latest \
    | jq '.assets[] | select(.name | endswith("_linux_amd64.rpm")).browser_download_url' \
    | xargs curl -O -L

  sudo -n rpm -Uvh ./gh_*.rpm
  rm -f ./gh_*.rpm
}

# Run the setup function for the current OS
case "$ID" in
  debian|ubuntu)
    setup_debian
    ;;
  alpine)
    setup_alpine
    ;;
  redhat|centos)
    setup_el
    ;;
  *)
    echo
    echo "No configuration for $PRETTY_NAME ($ID)"
    ;;
esac

echo
echo "** Done"

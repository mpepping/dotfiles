# dotfiles

Personal dotfiles for GitHub Codespaces and VS Code devcontainers.

* <https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles>

## For use with GitHub Codespaces

Codespaces automatically picks up `install.sh`.

## For use with VS Code devcontainers

Configure VS Code to use the dotfiles repository, so that it will be picked up by new devcontainers.

```lang=json
{
  "dotfiles.repository": "mpepping/dotfiles",
  "remote.containers.dotfiles.repository": "mpepping/dotfiles",
  "terminal.integrated.env.linux": {
    "GIT_COMMITTER_NAME": "Your Name",
    "GIT_COMMITTER_EMAIL": "your@email.com",
    "GIT_AUTHOR_NAME": "Your Name",
    "GIT_AUTHOR_EMAIL": "your@email.com"
  }
}

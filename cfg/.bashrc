. ~/.bash/alias
. ~/.bash/functions
. ~/.bash/env
. ~/.bash/app/git

if [ -f ~/.bash/local ]; then
  . ~/.bash/local
fi

# Prevents "update_terminal_cwd: command not found" errors in VS Code
update_terminal_cwd ()
{
    local SEARCH=' ';
    local REPLACE='%20';
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}";
    printf '\e]7;%s\a' "$PWD_URL"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
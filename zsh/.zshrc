DISABLE_MAGIC_FUNCTIONS=true
DISABLE_AUTO_TITLE="true"
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="minimal"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_profile
eval "$(zoxide init zsh)"

source ~/.local/share/omakub/defaults/bash/shell
source ~/.local/share/omakub/defaults/bash/aliases
source ~/.local/share/omakub/defaults/bash/functions

alias git-list-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}"'
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'

alias luamake=/home/adam/personal/lua-language-server/3rd/luamake/luamake
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export OMAKUB_PATH=$HOME/.local/share/omakub

eval "$(~/.local/bin/mise activate zsh)"

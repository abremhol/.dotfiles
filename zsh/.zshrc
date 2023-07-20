DISABLE_MAGIC_FUNCTIONS=true
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="minimal"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_profile

alias luamake=/home/adam/personal/lua-language-server/3rd/luamake/luamake
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

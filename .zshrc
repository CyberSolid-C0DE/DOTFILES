
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/chef/.zshrc'

autoload -Uz compinit
compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(oh-my-posh init zsh --config ~/Documents/chefzsh.json)"
source /home/chef/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# Chefs Edits 


export SUDO_EDITOR=/usr/bin/nvim
alias sedit=sudoedit

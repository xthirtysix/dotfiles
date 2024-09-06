####################################################
# Amazon Q pre block. Keep at the top of this file #
####################################################
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
export TERM=xterm-256color-italic
export PATH="$PATH:$HOME/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/opt/homebrew/bin"
export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/src"
export PATH="$PATH:$HOME/.spoof-dpi/bin"

#######
# nvm #
#######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########
# pnpm #
########
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

#################
# sfdx & sf cli #
#################
eval SFDX_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/sfdx/autocomplete/zsh_setup && test -f $SFDX_AC_ZSH_SETUP_PATH && source $SFDX_AC_ZSH_SETUP_PATH;
eval SF_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/sf/autocomplete/zsh_setup && test -f $SF_AC_ZSH_SETUP_PATH && source $SF_AC_ZSH_SETUP_PATH;

############################
# created by Zap installer #
############################
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "Aloxaf/fzf-tab"                           # Replaces zsh tab autocompletion with fzf
plug "zsh-users/zsh-autosuggestions"            # Suggests input completion
plug "zsh-users/zsh-syntax-highlighting"        # Highlights valid/invalid input
plug "zap-zsh/vim"                              # Uses vim navigation
plug "zpm-zsh/tmux"                             # Autolaunch TMux
plug "wintermi/zsh-starship"

###########
# aliases #
###########
alias vim="nvim"
alias ls="eza -l --icons -TL1 --git" 
alias cat="bat --style plain"

eval $(/opt/homebrew/bin/brew shellenv)
eval $(thefuck --alias)
eval $(starship init zsh)
eval ___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
eval $(thefuck --alias)

##############################
# tabtab source for packages #
##############################
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

########################################################
# Amazon Q post block. Keep at the bottom of this file #
########################################################
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

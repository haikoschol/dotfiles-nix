[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

setopt SHARE_HISTORY
setopt extended_glob

if [[ $(uname) = "Darwin" ]]; then
  fpath=("$HOME/.dotfiles/home/zsh/completions" /opt/homebrew/share/zsh/site-functions $fpath)
else
  fpath=("$HOME/.dotfiles/home/zsh/completions" $fpath)
fi

autoload -Uz compinit
compinit -u

HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=$SAVEHIST

# PROMPT="%F{yellow}%1~%f%F{green}$ %f"

# function gsw() {
#   local search="${*:-}"
#   if [[ -n "$search" ]]; then
#     git branch --format "%(refname:short)" \
#       | fzf -i -1 --preview 'git log --oneline {}' --query "$search" \
#       | xargs git switch
#   else
#     git branch --format "%(refname:short)" \
#       | fzf -i -1 --preview 'git log --oneline {}' \
#       | xargs git switch
#   fi
# }

# export EDITOR=vim
# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"
# export FZF_DEFAULT_OPTS="--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f2:toggle-preview'"

# if [[ $(uname) == "Darwin" ]]; then
#   export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
#   export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
# else
#   export TERM=xterm
# fi

# export PATH="$HOME/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

bindkey -e

[[ -f $HOME/.creds.zsh ]] && source $HOME/.creds.zsh

if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
  bindkey "∫" backward-word
  bindkey "ƒ" forward-word
  bindkey "∂" delete-word
fi

source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PATH="$PATH:/Users/haiko/Library/Application Support/JetBrains/Toolbox/scripts"

# alias ll='lsd -la'
# alias sweep-cargo='cargo sweep --toolchains $(rustup default | cut -d " " -f 1) -r'

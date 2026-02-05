HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

autoload -Uz vcs_info
setopt PROMPT_SUBST

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

precmd() { vcs_info }

PROMPT='%F{245}%~%f %# '
RPROMPT='%F{109}${vcs_info_msg_0_}%f %F{240}%*%f'

export ZINIT_HOME="$HOME/.zinit"
source "$ZINIT_HOME/bin/zinit.zsh"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey -v

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# source <(fzf --zsh)
# export FZF_DEFAULT_COMMAND="fzf --height 40% --tmux bottom,40% --border top --layout reverse --preview 'head {+}' --color='preview-border:-1' --highlight-line --preview-label='preview'"

typeset -U path
path=(
	$HOME/.local/bin
	$HOME/.local/go/bin
	$path
)


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

autoload -Uz compinit
compinit -c



export LESS_TERMCAP_mb=$'\e[1;31m' # start bold red
export LESS_TERMCAP_md=$'\e[1;38;5;74m' # start bold cyan
export LESS_TERMCAP_me=$'\e[0m' # end all modes
export LESS_TERMCAP_se=$'\e[0m' # end standout-mode
export LESS_TERMCAP_so=$'\e[01;44;33m' # start standout-mode - info box
export LESS_TERMCAP_us=$'\e[1;32m' # start underline green
export LESS_TERMCAP_ue=$'\e[0m' # end underline

# opencode
export PATH=/home/ak/.opencode/bin:$PATH

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
# Make backspace work reliably in vi mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
bindkey -M vicmd '^H' backward-delete-char



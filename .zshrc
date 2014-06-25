export PATH=/bin:/opt/bin:/sbin:/usr/bin:/usr/local/bin:$HOME/bin:$PATH
export EDITOR=vim
export RUBYOPT=''

export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
eval "$(rbenv init -)"

# Vim key bind
bindkey -v

# autoloads
autoload -Uz compinit
compinit

autoload -Uz colors
colors

# Complement
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt AUTO_PARAM_SLASH

# Set option
setopt auto_list
setopt list_packed
setopt list_types
setopt auto_pushd
setopt no_beep
setopt notify

# Prompt
PROMPT="%{${fg[cyan]}%}%n%(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

# History
setopt EXTENDED_HISTORY
setopt hist_ignore_all_dups
HISTTIMEFORMAT="[%M/%D %H:%M:%S]"
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# For Japanese
export LANG=ja_JP.UTF-8
setopt print_eight_bit

# Set title
case "${TERM}" in
  kterm*|xterm*|)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}\007"
    }
    ;;
esac

# Tmux auto atach
if which tmux 2>&1 >/dev/null; then
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Aliases
alias ls='ls -a --color'
alias ll='ls -la --color'
alias bi='bundle install --path vendor/bundle'
alias be='bundle exec'

alias emerge='sudo emerge'
alias docker='sudo docker'

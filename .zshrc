setopt autocd
bindkey -e

export EDITOR="vim"

PATH="$HOME/bin:$PATH"

PROMPT="%n@%m%% "
RPROMPT="[%~]"

#history file
HISTFILE=$HOME/.zsh_history
HISTSIZE=500
SAVEHIST=500

#alias
alias c="cd"
alias vf="cd"
alias sl="ls"
alias ks="ls"
alias mkae="make"
alias grpe="grep"
alias g="mvim"
alias gdiff="git diff $* | mvim -"
alias tag="ctags -R *$1"
alias timestamp="date +%Y%m%d%H%M"
alias datestamp="date +%Y%m%d"
alias flushdns="dscacheutil -flushcache"
alias gradle="sh ./gradlew"

#completion
autoload -U compinit
compinit
#completers
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

#colorize ls
case `uname -s` in
    FreeBSD)
        alias ls='ls -G'
        ;;
    Linux)
        alias ls='ls --color=tty'
        ;;
esac

#x terminal title
case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
        precmd () {
            print -Pn "\033]0;%n@%m : %~\007"
        }
        preexec () {
            print -Pn "\033]0;%n@%m : <$1>\007"
        }
        ;;
esac

BOXEN_ENV=/opt/boxen/env.sh
if [[ -f $BOXEN_ENV ]]; then
  source $BOXEN_ENV
fi

setopt autocd
setopt complete_aliases
bindkey -e

EDITOR="vim"
PROMPT="%n@%m%% "
RPROMPT="[%~]"

#history file
HISTFILE=$HOME/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

#alias
alias c="cd"
alias s="git status"
alias d="git diff"
alias vf="cd"
alias sl="ls"
alias ks="ls"
alias mkae="make"
alias rkae="rake"
alias grpe="grep"
alias gti="git"
alias g="mvim"
alias tag="ctags -R *$1"
alias timestamp="date +%Y%m%d%H%M"
alias datestamp="date +%Y%m%d"
alias flushdns="dscacheutil -flushcache"
alias gradle="sh ./gradlew"
alias unmerged="git ls-files --unmerged | cut -f2 | sort -u"
alias json="python -m json.tool"
alias ip="ifconfig en0 | grep inet | grep netmask | cut -d ' ' -f 2 | tr -d '\n' | pbcopy"
alias rf="rspec --only-failures"
alias rt="find spec -name '*_spec.rb' -print0 | xargs -0 stat -f '%m %N' | sort -rn | head -1 | cut -d ' ' -f 2 | xargs bundle exec rspec"
alias password="openssl rand -base64 6"

gdiff() { git diff $@ | mvim - }
glog() { git log $@ | mvim - }
ggrep() { git grep -l $@ | xargs mvim }

autoload -Uz compinit && compinit
zstyle ':completion:*' completer _expand _complete _approximate

#colorize ls
case `uname -s` in
    FreeBSD) ;&
    Darwin)
        alias ls='ls -G' ;;
    Linux)
        alias ls='ls --color=tty' ;;
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

  fpath=($HOMEBREW_ROOT/share/zsh/site-functions $fpath)
  source $HOMEBREW_ROOT/share/zsh/site-functions/_aws

  export JAVA_HOME=$(/usr/libexec/java_home)
  export SSL_CERT_FILE=$HOMEBREW_ROOT/etc/openssl/cert.pem
fi

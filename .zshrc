setopt autocd
setopt complete_aliases
bindkey -e

EDITOR="vim"
PROMPT="%n@%m%% "
RPROMPT="[%~]"

#history file
HISTFILE=$HOME/.zsh_history
HISTSIZE=8192
SAVEHIST=8192
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

#alias
alias c="cd"
alias d="git diff"
alias g="mvim"
alias k="kubectl"
alias s="git status"
alias gb="gradle build"
alias gg="git grep"
alias ggl="git grep -l"
alias vf="cd"
alias sl="ls"
alias ks="ls"
alias cn="code -n ."
alias mkae="make"
alias rkae="rake"
alias grpe="grep"
alias gti="git"
alias tag="ctags -R *$1"
alias kmux="pgrep mux\] | xargs kill"
alias timestamp="date +%Y%m%d%H%M"
alias datestamp="date +%Y%m%d"
alias flushdns="dscacheutil -flushcache"
alias unmerged="git ls-files --unmerged | cut -f2 | sort -u"
alias json="python -m json.tool"
alias web="python -m SimpleHTTPServer"
alias ip="ifconfig en0 | grep inet | grep netmask | cut -d ' ' -f 2 | tr -d '\n' | pbcopy"
alias rf="rspec --only-failures"
alias rt="find spec -name '*_spec.rb' -print0 | xargs -0 stat -f '%m %N' | sort -rn | head -1 | cut -d ' ' -f 2 | xargs bundle exec rspec"
alias password="openssl rand -base64 6"
alias hotspot="git log --format=format: --name-only | grep -v '^$' | sort | uniq -c | sort -r"

dim() { printf "\e[8;$2;$1t" }
xg() { xargs mvim }
xgs() { xargs mvim -o }
gdiff() { git diff $@ | mvim - }
glog() { git log $@ | mvim - }
ggrep() { git grep -l $@ | xargs mvim }
gfgrep() { git ls-files | grep --color=auto $@ }

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
    *xterm*|rxvt|ansi|(dt|k|E)term)
        precmd () {
            print -Pn "\033]0;%n@%m : %~\007"
        }
        preexec () {
            print -Pn "\033]0;%n@%m : <$1>\007"
        }
        ;;
esac

export DOTNET_CLI_TELEMETRY_OPTOUT=1

if (( $+commands[hub] )); then
    eval "$(hub alias -s)"
fi

if (( $+commands[pyenv] )); then
    eval "$(pyenv init -)"
fi

if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi

for file in $HOME/.zshrc.*; do
    source $file
done

setopt autocd
setopt complete_aliases
bindkey -e

export EDITOR="vim"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
PROMPT="%n@%m%% "
RPROMPT="[%~]"

#history file
HISTFILE=$HOME/.zsh_history
HISTSIZE=8192
SAVEHIST=8192
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

case `uname -s` in
    FreeBSD) ;&
    Darwin)
        export LSCOLORS="Fa"
        alias ls='ls -G'
        export GUI_EDITOR="mvim" ;;
    Linux)
        alias ls='ls --color=tty'
        export GUI_EDITOR="gvim" ;;
esac

#alias
alias c="cd"
alias d="git diff"
alias g="$GUI_EDITOR"
alias s="git status"
alias gb="gradle build"
alias gg="git grep"
alias gp="git pull"
alias sd="git status && git diff"
alias gpr="git pull --rebase"
alias ggl="git grep -l"
alias vf="cd"
alias sl="ls"
alias ks="ls"
alias mk="minikube"
alias mkae="make"
alias rkae="rake"
alias grpe="grep"
alias gti="git"
alias tag="ctags -R *$1"
alias kmux="pgrep mux\] | xargs kill"
alias chrome="open -a 'Google Chrome'"
alias vargant="vagrant"
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

b() { bazel build ${1:-...} }
t() { bazel test ${1:-...} }
ap() { awk "{print \$$1}" }
cn() { code -n ${1:-.} }
cne() { code -n ${1:-.} && exit }
cdg () { cd $(git rev-parse --show-toplevel) }
dim() { printf "\e[8;${2:-24};${1:-80}t" }
xg() { xargs $GUI_EDITOR }
xgs() { xargs $GUI_EDITOR -o }
gdiff() { git diff $@ | $GUI_EDITOR - }
glog() { git log $@ | $GUI_EDITOR - }
gfgrep() { git ls-files | grep --color=auto $@ }

export ZSH_EVAL_CACHE="$HOME/.cache/zsh"
mkdir -p "$ZSH_EVAL_CACHE"

function _eval() {
    local file="$ZSH_EVAL_CACHE/$1.zsh"

    if [ ! -s "$file" ]; then
        if (( $+commands[$1] )); then
            "$@" > "$file"
        else
            return
        fi
        
    fi

    source "$file"
}

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zstyle ':completion:*' completer _expand _complete _approximate

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

_eval hub alias -s
_eval pyenv init -
_eval rbenv init -
_eval nodenv init -
_eval kops completion zsh
_eval kind completion zsh
_eval velero completion zsh
_eval kubectl completion zsh

if (( $+commands[dotnet] )); then
    _dotnet_zsh_complete()
    {
        local completions=("$(dotnet complete "$words")")
        reply=( "${(ps:\n:)completions}" )
    }

    compctl -K _dotnet_zsh_complete dotnet
fi

if (( $+commands[kubectl] )); then
    alias k="kubectl"
    alias kc="kubectl config current-context"
    alias kgn="k get nodes"
    alias ksn="k config set-context --current --namespace $1"
fi

for file in $HOME/.zshrc.*(N.); do
    if [[ "$file" == *.bak ]]; then continue; fi
    source $file
done


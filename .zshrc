# load zgen
source "${HOME}/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # completions & highlight
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/colored-man-pages
    #zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/cabal

    # theme
    zgen oh-my-zsh themes/af-magic-ct

    # save all to init script
    zgen save
fi


# Custom options
setopt extended_glob
#unsetopt correct_all
unsetopt correct

function exists {
  type $1 2>&1 > /dev/null
  local exist=$?
  if [[ exist -ne 0 ]]; then
    echo "$1 not found"
  fi
  return $exist
}

if exists keychain && [[ $UID -ne 0 ]]; then
    eval `keychain --nogui --eval id_rsa id_ed25519 -q`
fi

# Custom alias
if exists xsel; then
  alias toclip='xsel -b -i'
  alias fromclip='xsel -b -o'
fi

if exists nvim; then
  alias vim='nvim'
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

# tmux version < 2.0 set ixon => freeze on ctrl+s
alias tmux='tmux -2'

alias gg='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gst='git status'
alias gss='git status -s'
alias gsb='git status -sb'

alias glgg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

alias p='ping google.com'
alias mu='_ mount -o gid=users,fmask=113,dmask=002'

# Custom variables
for dir in ~/.cabal/bin ~/bin; do
    if [[ -d $dir ]]; then
        export PATH=$dir:$PATH
    fi
done
typeset -U path

export GROFF_NO_SGR=1  # allow colored manual

# Disable C-s / C-q on terminal
stty -ixon

bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down

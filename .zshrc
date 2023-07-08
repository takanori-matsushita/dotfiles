# autoload -Uz compinit && compinit

# history settings
export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history

# alias settings
## docker
alias dc='docker-compose'

## ghq peco hub
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

## git
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gf='git fetch'
alias gl='git log'
alias gop='git open'
alias gpo='git push origin'
alias gpoh='git push origin HEAD'
alias gpom='git push origin master'
alias gr='git restore'
alias gra='git remote add origin'
alias grs='git remote set-url origin'
alias gs='git switch'
alias gsc='git switch -c'
alias gss='git status'

# tmux
alias tas='tmux attach-session -t'
alias tks='tmux kill-server'
alias tkss='tmux kill-session -t'
alias tl='tmux ls'
alias tns='tmux new -s'

# export PATH
export PATH="/Users/matsushitatakanori/.composer/vendor/bin:$PATH" # composer
export PATH="$PATH:$HOME/development/flutter/bin" # flutter
# php 7.4.0
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH" # openssl
export PATH="/usr/local/opt/bzip2/bin:$PATH" # bzip2
export PKG_CONFIG_PATH="/usr/local/opt/krb5/lib/pkgconfig:/usr/local/opt/icu4c/lib/pkgconfig:/usr/local/opt/libedit/lib/pkgconfig:/usr/local/opt/libjpeg/lib/pkgconfig:/usr/local/opt/libpng/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:/usr/local/opt/libzip/lib/pkgconfig:/usr/local/opt/oniguruma/lib/pkgconfig:/usr/local/opt/openssl@1.1/lib/pkgconfig:/usr/local/opt/tidy-html5/lib/pkgconfig"
export PHP_BUILD_CONFIGURE_OPTS="--with-bz2=/usr/local/opt/bzip2 --with-iconv=/usr/local/opt/libiconv"

# peco settings
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

#powerline settings
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi

# Source Prezto. 補完が見やすくなる
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# tmux 自動起動
# [[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

##########################################################
#
#  hyper.js settings 
#
##########################################################

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
tabtitle_precmd() {
  if overridden; then return; fi
  pwd=$(pwd) # Store full path as variable
  cwd=${pwd##*/} # Extract current working dir only
  print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions tabtitle_precmd)

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
tabtitle_preexec() {
  if overridden; then return; fi
  printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions tabtitle_preexec)

. /usr/local/opt/asdf/libexec/asdf.sh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# zinit plugins
zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit ice wait'!0'; zinit load zsh-users/zsh-completions # 補完
zinit ice wait'!0'; zinit load zsh-users/zsh-autosuggestions # 履歴補完サジェスト
zinit ice wait'!0'; zinit load zsh-users/zsh-history-substring-search # 履歴補完強化
zinit ice wait'!0'; zinit load paulirish/git-open # git openで作業ディレクトリのwebリポジトリを開ける
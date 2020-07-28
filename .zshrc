# anyenvパス
eval "$(anyenv init -)"

# alias settings
## docker
alias dc='docker-compose'

## git
alias ga='git add'
alias gbd='git branch -d'
alias bgD='git branch -D'
alias gbm='git branch -m'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gf='git fetch'
alias gl='git log'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gr='git restore'
alias gra='git remote add origin'
alias grs='git remote set-url origin'
alias gs='git switch'
alias gsc='git switch -c'
alias gss='git status'

# export PATH
export PATH="/Users/matsushitatakanori/.composer/vendor/bin:$PATH" # composer
export PATH="$PATH:$HOME/development/flutter/bin" # flutter

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
zplug "b-ryan/powerline-shell"

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in ${precmd_functions[@]}; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# tmux 自動起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

#_zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
# zinit plugins
zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit ice wait'!0'; zinit load zsh-users/zsh-completions # 補完
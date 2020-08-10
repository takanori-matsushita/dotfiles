# makeコマンドのみを叩いた際に実行される
.DEFAULT_GOAL := help

install:
	@echo 'mattsunのdotfilesをご利用いただきありがとうございます'
	@echo 'dotfileやアプリを自動でインストールします'
	@echo 'インストールにはしばらく時間がかかりますので今しばらくお待ち下さい'
	brew
	mkdir ~/development
	ln -s ~/dotfiles/.zshrc ~/.zshrc \
	&& ln -s  ~/dotfiles/.vimrc ~/.vimrc \
	&& ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf \
	&& ln -s ~/dotfiles/.config/powerline-shell/config.json ~/.config/powerline-shell/config.json
	anyenv ghq flutter powerline tmux vscode zinit zprezto

brew: #brew settings
	brew update \
	&& brew upgrade \
	&& brew cask upgrade \
	&& brew bundle

anyenv: #anyenv settings
	echo y | anyenv install --init \
	&& bin/bash -c $("mkdir -p $(anyenv root)/plugins") \
	&& bin/bash -c $("git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update") \
	&& bin/bash -c $("git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git") \
	&& anyenv update \
	&& anyenv git pull \
	&& anyenv install goenv \
	&& anyenv install nodenv \
	&& anyenv install phpenv \
	&& anyenv install pyenv \
	&& anyenv install rbenv \
	&& anyenv install tfenv

flutter:
	cd ~/development \
	&& curl -o flutter.zip -OL https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.5-stable.zip \
	&& unzip flutter.zip \
	&& rm -rf flutter.zip \
	&& flutter precache

ghq:
	git config --global ghq.root ~/src \
	&& ghq get git://github.com/project.git

powerline:
	git clone https://github.com/b-ryan/powerline-shell \
	&& cd ~/powerline-shell \
	&& python setup.py install \
	&& git clone https://github.com/powerline/fonts.git \
	&& cd fonts \
	&& ./install.sh

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

vscode:
	code --install-extension aaron-bond.better-comments
	code --install-extension akamud.vscode-theme-onedark
	code --install-extension bmewburn.vscode-intelephense-client
	code --install-extension bung87.vscode-gemfile
	code --install-extension christian-kohler.path-intellisense
	code --install-extension chrmarti.regex
	code --install-extension CoenraadS.bracket-pair-colorizer
	code --install-extension CraigMaslowski.erb
	code --install-extension cssho.vscode-svgviewer
	code --install-extension Dart-Code.dart-code
	code --install-extension Dart-Code.flutter
	code --install-extension donjayamanne.githistory
	code --install-extension eamodio.gitlens
	code --install-extension ecmel.vscode-html-css
	code --install-extension emilast.LogFileHighlighter
	code --install-extension felixfbecker.php-debug
	code --install-extension formulahendry.auto-close-tag
	code --install-extension formulahendry.auto-rename-tag
	code --install-extension foxundermoon.shell-format
	code --install-extension groksrc.ruby
	code --install-extension Hridoy.rails-snippets
	code --install-extension IBM.output-colorizer
	code --install-extension jock.svg
	code --install-extension kaiwood.endwise
	code --install-extension lacroixdavid1.vscode-format-context-menu
	code --install-extension manasxx.background-cover
	code --install-extension mechatroner.rainbow-csv
	code --install-extension mhutchie.git-graph
	code --install-extension mikestead.dotenv
	code --install-extension mosapride.zenkaku
	code --install-extension ms-azuretools.vscode-docker
	code --install-extension MS-CEINTL.vscode-language-pack-ja
	code --install-extension ms-vsliveshare.vsliveshare
	code --install-extension octref.vetur
	code --install-extension oderwat.indent-rainbow
	code --install-extension onecentlin.laravel5-snippets
	code --install-extension PKief.material-icon-theme
	code --install-extension pranaygp.vscode-css-peek
	code --install-extension rebornix.ruby
	code --install-extension ritwickdey.LiveServer
	code --install-extension SirTobi.code-clip-ring
	code --install-extension streetsidesoftware.code-spell-checker
	code --install-extension syler.sass-indented
	code --install-extension vscode-icons-team.vscode-icons
	code --install-extension waderyan.gitblame
	code --install-extension wingrunr21.vscode-ruby
	code --install-extension wmaurer.change-case
	code --install-extension xabikos.JavaScriptSnippets

zinit:
	echo y | curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh

zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

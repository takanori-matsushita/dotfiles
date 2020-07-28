# makeコマンドのみを叩いた際に実行される
.DEFAULT_GOAL := help

install:
	@echo 'mattsunのdotfilesをご利用いただきありがとうございます'
	@echo 'dotfileやアプリを自動でインストールします'
	@echo 'インストールにはしばらく時間がかかりますので今しばらくお待ち下さい'
	mkdir ~/development

brew: #brew settings
	brew update \
	&& brew upgrade \
	&& brew cask upgrade \
	&& brew bundle

anyenv: #anyenv settings
	echo y | anyenv install --init
	mkdir -p $(anyenv root)/plugins
	git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
	git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git
	anyenv update
	anyenv git pull
	anyenv install goenv
	anyenv install nodenv
	anyenv install phpenv
	anyenv install pyenv
	anyenv install rbenv
	anyenv install tfenv

flutter:
	cd ~/development
	curl -o flutter.zip -OL https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.5-stable.zip
	unzip flutter.zip
	rm -rf flutter.zip
	flutter precache

ghq:
	git config --global ghq.root ~/src
	ghq get git://github.com/project.git

powerline:
	pip install psutil
	pip install powerline-shell
	git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

zinit:
	echo y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

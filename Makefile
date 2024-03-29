# makeコマンドのみを叩いた際に実行される
.DEFAULT_GOAL := help

install: message brew ricty anyenv shell vscode laravel flutter

message:
	@echo 'mattsunのdotfilesをご利用いただきありがとうございます'
	@echo 'dotfileやアプリを自動でインストールします'
	@echo 'インストールにはしばらく時間がかかりますので今しばらくお待ち下さい'

link:
	mkdir ~/development \
	&& ln -s ~/dotfiles/.zshrc ~/.zshrc \
	&& ln -s ~/dotfiles/.vimrc ~/.vimrc \
	&& ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json \
	&& ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

shell: powerline tmux zinit zprezto

brew: #brew settings
	brew update \
	&& brew upgrade \
	&& brew bundle

anyenv: #anyenv settings
	echo y | anyenv install --init \
	&& mkdir -p ~/.anyenv/plugins \
	&& git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update \
	&& git clone https://github.com/znz/anyenv-git.git ~/.anyenv/plugins/anyenv-git \
	&& git clone https://github.com/rugamaga/anyenv-tfenv-init.git ~/.anyenv/plugins/anyenv-tfenv-init \
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
	&& sudo gem install cocoapods \
	&& flutter precache \
	&& yes | flutter doctor --android-licenses

ghq:
	git config --global ghq.root ~/src \
	&& ghq get git://github.com/project.git

laravel:
	composer global require laravel/installer friendsofphp/php-cs-fixer

powerline:
	git clone https://github.com/b-ryan/powerline-shell ~/powerline-shell \
	&& cd ~/powerline-shell \
	&& python setup.py install \
	&& git clone https://github.com/powerline/fonts.git \
	&& cd fonts \
	&& ./install.sh \
	&& mkdir ~/.config/powerline-shell \
	&& ln -s ~/dotfiles/.config/powerline-shell/config.json ~/.config/powerline-shell/config.json

ricty:
	brew reinstall ricty --with-powerline
	cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	fc-cache -vf

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

vscode:
	code --install-extension 42Crunch.vscode-openapi
	code --install-extension aaron-bond.better-comments
	code --install-extension abusaidm.html-snippets
	code --install-extension adpyke.vscode-sql-formatter
	code --install-extension adrianverdugo.buefy-snippet
	code --install-extension akamud.vscode-theme-onedark
	code --install-extension angelorafael.jsx-html-tags
	code --install-extension antonholmberg.remove-bg
	code --install-extension Arjun.swagger-viewer
	code --install-extension astro-build.astro-vscode
	code --install-extension bmewburn.vscode-intelephense-client
	code --install-extension bung87.vscode-gemfile
	code --install-extension christian-kohler.path-intellisense
	code --install-extension chrmarti.regex
	code --install-extension CraigMaslowski.erb
	code --install-extension csstools.postcss
	code --install-extension dariofuzinato.vue-peek
	code --install-extension Dart-Code.dart-code
	code --install-extension Dart-Code.flutter
	code --install-extension dbaeumer.vscode-eslint
	code --install-extension demijollamaxime.bulma
	code --install-extension donjayamanne.githistory
	code --install-extension dsznajder.es7-react-js-snippets
	code --install-extension eamodio.gitlens
	code --install-extension ecmel.vscode-html-css
	code --install-extension EditorConfig.EditorConfig
	code --install-extension emilast.LogFileHighlighter
	code --install-extension esbenp.prettier-vscode
	code --install-extension formulahendry.auto-close-tag
	code --install-extension formulahendry.auto-rename-tag
	code --install-extension foxundermoon.shell-format
	code --install-extension github.vscode-github-actions
	code --install-extension golang.go
	code --install-extension GraphQL.vscode-graphql
	code --install-extension GraphQL.vscode-graphql-execution
	code --install-extension GraphQL.vscode-graphql-syntax
	code --install-extension groksrc.ruby
	code --install-extension hediet.vscode-drawio
	code --install-extension hollowtree.canvas-snippets
	code --install-extension Hridoy.rails-snippets
	code --install-extension IBM.output-colorizer
	code --install-extension intellsmi.comment-translate
	code --install-extension jock.svg
	code --install-extension junstyle.php-cs-fixer
	code --install-extension kaiwood.endwise
	code --install-extension lacroixdavid1.vscode-format-context-menu
	code --install-extension manasxx.background-cover
	code --install-extension mechatroner.rainbow-csv
	code --install-extension MehediDracula.php-namespace-resolver
	code --install-extension mhutchie.git-graph
	code --install-extension mikestead.dotenv
	code --install-extension mosapride.zenkaku
	code --install-extension ms-azuretools.vscode-docker
	code --install-extension MS-CEINTL.vscode-language-pack-ja
	code --install-extension ms-vscode-remote.remote-containers
	code --install-extension ms-vscode-remote.remote-ssh
	code --install-extension ms-vscode-remote.remote-ssh-edit
	code --install-extension ms-vscode-remote.remote-wsl
	code --install-extension ms-vscode.remote-explorer
	code --install-extension ms-vscode.remote-server
	code --install-extension ms-vsliveshare.vsliveshare
	code --install-extension msjsdiag.vscode-react-native
	code --install-extension neilbrayfield.php-docblocker
	code --install-extension oderwat.indent-rainbow
	code --install-extension onecentlin.laravel-blade
	code --install-extension onecentlin.laravel5-snippets
	code --install-extension PKief.material-icon-theme
	code --install-extension pranaygp.vscode-css-peek
	code --install-extension Prisma.prisma
	code --install-extension rebornix.ruby
	code --install-extension redhat.vscode-yaml
	code --install-extension ritwickdey.LiveServer
	code --install-extension sdras.vue-vscode-snippets
	code --install-extension SirTobi.code-clip-ring
	code --install-extension streetsidesoftware.code-spell-checker
	code --install-extension stylelint.vscode-stylelint
	code --install-extension syler.sass-indented
	code --install-extension toba.vsfire
	code --install-extension vscode-icons-team.vscode-icons
	code --install-extension Vue.volar
	code --install-extension waderyan.gitblame
	code --install-extension wingrunr21.vscode-ruby
	code --install-extension wmaurer.change-case
	code --install-extension wraith13.open-in-github-desktop
	code --install-extension xabikos.JavaScriptSnippets
	code --install-extension xdebug.php-debug
	code --install-extension yzhang.markdown-all-in-one
	code --install-extension Zignd.html-css-class-completion

zinit:
	echo y | curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh

zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

.PHONY: vscode
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

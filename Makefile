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
	&& brew cask upgrade \
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
	code --install-extension
	42Crunch.vscode-openapi
	aaron-bond.better-comments
	abusaidm.html-snippets
	adpyke.vscode-sql-formatter
	adrianverdugo.buefy-snippet
	akamud.vscode-theme-onedark
	angelorafael.jsx-html-tags
	antonholmberg.remove-bg
	Arjun.swagger-viewer
	astro-build.astro-vscode
	bmewburn.vscode-intelephense-client
	bung87.vscode-gemfile
	christian-kohler.path-intellisense
	chrmarti.regex
	CraigMaslowski.erb
	cssho.vscode-svgviewer
	csstools.postcss
	dariofuzinato.vue-peek
	Dart-Code.dart-code
	Dart-Code.flutter
	dbaeumer.vscode-eslint
	demijollamaxime.bulma
	donjayamanne.githistory
	dsznajder.es7-react-js-snippets
	eamodio.gitlens
	ecmel.vscode-html-css
	EditorConfig.EditorConfig
	emilast.LogFileHighlighter
	esbenp.prettier-vscode
	felixfbecker.php-intellisense
	formulahendry.auto-close-tag
	formulahendry.auto-rename-tag
	foxundermoon.shell-format
	github.vscode-github-actions
	golang.go
	GraphQL.vscode-graphql
	GraphQL.vscode-graphql-execution
	GraphQL.vscode-graphql-syntax
	groksrc.ruby
	hediet.vscode-drawio
	hollowtree.canvas-snippets
	Hridoy.rails-snippets
	IBM.output-colorizer
	intellsmi.comment-translate
	jock.svg
	junstyle.php-cs-fixer
	kaiwood.endwise
	lacroixdavid1.vscode-format-context-menu
	manasxx.background-cover
	mechatroner.rainbow-csv
	MehediDracula.php-namespace-resolver
	mhutchie.git-graph
	mikestead.dotenv
	mosapride.zenkaku
	ms-azuretools.vscode-docker
	MS-CEINTL.vscode-language-pack-ja
	ms-vscode-remote.remote-containers
	ms-vscode-remote.remote-ssh
	ms-vscode-remote.remote-ssh-edit
	ms-vscode-remote.remote-wsl
	ms-vscode-remote.vscode-remote-extensionpack
	ms-vscode.remote-explorer
	ms-vscode.remote-server
	ms-vsliveshare.vsliveshare
	msjsdiag.vscode-react-native
	neilbrayfield.php-docblocker
	oderwat.indent-rainbow
	onecentlin.laravel-blade
	onecentlin.laravel5-snippets
	PKief.material-icon-theme
	pranaygp.vscode-css-peek
	Prisma.prisma
	rebornix.ruby
	redhat.vscode-yaml
	ritwickdey.LiveServer
	sdras.vue-vscode-snippets
	SirTobi.code-clip-ring
	streetsidesoftware.code-spell-checker
	stylelint.vscode-stylelint
	syler.sass-indented
	toba.vsfire
	vscode-icons-team.vscode-icons
	vscodevim.vim
	Vue.volar
	waderyan.gitblame
	wingrunr21.vscode-ruby
	wmaurer.change-case
	wraith13.open-in-github-desktop
	xabikos.JavaScriptSnippets
	xdebug.php-debug
	yzhang.markdown-all-in-one
	Zignd.html-css-class-completion

zinit:
	echo y | curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh

zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#!/bin/bash

# gitコマンド補完
#curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > git-completion.bash

# git管理下のディレクトリでブランチ名を表示する
#curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > git-prompt.sh

# vimrcのsymlink作成
ln -s ~/configfiles/vimrc ~/.vimrc

# gitconfigのsymlink作成
ln -s ~/configfiles/gitconfig ~/.gitconfig



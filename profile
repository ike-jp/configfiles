
# bashのプロンプトにgitのbranch名を表示する
source ~/configfiles/opt/git-completion.bash
PS1="\h@\u:\W\$(__git_ps1) \$ "

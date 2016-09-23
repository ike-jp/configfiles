echo 'loaded .bash_aliases'

alias ls='ls -lah'
alias ll='ls -lA'

alias relogin='exec $SHELL -l'
alias re=relogin

alias grep='grep --color'
"alias make='mingw64-make'

# bashのプロンプトにgitのbranch名を表示する
#source ~/configfiles/opt/git-completion.bash
#PS1="\h@\u:\W\$(__git_ps1) \$ "

# grepをデフォルトでカラー表示
alias grep="grep --color"

# lsだけで詳細情報表示
alias ls="ls -lah --color"



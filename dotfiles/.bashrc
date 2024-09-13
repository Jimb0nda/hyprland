#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias find='fzf --preview="bat --color=always {}"'
alias edit='code $(fzf -m --preview="bat --color=always {}")'
alias cdf='cd ~; cd $(fd --type directory --hidden | fzf)'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
fastfetch

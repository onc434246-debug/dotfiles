#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias dotpush='cd ~/dotfiles && cp ~/.config/i3/config ~/dotfiles/i3-config && cp ~/.bash_profile ~/dotfiles/ && cp ~/.bashrc ~/dotfiles/ && git add . && git commit -m "updated dotfiles" && git push'

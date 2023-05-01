# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# my prompt
bind 'set completion-ignore-case on'

## thick
export PS1='\[\e[0;1;94m\]┏ \[\e[0;1;93m\]\w\[\e[0m\] \[\e[0;1;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\n\[\e[0;1;94m\]┗━▶ \[\e[0m\]'

## thin
# export PS1='\[\e[0;1;94m\]╭ \[\e[0;93m\]\w\[\e[0m\] \[\e[0;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\n\[\e[0;1;94m\]╰─▶ \[\e[0m\]'


# my alias
## abbr
alias c=clear
alias dnf='sudo dnf'
alias sc='sudo systemctl'
alias ip='ip --color=auto'
alias py=python3.7
alias pyp='py -m pip'
alias pm=podman
alias x=exit
## ls
alias ls='ls -p --group-directories-first --color=auto'
alias l='ls -p --group-directories-first --color=auto'
alias l.='ls -dp --group-directories-first .* --color=auto'
alias la='ls -ap --group-directories-first --color=auto'
alias ll='ls -ahlp --group-directories-first --color=auto'
## util
alias pat='echo $PATH | tr ":" "\n"'
alias ports='netstat -tulanp'
alias tarc='tar -czf'
alias tarx='tar -xzf'
## git interface
alias gst='git status -s'
alias gco='git checkout'
alias gbn='git branch -vv'
alias glg='git log --oneline'
alias glast='git log -1 HEAD'
alias gcm='git commit -m'
alias gfe='git fetch'
alias gcfg='git config --global -l'
alias gadd='git add'
alias gpull='git pull'
alias gpush='git push'
## tmux interface
alias tm=tmux
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tmd='tmux detach'
alias tmn='tmux new-session -s'
alias tmk='tmux kill-session -t'
alias tmnw='tmux new-window -n'

# my function

# my path
add2path() {
	export PATH="$1:$PATH"
}
##add2path "$HOME/myPrograms"

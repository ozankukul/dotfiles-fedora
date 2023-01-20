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
export PS1="\n\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\n\[$(tput sgr0)\]\[\033[38;5;14m\]\t\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
bind 'set completion-ignore-case on'

## my alias
# abbr
alias c=clear
alias x=exit
alias dnf='sudo dnf'
alias sc='sudo systemctl'
alias ip='ip --color=auto'
alias py=python
alias pm=podman
# util
alias pat='echo $PATH | tr ":" "\n"'
alias ports='netstat -tulanp'
alias tarc='tar -czf'
alias tarx='tar -xzf'
# interface
alias tm=tmux
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tmd='tmux detach'
alias tmn='tmux new-session -s'
alias tmk='tmux kill-session -t'
alias tmnw='tmux new-window -n'

# my function
add2path() {
	export PATH="$1:$PATH"
}

vsc() {
    code $1 && exit
} 

# my path
#add2path "$HOME/myPrograms"

# pnpm
export PNPM_HOME="/home/ozan/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ozan/myPrograms/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ozan/myPrograms/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ozan/myPrograms/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ozan/myPrograms/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# program alias
alias vim=nvim

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

git () {
	if [[ $A == "glog" ]]; then
		command git log --oneline --graph --all --decorate
	else
		command git "$@"
	fi
}

elmrepl () {
	elm repl --no-colors
}

# Set the shell directory after leaving vifm
vicd () {
	local dst="$(command vifm --choose-dir - "$@")"
	if [ -z "$dst" ]; then
	    echo 'Directory picking cancelled/failed'
	    return 1
	fi
	cd "$dst"
}

export CYPRESS_CRASH_REPORTS=0 # Cypress, don't track me, bro
export EDITOR=/usr/bin/vi      # Use minimal vim for inline editing


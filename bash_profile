# Enable bash completion on Ubuntu, generic UNIX and Mac OSX
if ! shopt -oq posix; then
	#Bash autocompletion for UNIXes
        if [ -f /usr/share/bash-completion/bash-completion ]; then
                . /usr/share/bash-completion/bash-completion
        elif [ -f /etc/bash_completion ]; then
                . /etc/bash_completion
        elif [ -f `brew --prefix`/etc/bash_completion ]; then
                . `brew --prefix`/etc/bash_completion
        fi
fi

#Customize prompt with git info
function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=31
	elif [[ "$git_status" =~ Changes\ not\ staged\ for\ commit ]]; then
	    local ansi=35
	elif [[ "$git_status" =~ Changes\ to\ be\ committed ]]; then
	    local ansi=32
	elif [[ "$git_status" =~ Your\ branch\ is\ ahead\ of ]]; then
	    local ansi=34
	elif [[ "$git_status" =~ nothing\ to\ commit ]]; then
	    local ansi=30
        else
            local ansi=33
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            # test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n "git:\e[1;${ansi}m${branch}\e[m"
    else
	echo -n "\$"
    fi
}

function _prompt_command() {
	PS1="\e[1;36m\u\[\e[m@\e[1;33m\h\e[m:\e[1;32m\w\e[m\n`_git_prompt`> "
}

PROMPT_COMMAND=_prompt_command

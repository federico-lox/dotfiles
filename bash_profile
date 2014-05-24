# Binary folder for tools installed in the Home folder
if [ -d $HOME/bin ]; then
	PATH=$PATH:$HOME/bin
fi

#gitdir accepts 0 or 1 arguments (i.e., location)
# returns location of .git repo
__gitdir (){

	if [ -z "${1-}" ]; then
		if [ -n "${__git_dir-}" ]; then
			echo "$__git_dir"
		elif [ -n "${GIT_DIR-}" ]; then
			test -d "${GIT_DIR-}" || return 1
			echo "$GIT_DIR"
		elif [ -d .git ]; then
			echo .git
		else
			git rev-parse --git-dir 2>/dev/null
		fi
	elif [ -d "$1/.git" ]; then
		echo "$1/.git"
	else
		echo "$1"
	fi
}

__git_ps1 ()
{
	local pcmode=no
	local detached=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'


	case "$#" in
		2|3)	pcmode=yes
			ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
		;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return
		;;
	esac


	local g="$(__gitdir)"
	if [ -z "$g" ]; then
		if [ $pcmode = yes ]; then
			#In PC mode PS1 always needs to be set
			PS1="$ps1pc_start$ps1pc_end"
		fi
	else
		local r=""
		local b=""
		local step=""
		local total=""
		if [ -d "$g/rebase-merge" ]; then
			b="$(cat "$g/rebase-merge/head-name")"
			step=$(cat "$g/rebase-merge/msgnum")
			total=$(cat "$g/rebase-merge/end")
			if [ -f "$g/rebase-merge/interactive" ]; then
				r="|REBASE-i"
			else
				r="|REBASE-m"
			fi
		else
			if [ -d "$g/rebase-apply" ]; then
				step=$(cat "$g/rebase-apply/next")
				total=$(cat "$g/rebase-apply/last")
				if [ -f "$g/rebase-apply/rebasing" ]; then
					r="|REBASE"
				elif [ -f "$g/rebase-apply/applying" ]; then
					r="|AM"
				else
					r="|AM/REBASE"
				fi
			elif [ -f "$g/MERGE_HEAD" ]; then
				r="|MERGING"
			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
				r="|CHERRY-PICKING"
			elif [ -f "$g/REVERT_HEAD" ]; then
				r="|REVERTING"
			elif [ -f "$g/BISECT_LOG" ]; then
				r="|BISECTING"
			fi


			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
				detached=yes
				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||


				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
				b="unknown"
				b="($b)"
			}
		fi


		if [ -n "$step" ] && [ -n "$total" ]; then
			r="$r $step/$total"
		fi


		local w=""
		local i=""
		local s=""
		local u=""
		local c=""
		local p=""


		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
				c="BARE:"
			else
				b="GIT_DIR!"
			fi
		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
			   [ "$(git config --bool bash.showDirtyState)" != "false" ]
			then
				git diff --no-ext-diff --quiet --exit-code || w="*"
				if git rev-parse --quiet --verify HEAD >/dev/null; then
					git diff-index --cached --quiet HEAD -- || i="+"
				else
					i="#"
				fi
			fi
			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
			fi


			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
			   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
			   [ -n "$(git ls-files --others --exclude-standard)" ]
			then
				u="%${ZSH_VERSION+%}"
			fi


			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
				__git_ps1_show_upstream
			fi
		fi


		local f="$w$i$s$u"
		if [ $pcmode = yes ]; then
			local gitstring=
			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
				local c_red='\e[31m'
				local c_green='\e[32m'
				local c_lblue='\e[1;34m'
				local c_clear='\e[0m'
				local bad_color=$c_red
				local ok_color=$c_green
				local branch_color="$c_clear"
				local flags_color="$c_lblue"
				local branchstring="$c${b##refs/heads/}"


				if [ $detached = no ]; then
					branch_color="$ok_color"
				else
					branch_color="$bad_color"
				fi


				# Setting gitstring directly with \[ and \] around colors
				# is necessary to prevent wrapping issues!
				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"


				if [ -n "$w$i$s$u$r$p" ]; then
					gitstring="$gitstring "
				fi
				if [ "$w" = "*" ]; then
					gitstring="$gitstring\[$bad_color\]$w"
				fi
				if [ -n "$i" ]; then
					gitstring="$gitstring\[$ok_color\]$i"
				fi
				if [ -n "$s" ]; then
					gitstring="$gitstring\[$flags_color\]$s"
				fi
				if [ -n "$u" ]; then
					gitstring="$gitstring\[$bad_color\]$u"
				fi
				gitstring="$gitstring\[$c_clear\]$r$p"
			else
				gitstring="$c${b##refs/heads/}${f:+ $f}$r$p"
			fi
			gitstring=$(printf -- "$printf_format" "$gitstring")
			PS1="$ps1pc_start$gitstring$ps1pc_end"
		else
			# NO color option unless in PROMPT_COMMAND mode
			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
		fi
	fi
}

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
Host="\h"
User="\u"

PS1="$Color_Off"
PS1="$PS1$Yellow$Host"
PS1="$PS1$Color_Off:"
PS1="$PS1 $Green$PathShort"
# PS1="$PS1$Cyan"'$(__git_ps1)'
PS1="$PS1$Color_Off >"

#enable SSH compression
sshargs=-C

# enable ANSI colors
export TERM=xterm-256color

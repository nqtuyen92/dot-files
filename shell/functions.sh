pathmunge() {
	case ":${PATH}:" in
		*:"$1":* | "$1:${PATH}:")
			# $1 is already contained or $1 is NIL
			;;
		*)
			if [ "$2" = "after" ]
			then
				PATH=$PATH:$1
			else
				PATH=$1:$PATH
			fi
	esac
}
#[ -d "/usr/local/mysql" ] && pathmunge "/usr/local/mysql/bin" "after"
#[ -d "/Users/xinyi/Workspace/android-sdks/platform-tools" ] && pathmunge "/Users/xinyi/Workspace/android-sdks/platform-tools" "after"
[ -d "/Applications/Qt/Qt5.1.1/5.1.1/clang_64/bin" ] && pathmunge "/Applications/Qt/Qt5.1.1/5.1.1/clang_64/bin" "after"
unset pathmunge

man () {
	env \
	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

if [ -d "/etc/profile.d" ]
then
	for i in /etc/profile.d/*.sh
	do
		if [ -r "$i" ]
		then
			if [ "$PS1" ]
			then
				. "$i"
			else
				. "$i" > /dev/null 2>&1
			fi
		fi
	done
	unset i
fi

# look words in mac's dict
dict() {
	grep "$@" /usr/share/dict/words
}

# show ip
ips() {
	ifconfig | grep "inet" | awk '{print $2}'
}

# extract files from compressed status
extract() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)		tar xjf $1
				;;
			*.tar.gz)		tar xzf $1
				;;
			*.bz2)			bunzip2 $1
				;;
			*.rar)			unrar x $1
				;;
			*.gz) 			gunzip $1
				;;
			*.tar)			tar xf $1
				;;
			*.tbz2)			tar xfj $1
				;;
			*.tgz)			tar xzf $1
				;;
			*.zip)			unzip $1
				;;
			*.Z)			uncompress $1
				;;
			*)				echo "'$1' cannot be extracted via extract"
				;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
compdef '_files -g "*.gz *.tgz *.bz2 *.tbz *.zip *.rar *.tar *.lha"' extract

# Local variables:
# mode: shell-script
# sh-basic-offset: 4
# sh-indent-comment: t
# indent-tabs-mode: nil
# End:
# ex: ts=4 sw=4 et filetype=sh
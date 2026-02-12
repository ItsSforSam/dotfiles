# If you are cloning this dotfiles rember to run
# config config --local status.showUntrackedFiles no
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/sforsam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep

bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz promptinit
promptinit

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://unix.stackexchange.com/questions/58870/ctrl-left-right-arrow-keys-issue

# You can get the what the terminal send by runing cat and using your keystrokes
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char
# ctrl+backspace and ctrl+del
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
# Synamin of PS1
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
# __NEWLINE=$"\n"
# Fallbacks to this if something fails
PROMPT="%(?.%F{green}✔.%F{red}%?) %f[%F{blue}%n%f@%M%: %F{cyan}%~%f]%#➤ "

ZSH_THEME="sammy" # set by `omz`
plugins=(git archlinux sudo systemd)



# Sources other files
#source ~/.scripts/zsh-env
source ~/.scripts/zsh-env
source "$ZSH/oh-my-zsh.sh"




alias reload="source ~/.zshrc --reloaded-rc"

# shellcheck source=./shell-alias
source ~/.scripts/shell-alias


# CURSOR="\x1b\x5b?16;$((8+4+2+1));$((32+0+8+4+2+1))\x63"
# CURSOR='\033[?16;15;47c'
CURSOR='\e[5 q':
# === Special variables ===
#
# For more info visit: https://man.archlinux.org/man/zshparam.1#PARAMETERS_USED_BY_THE_SHELL
# shellcheck disable=SC1087
fpath=("$HOME/.zprompts" "$fpath[@]")  

# Sets preferred font, this only works if running in TTY not a graphical
# environment. If the variable is not set, 
if [[ "$XDG_SESSION_TYPE" == "tty" || -z "$XDG_SESSION_TYPE" ]]; then
	setfont -16 /usr/share/kbd/consolefonts/164.cp.gzs # 2> /dev/null

fi
# suppresses the error if fzf is not installed
if [[ -d "/usr/share/fzf" ]]; then
	# but differn't distros have them be somewhere else, for some reason
	if [[ -f "/usr/share/fzf/key-bindings.zsh" ]];then
		source /usr/share/fzf/key-bindings.zsh
		
	elif [[ -f "/usr/share/fzf/shell/key-bindings.zsh" ]];then
		source "/usr/share/fzf/shell/key-bindings.zsh"
	else # fallback to the embeded complitions
		eval "$(fzf --zsh)"
	fi
	# Fedoria doesn't have this script, for some reason....
	if [[ -f "/usr/share/fzf/completion.zsh" ]];then
		source /usr/share/fzf/completion.zsh
	fi
	eval "$(zoxide init zsh)"
else # This is set in shell-alias which is sourced above
	unalias cd
fi
if [[ "$*" == "--reloaded-rc" ]]; then
	echo "Reloaded zshrc"
elif [[ "$TERM_PROGRAM" != "vscode" ]]; then
	# stops running fastfetch if using vscode
	fastfetch
fi

# Allows modifying these dotfiles easily for the git repo
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

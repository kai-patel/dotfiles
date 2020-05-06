#
# ~/.bash_profile
#

echo "RUNNING .BASH_PROFILE" >> $HOME/startup_log.log
[[ -f ~/.bashrc ]] && source $HOME/.bashrc
[[ -f ~/.fehbg ]] && ~/.fehbg

export EDITOR="vim"
export TERMINAL="urxvt"

export BROWSER="firefox"

export PATH="$PATH:$HOME/scripts"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx > $HOME/startx.log
fi	

#[[ -f "~/.profile" ]] && . $HOME/.profile

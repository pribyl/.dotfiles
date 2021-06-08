# .bash_profile is executed for login shells,
# .bashrc is executed for interactive non-login shells.
# We want the same behaviour for both, so we source .bashrc from .bash_profile.

if [ -z "${NOZSH}" ] && [ $TERM = "xterm" -o $TERM = "xterm-256color" -o $TERM = "screen" ] && type zsh &> /dev/null
then
    export SHELL=$(which zsh)
    if [[ -o login ]]
    then
        exec zsh -l
    else
        exec zsh
    fi
fi

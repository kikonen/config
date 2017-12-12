export PATH=/Applications/Emacs.app/Contents/MacOS:$PATH
export PATH=$PATH:~/s:~/bin

export EDITOR=emacs
export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# @see http://superuser.com/questions/419775/with-bash-iterm2-how-to-name-tabs
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="[\u@\h \W $(parse_git_branch)]$ "

export PROMPT_COMMAND='echo -ne "\033]0;$(basename $(dirname "$PWD"))/$(basename "$PWD") $(parse_git_branch)\007"'


export NPM_USER=kikonen
export NPM_PASS=haakalooluukala
export NPM_EMAIL=mr.kari.ikonen@gmail.com

export NVM_DIR="/Users/kari/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

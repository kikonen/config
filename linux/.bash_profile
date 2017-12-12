if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
source ~/.profile
source ~/.rvm/scripts/rvm

alias be='bundle exec'

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/kari/.gvm/bin/gvm-init.sh" ]] && source "/home/kari/.gvm/bin/gvm-init.sh"

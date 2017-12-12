
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function set_term_bgcolor {
  local R=$1
  local G=$2
  local B=$3
echo "yyy"
  /usr/bin/osascript <<EOF
tell application "iTerm"
  tell the current terminal
    tell the current session
      set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
    end tell
  end tell
end tell
EOF
}
# iterm coloring
function tab-color() {
    if [[ $# == 1 ]]
    then
        # convert hex to decimal
        hex=$1
        if [[ ${hex:0:1} == "#" ]]
        then
            # strip leading hash sign
            hex=${hex:1:6}
        fi
        if [[ ${#hex} == 3 ]]
        then
            # handle 3-letter hex codes
            hex="${hex:0:1}${hex:0:1}${hex:1:1}${hex:1:1}${hex:2:1}${hex:2:1}"
        fi
        r=$(printf "%d" 0x${hex:0:2})
        g=$(printf "%d" 0x${hex:2:2})
        b=$(printf "%d" 0x${hex:4:2})
    else
        r=$1
        g=$2
        b=$3
    fi
    echo -ne "\033]6;1;bg;red;brightness;$r\a"
    echo -ne "\033]6;1;bg;green;brightness;$g\a"
    echo -ne "\033]6;1;bg;blue;brightness;$b\a"
}
function tab-red() { tab-color 203 111 111; }
function tab-green() { tab-color 6cc276; }
function tab-yellow() { tab-color "#e8e9ac"; }
function tab-blue() { tab-color 6f8ccc; }
function tab-purple() { tab-color a789d4; }
function tab-orange() { tab-color fbbc79; }
function tab-white() { tab-color fff; }
function tab-gray() { tab-color c3c3c3c; }

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# function ssh {
#     set_term_bgcolor 255 255 204
#     tab-color 255 200 200
#     command ssh $@
#     set_term_bgcolor 255 255 255
#     tab-reset
# }

function ssh {
    echo -e "\033]50;SetProfile=ssh\a"
    tab-color 255 200 200
    command ssh $@
    echo -e "\033]50;SetProfile=Default\a"
    tab-reset
}


##
# Your previous /Users/kari/.bash_profile file was backed up as /Users/kari/.bash_profile.macports-saved_2015-05-29_at_14:59:42
##

# MacPorts Installer addition on 2015-05-29_at_14:59:42: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

alias be='bundle exec'


export PS1="[\u@\h \W]$ "

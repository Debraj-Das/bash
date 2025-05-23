# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -salFh'               # all the files with all information
alias la='ls -A'                 # all files
alias l='ls -CF'                 # show the files with type
alias lx='ls -lXBh'              # sort by extension
alias lk='ls -lSrh'              # sort by size
alias lc='ls -lcrh'              # sort by change time
alias lu='ls -lurh'              # sort by access time
alias lr='ls -lRh'               # recursive ls
alias lt='ls -ltrh'              # sort by date
alias lm='ls -alh |more'         # pipe through 'more
alias lw='ls -xAh'               # wide listing format
alias labc='ls -lap'             #alphabetical sort
alias lf="ls -l | grep -E -v '^d'" # files only
alias ld="ls -l | grep -E '^d'"  # directories only

alias ref='source ~/.bashrc'
alias als='vi ~/.config/bash/aliases.sh'
alias brc='vi ~/.config/bash/bash.sh'

alias gpp='g++ -std=c++17 -Wshadow -Wall '
alias vi='nvim '

# alert alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# competitive programming alias
# alias run="/home/debraj/cs/dsa/CPSetup/scripts/run.sh"
# alias ts="/home/debraj/cs/dsa/CPSetup/scripts/test.sh"
# alias ck="/home/debraj/cs/dsa/CPSetup/scripts/check.sh"
# alias it="/home/debraj/cs/dsa/CPSetup/scripts/interact.sh"
# alias cpt="/home/debraj/cs/dsa/CPSetup/scripts/ch_test.sh "
# alias cpd="cp ~/cs/dsa/CPSetup/test/* ."
# alias cps="python3 -u /home/debraj/cs/dsa/CPSetup/scripts/chp.py"


alias ais='gh copilot suggest'
alias pym='python manage.py '

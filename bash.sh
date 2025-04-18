export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# Alias definitions.
if [ -f ~/.config/bash/aliases.sh ]; then
    . ~/.config/bash/aliases.sh
fi

# Load the prompt configuration
if [ -f ~/.config/bash/prompt.sh ]; then
	 . ~/.config/bash/prompt.sh
fi

## Load the input configuration
if [ -f ~/.config/bash/input.sh ]; then
	 bind -f ~/.config/bash/input.sh
fi

 export PATH+="$PATH:~/.config/bash/scripts"

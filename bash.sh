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

# Load the path
if [ -f ~/.config/bash/path.sh ]; then
	. ~/.config/bash/path.sh
fi

# Load the input configuration and bind -f is Readine keybindings
if [ -f ~/.config/bash/input.sh ]; then
	bind -f ~/.config/bash/input.sh
fi

# Loading the use full functions
if [ -f ~/.config/bash/functions.sh ]; then
	. ~/.config/bash/functions.sh
fi

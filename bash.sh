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

## Load the input configuration and bind -f is Readine keybindings
if [ -f ~/.config/bash/input.sh ]; then
	bind -f ~/.config/bash/input.sh
fi

modules_dir=~/.config/bash/modules/
# Check if the directory exists
if [ ! -d "$modules_dir" ]; then
	exit 0
fi

find "$modules_dir" -type f -name "*.sh" -print0 | while IFS= read -r -d $'\0' file; do
	absolute_path=$(realpath "$file")
	source $absolute_path
done

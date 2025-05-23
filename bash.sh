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

## Load the input configuration and bind -f is Readine keybindings
if [ -f ~/.config/bash/input.sh ]; then
	bind -f ~/.config/bash/input.sh
fi

readonly modules_dir=~/.config/bash/modules/

if [ -d "$modules_dir" ]; then
	while IFS= read -r -d '' file; do
		absolute_path=$(realpath "$file")
		source $absolute_path
	done < <(find "$modules_dir" -type f -name "*.sh" -print0)
fi

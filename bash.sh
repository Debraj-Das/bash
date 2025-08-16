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

# modules_dir_user=~/.config/bash/modules/

if [ -d "~/.config/bash/modules/" ]; then
	while IFS= read -r -d '' file; do
		absolute_path=$(realpath "$file")
		source $absolute_path
	done < <(find "~/.config/bash/modules/" -type f -name "*.sh" -print0)
fi

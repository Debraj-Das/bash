# This is a bash configuration reprojectory
## setup the bash configuration
1.In Home directory, if .config directory doesn't exist, create it. Go to the .config folder
```bash
cd ~/.config
```
2. clone the reprojectory
```bash
git clone https://github.com/Debraj-Das/bash.git
```
3. add the following line to the .bashrc file
```bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# setting of user bash configuration
# ~/.config/bash/setup.conf, instead of adding them here directly.
if [ -f ~/.config/bash/setup.conf ]; then
	 . ~/.config/bash/setup.conf
fi

# Alias definitions.
# ~/.config/bash/aliases.conf, instead of adding them here directly.
if [ -f ~/.config/bash/aliases.conf ]; then
    . ~/.config/bash/aliases.conf
fi

# Path configuration
# ~/.config/bash/.path.conf, instead of adding them here directly.
if [ -f ~/.config/bash/path.conf ]; then
	 . ~/.config/bash/path.conf
fi

# Load the prompt configuration
# ~/.config/bash/prompt.conf, instead of adding them here directly.
if [ -f ~/.config/bash/prompt.conf ]; then
	 . ~/.config/bash/prompt.conf
fi

## Load the input configuration
# ~/.config/bash/input.conf, instead of adding them here directly.
if [ -f ~/.config/bash/input.conf ]; then
	 bind -f ~/.config/bash/input.conf
fi
```

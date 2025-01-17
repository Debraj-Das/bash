# This is a bash configuration reprojectory

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

# Alias definitions.
if [ -f ~/.config/bash/aliases.conf ]; then
    . ~/.config/bash/aliases.conf
fi

# Load the prompt configuration
if [ -f ~/.config/bash/prompt.conf ]; then
	 . ~/.config/bash/prompt.conf
fi

## Load the input configuration
if [ -f ~/.config/bash/input.conf ]; then
	 bind -f ~/.config/bash/input.conf
fi
```

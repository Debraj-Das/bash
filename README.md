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
## Load the configuration
if [ -f ~/.config/bash/bash.sh ]; then
	 bind -f ~/.config/bash/bash.sh
fi
```

# Next I add install setting of system

- fzf installations
- nvim (lastest)
- tmux

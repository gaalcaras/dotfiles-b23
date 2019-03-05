# gaalcaras does dotfiles

These are my own dotfiles. They were originally forked from the [@holman
dotfiles](https://github.com/holman/dotfiles/fork), but they took a life of
their own.

## What's this?

My goal is to make an install script to set up a new machine within minutes and
to keep all my machines in sync.

While the specific details of the config are personal, it could be (yet) another source of inspiration for your own dotfiles scripts.
Feel free to fork and hack at it!

## Instructions

Run this:

```sh
git clone https://github.com/batlab/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo script/install
```

The install script has 3 main steps :

+ installing useful apps (ArchLinux only)
+ symlinking dotfiles (running `script/symlink`)
+ making your system comfy (updating zsh and vim plugins, adding SSH keys if needed, etc.)

NB: `sudo` is needed to install apps on your system.
All other commands are run as a normal user.

### Symlinking dotfiles (symlink)

The `symlink` script covers all possible symlinking scenarios:

+ `.symlink` extension will symlink to a dotfile in your home directory
+ `.config` extension will symlink to a config file in your `.config` directory
+ You can edit the `script/symlinks.txt` file for other complicated scenarios

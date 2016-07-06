# gaalcaras does dotfiles

These are my own dotfiles, forked from the excellent
[@holman dotfiles](https://github.com/holman/dotfiles/fork).

## Instructions

Run this:

```sh
git clone https://github.com/batlab/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo script/install
```

The install script has 3 main steps :

+ installing useful apps (ArchLinux only, Ubuntu coming soon)
+ symlinking dotfiles (running `script/bootstrap`)
+ making your system comfy (updating zsh and vim plugins, adding SSH keys if needed, etc.)

NB: `sudo` is needed to install apps on your system.
All other commands are run as a normal user.

### Installing apps

The goal here is to setup cool apps that I might need for server admin or programming.
For now, it's just : tmux, vim, neovim, zsh.

You can easily add a new app to install in the `script/modules` directory, following the same syntax than the other files.
The order of installation is set by the prefix : "0a, 0b, ..., 1a, 1b, ...".

### Symlinking dotfiles (bootstrap)

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

Sometimes software (like arara) needs to have a config file in your home
directory, not a dotfile. If so, use the `.vsymlink` (for 'visible symlink')
instead of `.symlink`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

Sometimes, you want to symlink an entire folder to a directory in your dotfiles.
You can edit the associative array in `script/folders` for that purpose.

The bootstrap script can be run on its own, outside of the install script :
`script/bootstrap`.

### Make yourself at home

After installing the apps and bootstraping the dotfiles, you might want to run some tasks to prepare your system : installing and updating plugins, generating missing SSH keys if any, etc.

You can easily add a new post-install script in the `script/post` directory, following the same syntax than the other files.
The order of installation is set by the prefix : "0a, 0b, ..., 1a, 1b, ...".

The hosts for the SSH keys are to be directly modified in the `script/post/2a-sshkeys`.

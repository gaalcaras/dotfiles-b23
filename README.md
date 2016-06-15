# gaalcaras does dotfiles

These are my own dotfiles, forked from the excellent
[@holman dotfiles](https://github.com/holman/dotfiles/fork).

## Instructions

Run this:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```
This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

Sometimes software (like arara) needs to have a config file in your home
directory, not a dotfile. If so, use the `.vsymlink` (for 'visible symlink')
instead of `.symlink`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

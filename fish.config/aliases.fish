# ls aliases
alias ls="ls -F --color=auto --block-size=M"
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -a"
alias ldot="ll -d .*"

# Directories
alias dotfiles="cd ~/.dotfiles"
alias pdw="cd ~/Documents/phd-writing"

# Git aliases
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gst='git status -sb'
alias gc='git commit'
alias ga='git add -p'

# Locale stuff
alias git='LC_ALL=C git'
alias khal='LC_TIME=C khal'
alias ikhal='LC_TIME=C ikhal'

# Tools
alias bib="cd $BIB_DIR && $EDITOR $BIB_FILE"
alias nv="nvim"
alias mutt='hash tmuxifier 2>/dev/null && tmuxifier load-window mutt || neomutt -n' # Check if tmuxifier exists before loading mutt setup
alias mr='mr -d "$HOME"' # Multi-repos with minimal output and 5 parallel jobs
alias rss='nvim ~/.dotfiles/newsboat/urls.config'
alias top='gtop'

# Development
alias nvtest='nvim +UpdateRemotePlugins +qall && nvim "+TranscribeAudio ~/Videos/googlepixel.webm"'

# Misc
alias reload='source ~/.zshrc'
alias msmtp-unlock="rm $HOME/.msmtpqueue/.lock"
alias stats="fc -l 1 | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl | head -n20"
alias mmv='noglob zmv -W'

# DOTFILES

function filerc -a rcfile
  set tmpdir (pwd)
  set rcdir (dirname $rcfile)
  $EDITOR $rcfile

  cd $tmpdir
end

alias comptonrc="filerc ~/.dotfiles/picom/compton.conf.config"
alias dunstrc="filerc ~/.dotfiles/dunst/dunstrc.config"
alias gitrc="filerc ~/.dotfiles/git/gitconfig.symlink"
alias gpgrc="filerc ~/.dotfiles/gpg/gpg-agent.conf"
alias gtkrc="filerc ~/.dotfiles/gtk-3.0/gtk.css.config"
alias i3rc="filerc ~/.dotfiles/i3/config_local"
alias imaprc="filerc ~/.dotfiles/offlineimap/offlineimaprc.symlink"
alias khalrc="filerc ~/.dotfiles/khal/config.config"
alias khardrc="filerc ~/.dotfiles/khard/khard.conf.config"
alias mpvrc="filerc ~/.dotfiles/mpv/mpv.conf.config"
alias mrrc="filerc ~/.dotfiles/mr/mrconfig.symlink"
alias msmtprc="filerc ~/.dotfiles/offlineimap/msmtprc.symlink"
alias muttrc="filerc ~/.dotfiles/neomutt.config/muttrc"
alias newsboatrc="filerc ~/.dotfiles/newsboat/config.config"
alias papisrc="filerc ~/.dotfiles/papis/config.config"
alias polybarrc="filerc ~/.dotfiles/polybar/config.config"
alias qutebrowserrc="filerc ~/.dotfiles/qutebrowser.config/config.py"
alias rangerrc="filerc ~/.dotfiles/ranger/rc.conf.config"
alias rofirc="filerc ~/.dotfiles/rofi/config.rasi.config"
alias scimrc="filerc ~/.dotfiles/scim/scimrc.symlink"
alias swayrc="filerc ~/.dotfiles/sway/config_local"
alias taskrc="filerc ~/.dotfiles/task/taskrc.symlink"
alias termiterc="filerc ~/.dotfiles/termite/config_local"
alias texrc="filerc ~/.dotfiles/tex/latexmkrc.symlink"
alias tmuxrc="filerc ~/.dotfiles/tmux/tmux.conf.symlink"
alias vdirsyncerrc="filerc ~/.dotfiles/vdirsyncer/config.config"
alias vimrc="filerc ~/.dotfiles/vim/vimrc.symlink"
alias waybarrc="filerc ~/.dotfiles/waybar/config.config"
alias xinitrc="filerc ~/.dotfiles/X/xinitrc.symlink"
alias zathurarc="filerc ~/.dotfiles/zathura/zathurarc.config"
alias zshrc="filerc ~/.dotfiles/zsh/zshrc.symlink"

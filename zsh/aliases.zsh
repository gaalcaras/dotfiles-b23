alias reload='source ~/.zshrc'

# Servers, remote machines
alias zsh_stats="fc -l 1 | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl | head -n20"

alias ls="ls -F --color=auto --block-size=M"
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -a"
alias ldot="ll -d .*"

alias nv="nvim"
alias mmv='noglob zmv -W'

alias git='LANG=en_US git'
alias khal='LC_TIME=C khal'
alias ikhal='LC_TIME=C ikhal'

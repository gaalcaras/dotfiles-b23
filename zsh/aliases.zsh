alias reload='source ~/.zshrc'

# Servers, remote machines
alias batcloud="ssh gabo@batcloud.me -p 10101"
alias clipper="ssh alcaras@sas.eleves.ens.fr"
alias trensmissions="ssh -A -t alcaras@sas.eleves.ens.fr ssh -A alcaras@www.trensmissions.ens.fr"
alias zsh_stats="fc -l 1 | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl | head -n20"

alias ls="ls -F --color=auto --block-size=M"
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -a"
alias ldot="ll -d .*"

alias nv="nvim"
alias mmv='noglob zmv -W'

alias git='LANG=en_US git'

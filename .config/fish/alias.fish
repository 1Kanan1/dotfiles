alias ls="eza --icons=always"
alias btm="btm -RTr 500ms --default_widget_type process"

# Aliases for python and related tools
alias python="python3"
alias ipython="ipython3"
alias pip="pip3"

# Alias for dnscrypt-proxy
alias dnscrypt-proxy="/usr/local/dnscrypt-proxy/dnscrypt-proxy"

alias cp="cp -i"

function chtsh
  curl cheat.sh/$argv
end

set -x FZF_CTRL_T_OPTS "
  --height=40%
  --border none
  --pointer ▶
  --marker ⇒
  --preview '
    if test -d {}; 
      eza -a --color=always --icons --tree --level=2 --git-ignore {}; 
    else if test -f {}; 
      bat --color=always --style='changes,numbers' --line-range :500 {}; 
    else; 
      echo \"Not a valid file or directory\"; 
    end'"

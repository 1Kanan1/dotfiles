# Disable default file completion and provide git branches with a description
complete -c bf -f -a "(git branch --format='%(refname:short)')" -d 'Git branch'

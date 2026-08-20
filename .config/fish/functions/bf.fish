function bf
    set b $argv[1]; or set b (git branch --show-current)

    git ls-tree -r --name-only $b |
        fzf --preview "git show $b:{} | bat --color=always --style=changes,numbers --file-name {}"
end

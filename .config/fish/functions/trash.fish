function trash
    for item in $argv
        mv $item ~/.Trash/$item
    end
end

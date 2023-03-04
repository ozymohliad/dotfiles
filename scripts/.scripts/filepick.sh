#!/bin/sh

pick() {
    [ "$dir" != / ] && filter=" | cat <(echo ..) -"
    list="ls '$dir' $filter"
    list_all="ls '$dir' -A $filter"

    FZF_DEFAULT_COMMAND=$list fzf --reverse --border=top --border-label="$dir" --border-label-pos=1 \
        --preview="preview.sh '$dir'/{}" \
        --info=inline \
        --bind "ctrl-h:reload($list_all)" \
        --bind "alt-h:reload($list)"
}

dir=$(pwd)
unset SHELL
while subdir=$(pick) || [ $? -eq 1 ]
do
    tmp=$(realpath "$dir/${subdir:-.}")
    if [ -d "$tmp" ]
    then
        [ -x "$tmp" ] && dir=$tmp
    else
        dir=$tmp
        break
    fi
done
echo $dir

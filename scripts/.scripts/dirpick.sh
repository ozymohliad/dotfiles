#!/bin/sh

pick() {
    [ "$dir" != / ] && filter=" | cat <(echo ..) -"
    list="exa '$dir' -D $filter"
    list_all="exa '$dir' -aD $filter"

    FZF_DEFAULT_COMMAND=$list fzf --reverse --border=top --border-label="$dir" --border-label-pos=1 \
        --info=inline --preview="ls '$dir'/{}" \
        --bind "ctrl-h:reload($list_all)" \
        --bind "alt-h:reload($list)"
}

dir=$(pwd)
unset SHELL
while subdir=$(pick) || [ $? -eq 1 ]
do
    tmp=$(realpath "$dir/${subdir:-.}")
    [ -x "$tmp" ] && dir=$tmp
done
echo $dir

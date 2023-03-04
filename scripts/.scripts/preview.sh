#!/bin/sh

file="$1"

if [ -d "$file" ]
then
    ls --color "$file"
elif (grep . -qI "$file")
then
    if (file -ib "$file" | grep -q '^application/json;')
    then
        jq -C <"$file"
    else
        bat --style=numbers --color=always --pager=never --terminal-width=${FZF_PREVIEW_COLUMNS:-$COLUMNS} "$file"
    fi
else
    file -b "$file" | fmt -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}
fi

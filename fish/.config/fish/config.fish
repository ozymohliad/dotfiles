if status is-interactive
    source_if_exists "$HOME/.config/aliases" # Set aliases
    bind -M insert \co 'cd (dirpick.sh); commandline -f repaint'
    bind -M insert \cp 'commandline -i (filepick.sh)" "'
end

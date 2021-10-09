function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end

    set arrow ❯
    set arrow 
    echo -n (set_color red)$arrow(set_color yellow)$arrow(set_color green)"$arrow "
    set_color normal
end

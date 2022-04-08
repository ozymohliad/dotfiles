function theme
    set dark "dark"
    set light "light"
    set var $argv[1]
    test "$var" != $dark && test "$var" != $light && echo "Usage: theme $light|$dark" && return

    if test "$var" = "$dark"
        set fish_color_autosuggestion 747369
        set fish_color_cancel -r
        set fish_color_command 99cc99
        set fish_color_comment ffcc66
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_end cc99cc
        set fish_color_error f2777a
        set fish_color_escape 66cccc
        set fish_color_history_current --bold
        set fish_color_host normal
        set fish_color_match 6699cc
        set fish_color_normal normal
        set fish_color_operator 6699cc
        set fish_color_param d3d0c8
        set fish_color_quote ffcc66
        set fish_color_redirection d3d0c8
        set fish_color_search_match bryellow --background=brblack
        set fish_color_selection white --bold --background=brblack
        set fish_color_user brgreen
        set fish_color_valid_path --underline
        set fish_pager_color_completion normal
        set fish_pager_color_description B3A06D yellow
        set fish_pager_color_prefix normal --bold --underline
        set fish_pager_color_progress brwhite --background=cyan
        set KITTY_THEME 'Gruvbox Material Dark Soft'
    else
        set fish_color_autosuggestion 93a1a1
        set fish_color_cancel -r
        set fish_color_command 586e75
        set fish_color_comment 93a1a1
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_end 268bd2
        set fish_color_error dc322f
        set fish_color_escape 00a6b2
        set fish_color_history_current --bold
        set fish_color_host normal
        set fish_color_match --background=brblue
        set fish_color_normal normal
        set fish_color_operator 00a6b2
        set fish_color_param 657b83
        set fish_color_quote 839496
        set fish_color_redirection 6c71c4
        set fish_color_search_match bryellow --background=white
        set fish_color_selection white --bold --background=brblack
        set fish_color_user brgreen
        set fish_color_valid_path --underline
        set fish_pager_color_completion green
        set fish_pager_color_description B3A06D
        set fish_pager_color_prefix cyan --underline
        set fish_pager_color_progress brwhite --background=cyan
        set KITTY_THEME 'Solarized Light'
    end

    set -x THEME $var
    kitty +kitten themes --reload-in=all $KITTY_THEME
end

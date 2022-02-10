if status is-login
	fish_add_path $HOME/.local/bin
end

if status is-interactive
    set fish_greeting
    set -x npm_config_prefix "$HOME/.local"
end

if status is-login
	fish_add_path $HOME/.local/bin
end

if status is-interactive
    source_if_exists "$HOME/.config/aliases" # Set aliases
    source_if_exists "local.config.fish"     # Execute local config (that is not to be shared)
end

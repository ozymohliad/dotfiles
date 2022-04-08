function source_if_exists
    test -f "$argv[1]" && source "$argv[1]"
end

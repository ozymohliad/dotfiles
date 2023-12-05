(annotation
    name: (identifier) @_ant (#eq? @_ant "Query")
    (annotation_argument_list
        [
            (
                (element_value_pair
                    key: (identifier) @_param (#eq? @_param value)
                    (string_literal
                        [(multiline_string_fragment) (string_fragment)] @sql))
                ; Uncomment to force 'nativeQuery = true'
                ; (element_value_pair
                ;     key: (identifier) @_param2 (#eq? @_param2 nativeQuery)
                ;     value: (true))
            )
            ; Comment to force 'nativeQuery = true'
            (string_literal
                [(multiline_string_fragment) (string_fragment)] @sql)
        ]
))

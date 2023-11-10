(style_block 
    ((tag_source) @injection.content
        (#set! injection.language "css"))
)
(rust_block 
    ((tag_source) @injection.content
        (#set! injection.language "rust"))
)
((generic_source) @injection.content
    (#set! injection.language "rust"))
((reactive_source) @injection.content
    (#set! injection.language "rust"))

((string_source_1) @injection.content
    (#set! injection.language "rust"))
((string_source_2) @injection.content
    (#set! injection.language "rust"))

((css_source) @injection.content
    (#set! injection.language "rust"))

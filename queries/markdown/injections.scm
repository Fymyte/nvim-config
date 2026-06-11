; extends

(fenced_code_block
  (info_string
    (language) @_lang
    (#eq? @_lang "console")
    (#set! injection.language "bash"))
  (code_fence_content) @injection.content)

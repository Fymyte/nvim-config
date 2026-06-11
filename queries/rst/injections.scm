; extends

(directive
  name: (type) @type (#eq? @type "code-block")
  body: (body
          (arguments) @args (#eq? @args "console")
          (content) @injection.content
          (#set! injection.language "bash")
        ) @body
  ) @directive

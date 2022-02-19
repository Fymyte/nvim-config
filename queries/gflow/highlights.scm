(comment) @comment
[
"="
] @operator

[
":"
";"
] @punctuation.delimiter

[
"{"
"}"
"|"
; "("
; ")"
"["
"]"
] @punctuation.bracket

(db_table) @variable
(db_entry) @variable
(number_literal) @number
(boolean_literal) @boolean
(text_literal) @string

(identifier) @variable
(type_identifier (identifier) @type)
(type_identifier list:_ @type.builtin)
(variable_definition "var" @keyword)
(object_definition "object" @keyword (name) @type (field(name) @variable))
(object_construction (field(name) @variable))

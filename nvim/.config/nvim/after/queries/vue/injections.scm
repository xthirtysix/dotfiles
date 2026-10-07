; extends

; <i18n lang="yaml"> / lang="yml"
(element
  (start_tag
    (tag_name) @_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_lang)))
  (text) @injection.content
  (#eq? @_tag "i18n")
  (#eq? @_attr "lang")
  (#any-of? @_lang "yaml" "yml")
  (#set! injection.language "yaml")
  (#set! injection.combined))

; <i18n> без атрибутов (vue-i18n по умолчанию json)
(element
  (start_tag
    (tag_name) @_tag .)
  (text) @injection.content
  (#eq? @_tag "i18n")
  (#set! injection.language "json")
  (#set! injection.combined))

; <i18n lang="json"> / lang="json5"
(element
  (start_tag
    (tag_name) @_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_lang)))
  (text) @injection.content
  (#eq? @_tag "i18n")
  (#eq? @_attr "lang")
  (#any-of? @_lang "json" "json5")
  (#set! injection.language "json")
  (#set! injection.combined))

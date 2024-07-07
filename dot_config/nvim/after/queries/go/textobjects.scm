;extends
(composite_literal
  body: (_
          (_) @parameter.inner
  ","? @_end
  )
  (#make-range! "parameter.outer" @parameter.inner @_end))

(define-syntax use-as
  (syntax-rules ()
    ((_ module alias)
      (begin
        (use module)
        (define-syntax alias
          (syntax-rules ()
            ((_ proc . args)
              ((with-module module proc) . args))))))))


(define-module util.perl-splice
 (export splice! slice))
(select-module util.perl-splice)
(use gauche.sequence)
(define-method splice! ((input <list>) pos n . replacement)
 (if (= pos 0)
  (if (= n 0)
   (values (append! replacement input) '())
   (let* ((end (list-tail input (- n 1))) (rest (cdr end)))
    (if (null? replacement)
     (begin
      (set-cdr! end '())
      (values rest input))
     (begin 
      (set-cdr! (last-pair replacement) rest)
      (set-cdr! end '())
      (values replacement input)))))
  (let* ((start (list-tail input (- pos 1))) (end (list-tail start n)) (rest (cdr end)))
   (if (= n 0)
     (begin
      (set-cdr! start replacement)
      (set-cdr! (last-pair replacement) rest)
      (values input '()))
    (begin0 
     (values input (cdr start))
      (set-cdr! start replacement)
      (set-cdr! end '())
      (set-cdr! (last-pair replacement) rest))))))

(define-method slice ((input <sequence>) start size)
  (slice-aux input (max 0 start) (min size (- (size-of input) start ))))
(define-method slice-aux (input start size)
  (if (>= 0 size) '()
    (cons (ref input start) (slice-aux input (+ start 1) (- size 1)))))

(provide "util/perl-splice")

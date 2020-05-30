#lang racket

; Create a debug syntax that prints the value of an expression during execution
;  (define factorial
;     (lambda (x)
;        (if (zero? x)
;          1
;          (* x (debug (factorial (- x 1))))
(define-syntax debug
  (lambda (syn)
    (let ((slist (syntax->list syn)))
      (datum->syntax syn `(let ((x ,(cadr slist)))
                            (begin (print x) (newline) x))))))

; Create a syntax for ?: for if
(define-syntax ?:
  (lambda (syn)
    (define slist (syntax->list syn))
    (datum->syntax syn `(if ,(cadr slist) ,(caddr slist) ,(cadddr slist)))))

; Create a syntax for rotate
; (rotate 1 2 3)   => '(2 3 1)
; This is a sloppy way to do the rotate because it does not "unquote" the elements
;   For that it is better to use some of the other macro creation routines of racket
(define-syntax rotate
  (lambda (syn)
    (define slist (syntax->list syn))
    (datum->syntax syn `(append (quote ,(cddr slist)) (list ,(cadr slist))))))

; Let's create Just and Nothing
(define-syntax Just
  (lambda (syn)
    (define slist (syntax->list syn))
    (datum->syntax syn `(list `Just ,(cadr slist)))))

(define-syntax Nothing
  (lambda (syn)
    (syntax 'Nothing)))
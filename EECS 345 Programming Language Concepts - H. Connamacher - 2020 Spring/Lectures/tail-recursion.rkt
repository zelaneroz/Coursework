#lang racket
; factorial as accumular passing style
; let's factorial be tail-recursive so that scheme can reuse the stack frame
;  and not have the stack build up
(define fact-acc
  (lambda (x acc)
    (if (zero? x)
        acc
        (fact-acc (- x 1) (* x acc)))))

; length of a list using an accumulator

; factorial using a "continuation function" to make it tail recursive
;  basically lets us replace the stack with an object in the heap
(define fact-cps
  (lambda (x return)
    (if (zero? x)
        (return 1)
        (fact-cps (- x 1) (lambda (v) (return (* x v)))))))
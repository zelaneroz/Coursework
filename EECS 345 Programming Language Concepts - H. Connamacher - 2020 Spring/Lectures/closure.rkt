#lang racket

;; a function that has a variable it must capture in its closure
(define whatdoido
  (lambda ()
    (let ((y 0))
      (lambda (x)
        (begin
          (set! y (+ 1 y))
          (+ x y))))))

(define increment
  (lambda ()
    (let ((y 0))
      (lambda ()
        (begin
          (set! y (+ 1 y))
          y)))))
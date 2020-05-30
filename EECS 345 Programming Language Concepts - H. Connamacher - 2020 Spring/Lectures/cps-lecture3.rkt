#lang racket

; (split '(a b c d e f)) should return two lists '(a c e) and '(b d f)
(define split-cps
  (lambda (lis return)
    (if (or (null? lis) (null? (cdr lis)))
        (return lis '())
        (split-cps (cddr lis) (lambda (v1 v2) (return (cons (car lis) v1) (cons (cadr lis) v2)))))))

; here is multiply lists that uses normal recursion but call/cc to immediately return if a 0 is encountered
(define multiply-break
  (lambda (lis break)
    (cond
      ((null? lis) 1)
      ((zero? (car lis)) (break 0))
      (else (* (car lis) (multiply-break (cdr lis) break))))))

(define multiply
  (lambda (lis)
    (call/cc
     (lambda (break)
       (multiply-break lis break)))))

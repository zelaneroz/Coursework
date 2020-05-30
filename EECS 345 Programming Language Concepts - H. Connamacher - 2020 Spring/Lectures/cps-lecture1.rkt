#lang racket
; accumulator passing style factorial function
(define factorial-acc
  (lambda (n acc)
    (if (zero? n)
        acc
        (factorial-acc (- n 1) (* n acc)))))

; continuation passing style factorial function
(define factorial-cps
  (lambda (n return)
    (if (zero? n)
        (return 1)
        (factorial-cps (- n 1) (lambda (v) (return (* n v)))))))

; remove the first occurrence of element x in a list of atoms
(define my-remove
  (lambda (x lis)
    (cond
      ((null? lis) '())
      ((eq? x (car lis)) (cdr lis))
      (else (cons (car lis) (my-remove x (cdr lis)))))))

(define remove-cps
  (lambda (x lis return)
    (cond
      ((null? lis) (return '()))
      ((eq? x (car lis)) (return (cdr lis)))
      (else (remove-cps x (cdr lis) (lambda (v) (return (cons (car lis) v))))))))

; removeall cps version removes every occurrence of x in a list of atoms

(define removeall-cps
  (lambda (x lis return)
    (cond
      ((null? lis) (return '()))
      ((eq? x (car lis)) (removeall-cps x (cdr lis) return))
      (else (removeall-cps x (cdr lis) (lambda (v) (return (cons (car lis) v))))))))

; myappend appends two lists

(define myappend
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (myappend (cdr l1) l2)))))

; the myappend, but now using continuation passing style

(define myappend-cps
  (lambda (l1 l2 return)
    (if (null? l1)
        (return l2)
        (myappend-cps (cdr l1) l2 (lambda (v) (return (cons (car l1) v)))))))

; reverse using continuation passing style.  The trick is to share the continuation
; between the cps versions of reverse and append so that only one stack frame is used
; throughout.

(define reverse-cps
  (lambda (l return)
    (if (null? l)
        (return '())
        (reverse-cps (cdr l) (lambda (v) (myappend-cps v (cons (car l) '()) return))))))
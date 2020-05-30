#lang racket
; This is a comment.
; This function counts the number of elements in a list
(define len
  (lambda (lis)
    ; (if condition then-function else-function)
    (if (null? lis)
        0
        (+ 1 (len (cdr lis))))))

; Determine if an atom is an element of a list of atoms
; Given an element x and a list lis
; case: the list is empty => #f
; case: list is not empty and the first element is x => #t
; case: list is not empty and the first element is not x => recurse
(define member?
  (lambda (x lis)
    (if (null? lis)
        #f
        (if (eq? x (car lis))
            #t
            (member? x (cdr lis))))))

; The same thing as member? but demonstrates the use of cond to replace nested if's
(define member2?
  (lambda (x lis)
    (cond
      [(null? lis)       #f]
      [(eq? x (car lis)) #t]
      [else              (member2? x (cdr lis))])))

; sumnumbers sums all the numbers in a list
(define sumnumbers
  (lambda (lis)
    (cond
      [(null? lis) 0]
      [(number? (car lis)) (+ (car lis) (sumnumbers (cdr lis)))]
      [else (sumnumbers (cdr lis))])))

; compute the factorial of a non-negative integer
(define factorial
  (lambda (x)
    (if (zero? x)
        1
        (* x (factorial (- x 1))))))

#lang racket
; sumnumbers: takes a list of atoms and sums the numbers in the list
(define sumnumbers
  (lambda (lis)
    (cond
      [(null? lis) 0]
      [(number? (car lis)) (+ (car lis) (sumnumbers (cdr lis)))]
      [else (sumnumbers (cdr lis))])))

(define sumnumbers-cps
  (lambda (lis return)
    (cond
      [(null? lis) (return 0)]
      [(number? (car lis)) (sumnumbers-cps (cdr lis) (lambda (v) (return (+ v (car lis)))))]
      [else (sumnumbers-cps (cdr lis) return)])))

; sumnumbers*: sum the numbers in a list that contains sublists
(define sumnumbers*
  (lambda (lis)
    (cond
      [(null? lis) 0]
      [(list? (car lis)) (+ (sumnumbers* (car lis)) (sumnumbers* (cdr lis)))]
      [(number? (car lis)) (+ (car lis) (sumnumbers* (cdr lis)))]
      [else (sumnumbers-cps (cdr lis))])))

(define sumnumbers*-cps
  (lambda (lis return)
    (cond
      [(null? lis) (return 0)]
      [(list? (car lis)) (sumnumbers*-cps (car lis)
                                          (lambda (v1) (sumnumbers*-cps (cdr lis)
                                                                        (lambda (v2) (return (+ v1 v2))))))]
      [(number? (car lis)) (sumnumbers*-cps (cdr lis) (lambda (v) (return (+ v (car lis)))))]
      [else (sumnumbers*-cps (cdr lis) return)])))

; removeall*-cps: remove all copies of x from a list of lists

(define removeall*-cps
  (lambda (x lis return)
    (cond
      [(null? lis) (return '())]
      [(list? (car lis)) (removeall*-cps x (car lis) (lambda (v1) (removeall*-cps x (cdr lis) (lambda (v2) (return (cons v1 v2))))))]
      [(eq? (car lis) x) (removeall*-cps x (cdr lis) return)]
      [else (removeall*-cps x (cdr lis) (lambda (v) (return (cons (car lis) v))))])))

; flatten-cps (need append-cps):  '((A)(B)((((C D)))))  ==> (A B C D)
(define append-cps
  (lambda (l1 l2 return)
    (if (null? l1)
        (return l2)
        (append-cps (cdr l1) l2 (lambda (v) (return (cons (car l1) v)))))))

(define flatten-cps
  (lambda (lis return)
    (cond
      [(null? lis) (return '())]
      [(list? (car lis)) (flatten-cps (car lis) (lambda (v1) (flatten-cps (cdr lis) (lambda (v2) (append-cps v1 v2 return)))))]
      [else  (flatten-cps (cdr lis) (lambda (v) (return (cons (car lis) v))))])))

; (split-cps '(a b c d e))  =>  '(a c e) '(b d)

; by using cps on this method to multiply a list of numbers, we can have it immediately
; jump out of the recursion once it hits a 0.  Try tracing this in the debugger so you
; can watch the call stack
(define multiply-cps
  (lambda (lis return break)
    (cond
      [(null? lis) (return 1)]
      [(zero? (car lis)) (break 0)]
      [else (multiply-cps (cdr lis) (lambda (v) (return (* v (car lis)))) break)])))
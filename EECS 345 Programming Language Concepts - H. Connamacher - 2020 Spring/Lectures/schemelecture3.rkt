#lang racket

; remove an every element from a list of atoms
(define removeall
  (lambda (a lis)
    (cond
      [(null? lis) '()]
      [(eq? a (car lis)) (removeall a (cdr lis))]
      [else (cons (car lis) (removeall a (cdr lis)))])))

; remove every element from a list that contains atoms and sublists, and lists of lists, etc.
(define removeall*
  (lambda (a lis)
    (cond
      [(null? lis) '()]
      [(list? (car lis)) (cons (removeall* a (car lis)) (removeall* a (cdr lis)))]
      [(eq? a (car lis)) (removeall* a (cdr lis))]
      [else (cons (car lis) (removeall* a (cdr lis)))])))

; is an element in a list of atoms?
;(define member?
;  (lambda (a lis)
;    (cond
;      [(null? lis) #f]
;      [(eq? a (car lis)) #t]
;      [else (member? a (cdr lis))])))

; is an element in a list of atoms?
(define member?
  (lambda (a lis)
    (if (null? lis)
        #f
        (or (eq? a (car lis)) (member? a (cdr lis))))))

; is a in a list that contains lists?
(define member*?
  (lambda (a lis)
    (cond
      [(null? lis) #f]
      [(list? (car lis)) (or (member*? a (car lis)) (member*? a (cdr lis)))]
      [(eq? a (car lis)) #t]
      [else (member*? a (cdr lis))])))

(define emptyall
  (lambda (lis)
    (cond
      [(null? lis) '()]
      [(list? (car lis)) (cons (emptyall (car lis)) (emptyall (cdr lis)))]
      [else (emptyall (cdr lis))])))

(define flatten
  (lambda (lis)
    (cond
      [(null? lis) '()]
      [(list? (car lis)) (append (flatten (car lis)) (flatten (cdr lis)))]
      [else (cons (car lis) (flatten (cdr lis)))])))
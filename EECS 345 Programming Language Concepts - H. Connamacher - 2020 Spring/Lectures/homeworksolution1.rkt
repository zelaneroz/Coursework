#lang racket
; programming exercise 1
; interleave3 interleaves three lists
(define interleave3
  (lambda (lis1 lis2 lis3)
    (cond
      ((and (null? lis1) (null? lis2)) lis3)
      ((null? lis1) (interleave3 lis2 lis3 lis1))
      (else (cons (car lis1) (interleave3 lis2 lis3 (cdr lis1)))))))

; reverses a list and all sublists of a list
(define reverse*
  (lambda (lis)
    (cond
      ((null? lis) '())
      ((list? (car lis)) (append (reverse* (cdr lis)) (cons (reverse* (car lis)) '())))
      (else (append (reverse* (cdr lis)) (cons (car lis) '()))))))

; only reverses the sublists of a list, but sublists of the sublist are not reversed, and so on
(define reverselists
  (lambda (lis)
    (cond
      ((null? lis) '())
      ((list? (car lis)) (cons (rl-helper (car lis)) (reverselists (cdr lis))))
      (else (cons (car lis) (reverselists (cdr lis)))))))

; reverses the list but not sublists of the list, but it does reverse sublists of the sublist and so on
(define rl-helper
  (lambda (lis)
    (cond
      ((null? lis) '())
      ((list? (car lis)) (append (rl-helper (cdr lis)) (cons (reverselists (car lis)) '())))
      (else (append (rl-helper (cdr lis)) (cons (car lis) '()))))))

; Returns a list containing the sum of all the numbers in the list.  Any sublists are included, but their content is just the sum of the numbers in that sublist
(define partialsums
  (lambda (lis)
    (cond
      ((null? lis) '(0))
      ((number? (car lis)) (cons (+ (car lis) (car (partialsums (cdr lis)))) (cdr (partialsums (cdr lis)))))
      ((list? (car lis)) (cons (+ (car (partialsums (car lis))) (car (partialsums (cdr lis)))) (cons (partialsums (car lis)) (cdr (partialsums (cdr lis))))))
      (else (partialsums (cdr lis))))))

; Removes the atoms in the front of lat, the number of atoms removed equals the number of non-list atoms in lis
(define trimatoms
  (lambda (lis lat)
    (cond
      ((or (null? lis) (null? lat)) lat)
      ((list? (car lis)) (trimatoms (cdr lis) (trimatoms (car lis) lat)))
      (else (trimatoms (cdr lis) (cdr lat))))))

; Returns lis but with each non-list atom of lis replaced with the corresponding atom from lat
(define exchange
  (lambda (lis lat)
    (cond
      ((or (null? lis) (null? lat)) lis)
      ((list? (car lis)) (cons (exchange (car lis) lat) (exchange (cdr lis) (trimatoms (car lis) lat))))
      (else (cons (car lat) (exchange (cdr lis) (cdr lat)))))))
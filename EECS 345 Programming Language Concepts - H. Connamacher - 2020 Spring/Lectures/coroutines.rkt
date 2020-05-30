#lang racket
; coroutine example: functions that pause so other functions can run

; first, here are some basic functions
; insertion sort a list
(define insertionsort
  (lambda (l)
    (cond
      ((null? l) '())
      (else (insert (car l) (insertionsort (cdr l)))))))

(define insert
  (lambda (a l)
    (cond
      ((null? l) (list a))
      ((<= a (car l)) (cons a l))
      (else (cons (car l) (insert a (cdr l)))))))

; compute a list of k pseudorandom numbers between 0 and n-1
(define randomlist
  (lambda (k n seed a b)
    (cond
      ((zero? k) '())
      (else (cons (modulo seed n) (randomlist (- k 1) n (modulo (+ seed a) b) a b))))))

; then, convert these to cps style to replace schemes call stack with continuation functions
(define insertionsort-cps
  (lambda (l return)
    (cond
      ((null? l) (return '()))
      (else (insertionsort-cps (cdr l) (lambda (v) (insert-cps (car l) v return)))))))

(define insert-cps
  (lambda (a l return)
    (cond
      ((null? l) (return (list a)))
      ((<= a (car l)) (return (cons a l)))
      (else (insert-cps a (cdr l) (lambda (v) (return (cons (car l) v))))))))

(define randomlist-cps
  (lambda (k n seed a b return)
    (cond
      ((zero? k) (return '()))
      (else (randomlist-cps (- k 1) n (modulo (+ seed a) b) a b (lambda (v) (return (cons (modulo seed n) v))))))))

; Now we convert the insertionsort and randomlist into coroutines by giving each a "yield" function
; that lets a routine yield to the other function, and it must create its own yield to say how it should restart
;(define insertionsort-co
;  (lambda (l return yield)
;    (cond
;      ((null? l) (return '()))
;      ((when do I yield) (yield 10 l (lambda (l2 y) (insertionsort-co l2 return y))))
;      (else (insertionsort-co (cdr l) (lambda (v) (insert-cps (car l) v return)) yield)))))
;
;(define randomlist-co
;  (lambda (k n seed a b return yield)
;    (cond
;      ((zero? k) (return '()))
;      ((when do I yield?) (yield (return '()) (lambda (k1 l2 y) (randomlist-co k1 n seed a b (lambda (v) (append v l2))))))
;      (else (randomlist-co (- k 1) n (modulo (+ seed a) b) a b (lambda (v) (return (cons (modulo seed n) v))) yield)))))

; Now let's use it.   Let's have the insertion sort routine take a number which is how many elements
; it should sort, and then call the randomlist routine to generate numbers as needed.
; Let's also yield every 8 elements
;
; Run with (insertionsort-co (# elements to create) 0 '() (lambda (v) v) (lambda (k1 l2 y) (randomlist-co k1 (size of random number) (seed) (a large prime) (a large prime) (lambda (v) (append v l2)) y)))

(define insertionsort-co
  (lambda (n count l return yield)
    (cond
      ((zero? n) (return '()))
      ((or (null? l) (= count 8)) (yield 10 l (lambda (l2 y) (insertionsort-co n 0 l2 return y))))
      (else (insertionsort-co (- n 1) (+ count 1) (cdr l) (lambda (v) (insert-cps (car l) v return)) yield)))))

(define randomlist-co
  (lambda (k n seed a b return yield)
    (cond
      ((zero? k) (yield (return '()) (lambda (k1 l2 y) (randomlist-co k1 n seed a b (lambda (v) (append l2 v)) y))))
      (else (randomlist-co (- k 1) n (modulo (+ seed a) b) a b (lambda (v) (return (cons (modulo seed n) v))) yield)))))
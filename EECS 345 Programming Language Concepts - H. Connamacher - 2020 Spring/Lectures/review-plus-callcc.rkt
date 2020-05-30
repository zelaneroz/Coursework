#lang racket

; First example: (duplicate takes an item and a number n and creates a list with n copies of the item
;   (duplicate 'a 4)   should output '(a a a a)
(define duplicate
  (lambda (a n)
    (if (zero? n)
        '()
        (cons a (duplicate a (- n 1))))))

; Second example: (duplicate* takes a list that may contain sublists and a number n and creates a list where each element is duplicated n times, but if the element is a sublist, then the
;    contents of that sublist are also duplicated n times
;   (duplicate* '(a (b c) ((d))) 2)  should return '(a a ((b b c c) (b b c c)) ((((d d) (d d))) (((d d) (d d)))))
(define duplicate*
  (lambda (lis n)
    (cond
      ((null? lis) '())
      ((list? (car lis)) (cons (duplicate (duplicate* (car lis) n) n) (duplicate* (cdr lis) n)))
      (else (append (duplicate (car lis) n) (duplicate* (cdr lis) n))))))

; Third example for the homework.  Using call/cc create a method sumwithcut that sums a list of numbers.  However there are 3 non-numbers that can appear in the list:
;    cut:    Any values between cut and the next end are not counted in the sum.  However if a cut appears without a later end, the cut is ignored.
;    end:    Used to end a subseqeunce of numbers that are ignored in the sum.  An end that appears without a preceding cut is ignored.
;    allow:  If used between cut and end, the number immediately after allow is included in the sum.  Allow is ignored if used outside of cut and end.
;  (sum-with-cut '(1 2 3 cut 4 5 6 end 7))            =>  outputs 13  (1 + 2 + 3 + 7)
;  (sum-with-cut '(1 2 3 cut 4 allow 5 6 end 7))      =>  outputs 18  (1 + 2 + 3 + 5 + 7)
;  (sum-with-cut '(cut 1 2 allow 3 4 allow 5 6 end))  => outputs 8  (3 + 5)
;  (sum-with-cut '(1 2 3 cut 4 5 6 7))                =>  outputs 28 because the cut is ignored
;  (sum-with-cut '(1 2 end 3 4 5 6 cut 7 end))        =>  outputs 21 because the first end is ignored  (1 + 2 + 3 + 4 + 5 + 6)

(define sum-with-cut
  (lambda (lis)
    (sumwithcut lis (lambda (v) v))))

(define sumwithcut
  (lambda (lis break)
    (cond
      ((null? lis) 0)
      ((eq? (car lis) 'cut) (call/cc (lambda (k) (sumwithcut (cdr lis) k))))
      ((eq? (car lis) 'end) (break (sumwithcut (cdr lis) (lambda (v) v))))
      ((eq? (car lis) 'allow) (+ (cadr lis) (sumwithcut (cddr lis) (lambda (v) (break (+ (cadr lis) v))))))
      (else (+ (car lis) (sumwithcut (cdr lis) break))))))
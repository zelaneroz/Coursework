#lang racket

; This lecture is about abstracting recursion.  Can we do recursion without binding a function
;  name to the body of the function?  What is recursion really?
(define factorial
  (lambda (n)
    (if (zero? n)
        1
        (* n (factorial (- n 1))))))

; We are using "crash" for when we get to the end of a recursion unrolling
(define crash
  (lambda (n)
    (error 'crash)))

; Attempt 1:  We are going to "unroll" the recursion so that, instead of using "fact1" in the
; body, whenever we need another round of the recursion, we write in the function explicitly.
(define fact1
  (lambda (n)
    (if (zero? n)
        1
        (* n ((lambda (n)
                (if (zero? n)
                    1
                    (* n ((lambda (n)
                            (if (zero? n)
                                1
                                (* n ((lambda (n)
                                        (if (zero? n)
                                            1
                                            (* n (crash (- n 1)))))
                                      (- n 1)))))
                          (- n 1)))))
              (- n 1))))))


; Version 2: We are going to again unroll the recursion, but now we are going to change the
;  order.  We have a function that takes a function f as input and outputs the recursive
;  function that uses f as its recursive call.
(define fact2
  ((lambda (f)
     (lambda (n)
       (if (zero? n)
           1
           (* n (f (- n 1))))))
   ((lambda (f)
      (lambda (n)
        (if (zero? n)
            1
            (* n (f (- n 1))))))
    ((lambda (f)
       (lambda (n)
         (if (zero? n)
             1
             (* n (f (- n 1))))))
     ((lambda (f)
        (lambda (n)
          (if (zero? n)
              1
              (* n (f (- n 1))))))
      crash)))))


; Version 3: We do the same thing, but rearranged so that we do not have to keep writing the
;   same function body over and over.  We take the function that inputs f and outputs the "recursive"
;   function and pass it as a parameter m.  Now each time we want to unroll the loop, we make another
;   call to m.
(define fact3
  ((lambda (m)
     (m (m (m (m (m (m crash)))))))
   (lambda (f)
      (lambda (n)
        (if (zero? n)
            1
            (* n (f (- n 1))))))))

; Version 4: A Y-Combinator.  The function that takes generates the next "unrolling" of the recursion
;   takes itself as input!  Now, we get an unlimited recursion because each time we need to make
;   another recursive call, the function call itself and generates the next iteration of the recursion.
(define fact4
  ((lambda (m)
     (m m))
   (lambda (f)
      (lambda (n)
        (if (zero? n)
            1
            (* n ((f f) (- n 1))))))))

; create append using exactly same model
(define myappend
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (myappend (cdr l1) l2)))))

; Here is the y-combinator version of myappend
(define myappend2
  ((lambda (m)
     (m m))
   (lambda (f)
     (lambda (l1 l2)
       (if (null? l1)
           l2
           (cons (car l1) ((f f) (cdr l1) l2)))))))

; Can you create a y-combinator version for reversing a list?  Here is the framework.
;
;(define myreverse
;  ((lambda (r a)
;     (r r a))
;   (lambda (f a)  ; reverse function takes the append and reverse
;     )
;   (lambda (f) ; the append function
;     )))


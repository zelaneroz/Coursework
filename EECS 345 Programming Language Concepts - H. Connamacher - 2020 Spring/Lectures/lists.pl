% A list is [H | T] where H is the head (car) and T is the tail (cdr)
% mappend(operand1, operand2, result).
myappend([], L, L).
myappend([H|T], L, [H|S]) :- myappend(T, L, S).

% contains: is A an element of list L?
contains(A, [A|_]).
contains(A, [_|T]) :- contains(A,T).

% removeall, removes all occurrence of an element from a list
% myreverse, reverses a list
% myflatten, takes a list that contains sublists, and returns an list of just the elements
% removeallstar, takes an element and a list containing lists and removes all occurrences of the element

removeall(_, [], []).
removeall(X, [X|T], S) :- removeall(X, T, S).
removeall(X, [H|T], [H|S]) :- removeall(X, T, S).

myreverse([], []).
myreverse([H|T], R) :- myreverse(T, S), myappend(S, [H], R).

myflatten([], []).
% do the case where the head of the list is a list
myflatten([H|T], R) :- myflatten(H, FH), myflatten(T, FT), myappend(FH, FT, R).
% do the case where the head of the list is not a list
myflatten([H|T], [H|FT]) :- myflatten(T, FT). 

% For calculating numbers, we use "is"
% Everything to the right of the is must be fully resolved.
factorial(0,1).
factorial(N,F) :- M is N-1, factorial(M,R), F is R * N.
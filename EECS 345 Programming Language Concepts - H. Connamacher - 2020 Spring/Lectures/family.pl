% This is a comment
% A file is basically a database.
% Facts end in a period.
% values and predicates are all lowercase

parentof(arthur, ron).
parentof(molly, ron).
parentof(arthur, fred).
parentof(molly, fred).
parentof(arthur, george).
parentof(molly, george).
parentof(arthur, ginny).
parentof(molly, ginny).
parentof(james, harry).
parentof(lily, harry).
parentof(petunia, dudley).
parentof(vernon, dudley).
parentof(harry, albusjr).
parentof(ginny, albusjr).
parentof(harry, jamesjr).
parentof(ginny, jamesjr).
parentof(harry, lilyjr).
parentof(ginny, lilyjr).
parentof(mathilda, lily).
parentof(mathilda, petunia).
parentof(ron, rose).
parentof(hermione, rose).
parentof(ron, hugo).
parentof(hermione, hugo).

married(harry, ginny).
married(hermione, ron).
married(lily, james).

% Inference rules are the form:
%  A :- B, C.
% means, logically, that B and C implies A.
% all variables are upper case
grandparentof(A, B) :- parentof(A, X), parentof(X, B).

% sibling
sibling(A, B) :- parentof(X, A), parentof(X, B), A \= B.

% cousin (each of your parents are siblings)
cousin(A, B) :- parentof(X, A), parentof(Y, B), sibling(X, Y).

% parentinlaw (harry's inlaws are ginny's parents)
% a logical or is formed by multiple inference rules
parentinlaw(A,B) :- parentof(A,X), married(X,B).
parentinlaw(A,B) :- parentof(A,X), married(B,X).


% factorial
% factorial(0,1).
% factorial(N, F) :- M is N - 1, factorial(M, R), !, F is R * N.

factorial(0,1).
factorial(N, F) :- factorial2(M, R), N is M + 1, F is R * N, !.

factorial2(0, 1).
factorial2(N, F) :- factorial2(M, R), N is M + 1, F is R * N.

% Prolog cut:  !
% This is a predicate that is always true.
% When crossing the cut, prolog fixes any resolved values to
% have only those values (no backtracking to try a new value)
% 
% After crossing the cut, only variables without values yet will we be still searching on

removeall(_, [], []).
removeall(A, [A|T], R) :- !, removeall(A, T, R).
removeall(A, [H|T], [H|R]) :- removeall(A, T, R).

contains(A, [A|_]) :- !.
contains(A, [_|T]) :- contains(A, T).

% Why are prolog rules only using a single value on the left side?
% (a :- b,c,d  ==   (b AND c AND d -> a)  ==
%   NOT(b and c and d) OR a)
%   (NOT b) OR (NOT c) OR (NOT d) OR A
% Clauses with a single true literal are "Horn" clauses,
%   and these can be resolved with a polynomial time algorithm
%
% The fastest known algorithms for resolving clauses with multiple positive literals are exponential time.
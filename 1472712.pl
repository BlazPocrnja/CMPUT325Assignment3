/*
CMPUT 325 Assignment 3
Author: Blaz Pocrnja
Student ID: 1472712
*/

/*	Question 1
*/
xreverse(L, R) :- xreverse(L, R, []).
xreverse([], R, R).
xreverse([Front|Rest], R, Accum) :- xreverse(Rest, R, [Front|Accum]).

/*	Question 2
*/
xunique(L,O) :- xunique(L, O, []).
xunique([], O, O).
xunique([F|R], O, Accum) :- member(F, Accum), xunique(R, O, Accum). 
xunique([F|R], O, Accum) :- \+ member(F, Accum), append(Accum, [F], L), xunique(R, O, L).

/* Question 3
*/
xdiff(L1, L2, L):- subtract(L1, L2, L3), xunique(L3, L).


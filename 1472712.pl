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


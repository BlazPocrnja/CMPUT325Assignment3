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
xunique(L, O) :- xunique(L, O, []).
xunique([], O, O).
xunique([F|R], O, Accum) :- member(F, Accum), xunique(R, O, Accum). 
xunique([F|R], O, Accum) :- \+ member(F, Accum), append(Accum, [F], L), xunique(R, O, L).

/*	Question 3
*/
xdiff(L1, L2, L) :- subtract(L1, L2, L3), xunique(L3, L).

/*	Question 4
*/
removeLast(L, L1, Last) :- xreverse(L, [F|R]), xreverse(R,L1), Last = F.

/*	Question 5
*/
node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).

/*	Question 5.1
*/
allConnected([]).
allConnected([A|L]) :- connect(A, L), allConnected(L).

connect(A, []).
connect(A, [F|R]) :- (edge(A, F) ; edge(F, A)) , connect(A, R).

/*	Question 5.2
*/
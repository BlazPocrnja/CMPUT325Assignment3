/*
CMPUT 325 Assignment 3
Author: Blaz Pocrnja
Student ID: 1472712
*/

/*	Question 1
		xreverse(+L, ?R): reverses a list, where L is a given list and R is either 
		a variable or another given list.
*/
xreverse(L, R) :- xreverse(L, R, []).
xreverse([], R, R).
xreverse([Front|Rest], R, Accum) :- xreverse(Rest, R, [Front|Accum]).


/*	Question 2
		xunique(+L, ?O): L is a given list of atoms and O is a copy of L 
		where all the duplicates have been removed. O can be either a variable 
		or a given list. The elements of O are in the order in which they 
		first appear in L.
*/
xunique(L, O) :- xunique(L, O, []).
xunique([], O, O).
xunique([F|R], O, Accum) :- member(F, Accum), xunique(R, O, Accum). 
xunique([F|R], O, Accum) :- \+ member(F, Accum), append(Accum, [F], L), xunique(R, O, L).


/*	Question 3
		xdiff(+L1, +L2, -L): L1 and L2 are given lists of atoms, and L 
		contains the elements that are contained in L1 but not L2 
		(set difference of L1 and L2). 
*/
xdiff(L1, L2, L) :- subtract(L1, L2, L3), xunique(L3, L).


/*	Question 4
		removeLast(+L, ?L1, ?Last): L is a given non-empty list, L1 is the result of 
		removing the last element from L, and Last is that last element. L1 and Last 
		can be either variables or given values.
*/
removeLast(L, L1, Last) :- xreverse(L, [F|R]), xreverse(R,L1), Last = F.


/*	Question 5
		The following predicates were given as per the assignment.
*/

% clique(?L): returns a list of subsets of nodes that are all connected to eachother.
clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

% xsubset(?SL, +L): Succeeds if L is the list which contains all elements from 
% SL in the same order as in SL.
xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

% xappend(?L1, ?L2, ?L3): Succeeds if L3 is the result of appending L2 to L1.
xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).

/*	Question 5.1
		allConnected(?L): tests if each node in L is connected to each other node in L. 
		A node A is connected to another node B if either edge(A,B) or edge(B,A) is true.
*/
allConnected([]).
allConnected([A|L]) :- connect(A, L), allConnected(L).

% connect(?A, +L): tests if A is connected to every node in L.
connect(_, []).
connect(A, [F|R]) :- (edge(A, F) ; edge(F, A)) , connect(A, R).

/*	Question 5.2
		maxclique(+N, -Cliques): computes all the maximal cliques of size N that are contained 
		in a given graph. N is the given input, Cliques is the output you compute: a list of cliques. 
		A clique is maximal if there is no larger clique that contains it. 
*/

% issubset(?A, +L): Succeeds if the list A is a subset of any list element in the list L.
issubset(A, [F|_]) :- xsubset(A, F).
issubset(A, [_|R]) :- issubset(A, R).

maxclique(N, Cliques) :- findall(L, (clique(L) , length(L, N)), L1), 
						 X is N+1, findall(L, (clique(L) , length(L, X)), L2) , 
						 findall(S, issubset(S, L2), L3), xdiff(L1, L3, Cliques).

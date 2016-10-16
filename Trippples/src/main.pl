:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').
:- include('Tiles.pl').

run:-
	write('\33\[2J'), nl,
	write('\t\t#############################################'), nl, nl,
	write('\t\t####              TRIPPLES               ####'), nl, nl,
	write('\t\t#############################################'), nl, nl,
	board(T), startBoard(T).

% Game board
startingBoard([[2, 0, 0, 0, 0, 0, 0, 3],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [4, 0, 0, 0, 0, 0, 0, 1]]).

board([[2, 5, 6, 7, 8, 9, 10, 3],
	   [11, 12, 13, 14, 15, 16, 17, 18],
	   [19, 20, 21, 22, 23, 24, 25, 26],
	   [27, 28, 29, 0, 30, 44, 31, 32],
	   [33, 34, 35, 0, 0, 36, 37, 38],
	   [39, 40, 41, 42, 43, 0, 45, 46],
	   [47, 48, 49, 50, 51, 52, 53, 54],
	   [4, 55, 56, 57, 58, 59, 60, 1]]).

printRowSeparator:-
	write('#-----------------------------------#').

printDownBorder:-
	write('#####################################').

printBorder:-
    write('#').

printColSeparator:-
    write('|').

printTopBorder:-
	write('#####################################'), nl,
    write('#   |   |   |   |   |   |   |   |   #'), nl,
    write('#   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 #'), nl,
    write('#   |   |   |   |   |   |   |   |   #'), nl,
    printRowSeparator, nl.

% Prints a line of the game board
displayRowA([]).

displayRowA([C]):-
	translate(C, 1),
	printBorder.

displayRowA([C|Cs]):-
	translate(C, 1),
	printColSeparator,
	displayRowA(Cs).

displayRowB([]).

displayRowB([C]):-
	translate(C, 2),
	printBorder.

displayRowB([C|Cs]):-
	translate(C, 2),
	printColSeparator,
	displayRowB(Cs).

displayRowC([]).

displayRowC([C]):-
	translate(C, 3),
	printBorder.

displayRowC([C|Cs]):-
	translate(C, 3),
	printColSeparator,
	displayRowC(Cs).

% Prints the game board
startBoard(T):-
	printTopBorder,
	displayBoard(T, 0).

displayBoard([T], N):-
    X is N+1,
    write('#   |'),
	displayRowA(T), nl,
    write('# '),
    write(X),
    write(' |'),
	displayRowB(T), nl,
    write('#   |'),    
	displayRowC(T), nl,
	printDownBorder, nl.


displayBoard([T|Ts], N):-
    X is N+1,
    write('#   |'),
	displayRowA(T), nl,
    write('# '),
    write(X),
    write(' |'),
	displayRowB(T), nl,
    write('#   |'),    
	displayRowC(T), nl,
	printRowSeparator, nl,
	displayBoard(Ts, X).



% Game predicates

% Moves the marker of a player to a different tile
% moveMarker(Player, Tile).
%gameEnd(G).




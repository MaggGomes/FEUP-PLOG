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
board([[1, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 1, 0, 0, 0, 2, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 2, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0]]).

printTopBorder:-
	write(' _______________________________'), nl.

printSeparator:-
	write(' -------------------------------').

% Prints a line of the game board
displayRowA([]).

displayRowA([C]):-
	translate(C, 1),
	write('|').

displayRowA([C|Cs]):-
	translate(C, 1),
	write('|'),
	displayRow(Cs).

displayRowB([]).

displayRowB([C]):-
	translate(C, 2),
	write('|').

displayRowB([C|Cs]):-
	translate(C, 2),
	write('|'),
	displayRow(Cs).

displayRowC([]).

displayRowC([C]):-
	translate(C, 3),
	write('|').

displayRowC([C|Cs]):-
	translate(C, 3),
	write('|'),
	displayRow(Cs).

% Prints the game board
startBoard(T):-
	printTopBorder,
	displayBoard(T).

displayBoard([]).

displayBoard([T|Ts]):-
	write('|'),
	displayRowA(T), nl,
	write('|'),
	displayRowB(T), nl,
	write('|'),
	displayRowC(T), nl,
	printSeparator, nl,
	displayBoard(Ts).



% Game predicates

% Moves the marker of a player to a different tile
% moveMarker(Player, Tile).




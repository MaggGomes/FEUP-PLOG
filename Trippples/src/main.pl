:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').
:- include('Tiles.pl').

run:-
	write('\33\[2J'), nl,
	write('\t\t#############################################'), nl, nl,
	write('\t\t####              TRIPPLES               ####'), nl, nl,
	write('\t\t#############################################'), nl, nl,
	endBoard(T), startBoard(T).

% Game board
startingBoard([[[2, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [3, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
	   [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],[0, 0], [0, 0], [0, 0]],
       [[4, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [1, 0]]]).

intermediateBoard([[[2, 0], [5, 0], [6, 0], [7, 0], [8, 0], [9, 0], [10, 0], [3, 0]],
       [[11, 0], [12, 0], [13, 0], [14, 0], [15, 0], [16, 0], [17,0], [18, 0]],
       [[19, 0], [20, 1], [21, 0], [22, 0], [23, 0], [24, 0], [25, 0], [26, 0]],
       [[27, 0], [28, 0], [29, 0], [0, 0], [30, 0], [44, 0], [31, 0], [32, 0]],
       [[33, 0], [34, 0], [35, 0], [0, 0], [0, 0], [36, 0], [37, 0], [38, 0]],
       [[39, 0], [40, 0], [41, 0], [42, 0], [43, 0], [0, 0], [45, 0], [46, 0]],
       [[47, 0], [48, 2], [49, 0], [50, 0], [51, 0], [52, 0], [53, 0], [54, 0]],
       [[4, 0], [55, 0], [56, 0], [57, 0], [58, 0], [59, 0], [60, 0], [1, 0]]]).

endBoard([[[2, 0], [5, 0], [6, 0], [7, 0], [8, 0], [9, 0], [10, 0], [3, 0]],
       [[11, 0], [12, 0], [13, 0], [14, 0], [15, 0], [16, 0], [17,0], [18, 0]],
       [[19, 0], [20, 0], [21, 0], [22, 0], [23, 0], [24, 0], [25, 0], [26, 0]],
       [[27, 0], [28, 0], [29, 0], [0, 0], [30, 0], [44, 2], [31, 0], [32, 0]],
       [[33, 0], [34, 0], [35, 0], [0, 0], [0, 0], [36, 0], [37, 0], [38, 0]],
       [[39, 0], [40, 0], [41, 0], [42, 0], [43, 0], [0, 0], [45, 0], [46, 0]],
       [[47, 0], [48, 0], [49, 0], [50, 0], [51, 0], [52, 0], [53, 0], [54, 0]],
       [[4, 0], [55, 0], [56, 0], [57, 0], [58, 0], [59, 0], [60, 0], [1, 1]]]).

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
displayCell([T, P], R):-
    translate(T, P, R).

displayRow([], _).

displayRow([C], R):-
	displayCell(C, R),
	printBorder.

displayRow([C|Cs], R):-
    displayCell(C, R),
	printColSeparator,
	displayRow(Cs, R).

% Prints the game board
startBoard(T):-
	printTopBorder,
	displayBoard(T, 0).

displayBoard([T], N):-
    X is N+1,
    write('#   |'),
	displayRow(T, 1), nl,
    write('# '),
    write(X),
    write(' |'),
	displayRow(T, 2), nl,
    write('#   |'),    
	displayRow(T, 3), nl,
	printDownBorder, nl.


displayBoard([T|Ts], N):-
    X is N+1,
    write('#   |'),
	displayRow(T, 1), nl,
    write('# '),
    write(X),
    write(' |'),
	displayRow(T, 2), nl,
    write('#   |'),    
	displayRow(T, 3), nl,
	printRowSeparator, nl,
	displayBoard(Ts, X).

% Game predicates

% Moves the marker of a player to a different tile
verifyPlace([T|Ts], PosX, PosY).
placeTile(Player, Tile, [T|Ts], PosX, PosY).
verifyMove(Player, [T|Ts], PosX, PosY).
movePlayer(Player, [T|Ts], PosX, PoY).
gameEnd(G).




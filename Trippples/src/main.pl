:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').
:- include('Tiles.pl').
:- dynamic player/3.

run:-
	write('\33\[2J'), nl,
	write('\t\t#############################################'), nl, nl,
	write('\t\t####              TRIPPLES               ####'), nl, nl,
	write('\t\t#############################################'), nl, nl,
    board(T), player(1, X1, Y1), player(2, X2, Y2), startBoard(T, X1, Y1, X2, Y2).

% Game board
board([[2, 5, 6, 7, 8, 9, 10, 3],
       [11, 12, 13, 14, 15, 16, 17, 18],
       [19, 20, 21, 22, 23, 24, 25, 26],
       [27, 28, 29, 0, 30, 44, 31, 32],
       [33, 34, 35, 0, 0, 36, 37, 38],
       [39, 40, 41, 42, 43, 0, 45, 46],
       [47, 48, 49, 50, 51, 52, 53, 54],
       [4, 55, 56, 57, 58, 59, 60, 1]]).

% Predicate with the position of players
player(1, 3, 5).
player(2, 7, 5).

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

%criar predicado que faça automaticamente isto
%retract(position(+, _, _)), assert(position(+, 2, 1)).


startBoard(T, X1, Y1, X2, Y2):-
	printTopBorder,
	displayBoard(T, 1, X1, Y1, X2, Y2).

printPlayerCell(Line, Col, X1, Y1, _, _, _):-
    Line == X1,
    Col == Y1,
    write('+').

printPlayerCell(Line, Col, _, _, X2, Y2, _):-
    Line == X2,
    Col == Y2,    
    write('x').

printPlayerCell(_, _, _, _, _, _, MidCenter):-  
    write(MidCenter).

printCellLine(X, Y, Z):-
    write(X), write(Y), write(Z).

displayTop([]).

displayTop([C]):-
    tile(C, _, TopLeft, TopCenter, TopRight, _, _, _, _, _, _),    
    printCellLine(TopLeft, TopCenter, TopRight),
    printBorder, nl.

displayTop([C|Cs]):-
    tile(C, _, TopLeft, TopCenter, TopRight, _, _, _, _, _, _),
    printCellLine(TopLeft, TopCenter, TopRight),
    printColSeparator, 
    displayTop(Cs).

displayMid([C], Line, Col, X1, Y1, X2, Y2):-
    tile(C, _, _, _, _, MidLeft, MidCenter, MidRight, _, _, _),
    write(MidLeft),
    printPlayerCell(Line, Col, X1, Y1, X2, Y2, MidCenter),
    write(MidRight),
    printBorder, nl.

displayMid([C|Cs], Line, Col, X1, Y1, X2, Y2):-
    tile(C, _, _, _, _, MidLeft, MidCenter, MidRight, _, _, _),
    write(MidLeft),
    printPlayerCell(Line, Col, X1, Y1, X2, Y2, MidCenter),
    write(MidRight),
    printColSeparator,
    NextCol is Col + 1,
    displayMid(Cs, Line, NextCol, X1, Y1, X2, Y2).

displayBottom([]).

displayBottom([C]):-
    tile(C, _, _, _, _, _, _, _, BottomLeft, BottomCenter, BottomRight),
    printCellLine(BottomLeft, BottomCenter, BottomRight), 
    printBorder, nl.

displayBottom([C|Cs]):-
    tile(C, _, _, _, _, _, _, _, BottomLeft, BottomCenter, BottomRight),
    printCellLine(BottomLeft, BottomCenter, BottomRight),
    printColSeparator,
    displayBottom(Cs).

displayBoard([], _, _, _, _, _).

displayBoard([T], Line, X1, Y1, X2, Y2):-    
    write('#   |'),
    displayTop(T),
    write('# '),
    write(Line),
    write(' |'),
    displayMid(T, Line, 1, X1, Y1, X2, Y2),
    write('#   |'),
    displayBottom(T),
    printDownBorder.

displayBoard([T|Ts], Line, X1, Y1, X2, Y2):-        
    write('#   |'),    
    displayTop(T),
    write('# '),
    write(Line),
    write(' |'),
    displayMid(T, Line, 1, X1, Y1, X2, Y2),
    write('#   |'),
    displayBottom(T),
    printRowSeparator, nl,  
    NextLine is Line+1,      
    displayBoard(Ts, NextLine, X1, Y1, X2, Y2).

% Game predicates

% Moves the marker of a player to a different tile
%verifyPlace([T|Ts], PosX, PosY).
%placeTile(Player, Tile, [T|Ts], PosX, PosY).
%verifyMove(Player, [T|Ts], PosX, PosY).
%movePlayer(Player, [T|Ts], PosX, PoY).
%gameEnd(G).




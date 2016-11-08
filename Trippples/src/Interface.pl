
% FALTA VALIDAR INPUT

%%%%%%%%%% Gets player input %%%%%%%%%%
% Ask the user new marker position
playerInput(P):-
    nl, write('PLAYER '), write(P), nl,
    write('Horizontal coordinate:'), read(Col),
    write('Vertical coordinate'), read(Line),
    checkFirstMove(P, Line, Col).

playerInput(P1, P2):-
    nl, write('PLAYER '), write(P1), nl,
    write('Horizontal coordinate:'), read(Col),
    write('Vertical coordinate'), read(Line),
    checkMove(P1, P2, Line, Col).

% Check validaty of player input
checkFirstMove(P, Line, Col):-
    player(P, PLine, PCol, _, _),
    \+((Line =:= PLine, Col =:= PCol)),
    Line > 0, Line < 9, Col > 0, Col < 9,
    (Line-PLine)=<1, (PLine-Line)=<1, (Col-PCol)=<1, (PCol-Col)=<1, 
    board(T),
    getCell(T, Line, Col, Element),
	Element =\= 0,
    updatePlayer(P, Line, Col).

checkFirstMove(P, _, _):-
    write('\nWrong play. Please try again!\n'),
    playerInput(P), !.

checkMove(P1, P2, Line, Col):-
    player(P1, P1Line, P1Col, _, _),
    Line > 0, Line < 9, Col > 0, Col < 9,
    (Line-P1Line)=<1, (P1Line-Line)=<1, (Col-P1Col)=<1, (P1Col-Col)=<1, 
    board(T),
    getCell(T, Line, Col, Element),
	Element =\= 0,
    valideMove(T, P1, P2, Line, Col).

checkMove(P1, P2, _, _):-
    write('\nWrong play. Please try again!\n'),
    playerInput(P1, P2), !.   

%%%%%%%%%% Displays game title %%%%%%%%%%
% Prints the logo of the game
displayLogo:-   
    clearScreen, nl,
	write('#####################################'), nl, nl,
	write('####          TRIPPLES           ####'), nl, nl,
	write('#####################################'), nl, nl.

% Borders and column separators of the board
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

%%%%%%%%%% Displays game title %%%%%%%%%%
% Displays the game board
printBoard(T, X1, Y1, X2, Y2):-
	printTopBorder,
	displayBoard(T, 1, X1, Y1, X2, Y2).

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
    printDownBorder, nl.

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

% Displays top line of a tile
displayTop([]).

displayTop([C]):-
    tile(C, TopLeft, TopCenter, TopRight, _, _, _, _, _, _),    
    printCellLine(TopLeft, TopCenter, TopRight),
    printBorder, nl.

displayTop([C|Cs]):-
    tile(C, TopLeft, TopCenter, TopRight, _, _, _, _, _, _),
    printCellLine(TopLeft, TopCenter, TopRight),
    printColSeparator, 
    displayTop(Cs).

% Displays mid line of a tile
displayMid([C], Line, Col, X1, Y1, X2, Y2):-
    tile(C, _, _, _, MidLeft, MidCenter, MidRight, _, _, _),
    write(MidLeft),
    printPlayerCell(Line, Col, X1, Y1, X2, Y2, MidCenter),
    write(MidRight),
    printBorder, nl.

displayMid([C|Cs], Line, Col, X1, Y1, X2, Y2):-
    tile(C, _, _, _, MidLeft, MidCenter, MidRight, _, _, _),
    write(MidLeft),
    printPlayerCell(Line, Col, X1, Y1, X2, Y2, MidCenter),
    write(MidRight),
    printColSeparator,
    NextCol is Col + 1,
    displayMid(Cs, Line, NextCol, X1, Y1, X2, Y2).

% Displays bottom line of a tile
displayBottom([]).

displayBottom([C]):-
    tile(C, _, _, _, _, _, _, BottomLeft, BottomCenter, BottomRight),
    printCellLine(BottomLeft, BottomCenter, BottomRight), 
    printBorder, nl.

displayBottom([C|Cs]):-
    tile(C, _, _, _, _, _, _, BottomLeft, BottomCenter, BottomRight),
    printCellLine(BottomLeft, BottomCenter, BottomRight),
    printColSeparator,
    displayBottom(Cs).

% Display players

% Print player 1 marker
printPlayerCell(Line, Col, X1, Y1, _, _, _):-
    Line == X1,
    Col == Y1,
    write('1').

% Print player 2 marker
printPlayerCell(Line, Col, _, _, X2, Y2, _):-
    Line == X2,
    Col == Y2,    
    write('2').

% Prints the center of the tile, when not occupied by a player
printPlayerCell(_, _, _, _, _, _, MidCenter):-  
    write(MidCenter).

% Prints a tile line (each tile divided in 3 lines)
printCellLine(X, Y, Z):-
    write(X), write(Y), write(Z).
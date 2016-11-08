:- dynamic player/5.

%%%%%%%%%% Game boards %%%%%%%%%%
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

%%%%%%%%%% Predicates with the starting position of each player %%%%%%%%%%
% Player, Initial line, Initial column, Final line, Final column
player(1, 1, 1, 8, 8).
player(2, 8, 1, 1, 8).

%%%%%%%%%% Starts a new game %%%%%%%%%%
startGame:-
	updateBoard,
	playFirstMove, 
    updateGame.

%%%%%%%%%% Predicates to update the game cycle %%%%%%%%%%
% Player 1 makes the first play in the game
playFirstMove:-
	playerInput(1).

% Updates the game
updateGame:-
	player(1, Line1, Col1, _, _), player(2, Line2, Col2, _, _),
	((Line1 =:= 1, Col1 =:= 8); (Line2 =:= 8, Col2 =:= 8)),
	resetPlayersPosition,
	write('\n\nThe game is over!\n\n\n'),
	pressAnyKeyToContinue, !, run.

updateGame:-
	playerInput(2, 1),	
	updateBoard,
	playerInput(1, 2),
	updateBoard,
	updateGame.

%%%%%%%%%% Updates the board %%%%%%%%%%
% Updates the board
updateBoard:-
	board(T), player(1, Line1, Col1, _, _), player(2, Line2, Col2, _, _), printBoard(T, Line1, Col1, Line2, Col2).

%%%%%%%%%% Updates the position of the player P %%%%%%%%%%
% Updates the player position
updatePlayer(P, Line, Col):-
	retract(player(P, _, _, _, _)), assert(player(P, Line, Col, _, _)).

%%%%%%%%%% Resets the positions of the players to the initial ones %%%%%%%%%%
resetPlayersPosition:-
	retract(player(1, _, _, Line1, Col1)), assert(player(1, 1, 1, Line1, Col1)),
	retract(player(2, _, _, Line2, Col2)), assert(player(2, 8, 2, Line2, Col2)).

%%%%%%%%%% Player moves %%%%%%%%%%
valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, '\\', _, _, _, _, _, _, _, _),	
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col =:= P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, '|', _, _, _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, '/', _, _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line =:= P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, '-', _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line =:= P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, '-', _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, '/', _, _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col =:= P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, _, '|', _),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(T, P1, P2, Line, Col):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, _, _, '\\'),
    updatePlayer(P1, Line, Col), nl, !.

valideMove(_, P1, P2, _, _):-
	write('\nWrong play. Please try again!\n'),
	playerInput(P1, P2).

%%%%%%%%%% Predicates set e get for board manipulation %%%%%%%%%%
% Sets a new element in the board
setCell(0, Col, [T|Ts], NewElement, [NewT|Ts]):-
    setCell(Col, T, NewElement, NewT).

setCell(Row, Col, [T|Ts], NewElement, [T|NewTs]):-
    Row > 0,
    NewRow is Row-1,
    setCell(NewRow, Col, Ts, NewElement, NewTs).

setCell(0, [_|Ts], NewElement, [NewElement|Ts]).
setCell(Col, [T|Ts], NewElement, [T|NewTs]):-
    Col > 0,
    NewCol is Col-1,
    setCell(NewCol, [Ts], NewElement, NewTs).

% Gets an element of the board
getCell(Board, Row, Col, Element):-
	VarX is Row-1,
	VarY is Col-1,
    nth0(VarX, Board, List),
    nth0(VarY, List, Element).

% Get the tile where the player marker is placed
getPlayerTile(T, P, Tile):-
	player(P, PLine, PCol, _, _),
	getCell(T, PLine, PCol, Tile).
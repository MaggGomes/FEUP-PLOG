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

tiedBoard([[2, 31, 6, 7, 8, 9, 10, 3],
       [11, 0, 13, 14, 15, 16, 17, 18],
       [19, 20, 21, 22, 23, 24, 25, 26],
       [27, 28, 29, 12, 30, 44, 5, 32],
       [33, 34, 35, 0, 0, 36, 37, 38],
       [56, 55, 41, 39, 43, 0, 45, 46],
       [47, 48, 49, 50, 51, 52, 53, 54],
       [4, 40, 0, 57, 58, 59, 60, 1]]).

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
player(1, 1, 1, 1, 8).
player(2, 8, 1, 8, 8).

%%%%%%%%%% Starts a new game %%%%%%%%%%
% There are 4 different modes of game:
% - Mode 1: Human vs Human
% - Mode 2: Human vs Computer lvl Begginer
% - Mode 3: Human vs Computer lvl Advanced
% - Mode 4: Computer vs Computer
% In mode Human vs Computer, Human will be player 1 and Computer player 2

startGame(Mode):-
	board(T),
	updateBoard(T),
	playFirstMove(T),
	updateBoard(T), 
	updateGame(T, 2, 1, Mode).

%%%%%%%%%% Predicates to update the game cycle %%%%%%%%%%
% Player 1 makes the first play in the game
playFirstMove(T):-
	playerInput(T, 1).

% Updates the game
% Predicate that updates the game Human vs Human
updateGame(_, _, _, _):-
	gameOver(Winner),							
	resetPlayersPosition,
	write('\n\nThe game is over!\n\n\n'),
	format('The winner of the game is Player ~w! ~n', [Winner]),
	pressAnyKeyToContinue, !, run.

updateGame(T, P1, P2, Mode):-
	movePlayer(T, P1, P2, Mode),	
	updateBoard(T),
	updateGame(T, P2, P1, Mode).

% Predicate to move a player marker
% Human vs Human
movePlayer(T, P1, P2, Mode):-
	Mode =:= 1,
	playerInput(T, P1, P2, Mode), !.

% Human vs Computer level begginer
movePlayer(T, P1, P2, Mode):-
	Mode =:= 2,
	P1 =:= 1,
	playerInput(T, P1, P2, Mode), !.

movePlayer(T, P1, P2, Mode):-
	Mode =:= 2,
	P1 =:= 2,
	generateCompPlay(T, P1, P2, Mode), !.

% Human vs Computer level Advanced
movePlayer(T, P1, P2, Mode):-
	Mode =:= 3,
	P1 =:= 1,
	playerInput(T, P1, P2, Mode), !.

movePlayer(T, P1, P2, Mode):-
	Mode =:= 3,
	P1 =:= 2,
	generateCompPlay(T, P1, P2, Mode), !.

% Computer vs Computer
movePlayer(T, P1, P2, Mode):-
	Mode =:= 4,
	generateCompPlay(T, P1, P2, Mode), !.

% Generates a play for the computer
generateCompPlay(T, P1, P2, Mode):-
	player(P1, P1Line, P1Col, _, _),
	LineMin is P1Line-1,
	LineMax is P1Line+2,
	ColMin is P1Col-1,
	ColMax is P1Col+2,
	random(LineMin, LineMax, Line),
	random(ColMin, ColMax, Col),
	checkMove(T, P1, P2, Line, Col, Mode).



%%%%%%%%%% Checks the validaty of a play %%%%%%%%%% 
% Check validaty of player input
checkFirstMove(T, P, Line, Col):-
    integer(Line),
    integer(Col),
    player(P, PLine, PCol, _, _),
    \+((Line =:= PLine, Col =:= PCol)),         % Player can not chose to move to the cell where is placed
    Line > 0, Line < 9, Col > 0, Col < 9,		% Player must move within the limits of the board
    (Line-PLine)=<1, (PLine-Line)=<1, (Col-PCol)=<1, (PCol-Col)=<1,
    getCell(T, Line, Col, Element),
	Element =\= 0, !,                           % Player can not move to a blank cell
    updatePlayer(P, Line, Col).

checkFirstMove(T, P, _, _):-
    write('\nWrong play. Please try again!\n'),
    playerInput(T, P), !.

checkMove(T, P1, P2, Line, Col, Mode):-
    integer(Line),
    integer(Col),
    player(P1, P1Line, P1Col, _, _),
    \+((Line =:= 1, Col =:= 1)),                % Players can not move to a starting cell
    \+((Line =:= 8, Col =:= 1)),
    Line > 0, Line < 9, Col > 0, Col < 9,		% Player must move within the limits of the board
    (Line-P1Line)=<1, (P1Line-Line)=<1, (Col-P1Col)=<1, (P1Col-Col)=<1, 
    getCell(T, Line, Col, Element),
	Element =\= 0, !,                           % Player can not move to a blank cell
    validMove(T, P1, P2, Line, Col, Mode).

checkMove(T, P1, P2, _, _, Mode):-
    write('\nWrong play. Please try again!\n'),
    movePlayer(T, P1, P2, Mode), !.

%%%%%%%%%% Player moves %%%%%%%%%%
validMove(T, P1, P2, Line, Col, _):-
	player(P2, P2Line, P2Col, _, _),
	Line =:= P2Line, Col =:= P2Col, 				% Player can not move to an occupied cell
	write('\nWrong play. Please try again!\n'), !,
	playerInput(T, P1, P2).

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, '\\', _, _, _, _, _, _, _, _),	
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col =:= P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, '|', _, _, _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line < P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, '/', _, _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line =:= P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, '-', _, _, _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line =:= P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, '-', _, _, _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col < P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, '/', _, _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col =:= P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, _, '|', _),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, Line, Col, _):-
	player(P1, P1Line, P1Col, _, _),
	Line > P1Line, Col > P1Col,
	getPlayerTile(T, P2, Tile),
	tile(Tile, _, _, _, _, _, _, _, _, '\\'),
    updatePlayer(P1, Line, Col), nl, !.

validMove(T, P1, P2, _, _, Mode):-
	write('\nWrong play. Please try again!\n'), !,
	movePlayer(T, P1, P2, Mode).

%%%%%%%%%% Predicate to check if the game is over %%%%%%%%%%
gameOver(Winner):-
	player(1, Line, Col, _, _),
	Line =:= 3, Col =:= 3,
	Winner = 1, !.

gameOver(Winner):-
	player(2, Line, Col, _, _),
	Line =:= 8, Col =:= 8,
	Winner = 2, !.

%%%%%%%%%% Updates the board %%%%%%%%%%
% Updates the board
updateBoard(T):-
	clearScreen,
	displayLogo,
	player(1, Line1, Col1, _, _), player(2, Line2, Col2, _, _), printBoard(T, Line1, Col1, Line2, Col2).

%%%%%%%%%% Updates the position of the player P %%%%%%%%%%
% Updates the player position
updatePlayer(P, Line, Col):-
	retract(player(P, _, _, _, _)), assert(player(P, Line, Col, _, _)).

%%%%%%%%%% Resets the positions of the players to the initial ones %%%%%%%%%%
resetPlayersPosition:-
	retract(player(1, _, _, Line1, Col1)), assert(player(1, 1, 1, Line1, Col1)),
	retract(player(2, _, _, Line2, Col2)), assert(player(2, 8, 1, Line2, Col2)).

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
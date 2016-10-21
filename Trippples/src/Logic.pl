% Finish game cycle
% Game cycle
updateGame:-
	%checkGameEnd
	playerInput(1),
	playerInput(2),
	updateBoard,
	updateGame.

% Updates the game board
updateBoard:-
	board(T), player(1, X1, Y1, _, _), player(2, X2, Y2, _, _), printBoard(T, X1, Y1, X2, Y2).

% Updates the player position
updatePlayer(P, X, Y):-
	retract(player(P, _, _, _, _)), assert(player(P, X, Y, _, _)).

% Resets the playeers to their initial position
resetPlayers:-
	retract(player(1, _, _, _, _)), assert(player(1, 1, 1, _, _)),
	retract(player(2, _, _, _, _)), assert(player(1, 8, 1, _, _)).

% FALTA VALIDAR INPUT
% Ask the user new marker position
playerInput(P):-
    nl, write('PLAYER '), write(P), nl,
    write('Horizontal coordinate:'), read(X),
    write('Vertical coordinate'), read(Y),
    updatePlayer(P, X, Y), nl.

% FALTA TERMINAR
checkPlayer(P):-
	player(P, X, Y, XF, YF),
	X =:= XF,
	Y =:= YF.

% falta terminar
%%%%%%%%%%%%%%%
% Verifies if game is finished
checkGameEnd:-
	checkPlayer(1),
	checkPlayer(2);
	write('END GAME'), !, fail.


% Game predicates

% Moves the marker of a player to a different tile
%verifyPlace([T|Ts], PosX, PosY).
%placeTile(Player, Tile, [T|Ts], PosX, PosY).
%verifyMove(Player, [T|Ts], PosX, PosY).
%movePlayer(Player, [T|Ts], PosX, PoY).
%gameEnd(G).
:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').

run:-
	write('\33\[2J'),
	nl,
	write('\t\t#############################################'), nl, nl,
	write('\t\t####              TRIPPLES              ####'), nl, nl,
	write('\t\t#############################################'), nl, nl,
	board(T), displayBoard(T).

board([[0, 1, 2, 3, 4, 5, 6, 7, 8],
	   [1, 0, 0, 0, 0, 0, 0, 0, 0],
	   [2, 0, 0, 0, 0, 0, 0, 0, 0],
	   [3, 0, 0, 0, 0, 0, 0, 0, 0],
	   [4, 0, 0, 0, 0, 0, 0, 0, 0],
	   [5, 0, 0, 0, 0, 0, 0, 0, 0],
	   [6, 0, 0, 0, 0, 0, 0, 0, 0],
	   [7, 0, 0, 0, 0, 0, 0, 0, 0],
	   [8, 0, 0, 0, 0, 0, 0, 0, 0]]).


% Game tiles
tile([[\, /], [' ',\]]).

translate(startSquare):-
	write('D').

translate(startCircle):-
	write('O').

translate(finishSquare):-
	write('#').

translate(finishCircle):-
	write('@').

printLine:-
	write('------------------').

% Prints game board
displayBoard([]).

displayBoard([L|Ls]):- 
	displayRow(L), nl,
	printa,
	displayBoard(Ls).

% Prints a line of the game board
displayRow([]).

displayRow([C]):-write(C), write('|').

displayRow([C|Cs]):-
	write(C),
	write('|'),
	displayRow(Cs).


readPlay:-
	write('What is your move?'),
	read(X),
	format('Your move is ~w', [X]).

gameEnd.

:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').

run:-
	write('\33\[2J'),
	nl,
	write('\t\t#############################################'), nl, nl,
	write('\t\t####              TRIPPLES              ####'), nl, nl,
	write('\t\t#############################################'), nl, nl,
	readPlay.

board([[finishSquare, 0, 0, 0, 0, 0, 0, finishCircle],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0, 0],
	   [startSquare, 0, 0, 0, 0, 0, 0, startCircle]]).

translate(startSquare):-
	write('D').

translate(startCircle):-
	write('O').

translate(finishSquare):-
	write('#').

translate(finishCircle):-
	write('@').


/*
print_line([Cell | Rest]):-
    translate(Cell, PrintCell),
    write(PrintCell),
    print_line(Rest).*/


% Prints game board
displayBoard([]).

displayBoard([L|Ls]):- 
	displayLine(L), nl,
	displayBoard(Ls).

% Prints a line of the game board
displayLine([]).

displayLine([C|Cs]):-
	write(C),
	displayLine(Cs).


readPlay:-
	write('What is your move?'),
	read(X),
	format('Your move is ~w', [X]).

gameEnd.

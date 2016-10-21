:- include('Utilities.pl').
:- include('Logic.pl').
:- include('Interface.pl').
:- include('Tiles.pl').
:- dynamic player/5.

run:-
	displayLogo,
    updateBoard,  
    updateGame.

% Game board
board([[2, 5, 6, 7, 8, 9, 10, 3],
       [11, 12, 13, 14, 15, 16, 17, 18],
       [19, 20, 21, 22, 23, 24, 25, 26],
       [27, 28, 29, 0, 30, 44, 31, 32],
       [33, 34, 35, 0, 0, 36, 37, 38],
       [39, 40, 41, 42, 43, 0, 45, 46],
       [47, 48, 49, 50, 51, 52, 53, 54],
       [4, 55, 56, 57, 58, 59, 60, 1]]).

% Predicate with the starting position of the players
% Player, Initial line, Initial column, Final Line, Final column
player(1, 1, 1, 1, 8).
player(2, 8, 1, 8, 8).


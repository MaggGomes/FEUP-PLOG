clearScreen:-
    write('\33\[2J').

pressAnyKeyToContinue:-
    write('\n\nPress any key to continue...\n\n'),
    get_char(_),
    get_code(_).
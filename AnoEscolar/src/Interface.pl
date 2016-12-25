%%%%%% Predicates used to display results

% Display results
displayResults(_, [], []).

displayResults(Days, [Schedule-_|Hs], [ClassResult|Ts]):-
    nl, nl, nl,
    write('######################## Horario ########################'), nl, nl,
    displaySchedule(0, Schedule), nl,
    write('######################## TPCs e Testes ########################'), nl, nl,
    displayTPCsAndTests(0, Days, ClassResult),
    displayResults(Days, Hs, Ts).

% Displays Class Schedule
displaySchedule(_, []).

displaySchedule(Day, [Disciplines|Hs]):-    
    WeekDayPos is Day mod 5,
    translateDay(WeekDayPos, DayName),
    format('~w: ', [DayName]),
    displayDisciplines(Disciplines),
    nl,
    NewDay is Day+1,
    displaySchedule(NewDay, Hs).

% Displays TPCs and Tests

displayTPCsAndTests(EndDay, EndDay, _).

displayTPCsAndTests(Day, EndDay, ClassResult):-
    Day < EndDay,     
    WeekDayPos is Day mod 5,
    translateDay(WeekDayPos, DayName),
    format('Dia - ~d - ~w: ', [Day+1, DayName]),
    displayDayStatus(Day, ClassResult),
    nl,
    NewDay is Day+1,
    displayTPCsAndTests(NewDay, EndDay, ClassResult).    

% Disples tests and TPCs for a specific day
displayDayStatus(_, []).

displayDayStatus(Day, [Discipline-TPCs-Tests|Hs]):-
    nth0(Day, TPCs, Result1),
    nth0(Day, Tests, Result2),
    displayDay(Result1, 1, Discipline),
    displayDay(Result2, 2, Discipline),
    displayDayStatus(Day, Hs).

% Displays a discipline in case there is TPC or Test
displayDay(0, _, _).

displayDay(1, 1, Discipline):-
    write('TPC-'),
    displayDiscipline(Discipline),
    write('  ').

displayDay(1, 2, Discipline):-
    write('TESTE-'),
    displayDiscipline(Discipline),
    write('  ').




% Display disciplines
displayDisciplines([]).

displayDisciplines([H]):-
    displayDiscipline(H).

displayDisciplines([H|Hs]):-
    displayDiscipline(H), write(', '),
    displayDisciplines(Hs).

% Display a single discipline
displayDiscipline(H):-
    translateDiscipline(H, Discipline),
    format('~w', [Discipline]).

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('Interface.pl').

% Predicados para as disciplinas
translateDiscipline(1, 'Matematica').
translateDiscipline(2, 'Portugues').
translateDiscipline(3, 'Ciencias').
translateDiscipline(4, 'Ed.Fisica').
translateDiscipline(5, 'Tecnologias').

% Predicados para os dias
translateDay(0, 'Segunda').
translateDay(1, 'Terca').
translateDay(2, 'Quarta').
translateDay(3, 'Quinta').
translateDay(4, 'Sexta').

% Examplesof schedules
% List with a schedule in the form Monday, Tuesday, Wednesday, Thursday, Friday, followed by list with the disciplines
% 1 turma 3 disciplinas
schedule1([
            [[1, 2, 3], [1, 2], [1, 2, 3], [1, 3], [2, 3]]-[1, 2, 3]
            ]).

% 2 turmas com diferente numero de disciplinas
schedule2([
            [[1, 2], [1, 2], [1, 2], [1], [2]]-[1, 2],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5]
            ]).

% 2 turmas com igual numero de disciplinas
schedule3([
            [[1, 2, 3], [1, 2], [1, 2, 3], [1, 3], [2, 3]]-[1, 2, 3],
            [[1, 2], [1, 2, 4], [1, 2, 4], [2, 4], [1, 4]]-[1, 2, 4]
            ]).

% 6 turmas com diferente numero de disciplinas - testar com 30 e 90 dias
% tempo de processamento aumenta mais rapido com aumento de numero de dias que com aumento do numero de disciplinas
schedule4([
            [[1, 2], [1, 2], [1, 2], [1], [2]]-[1, 2],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5],
            [[4, 2], [4, 2, 5], [4, 2, 5], [2, 5], [4, 5]]-[2, 4, 5]
            ]).

% Exemplo de parâmetros para correr o programa
% Numero de dias, numero maximo de tpcs por dia, percenagem tpc por disciplina por periodo, horários, resultados
% run(30, 1, 2, 2, 2, X).

% Starts the program
run(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, ClassResults):-
    statistics(runtime, [Start|_]),
    schedule3(Schedules),
    solveClasses(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, Schedules, ClassResults, [], FinalResult),
    testsCloseDays(Days, Schedules, ClassResults, Test1, Test2),
    sum(Test1, #=, ResultTest1),
    sum(Test2, #=, ResultTest2),
    labeling([ffc, down, step, minimize(ResultTest1), minimize(ResultTest2), time_out(120000, _)], FinalResult),
    statistics(runtime, [End|_]),
    Time is End - Start,
    displayResults(Days, Schedules, ClassResults),
    format('~nRuntime: ~3d seconds.~n', [Time]), nl, nl.
    
solveClasses(_, _, _, _, _, [], [], FinalResult, FinalResult).

solveClasses(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, [Schedule-DisciplinesList|Ts], [ClassResult|Hs], CurrentResult, FinalResult):-
    solver(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, DisciplinesList, Schedule, ClassResult, Result),
    append(CurrentResult, Result, NewResult),
    solveClasses(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, Ts, Hs, NewResult, FinalResult).

% Solves the problem of a single class
solver(Days, FreeTPCDay, NumMaxTPCDay, RatioTPC, NumMaxTestsWeek, DisciplinesList, Schedule, ClassResult, Result):-
  initDisciplines(Days, Schedule, DisciplinesList, ClassResult),        % Initiates the tpc and tests lists for each discipline
  freeTPC(FreeTPCDay, ClassResult),                                     % Creates a constraint for the free TPC day specified
  maxNumTPCDay(0, Days, ClassResult, NumMaxTPCDay),                     % Creates a constraint for maximum TPC in a day
  maxTPCPeriod(Days, RatioTPC, Schedule, ClassResult),                  % Constraint for maximum number of TPCs per period based on ratio                       
  maxTestsPerWeek(0, Days, NumMaxTestsWeek, ClassResult),               % Each class cant have more than NumMaxTestsWeek tests per week
  twoTestsDisciplinePeriod(ClassResult),                                % Each class must have 2 tests per period
  twoTestsDifferentPeriod(Days, ClassResult),                           % Each class must have 2 tests per period at 2 specific evaluation moments
  testsConsecutiveDays(0, Days, ClassResult),                           % Each class cant have more than 1 test in 2 consecutive days
  getAllTPCsAndTests(ClassResult, [], Result).                                          

% Creates a list of Tests and TPCs for each discipline
initDisciplines(_, _, [],[]).

initDisciplines(Days, Schedule, [Discipline|Hs], [T|Ts]):-
    length(TPCs, Days),
    length(Tests, Days),    
    domain(TPCs, 0, 1),
    domain(Tests, 0, 1),
    noDisciplineClass(0, Discipline, TPCs, Tests, Schedule), 
    T = Discipline-TPCs-Tests,
    initDisciplines(Days, Schedule, Hs, Ts).

% Predicate that places a constraint #=0 if there is no class of discipline
noDisciplineClass(_, _, [], [], _).

noDisciplineClass(Day, Discipline, [H|Hs], [T|Ts], Schedule):-
    WeekDay is (Day mod 5) + 1,
    nth1(WeekDay, Schedule, ListDayDisciplines),
    (\+member(Discipline, ListDayDisciplines)), !,
    H #= 0,
    T #= 0,
    NewDay is Day+1,
    noDisciplineClass(NewDay, Discipline, Hs, Ts, Schedule).

noDisciplineClass(Day, Discipline, [_|Hs], [_|Ts], Schedule):-
    WeekDay is (Day mod 5) + 1,
    nth1(WeekDay, Schedule, ListDayDisciplines),
    member(Discipline, ListDayDisciplines), !,    
    NewDay is Day+1,
    noDisciplineClass(NewDay, Discipline, Hs, Ts, Schedule).

% Returns a list with of TPCs and Tests
 getAllTPCsAndTests([], Result, Result).

getAllTPCsAndTests([_-TPCs-Tests|Hs], CurrentResult, Result):-
    append(TPCs, Tests, List),
    append(List, CurrentResult, NewResult),
    getAllTPCsAndTests(Hs, NewResult, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%% TPCs restrictions %%%%%%%%%%%%%%%%%%%%%%%%%%
% Every class must have a free day per week free of TPC, remaining the same untile the end of the period
freeTPC(FreeTPCDay, [_-TPCs-_|Ts]) :-
  cleanTPC(1, FreeTPCDay, TPCs),
  freeTPC(FreeTPCDay, Ts).

freeTPC(_, []).

cleanTPC(Day, FreeTPCDay, [_|Ts]):-
    WeekDay is Day mod 5,
    WeekDay \= FreeTPCDay, !,
    NewDay is Day + 1,
    cleanTPC(NewDay, FreeTPCDay, Ts).

cleanTPC(Day, FreeTPCDay, [T|Ts]):-
    WeekDay is Day mod 5,
    WeekDay =:= FreeTPCDay, !,
    T #= 0,
    NewDay is Day + 1,
    cleanTPC(NewDay, FreeTPCDay, Ts).

cleanTPC(_, _, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each day cant have TPC in more than 2 disciplines
maxNumTPCDay(Days, Days, _, _).

maxNumTPCDay(Day, Days, Class, NumMaxTPCDay):-
    getDayTPCList(Day, Class, [], Result),
    sum(Result, #=<, NumMaxTPCDay),
    NewDay is Day + 1,
    maxNumTPCDay(NewDay, Days, Class, NumMaxTPCDay).

getDayTPCList(_, [], Result, Result).

getDayTPCList(Day, [_-TPCs-_|Hs], CurrentResult, Result):-
    nth0(Day, TPCs, TPCDay),
    append(CurrentResult, [TPCDay], NewResult),
    getDayTPCList(Day, Hs, NewResult, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each class can have TPC in half of the classes - FALTA TESTAR
maxTPCPeriod(_, _, _, []).

maxTPCPeriod(Days, RatioTPC, Schedule, [Discipline-TPCs-_|Hs]):-
    getNumClassesDisciplineWeek(Schedule, Discipline, 0, Result),
    NumWeeks is div(Days, 5),
    ModWeek is Days mod 5,
    getNumClassesDisciplineModWeek(0, ModWeek, Schedule, Discipline, 0, ModResult),
    FinalResult is (NumWeeks * Result) + ModResult,
    MaxTPC is div(FinalResult, RatioTPC),
    sum(TPCs, #=<, MaxTPC),
    maxTPCPeriod(Days, RatioTPC, Schedule, Hs).

getNumClassesDisciplineModWeek(Days, Days, _, _, Result, Result).

getNumClassesDisciplineModWeek(CurrentDay, Days, [Day|Ts], Discipline, CurrentResult, Result):-
    member(Discipline, Day), !,
    NewResult is CurrentResult + 1,
    NextDay is CurrentDay + 1,
    getNumClassesDisciplineModWeek(NextDay, Days, Ts, Discipline, NewResult, Result).

getNumClassesDisciplineModWeek(CurrentDay, Days, [Day|Ts], Discipline, CurrentResult, Result):-
    \+member(Discipline, Day), !,
    NextDay is CurrentDay + 1,
    getNumClassesDisciplineModWeek(NextDay, Days, Ts, Discipline, CurrentResult, Result).

getNumClassesDisciplineWeek([], _, Result, Result).

getNumClassesDisciplineWeek([Day|Ts], Discipline, CurrentResult, Result):-
    member(Discipline, Day), !,
    NewResult is CurrentResult + 1,
    getNumClassesDisciplineWeek(Ts, Discipline, NewResult, Result).

getNumClassesDisciplineWeek([Day|Ts], Discipline, CurrentResult, Result):-
    \+member(Discipline, Day), !,
    getNumClassesDisciplineWeek(Ts, Discipline, CurrentResult, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%% Tests Restrictions %%%%%%%%%%%%%%%%%%%%%%%%%%
% Each discipline must have 2 tests per period, in 2 specific moment at mid and end of the period
twoTestsDisciplinePeriod([_-_-Tests|Ts]):-
    sum(Tests, #=, 2),
    twoTestsDisciplinePeriod(Ts).

twoTestsDisciplinePeriod([]).

twoTestsDifferentPeriod(Days, ClassResult):-
    TestMomentDuration is div(Days, 4),
    StartFirstTestMoment is TestMomentDuration,
    StartSecondTestMoment is 3*TestMomentDuration,
    twoDifferentTestMoments(StartFirstTestMoment, TestMomentDuration, StartSecondTestMoment, ClassResult).

twoDifferentTestMoments(_, _, _, []).

twoDifferentTestMoments(StartFirstTestMoment, TestMomentDuration, StartSecondTestMoment, [_-_-Tests|Ts]):-
    sublists(Tests, StartFirstTestMoment, TestMomentDuration, FirstResult),
    sublists(Tests, StartSecondTestMoment, TestMomentDuration, SecondResult),
    sum(FirstResult, #=, 1),
    sum(SecondResult, #=, 1),
    twoDifferentTestMoments(StartFirstTestMoment, TestMomentDuration, StartSecondTestMoment, Ts).

sublists(List, Offset, Length, Sublist):-
  length(Prefix, Offset),
  append(Prefix, Rest, List),
  length(Sublist, Length),
  append(Sublist, _, Rest).

% The students cant have more than NumMaxTestsWeek tests per week
maxTestsPerWeek(Day, Days, _, _):-
    Day >= Days.

maxTestsPerWeek(Day, Days, NumMaxTestsWeek, Class):-
    Day < Days,
    getWeekTestList(Day, Days, Class, [], Result),
    sum(Result, #=<, NumMaxTestsWeek),
    NewDay is Day+5,
    maxTestsPerWeek(NewDay, Days, NumMaxTestsWeek, Class).

getWeekTestList(_, _, [], Result, Result).

getWeekTestList(Day, Days, [_-_-Tests|Hs], CurrentResult, Result):-
    getDisciplineWeekTestList(1, Day, Days, Tests, [], Result1),
    append(CurrentResult, Result1, NewResult),
    getWeekTestList(Day, Days, Hs, NewResult, Result).

getDisciplineWeekTestList(_, Days, Days, _, Result, Result).

getDisciplineWeekTestList(WeekDay, Day, Days, Tests, CurrentResult, Result):-
    WeekDay < 6, !,
    nth0(Day, Tests, TestDay),
    append(CurrentResult, [TestDay], NewResult),
    NewWeekDay is WeekDay+1,
    NewDay is Day+1,
    getDisciplineWeekTestList(NewWeekDay, NewDay, Days, Tests, NewResult, Result).

getDisciplineWeekTestList(WeekDay, _, _, _, Result, Result):-
    WeekDay > 5, !.

% The students cant have more than 1 test in consecutive days
testsConsecutiveDays(Days, Days, _).

testsConsecutiveDays(Day, Days, Class):-
    Day =< Days - 2,
    NextDay is Day + 1,
    isMonday(NextDay), !,                         
    NewDay is Day + 1,
    testsConsecutiveDays(NewDay, Days, Class).

testsConsecutiveDays(Day, Days, Class):-
    Day =< Days - 2,   
    NextDay is Day + 1,
    \+isMonday(NextDay), !,
    getDayTestList(Day, Class, [], Result1),   
    getDayTestList(NextDay, Class, [], Result2),
    append(Result1, Result2, SumResults),
    sum(SumResults, #=<, 1),                             % Cant there is more than 1 test in 2 consectuive days
    NewDay is Day + 1,
    testsConsecutiveDays(NewDay, Days, Class).

testsConsecutiveDays(Day, Days, Class):-
    Day > Days - 2, !, 
    NewDay is Day + 1,
    testsConsecutiveDays(NewDay, Days, Class).

isMonday(Day):-
    WeekDay is Day mod 5,
    WeekDay =:= 0.

getDayTestList(_, [], Result, Result).

getDayTestList(Day, [_-_-Tests|Hs], CurrentResult, Result):-
    nth0(Day, Tests, TestDay),
    append(CurrentResult, [TestDay], NewResult),
    getDayTestList(Day, Hs, NewResult, Result).

% Students from different classes must have the test for the same discipline in closing days
testsCloseDays(Days, Schedules, Classes, Test1, Test2):-
    getDisciplineList(Schedules, [], Result),
    sort(Result, DisciplineList),                       % list with all disciplines created
    TestMomentDuration is div(Days, 4),
    StartFirstTestMoment is TestMomentDuration,
    StartSecondTestMoment is 3*TestMomentDuration,
    getTestsCloseAll(DisciplineList, Classes, TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, Test1, Test2).

getTestsCloseAll([], _, _, _, _, [], []).

getTestsCloseAll([Discipline|DisciplineList], Classes, TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, [Test1|Tests1], [Test2|Tests2]):-
    getDisciplineCloseDays(Discipline, Classes, TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, CloseDaysTest1, CloseDaysTest2),
    write(CloseDaysTest2),
    sum(CloseDaysTest1, #=, Test1),
    sum(CloseDaysTest2, #=, Test2),
    getTestsCloseAll(DisciplineList, Classes, TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, Tests1, Tests2).

getDisciplineCloseDays(_, [], _, _, _, [], []).

getDisciplineCloseDays(_, [_], _, _, _, [], []).

getDisciplineCloseDays(Discipline, [Class1, Class2 | Classes], TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, [FirstTestDiff|CloseDaysTest1], [SecondTestDiff|CloseDaysTest2]):-
    member(Discipline-_-TestsClass1, Class1),
    member(Discipline-_-TestsClass2, Class2),!,    
    sublists(TestsClass1, StartFirstTestMoment, TestMomentDuration, FirstPeriodClass1),            % Creates sublists with the possible days for each moment of a test
    sublists(TestsClass1, StartSecondTestMoment, TestMomentDuration, SecondPeriodClass1),
    sublists(TestsClass2, StartFirstTestMoment, TestMomentDuration, FirstPeriodClass2),
    sublists(TestsClass2, StartSecondTestMoment, TestMomentDuration, SecondPeriodClass2),
    element(FirstTestClass1, FirstPeriodClass1, 1),
    element(FirstTestClass2, FirstPeriodClass2, 1),
    element(SecondTestClass1, SecondPeriodClass1, 1),
    element(SecondTestClass2, SecondPeriodClass2, 1),
    FirstTestDiff #= abs(FirstTestClass1-FirstTestClass2),
    SecondTestDiff #= abs(SecondTestClass1-SecondTestClass2),
    getDisciplineCloseDays(Discipline, [Class2 | Classes], TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, CloseDaysTest1, CloseDaysTest2).

getDisciplineCloseDays(Discipline, [_, Class2 | Classes], TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, CloseDaysTest1, CloseDaysTest2):-
    getDisciplineCloseDays(Discipline, [Class2 | Classes], TestMomentDuration, StartFirstTestMoment, StartSecondTestMoment, CloseDaysTest1, CloseDaysTest2).
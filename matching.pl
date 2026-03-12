% ============================================================
% Proiect: Sistem Expert - Recomandare Cariera
% Fisier:  matching.pl
% Scop:    Logica de potrivire si sistemul de scor
% Depinde: knowledge_base.pl
% ============================================================
%
% Predicate definite:
%   intersectie(+Lista1, +Lista2, -Comune)
%   match_abilitati(+Cariera, +AbilitatiUtilizator, -Score)
%   match_interese(+Cariera, +IntereseUtilizator, -Score)
%   scor(+Cariera, +AbilitatiUtilizator, +IntereseUtilizator, -Scor)
%   scoruri_toate(+AbilitatiUtilizator, +IntereseUtilizator, -ListaScoruri)
%   sorteaza_scoruri(+ListaScoruri, -ListaSortata)
% ============================================================

:- use_module(library(lists)).

% ============================================================
% intersectie(+L1, +L2, -Comune)
%   Elementele comune intre doua liste (fara duplicate).
% ============================================================

intersectie([], _, []).
intersectie([H|T], L2, [H|Comune]) :-
    member(H, L2), !,
    intersectie(T, L2, Comune).
intersectie([_|T], L2, Comune) :-
    intersectie(T, L2, Comune).

% ============================================================
% match_abilitati(+Cariera, +AbilitatiUtilizator, -Score)
%
%   Score = numar_abilitati_comune / numar_abilitati_cerute
%   Rezultat in intervalul [0.0, 1.0].
%   Daca o cariera nu are abilitati definite, Score = 0.0.
% ============================================================

match_abilitati(Cariera, AbilitatiUtilizator, Score) :-
    abilitati(Cariera, AbilitatiCerute),
    AbilitatiCerute \= [],
    intersectie(AbilitatiUtilizator, AbilitatiCerute, Comune),
    length(Comune, NrComune),
    length(AbilitatiCerute, NrCerute),
    Score is NrComune / NrCerute.

match_abilitati(Cariera, _, 0.0) :-
    \+ abilitati(Cariera, _).

match_abilitati(Cariera, _, 0.0) :-
    abilitati(Cariera, []).

% ============================================================
% match_interese(+Cariera, +IntereseUtilizator, -Score)
%
%   Score = numar_interese_comune / numar_interese_asociate
%   Rezultat in intervalul [0.0, 1.0].
% ============================================================

match_interese(Cariera, IntereseUtilizator, Score) :-
    interese(Cariera, IntereseAsociate),
    IntereseAsociate \= [],
    intersectie(IntereseUtilizator, IntereseAsociate, Comune),
    length(Comune, NrComune),
    length(IntereseAsociate, NrAsociate),
    Score is NrComune / NrAsociate.

match_interese(Cariera, _, 0.0) :-
    \+ interese(Cariera, _).

match_interese(Cariera, _, 0.0) :-
    interese(Cariera, []).

% ============================================================
% scor(+Cariera, +AbilitatiUtilizator, +IntereseUtilizator, -Scor)
%
%   Scor = PondereAbilitati * MatchAbilitati
%        + PondereInterese  * MatchInterese
%
%   Ponderi implicite: abilitati = 0.6, interese = 0.4
%   Scor final in intervalul [0.0, 1.0].
% ============================================================

:- dynamic pondere_abilitati/1.
:- dynamic pondere_interese/1.

pondere_abilitati(0.6).
pondere_interese(0.4).

scor(Cariera, AbilitatiUtilizator, IntereseUtilizator, Scor) :-
    match_abilitati(Cariera, AbilitatiUtilizator, MA),
    match_interese(Cariera, IntereseUtilizator, MI),
    pondere_abilitati(PA),
    pondere_interese(PI),
    Scor is PA * MA + PI * MI.

% ============================================================
% scoruri_toate(+AbilitatiUtilizator, +IntereseUtilizator, -Lista)
%
%   Calculeaza scorul pentru toate carierele din baza de
%   cunostinte si returneaza o lista de perechi scor(Scor, Cariera).
% ============================================================

scoruri_toate(Abilitati, Interese, Lista) :-
    findall(
        scor(S, C),
        (cariera(C, _, _), scor(C, Abilitati, Interese, S)),
        Lista
    ).

% ============================================================
% sorteaza_scoruri(+Lista, -ListaSortata)
%
%   Sorteaza lista de termeni scor(Scor, Cariera) descrescator
%   dupa Scor. Cele mai bune potriviri apar primele.
% ============================================================

sorteaza_scoruri(Lista, Sortata) :-
    msort(Lista, Ascendent),
    reverse(Ascendent, Sortata).

% ============================================================
% top_n(+N, +ListaSortata, -Top)
%
%   Returneaza primele N elemente dintr-o lista sortata.
%   Util pentru a obtine top-K recomandari.
% ============================================================

top_n(_, [], []) :- !.
top_n(0, _, []) :- !.
top_n(N, [H|T], [H|Rest]) :-
    N > 0,
    N1 is N - 1,
    top_n(N1, T, Rest).

% ============================================================
% Sfarsit matching.pl
% ============================================================

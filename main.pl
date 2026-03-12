% ============================================================
% Proiect: Sistem Expert - Recomandare Cariera
% Fisier:  main.pl
% Scop:    Interfata utilizator, filtrare avansata si integrare
% Depinde: knowledge_base.pl, matching.pl
% ============================================================

% Incarcarea dependintelor: baza de fapte si logica de calcul.
:- [knowledge_base].
:- [matching].

% ============================================================
% recomanda(+AbilitatiUtilizator, +IntereseUtilizator, -Recomandari)
%
%   Predicatul principal care realizeaza legatura intre input si 
%   rezultatul final.
%   1. Calculeaza scorurile pentru toate carierele existente.
%   2. Sorteaza lista descrescator (cele mai bune potriviri primele).
%   3. Gestioneaza cazul in care nu exista nicio potrivire.
% ============================================================
recomanda(Abilitati, Interese, Recomandari) :-
    % Obtine lista de termeni scor(Scor, Cariera) din matching.pl.
    scoruri_toate(Abilitati, Interese, Lista),
    % Sorteaza lista pentru a pune scorurile mari in top.
    sorteaza_scoruri(Lista, Recomandari),
    % Verifica daca lista este vida pentru a informa utilizatorul.
    (Recomandari = [] -> 
        writeln('Nu s-au gasit cariere compatibile in baza de date.') ; 
        true
    ).

% ============================================================
% recomanda_filtrat(+Abilitati, +Interese, +Filtre, -Rezultat)
%
%   Extinde functionalitatea de baza prin aplicarea unor constrangeri.
%   Filtrele sunt transmise ca o lista (ex: [industrie(it), salariu_min(5000)]).
% ============================================================
recomanda_filtrat(Abilitati, Interese, Filtre, Rezultat) :-
    scoruri_toate(Abilitati, Interese, Toate),
    sorteaza_scoruri(Toate, Sortate),
    % Filtreaza recursiv lista sortata conform predicatelor de verificare.
    aplica_filtre(Sortate, Filtre, Rezultat).

% --- Logica de filtrare (Recursivitate pe liste) ---

% Daca lista de cariere este vida, rezultatul filtrarii este vid.
aplica_filtre([], _, []).

% Daca prima cariera (H) trece toate filtrele, este inclusa in Rezultat.
aplica_filtre([scor(S, C)|T], Filtre, [scor(S, C)|Rest]) :-
    trece_filtre(C, Filtre), !,
    aplica_filtre(T, Filtre, Rest).

% Daca cariera nu trece filtrele, este omisa si se continua procesarea cozii (T).
aplica_filtre([_|T], Filtre, Rest) :-
    aplica_filtre(T, Filtre, Rest).

% Verifica daca o cariera specifica respecta TOATE filtrele din lista.
trece_filtre(_, []).
trece_filtre(C, [Filtru|Rest]) :-
    verifica_filtru(C, Filtru),
    trece_filtre(C, Rest).

% --- Definirea Criteriilor de Filtrare ---

% Ierarhia educatiei: maparea nivelului text pe valori numerice pentru comparare.
nivel_educatie(bacalaureat, 1).
nivel_educatie(licenta, 2).
nivel_educatie(masterat, 3).
nivel_educatie(doctorat, 4).

% Filtru Educatie: Cariera (C) este valida daca studiile necesare (VNec) 
% sunt mai mici sau egale cu pragul maxim acceptat de utilizator (VMax).
verifica_filtru(C, educatie_max(NivelMax)) :-
    educatie(C, NivelNecesar),
    nivel_educatie(NivelMax, VMax),
    nivel_educatie(NivelNecesar, VNec),
    VNec =< VMax.

% Filtru Salariu: Verifica daca plafonul maxim al carierei atinge pragul minim dorit.
verifica_filtru(C, salariu_min(S)) :-
    salariu(C, interval(_, Max)),
    Max >= S.

% Filtru Industrie: Potrivire directa intre industria carierei si cerinta utilizatorului.
verifica_filtru(C, industrie(Ind)) :-
    cariera(C, _, Ind).

% ============================================================
% Exemple de utilizare (Interogari SWISH):
%
% 1. Recomandare simpla:
%    ?- recomanda([programare, baze_de_date, comunicare], [tehnologie, inovatie], R).
%
% 2. Recomandare cu filtrare (Doar IT si studii de licenta):
%    ?- recomanda_filtrat([programare, matematica], [tehnologie], [industrie(it), educatie_max(licenta)], R).
%
% 3. Top 3 recomandari:
%    ?- recomanda([matematica, analiza_date], [finante], L), top_n(3, L, Top).
% ============================================================

% ============================================================
% Sfarsit main.pl
% ============================================================
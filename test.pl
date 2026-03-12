% ============================================================
% Proiect: Sistem Expert - Recomandare Cariera
% Fisier:  test.pl
% Scop:    Unit testing manual pentru toate modulele
% ============================================================

% Incarca intreg sistemul pentru a avea acces la toate predicatele.
:- [main].

% ============================================================
% ruleaza_teste
%   Punct de intrare pentru testarea intregului sistem.
%   Ruleaza pe rand teste pentru logica interna, formule si integrare.
% ============================================================
ruleaza_teste :-
    writeln('--- Incepere Testare Manuala ---'),
    test_intersectie,
    test_matching_logic,
    test_scoring_formula,
    test_recomandare_top,
    test_filtrare_avansata,
    writeln('--- Toate testele au fost finalizate cu succes ---').

% --- Teste Logica Interna (Functii utilitare) ---

% Verifica daca functia de intersectie functioneaza corect matematic.
test_intersectie :-
    intersectie([a, b, c], [b, c, d], [b, c]), % Test elemente comune.
    intersectie([programare], [design], []),   % Test multimi disjuncte.
    writeln('[OK] Test Intersectie (Seturi comune)').

% Verifica daca calculul de matching returneaza scoruri pozitive cand exista potriviri.
test_matching_logic :-
    % Test abilitati pentru Programator (asteptat > 0).
    match_abilitati(programator_software, [programare, algoritmi], ScoreA),
    ScoreA > 0,
    % Test interese pentru Data Scientist (asteptat > 0).
    match_interese(data_scientist, [stiinta, tehnologie], ScoreI),
    ScoreI > 0,
    writeln('[OK] Test Matching (Abilitati si Interese)').

% Verifica daca scorul final este normalizat intre 0.0 si 1.0.
test_scoring_formula :-
    scor(arhitect, [software_cad], [arta], S),
    S >= 0, S =< 1,
    writeln('[OK] Test Calcul Scor (Ponderat)').

% --- Teste Integrare (Interactiunea cu Baza de Cunostinte) ---

% Verifica daca sistemul pune in top cariera cea mai relevanta abilitatilor date.
test_recomandare_top :-
    recomanda([programare, baze_de_date], [tehnologie, inovatie], Rezultate),
    % Prima pozitie trebuie sa fie programator_software.
    Rezultate = [scor(_, programator_software)|_],
    writeln('[OK] Test Recomandare (Validare Top Cariera)').

% Testeaza functionarea combinata a filtrelor de industrie, educatie si salariu.
test_filtrare_avansata :-
    % 1. Verifica daca filtrul de industrie returneaza DOAR cariere din acel domeniu.
    recomanda_filtrat([matematica], [finante], [industrie(finante)], R1),
    forall(member(scor(_, C), R1), cariera(C, _, finante)),

    % 2. Verifica ierarhia educationala: Medicul cere doctorat, deci nu trebuie sa apara la licenta.
    recomanda_filtrat([cunostinte_medicale], [sanatate], [educatie_max(licenta)], R2),
    \+ member(scor(_, medic_generalist), R2),

    % 3. Verifica pragul salarial maxim.
    recomanda_filtrat([programare], [tehnologie], [salariu_min(15000)], R3),
    forall(member(scor(_, C3), R3), (salariu(C3, interval(_, Max)), Max >= 15000)),

    writeln('[OK] Test Filtrare (Industrie, Educatie, Salariu)').

% ============================================================
% Sfarsit test.pl
% ============================================================

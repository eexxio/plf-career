% ============================================================
% Proiect: Sistem Expert - Recomandare Cariera
% Fisier:  knowledge_base.pl
% Scop:    Baza de cunostinte — doar fapte Prolog (fara reguli)
% Data:    12 Martie 2026
% ============================================================
%
% Predicate definite:
%   cariera(Nume, Domeniu, Industrie)
%   abilitati(Cariera, ListaAbilitati)
%   interese(Cariera, ListaInterese)
%   educatie(Cariera, NivelStudii)    % bacalaureat | licenta | masterat | doctorat
%   salariu(Cariera, interval(Min, Max))  % RON / luna
%
% Cariere acoperite (12):
%   programator_software, data_scientist, designer_ux_ui,
%   inginer_devops, medic_generalist, farmacist,
%   avocat, contabil, analist_financiar,
%   profesor, arhitect, inginer_mecanic
% ============================================================

:- discontiguous cariera/3.
:- discontiguous abilitati/2.
:- discontiguous interese/2.
:- discontiguous educatie/2.
:- discontiguous salariu/2.

% ============================================================
% Sectiunea 1: cariera/3
%   cariera(Nume, Domeniu, Industrie)
% ============================================================

cariera(programator_software,  informatica,          it).
cariera(data_scientist,        stiinta_datelor,      it).
cariera(designer_ux_ui,        design_digital,       it).
cariera(inginer_devops,        inginerie_software,   it).
cariera(medic_generalist,      medicina,             sanatate).
cariera(farmacist,             farmacie,             sanatate).
cariera(avocat,                drept,                juridic).
cariera(contabil,              contabilitate,        finante).
cariera(analist_financiar,     finante,              banking).
cariera(profesor,              educatie,             academica).
cariera(arhitect,              arhitectura,          constructii).
cariera(inginer_mecanic,       inginerie_mecanica,   industrie).

% ============================================================
% Sectiunea 2: abilitati/2
%   abilitati(Cariera, ListaAbilitati)
% ============================================================

abilitati(programator_software, [
    programare,
    algoritmi,
    baze_de_date,
    rezolvare_probleme,
    lucru_in_echipa,
    control_versiuni
]).

abilitati(data_scientist, [
    programare,
    machine_learning,
    statistica,
    vizualizare_date,
    baze_de_date,
    rezolvare_probleme
]).

abilitati(designer_ux_ui, [
    design_grafic,
    prototipare,
    gandire_creativa,
    comunicare,
    empatie_utilizator,
    instrumente_design
]).

abilitati(inginer_devops, [
    programare,
    administrare_sisteme,
    automatizare,
    retele_calculatoare,
    control_versiuni,
    rezolvare_probleme
]).

abilitati(medic_generalist, [
    cunostinte_medicale,
    comunicare,
    empatie,
    lucru_sub_presiune,
    atentie_la_detalii,
    rezolvare_probleme
]).

abilitati(farmacist, [
    cunostinte_farmaceutice,
    cunostinte_chimie,
    atentie_la_detalii,
    comunicare,
    organizare
]).

abilitati(avocat, [
    gandire_analitica,
    comunicare,
    redactare_documente,
    cercetare,
    negociere,
    atentie_la_detalii
]).

abilitati(contabil, [
    matematica,
    atentie_la_detalii,
    organizare,
    cunostinte_fiscale,
    software_contabilitate
]).

abilitati(analist_financiar, [
    matematica,
    statistica,
    analiza_date,
    gandire_analitica,
    cunostinte_financiare,
    comunicare
]).

abilitati(profesor, [
    comunicare,
    pedagogie,
    rabdare,
    planificare,
    cunostinte_domeniu,
    empatie
]).

abilitati(arhitect, [
    gandire_creativa,
    desen_tehnic,
    software_cad,
    matematica,
    atentie_la_detalii,
    comunicare
]).

abilitati(inginer_mecanic, [
    matematica,
    fizica,
    desen_tehnic,
    software_cad,
    rezolvare_probleme,
    atentie_la_detalii
]).

% ============================================================
% Sectiunea 3: interese/2
%   interese(Cariera, ListaInterese)
% ============================================================

interese(programator_software, [
    tehnologie,
    rezolvare_puzzleuri,
    inovatie,
    open_source
]).

interese(data_scientist, [
    tehnologie,
    stiinta,
    statistica,
    inovatie,
    cercetare
]).

interese(designer_ux_ui, [
    arta,
    tehnologie,
    psihologie,
    estetica
]).

interese(inginer_devops, [
    tehnologie,
    automatizare,
    infrastructura,
    eficienta
]).

interese(medic_generalist, [
    sanatate,
    stiinta,
    ajutor_oameni,
    biologie
]).

interese(farmacist, [
    sanatate,
    chimie,
    stiinta,
    ajutor_oameni
]).

interese(avocat, [
    dreptate,
    societate,
    politica,
    dezbatere,
    cercetare
]).

interese(contabil, [
    matematica,
    organizare,
    afaceri,
    finante
]).

interese(analist_financiar, [
    finante,
    matematica,
    economie,
    piete_financiare,
    cercetare
]).

interese(profesor, [
    educatie,
    comunicare,
    psihologie,
    ajutor_oameni
]).

interese(arhitect, [
    arta,
    constructii,
    urbanism,
    design,
    matematica
]).

interese(inginer_mecanic, [
    mecanica,
    fizica,
    constructii,
    inovatie,
    productie
]).

% ============================================================
% Sectiunea 4: educatie/2
%   educatie(Cariera, NivelMinimStudii)
%   Niveluri: bacalaureat | licenta | masterat | doctorat
% ============================================================

educatie(programator_software, licenta).
educatie(data_scientist,       masterat).
educatie(designer_ux_ui,       licenta).
educatie(inginer_devops,       licenta).
educatie(medic_generalist,     doctorat).
educatie(farmacist,            licenta).
educatie(avocat,               licenta).
educatie(contabil,             licenta).
educatie(analist_financiar,    licenta).
educatie(profesor,             masterat).
educatie(arhitect,             licenta).
educatie(inginer_mecanic,      licenta).

% ============================================================
% Sectiunea 5: salariu/2
%   salariu(Cariera, interval(Min, Max))
%   Valori in RON / luna (brut, estimativ)
% ============================================================

salariu(programator_software, interval(5000,  15000)).
salariu(data_scientist,       interval(6000,  18000)).
salariu(designer_ux_ui,       interval(4000,  12000)).
salariu(inginer_devops,       interval(6000,  16000)).
salariu(medic_generalist,     interval(4000,  12000)).
salariu(farmacist,            interval(3500,   8000)).
salariu(avocat,               interval(3000,  20000)).
salariu(contabil,             interval(3000,   8000)).
salariu(analist_financiar,    interval(5000,  14000)).
salariu(profesor,             interval(2500,   6000)).
salariu(arhitect,             interval(4000,  12000)).
salariu(inginer_mecanic,      interval(4000,  11000)).

% ============================================================
% Sfarsit knowledge_base.pl
% ============================================================

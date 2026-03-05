# Proiect Prolog - Sistem Expert - Recomandare Carieră

## Enunț

Dezvoltarea unui sistem expert care recomandă cariere pe baza abilităților, intereselor și obiectivelor profesionale ale utilizatorului.

## Plan de Implementare

1. **Baza de cunoștințe**
    * `cariera(Nume, Domeniu, Industrie)` - informații generale
    * `abilitati(Cariera, ListaAbilitati)` - abilități necesare
    * `interese(Cariera, ListaInterese)` - interese asociate
    * `educatie(Cariera, NivelStudii)` - studii necesare
    * `salariu(Cariera, IntervalSalarial)` - interval salarial

2. **Reguli de potrivire**
    * Calcularea gradului de potrivire între abilitățile utilizatorului și cele cerute
    * Calcularea gradului de potrivire între interesele utilizatorului și cele asociate

3. **Sistem de scor**
    * Formula de calcul:
      `Scor = pondere_abilitati * match_abilitati + pondere_interese * match_interese`
    * Ierarhizarea recomandărilor

4. **Interfața cu utilizatorul**
    * Predicat `recomanda(AbilitatiUtilizator, IntereseUtilizator, Recomandari)`
    * Posibilitatea de filtrare după criterii suplimentare

---

## Barem de Lucru

| Cerință | Punctaj |
| :--- | :---: |
| Construirea bazei de cunoștințe (minim 10 cariere) | 20p |
| Reguli de potrivire pe baza abilităților | 15p |
| Reguli de potrivire pe baza intereselor | 15p |
| Implementarea sistemului de scor | 20p |
| Predicat principal de recomandare | 10p |
| Gestionarea cazurilor fără potrivire | 5p |
| Documentație și exemple | 10p |
| **<span style="color:red">Progres pe parcurs (versionare cod)</span>** | **5p** |
| **Total** | **100p** |

<div align="center">Tabela 5: Barem de notare - Recomandare Carieră</div>
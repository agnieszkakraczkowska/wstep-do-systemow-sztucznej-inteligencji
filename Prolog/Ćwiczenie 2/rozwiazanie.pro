%baza 
osoba(anna).
osoba(natalia).
osoba(hanna).
osoba(sofia).
osoba(olga).
osoba(marta).
osoba(sylwia).
osoba(eliza).
osoba(maria).
osoba(karolina).
osoba(rozalia).
osoba(jan).
osoba(milosz).
osoba(marek).
osoba(bartek).
osoba(kamil).
osoba(dominik).
osoba(kuba).
osoba(aleksander).
osoba(karol).
osoba(leon).
osoba(lukasz).
osoba(adrian).
mezczyzna(jan).
mezczyzna(milosz).
mezczyzna(marek).
mezczyzna(bartek).
mezczyzna(kamil).
mezczyzna(dominik).
mezczyzna(kuba).
mezczyzna(aleksander).
mezczyzna(karol).
mezczyzna(leon).
mezczyzna(lukasz).
mezczyzna(adrian).
%rodzic(rodzic,dziecko)
rodzic(jan,milosz).
rodzic(anna,milosz).
rodzic(jan,marek).
rodzic(anna,marek).
rodzic(bartek,hanna).
rodzic(natalia,hanna).
rodzic(milosz,karol).
rodzic(hanna,karol).
rodzic(kamil,dominik).
rodzic(sofia,dominik).
rodzic(aleksander,marta).
rodzic(olga,marta).
rodzic(aleksander,kuba).
rodzic(olga,kuba).
rodzic(dominik,sylwia).
rodzic(marta,sylwia).
rodzic(kuba,leon).
rodzic(karolina,leon).
rodzic(karol,eliza).
rodzic(sylwia,eliza).
rodzic(eliza,rozalia).
rodzic(lukasz,rozalia).
rodzic(maria,adrian).
rodzic(lukasz,adrian).

kobieta(X) :-
    \+mezczyzna(X).

%ojciec(X,Y) – X jest ojcem Y
ojciec(X,Y) :- 
    rodzic(X,Y),
    mezczyzna(X).
    
%matka(X,Y) - X jest matką Y
matka(X,Y) :-
    rodzic(X,Y),
    \+mezczyzna(X).
    
%corka(X,Y) - X jest córką Y
corka(X,Y) :-
    rodzic(Y,X),
    kobieta(X).
    
%brat_rodzony(X,Y) - X jest rodzonym bratem Y
brat_rodzony(X,Y) :- 
	ojciec(A,X),
    matka(B,X),
    ojciec(A,Y),
    matka(B,Y),
    mezczyzna(X),
    X \= Y.

%brat_przyrodni(X,Y) - X jest rodzonym bratem Y
brat_przyrodni(X,Y) :-
    ((matka(A,X),
    matka(A,Y),
    ojciec(B,X),
    ojciec(C,Y),
    B \= C);
    (ojciec(A,X),
    ojciec(A,Y),
    matka(B,X),
    matka(C,Y),
    B \= C)),
    mezczyzna(X).

%kuzyn(X,Y) - X jest kuzynem Y
kuzyn(X,Y) :-
    (rodzic(A,B),rodzic(A,C), B \= C),
    rodzic(B,X),
    rodzic(C,Y),
    (A \= X, A \= Y, B \= Y, C \= X, X \= Y).

%dziadek_od_strony_ojca(X,Y) – X jest dziadkiem od strony ojca dla Y
dziadek_od_strony_ojca(X,Y) :- 
    ojciec(B,Y),
    ojciec(X,B).

%dziadek_od_strony_matki(X,Y) – X jest dziadkiem od strony matki dla Y
dziadek_od_strony_matki(X,Y) :- 
    matka(B,Y),
    ojciec(X,B).

%dziadek(X,Y) – X jest dziadkiem Y
dziadek(X,Y) :-
    rodzic(A,Y),
    ojciec(X,A).

%babcia(X,Y) – X jest babcią Y
babcia(X,Y) :- 
    rodzic(A,Y),
    matka(X,A).

%wnuczka(X,Y) – Y jest wnuczką X
wnuczka(X,Y) :-
    (dziadek(X,Y);babcia(X,Y)),
    kobieta(X).

%przodek_do2pokolenia_wstecz(X,Y) – X jest przodkiem Y do drugiego pokolenia wstecz
przodek_do2pokolenia_wstecz(X,Y) :-
    rodzic(X,Y);
    dziadek(X,Y);
    babcia(X,Y).

%przodek_do3pokolenia_wstecz(X,Y) - X jest przodkiem Y do trzeciego pokolenia wstecz    
przodek_do3pokolenia_wstecz(X,Y) :-
    rodzic(X,Y);
    dziadek(X,Y);
    babcia(X,Y);
    ((dziadek(A,Y);babcia(A,Y)),
    rodzic(X,A)).

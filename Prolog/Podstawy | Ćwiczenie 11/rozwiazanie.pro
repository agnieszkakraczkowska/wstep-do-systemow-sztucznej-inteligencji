%Zapisz reguły dla:
%nieprzyjazn(X,Y),
%niby_przyjazn(X,Y)
%loves(X,Y) 1) może być na zasadzie wzajemności i wyłączności 2) dodaj fakt płeć
%true_love(X,Y)

plec(michal,mezczyzna).
plec(karol,mezczyzna).
plec(krzysztof,mezczyzna).
plec(kamil,mezczyzna).
plec(anna,kobieta).
plec(wiktoria,kobieta).
plec(monika,kobieta).
plec(magda,kobieta).

% przyjazn(wiktoria,michal), ~loves(wiktoria,michal)
lubi(wiktoria,michal).
lubi(michal,wiktoria).
lubi(michal,magda).
% niby_przyjazn(anna,wiktoria)
lubi(anna,wiktoria).
% nieprzyjazn(anna,monika)
% loves(karol,kamil), ~true_love(karol,kamil)
lubi(karol,kamil).
lubi(kamil,karol).
% true_love(magda,krzysztof)
lubi(magda,krzysztof).
lubi(krzysztof,magda).

przyjazn(X, Y) :-
	lubi(X,Y),
	lubi(Y,X).

niby_przyjazn(X,Y) :-
	lubi(X,Y);
	lubi(Y,X).

nieprzyjazn(X,Y) :-
    \+lubi(X,Y),
    \+lubi(Y,X).

loves(X, Y) :-
    lubi(X, Y),
    \+ (lubi(X, Z), Z \= Y),
    lubi(Y, X),
    \+ (lubi(Y, Z), Z \= X).

true_love(X,Y) :-
    ((plec(X,mezczyzna),plec(Y,kobieta));(plec(X,kobieta),plec(Y,mezczyzna))),
    loves(X,Y).

%1.1
%relacje przedstawione na rysunkach:
%A x i y są rodzeństwem
%B x i y to kuzyni
%C x i y są dziadkami od stron rodziców
%D y jest przyrodnim rodzicem x
%E x i y to przyrodnie rodzeństwo
%F y jest szwagrem/szwagierką x
%G x i y są przyrodnim rodzeństwem powstałym z niepoprawnej relacji ojca

%1.2
%przykład A
%rodzic(c,a).
%rodzic(c,b).
%rodzic(d,a).
%rodzic(d,b).
%?- rodzenstwo(c,d)
rodzenstwo(X,Y) :-
    rodzic(X,A),
    rodzic(X,B),
    rodzic(Y,A),
    rodzic(Y,B),
    (A \= B, X \= Y).

%przykład B
%rodzic(b,a).
%rodzic(c,a).
%rodzic(d,b).
%rodzic(e,c).
%?- kuzyni(d,e)
kuzyni(X,Y) :-
    (rodzic(B,A),rodzic(C,A), B \= C),
    rodzic(X,B),
    rodzic(Y,C),
    (A \= X, A \= Y, B \= Y, C \= X, X \= Y).

%przykład C
%rodzic(c,a).
%rodzic(e,c).
%rodzic(e,d).
%rodzic(d,b).
%?- dziadkowie_od_stron_rodzicow(a,b)
dziadkowie_od_stron_rodzicow(X,Y) :-
    rodzic(A,X),
    rodzic(C,A),
    rodzic(B,Y),
    rodzic(C,B),
    (A \= B, A \= Y, B \= X, C \= X, C \= Y, X \= Y).

%przykład D
%rodzic(c,a).
%rodzic(d,a).
%rodzic(d,b).
%?- przyrodni_rodzic(c,b)
przyrodni_rodzic(X,Y) :-
    rodzic(X,A),
    rodzic(B,A),
    rodzic(B,Y),
    (A \= Y, B \= X, X \= Y).

%przykład E
%rodzic(d,a).
%rodzic(d,b).
%rodzic(e,b).
%rodzic(e,c).
%?- przyrodnie_rodzenstwo(d,e)
przyrodnie_rodzenstwo(X,Y) :-
    (rodzic(X,A),rodzic(X,B), A \= B),
    (rodzic(Y,B),rodzic(Y,C), B \= C),
    (A \= C, A \= Y, C \= X, X \= Y).

%przykład F
%rodzic(c,a).
%rodzic(d,a).
%rodzic(e,b).
%rodzic(e,c).
%?- szwagier_ka(b,d)
szwagier_ka(X,Y) :-
    (rodzic(C,X),rodzic(C,B), X \= B),
    (rodzic(B,A),rodzic(Y,A), B \= Y),
    (A \= C, A \= X, C \= Y, X \= Y).

%przykład G
%rodzic(c,a).
%rodzic(c,b).
%rodzic(d,a).
%rodzic(e,d).
%rodzic(e,b).
%?- niepoprawna_przyrodnia_relacja(c,e)
niepoprawna_przyrodnia_relacja(X,Y) :-
    (((rodzic(X,A),rodzic(X,B), A \= B),
    rodzic(C,A),
    (rodzic(Y,C),rodzic(Y,B), B \= C));
    ((rodzic(Y,A),rodzic(Y,B), A \= B),
    rodzic(C,A),
    (rodzic(X,C),rodzic(X,B), B \= C))),
    (A \= Y, C \= X, X \= Y).

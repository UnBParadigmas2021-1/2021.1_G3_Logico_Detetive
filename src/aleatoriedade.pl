:- style_check(-singleton).

:- consult(databases/armas).
:- consult(databases/motivos).
:- consult(databases/locais).
:- consult(databases/solucao).

solucao_aleatoria :- nl,
    random_between(1, 10, IndiceArma),
    arma(IndiceArma, Arma, _),
    write('IndiceArma:'), write(IndiceArma),
    nl,
    random_between(1, 5, IndiceLocal),
    local(IndiceLocal, Local, _),
    write('IndiceLocal:'), write(IndiceLocal),
    nl,
    random_between(1, 5, IndiceMotivo),
    motivo(IndiceMotivo, Motivo, _),
    write('IndiceMotivo:'), write(IndiceMotivo),
    nl,
    asserta(solucao(Arma, Local, Motivo)),
    solucao(RespostA, RespostB, RespostC),
    write('Solucao Final:'), write(RespostA), write('-'), write(RespostB), write('-'), write(RespostC).

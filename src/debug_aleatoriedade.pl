:- style_check(-singleton).

:-include('./databases/armas.pl').
:-include('./databases/motivos.pl').
:-include('./databases/locais.pl').
:-include('./databases/solucao.pl').
:- module(random).


solucao_aleatoria :- nl,
    write('============DEBUG ASSASSINATO===============\n'),
    random(1, 10, IndiceArma),
    arma(IndiceArma, Arma, _),
    write('ARMA:'), write(Arma),
    nl,
    random(1, 5, IndiceLocal),
    local(IndiceLocal, Local, _),
    write('LOCAL:'), write(Local),
    nl,
    random(1, 5, IndiceMotivo),
    motivo(IndiceMotivo, Motivo, _),
    write('MOTIVO:'), write(Motivo),
    write('\n=============================================\n').


:-initialization(solucao_aleatoria).
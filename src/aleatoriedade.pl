:- style_check(-singleton).

:- consult(databases/armas).
:- consult(databases/motivos).
:- consult(databases/locais).
:- consult(databases/solucao).

solucao_aleatoria :- nl,
    random_between(1, 10, IndiceArma),
    arma(IndiceArma, Arma, _),
    write('IndiceArma:'), write(IndiceArma),
    
    % Armazenamento da Variável
    arma(IndiceArma, Arma, Dica),
    recorda(idArma, IndiceArma),
    recorda(dica_arma, Dica),
    
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


menuArma :- nl,
    write('Dica da arma do crime: '), recorded(dica_arma, X),
    write(X),
    write('\nChute uma das opções abaixo:\n'),
    
    recorded(idArma, OpcaoCorreta),
    
    % Mapeamento das Alternativas
    arma(OpcaoCorreta,NomeArmaCerta,_),
    random(1, 10, Opcao1), arma(Opcao1,ArmaErrada1,_),
    random(1, 10, Opcao2),arma(Opcao2,ArmaErrada2,_),
    random(1, 10, Opcao3), arma(Opcao3,ArmaErrada3,_),
    random_permutation([ArmaErrada1, ArmaErrada2, ArmaErrada3, NomeArmaCerta],Alternativas),
    
    % Setando Alternativas
    nth1(1,Alternativas,A),
    nth1(2,Alternativas,B),
    nth1(3,Alternativas,C),
    nth1(4,Alternativas,D),
    write('=======================================\n'),
    write(A), write('\n'),
    write(B), write('\n'),
    write(C), write('\n'),
    write(D), write('\n'),
    write('======================================='), nl,
    write('Digite uma das Opções acima: '), 
    
    % Leitura de Input do Usuário
    read_line_to_codes(user_input,Cs), atom_codes(RespostaUsuario, Cs), atomic_list_concat(L, ' ', RespostaUsuario),
    write(RespostaUsuario),
    
    % Verificando a Resposta
    (solucao(RespostaUsuario,_,_) -> nl, write('Igual'), nl;nl, write('Diferente'), nl).

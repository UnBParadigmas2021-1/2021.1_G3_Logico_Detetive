:- style_check(-singleton).

:- consult(databases/armas).
:- consult(databases/motivos).
:- consult(databases/locais).
:- consult(databases/solucao).

incrementador(X, X1) :-
    X1 is X+1.

contador_global :-
    CONTADOR is 0,
    recorda(contador, CONTADOR).

gameOver:-
    nl, write('GAME OVER'),nl.

solucao_aleatoria :- nl,
    contador_global,

    random_between(1, 10, IndiceArma),
    arma(IndiceArma, Arma, _),
    write('IndiceArma:'), write(IndiceArma),
    
    % Armazenamento da Variável Local
    arma(IndiceArma, Arma, Dica),
    recorda(idArma, IndiceArma),
    recorda(dica_arma, Dica),
    
    nl,
    random_between(1, 5, IndiceLocal),
    
    local(IndiceLocal, Local, DicaLocal),
    recorda(idLocal, IndiceLocal),
    recorda(dica_local, DicaLocal),

    write('IndiceLocal:'), write(IndiceLocal),
    nl,
    random_between(1, 5, IndiceMotivo),
    motivo(IndiceMotivo, Motivo, _),
    write('IndiceMotivo:'), write(IndiceMotivo),
    nl,
    asserta(solucao(Arma, Local, Motivo)),
    solucao(RespostA, RespostB, RespostC),
    write('Solucao Final:'), write(RespostA), write('-'), write(RespostB), write('-'), write(RespostC), nl,
    menuArma.

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
    (solucao(RespostaUsuario,_,_) -> 
        nl, write('Chamar outro menu (Motivo ou Local)'), tty_clear, menuLocal;
        
        % Lógica dos Valores referentes ao Incrementador
        recorded(contador, CONTADOR),
        incrementador(CONTADOR, CONTADOR_ATUAL),
        recorda(contador, CONTADOR_ATUAL),

        (CONTADOR_ATUAL < 5 -> 
            tty_clear, write('ERROU!! Você possui '), write(CONTADOR_ATUAL/4) ,write(' tentativas'), menuArma ; gameOver)).


menuLocal :- nl,
    recorded(contador, CONTADOR_ATUAL),
    write('Você ainda possui '), write(CONTADOR_ATUAL/4) ,write(' tentativas'),nl,
    write('Dica do local do crime: '), recorded(dica_local, Y),
    write(Y),
    write('\nChute uma das opções abaixo:\n'),
    
    recorded(idLocal, OpcaoCorretaB),
    
    % Mapeamento das Alternativas
    local(OpcaoCorretaB,NomeLocalCerto,_),
    random(1, 5, Opcao1), local(Opcao1,LocalErrado1,_),
    random(1, 5, Opcao2),local(Opcao2,LocalErrado2,_),
    random(1, 5, Opcao3), local(Opcao3,LocalErrado3,_),

    random_permutation([LocalErrado1, LocalErrado2, LocalErrado3, NomeLocalCerto],AlternativasLocal),

    % Setando Alternativas
    nth1(1,AlternativasLocal,A),
    nth1(2,AlternativasLocal,B),
    nth1(3,AlternativasLocal,C),
    nth1(4,AlternativasLocal,D),
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
    (solucao(_,RespostaUsuario,_) -> 
        nl, write('Chamar outro menu (Motivo)'), nl;
        
        % Lógica dos Valores referentes ao Incrementador
        
        recorded(contador, CONTADOR_LOC),
        nl, nl, write(CONTADOR_LOC), nl, nl,
        incrementador(CONTADOR_LOC, CONTADOR_LOCAL),
        recorda(contador, CONTADOR_LOCAL),

        (CONTADOR_LOCAL < 5 -> 
            write('ERROU!! Você possui '), write(CONTADOR_LOCAL/4) ,write(' tentativas') ,tty_clear, menuLocal; gameOver)).
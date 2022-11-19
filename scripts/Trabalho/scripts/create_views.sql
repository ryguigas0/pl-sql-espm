create view RESERVAS as
    select
        RESERVA_MSG(M.MEMBRO_ID,
        M.MEMBRO_NOME,
        M.MEMBRO_TELEFONE,
        ML.RESERVA_INICIO,
        ML.RESERVA_FIM,
        L.LOCAL_NOME) as RESERVAS
    from
        MEMBRO_LOCAL ML
        inner join MEMBRO M
        on M.MEMBRO_ID = ML.MEMBRO_ID
        inner join DB_LOCAL L
        on L.LOCAL_ID = ML.LOCAL_ID;

create view CONVIDADOS as
    select
        CONVIDADOS_MSG(M.MEMBRO_ID,
        M.MEMBRO_NOME,
        M.MEMBRO_RG,
        C.CONVIDADO_ID,
        C.CONVIDADO_NOME,
        C.CONVIDADO_RG) as CONVIDADOS
    from
        MEMBRO    M
        inner join CONVIDADO C
        on C.MEMBRO_ID = M.MEMBRO_ID;

create view JOGOS as
    select
        JOGOS_MSG(M.MEMBRO_ID,
        M.MEMBRO_NOME,
        M.MEMBRO_RG,
        J.JOGO_NOME,
        J.JOGO_DESCRICAO_PECAS) as JOGOS_EMPRESTADOS
    from
        JOGO   J
        inner join MEMBRO M
        on M.MEMBRO_ID = J.MEMBRO_ID;

create view SITUACAO_MEMBROS as
    select
        MEMBRO_MSG(M.MEMBRO_ID,
        M.MEMBRO_NOME,
        M.MEMBRO_RG,
        M.MEMBRO_VALIDO) as SITUACAO_MEMBROS
    from
        MEMBRO M;
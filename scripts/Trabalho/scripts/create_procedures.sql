create or replace procedure CUD_MEMBRO(
    VAR_OPR varchar2,
    VAR_MEMBRO_ID MEMBRO.MEMBRO_ID%TYPE,
    VAR_MEMBRO_NOME MEMBRO.MEMBRO_NOME%TYPE,
    VAR_MEMBRO_RG MEMBRO.MEMBRO_RG%TYPE,
    VAR_MEMBRO_TELEFONE MEMBRO.MEMBRO_TELEFONE%TYPE,
    VAR_MEMBRO_CEP MEMBRO.MEMBRO_CEP%TYPE
)is
begin
    if(VAR_OPR = 'i')then
        insert into MEMBRO(
            MEMBRO_ID,
            MEMBRO_NOME,
            MEMBRO_RG,
            MEMBRO_TELEFONE,
            MEMBRO_CEP
        )values(
            VAR_MEMBRO_ID,
            VAR_MEMBRO_NOME,
            VAR_MEMBRO_RG,
            VAR_MEMBRO_TELEFONE,
            VAR_MEMBRO_CEP
        );
    elsif(VAR_OPR = 'd')then
        delete from MEMBRO
        where
            MEMBRO_ID = VAR_MEMBRO_ID;
    elsif(VAR_OPR = 'u')then
        update MEMBRO
        set
            MEMBRO_NOME = VAR_MEMBRO_NOME,
            MEMBRO_RG = VAR_MEMBRO_RG,
            MEMBRO_TELEFONE = VAR_MEMBRO_TELEFONE,
            MEMBRO_CEP = VAR_MEMBRO_CEP
        where
            MEMBRO_ID = VAR_MEMBRO_ID;
    end if;
end CUD_MEMBRO;
/

create or replace procedure CUD_CONVIDADO(
    VAR_OPR varchar2,
    VAR_CONVIDADO_ID CONVIDADO.CONVIDADO_ID%TYPE,
    VAR_MEMBRO_ID MEMBRO.MEMBRO_ID%TYPE,
    VAR_CONVIDADO_NOME CONVIDADO.CONVIDADO_NOME%TYPE,
    VAR_CONVIDADO_RG CONVIDADO.CONVIDADO_RG%TYPE
)is
begin
    if(VAR_OPR = 'i')then
        insert into CONVIDADO(
            CONVIDADO_ID,
            MEMBRO_ID,
            CONVIDADO_NOME,
            CONVIDADO_RG
        )values(
            VAR_CONVIDADO_ID,
            VAR_MEMBRO_ID,
            VAR_CONVIDADO_NOME,
            VAR_CONVIDADO_RG
        );
    elsif(VAR_OPR = 'd')then
        delete from CONVIDADO
        where
            CONVIDADO_ID = VAR_CONVIDADO_ID;
    elsif(VAR_OPR = 'u')then
        update CONVIDADO
        set
            CONVIDADO_NOME = VAR_CONVIDADO_NOME,
            CONVIDADO_RG = VAR_CONVIDADO_RG,
            MEMBRO_ID = VAR_MEMBRO_ID
        where
            CONVIDADO_ID = VAR_CONVIDADO_ID;
    end if;
end CUD_CONVIDADO;
/

create or replace procedure CUD_JOGO(
    VAR_OPR varchar2,
    VAR_JOGO_ID JOGO.JOGO_ID%TYPE,
    VAR_JOGO_NOME JOGO.JOGO_NOME%TYPE,
    VAR_JOGO_DESCRICAO_PECAS JOGO.JOGO_DESCRICAO_PECAS%TYPE,
    VAR_MEMBRO_ID JOGO.MEMBRO_ID%TYPE
)is
begin
    if(VAR_OPR = 'i')then
        insert into JOGO(
            JOGO_ID,
            MEMBRO_ID,
            JOGO_NOME,
            JOGO_DESCRICAO_PECAS
        )values(
            VAR_JOGO_ID,
            VAR_MEMBRO_ID,
            VAR_JOGO_NOME,
            VAR_JOGO_DESCRICAO_PECAS
        );
    elsif(VAR_OPR = 'd')then
        delete from JOGO
        where
            JOGO_ID = VAR_JOGO_ID;
    elsif(VAR_OPR = 'u')then
        update JOGO
        set
            JOGO_NOME = VAR_JOGO_NOME,
            JOGO_DESCRICAO_PECAS = VAR_JOGO_DESCRICAO_PECAS,
            MEMBRO_ID = VAR_MEMBRO_ID
        where
            JOGO_ID = VAR_JOGO_ID;
    end if;
end CUD_JOGO;
/

create or replace procedure CUD_DB_LOCAL(
    VAR_OPR varchar2,
    VAR_LOCAL_ID DB_LOCAL.LOCAL_ID%TYPE,
    VAR_LOCAL_NOME DB_LOCAL.LOCAL_NOME%TYPE,
    VAR_LOCAL_DESCRICAO DB_LOCAL.LOCAL_DESCRICAO%TYPE
)is
begin
    if(VAR_OPR = 'i')then
        insert into DB_LOCAL(
            LOCAL_ID,
            LOCAL_NOME,
            LOCAL_DESCRICAO
        )values(
            VAR_LOCAL_ID,
            VAR_LOCAL_NOME,
            VAR_LOCAL_DESCRICAO
        );
    elsif(VAR_OPR = 'd')then
        delete from DB_LOCAL
        where
            LOCAL_ID = VAR_LOCAL_ID;
    elsif(VAR_OPR = 'u')then
        update DB_LOCAL
        set
            LOCAL_NOME = VAR_LOCAL_NOME,
            LOCAL_DESCRICAO = VAR_LOCAL_DESCRICAO
        where
            LOCAL_ID = VAR_LOCAL_ID;
    end if;
end CUD_DB_LOCAL;
/

create or replace procedure CUD_MEMBRO_LOCAL(
    VAR_OPR varchar2,
    VAR_MEMBRO_ID MEMBRO_LOCAL.MEMBRO_ID%TYPE,
    VAR_LOCAL_ID MEMBRO_LOCAL.LOCAL_ID%TYPE,
    VAR_RESERVA_INICIO MEMBRO_LOCAL.RESERVA_INICIO%TYPE,
    VAR_RESERVA_FIM MEMBRO_LOCAL.RESERVA_FIM%TYPE
)is
begin
    if(VAR_OPR = 'i')then
        insert into MEMBRO_LOCAL(
            MEMBRO_ID,
            LOCAL_ID,
            RESERVA_INICIO,
            RESERVA_FIM
        )values(
            VAR_MEMBRO_ID,
            VAR_LOCAL_ID,
            VAR_RESERVA_INICIO,
            VAR_RESERVA_FIM
        );
    elsif(VAR_OPR = 'd')then
        delete from MEMBRO_LOCAL
        where
            MEMBRO_ID = VAR_MEMBRO_ID
            and LOCAL_ID = VAR_LOCAL_ID;
    elsif(VAR_OPR = 'u')then
        update MEMBRO_LOCAL
        set
            RESERVA_INICIO = VAR_RESERVA_INICIO,
            RESERVA_FIM = VAR_RESERVA_FIM
        where
            MEMBRO_ID = VAR_MEMBRO_ID
            and LOCAL_ID = VAR_LOCAL_ID;
    end if;
end CUD_MEMBRO_LOCAL;
/



create or replace trigger MEMBRO_TRIGGER before
    insert or
        update on MEMBRO for each row
    begin
        insert into MEMBRO_LOG(
            MEMBRO_ID,
            MEMBRO_NOME,
            MEMBRO_RG,
            MEMBRO_TELEFONE,
            MEMBRO_CEP,
            MEMBRO_LOG_ID,
            MEMEBRO_LOG_ALTERACAO
        )values(
            :NEW.MEMBRO_ID,
            :NEW.MEMBRO_NOME,
            :NEW.MEMBRO_RG,
            :NEW.MEMBRO_TELEFONE,
            :NEW.MEMBRO_CEP,
            ROUND(DBMS_RANDOM.VALUE(0, 999999999), 0),
            SYSDATE
        );
    end;
    create or replace trigger CONVIDADO_TRIGGER before insert or update on CONVIDADO for each row begin insert into CONVIDADO_LOG(
        CONVIDADO_ID,
        MEMBRO_ID,
        CONVIDADO_NOME,
        CONVIDADO_RG,
        CONVIDADO_LOG_ID,
        CONVIDADO_LOG_ALTERACAO
    )values(
        :NEW.CONVIDADO_ID,
        :NEW.MEMBRO_ID,
        :NEW.CONVIDADO_NOME,
        :NEW.CONVIDADO_RG,
        ROUND(DBMS_RANDOM.VALUE(0, 999999999), 0),
        SYSDATE
    );
end;
create or replace trigger JOGO_TRIGGER before insert or update on JOGO for each row begin insert into JOGO_LOG(
    JOGO_ID,
    JOGO_NOME,
    JOGO_DESCRICAO_PECAS,
    MEMBRO_ID,
    JOGO_LOG_ID,
    JOGO_LOG_ALTERACAO
)values(
    :NEW.JOGO_ID,
    :NEW.JOGO_NOME,
    :NEW.JOGO_DESCRICAO_PECAS,
    :NEW.MEMBRO_ID,
    ROUND(DBMS_RANDOM.VALUE(0, 999999999), 0),
    SYSDATE
);
end;
create or replace trigger MEMBRO_LOCAL_TRIGGER before insert or update on MEMBRO_LOCAL for each row begin insert into MEMBRO_LOCAL_LOG(
    MEMBRO_ID,
    LOCAL_ID,
    RESERVA_INICIO,
    RESERVA_FIM,
    MEMBRO_LOCAL_LOG_ID,
    MEMBRO_LOCAL_LOG_ALTERACAO
)values(
    :NEW.MEMBRO_ID,
    :NEW.LOCAL_ID,
    :NEW.RESERVA_INICIO,
    :NEW.RESERVA_FIM,
    ROUND(DBMS_RANDOM.VALUE(0, 999999999), 0),
    SYSDATE
);
end;
create or replace trigger LOCAL_TRIGGER before insert or update on DB_LOCAL for each row begin insert into DB_LOCAL_LOG(
    LOCAL_ID,
    LOCAL_NOME,
    LOCAL_DESCRICAO,
    LOCAL_LOG_ID,
    LOCAL_LOG_ALTERACAO
)values(
    :NEW.LOCAL_ID,
    :NEW.LOCAL_NOME,
    :NEW.LOCAL_DESCRICAO,
    ROUND(DBMS_RANDOM.VALUE(0, 999999999), 0),
    SYSDATE
);
end;
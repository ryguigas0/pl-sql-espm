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
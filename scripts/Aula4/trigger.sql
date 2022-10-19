-- Trigger que roda depois de rodar um update na col_a ou col_b na important_table para cada linha atualizda
create or replace trigger UPDATE_TABLE after
    update of COL_A, COL_B on IMPORTANT_TABLE for each row
begin
 -- Procedure de fazer insert na tabela de logs
 --  Procedures em Triggers não precisam de exec
    ADD_LOG (:OLD.COL_A, :OLD.COL_B, SYSDATE);
 -- :NEW -> Estado APÓS
 -- :OLD -> Estado ANTES
end;
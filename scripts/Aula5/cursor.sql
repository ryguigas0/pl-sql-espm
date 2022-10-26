declare
 -- Cria o cursor para percorrer na tabela
    cursor CURSOR_TABELA is
 -- Quais colunas o cursor passa
        select
            COL_ID,
            COL_A,
            COL_B
        from
 -- Qual tabela tem as colunas
            TABELA;
 -- Variáveis necessárias
    VAR_COL_ID TABELA.COL_ID%TYPE;
    VAR_COL_A  TABELA.COL_A%TYPE;
    VAR_COL_B  TABELA.COL_B%TYPE;
begin
 -- Abre o cursor
    open CURSOR_TABELA;
 -- Inicia um loop
    loop
 -- Busca o próximo elemento na fila (primeiro ao último)
        fetch CURSOR_TABELA into VAR_COL_ID, VAR_COL_A, VAR_COL_B;
 -- Quebra o loop quando ele acabar o index, ou seja, achar mais nada
        exit when CURSOR_TABELA%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VAR_COL_ID
            || VAR_COL_A
            || VAR_COL_B);
 -- Finaliza o código pra loopar
    end loop;
 -- Fecha o cursor para outra tabela usar
    close CURSOR_TABELA;
end;
/
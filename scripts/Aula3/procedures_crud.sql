-- Criar a tabela que é usada no procedure
create table CIDADES (
    COD_CIDADE integer not null,
    NOME varchar2 (100),
    UF char (2)
);

-- Criar o procedure
create or replace procedure SP_CIDADES (
    VCOD_CIDADE integer,
    VNOME varchar2,
    VUF char,
    VOPR char
) is
begin
    if (VOPR = 'i') then
        insert into CIDADES (
            COD_CIDADE,
            NOME,
            UF
        ) values (
            VCOD_CIDADE,
            VNOME,
            VUF
        );
    elsif (VOPR = 'd') then
        delete from CIDADES
        where
            COD_CIDADE = VCOD_CIDADE;
    elsif (VOPR = 'u') then
        update CIDADES
        set
            NOME = VNOME,
            UF = VUF
        where
            COD_CIDADE = VCOD_CIDADE;
    end if;
end SP_CIDADES;
/

-- Executar sp_cidades com insert
EXEC SP_CIDADES (2, 'SÃO JOSÉ DOS CAMPOS', 'SJ', 'i');

-- Executar sp_cidades com update
EXEC SP_CIDADES (2, 'SÃO JOSÉ DOS CAMPOS', 'SC', 'u');

-- Executar sp_cidades com delete
EXEC SP_CIDADES (2, 'SÃO JOSÉ DOS CAMPOS', 'SC', 'd');
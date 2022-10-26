-- Cria ou substitui uma funcao chamada FormatName que tem dois argumentos
-- do tipo varchar e retorna varchar. Ele cocatena as duas strings

create or replace function FORMATNAME(
    FIRST_VARCHAR in varchar,
    SECOND_VARCHAR in varchar
)return varchar is
begin
    return FIRST_VARCHAR
        || ' '
        || SECOND_VARCHAR;
end;
-- Cria ou substitui uma funcao chamada FormatName que tem dois argumentos
-- do tipo varchar e retorna varchar. Ele cocatena as duas strings

CREATE OR REPLACE FUNCTION FORMATNAME(
    FIRST_VARCHAR IN VARCHAR,
    SECOND_VARCHAR IN VARCHAR
) RETURN VARCHAR IS BEGIN RETURN FIRST_VARCHAR
    || ' '
    || SECOND_VARCHAR;

END;
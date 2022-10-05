-- Cria a tabela com pelo menos cinco campos
create table JOGADORES (
    COD_JOGADOR integer,
    NOME varchar2 (50),
    FISICO integer,
    AGILIDADE integer,
    CORAGEM integer,
    INTELIGENCIA integer
);

-- 1. Crie uma procedure que gere o CUD de uma tabela com no
-- mínimo 5 campos (gere o script de create da tabela).

create or replace procedure P_JOGADORES_CUD (
    VOPR char,
    VCOD_JOGADOR integer,
    VNOME varchar2,
    VFISICO integer,
    VAGILIDADE integer,
    VCORAGEM integer,
    VINTELIGENCIA integer
) is
begin
    if (VOPR = 'I') then
        insert into JOGADORES (
            COD_JOGADOR,
            NOME,
            FISICO,
            AGILIDADE,
            CORAGEM,
            INTELIGENCIA
        ) values (
            VCOD_JOGADOR,
            VNOME,
            VFISICO,
            VAGILIDADEM,
            VCORAGEM,
            VINTELIGENCIA
        );
    elsif (VOPR = 'D') then
        delete from JOGADORES
        where
            COD_JOGADOR = VCOD_JOGADOR;
    elsif (VOPR = 'U') then
        update JOGADORES
        set
            NOME = VNOME,
            FISICO = VFISICO,
            AGILIDADE = VAGILIDADE,
            CORAGEM = VCORAGEM,
            INTELIGENCIA = VINTELIGENCIA
        where
            COD_JOGADOR = VCOD_JOGADOR;
    end if;
end P_JOGADORES_CUD;
/

-- 2. Crie uma procedure que insira 3 registros utilizando a
-- procedure do primeiro exercício e altere os dados da segunda
-- linha da tabela utilizando a primeira procedure.

EXEC P_JOGADORES_CUD ('I', 1, 'McBruce Leeniel', 0, 4, 0, 0);

EXEC P_JOGADORES_CUD ('I', 2, 'Erron Black', 1, 1, 1, 1);

EXEC P_JOGADORES_CUD ('U', 2, 'Erron Black', 1, 1, 0, 2);
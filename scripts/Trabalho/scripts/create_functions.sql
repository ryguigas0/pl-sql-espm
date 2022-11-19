create or replace function RESERVA_MSG(
    MEMBRO_ID in number,
    MEMBRO_NOME in varchar,
    MEMBRO_TELEFONE in varchar,
    DATA_RESERVA_INICIO in date,
    DATA_RESERVA_FIM in date,
    NOME_LOCAL in varchar
)return varchar is
begin
    return 'O local '
        || NOME_LOCAL
        || ' está alugado do dia '
        || DATA_RESERVA_INICIO
        || ' até o dia '
        || DATA_RESERVA_FIM
        || ' pelo membro do clube '
        || MEMBRO_NOME
        || ' (ID: '
        || MEMBRO_ID
        || ')';
end RESERVA_MSG;
/

create or replace function CONVIDADOS_MSG(
    MEMBRO_ID in number,
    MEMBRO_NOME in varchar,
    MEMBRO_RG in varchar,
    CONVIDADO_ID in number,
    CONVIDADO_NOME in varchar,
    CONVIDADO_RG in varchar
)return varchar is
begin
    return 'O membro '
        || MEMBRO_NOME
        || ' (ID: '
        || MEMBRO_ID
        || ' ), de rg '
        || MEMBRO_RG
        || ' é responsável pelo convidado '
        || CONVIDADO_NOME
        || ' do rg '
        || CONVIDADO_RG;
end CONVIDADOS_MSG;
/

create or replace function JOGOS_MSG(
    MEMBRO_ID in number,
    MEMBRO_NOME in varchar,
    MEMBRO_RG in varchar,
    JOGO_NOME in varchar,
    JOGO_DESCRICAO_PECAS in varchar
)return varchar is
begin
    return 'O membro '
        || MEMBRO_NOME
        || ' (ID: '
        || MEMBRO_ID
        || ' ), de rg '
        || MEMBRO_RG
        || ' emprestou o jogo '
        || JOGO_NOME
        || ' DESCRIÇÃO DE PEÇAS: '
        || JOGO_DESCRICAO_PECAS;
end JOGOS_MSG;
/

create or replace function MEMBRO_MSG(
    MEMBRO_ID in number,
    MEMBRO_NOME in varchar,
    MEMBRO_RG in varchar,
    MEMBRO_VALIDO in number
)return varchar is
begin
    if MEMBRO_VALIDO = 1 then
        return 'O membro '
            || MEMBRO_NOME
            || ' (ID: '
            || MEMBRO_ID
            || ' ), de rg '
            || MEMBRO_RG
            || ' é um membro válido';
    else
        return 'O membro '
            || MEMBRO_NOME
            || ' (ID: '
            || MEMBRO_ID
            || ' ), de rg '
            || MEMBRO_RG
            || ' é um membro inválido';
    end if;
end MEMBRO_MSG;
/
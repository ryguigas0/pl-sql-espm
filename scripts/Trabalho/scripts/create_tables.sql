create table MEMBRO(
    MEMBRO_ID number(8, 0)not null constraint MEMBRO_PK primary key,
    MEMBRO_NOME varchar2(45)not null,
    MEMBRO_RG varchar2(9)not null,
    MEMBRO_TELEFONE varchar2(11)not null,
    MEMBRO_CEP varchar2(8)not null
);

create table CONVIDADO(
    CONVIDADO_ID NUMBER not null constraint CONVIDADO_PK primary key,
    MEMBRO_ID NUMBER not null,
    CONVIDADO_NOME varchar2(45)not null,
    CONVIDADO_RG varchar2(9)not null
);

create table JOGO(
    JOGO_ID NUMBER not null constraint JOGO_PK primary key,
    JOGO_NOME varchar2(45)not null,
    JOGO_DESCRICAO_PECAS varchar2(256)not null,
    MEMBRO_ID NUMBER
);

create table MEMBRO_LOCAL(
    MEMBRO_ID NUMBER not null,
    LOCAL_ID NUMBER not null,
    RESERVA_INICIO DATE not null,
    RESERVA_FIM DATE not null
);

create table DB_LOCAL(
    LOCAL_ID NUMBER not null constraint LOCAL_PK primary key,
    LOCAL_NOME varchar2(45)not null,
    LOCAL_DESCRICAO varchar2(256)
);

create table MEMBRO_LOG(
    MEMBRO_ID NUMBER not null,
    MEMBRO_NOME varchar2(45)not null,
    MEMBRO_RG varchar2(9)not null,
    MEMBRO_TELEFONE varchar2(11)not null,
    MEMBRO_CEP varchar2(8)not null,
    MEMBRO_LOG_ID NUMBER not null constraint MEMBRO_LOG_PK primary key,
    MEMEBRO_LOG_ALTERACAO DATE not null
);

create table CONVIDADO_LOG(
    CONVIDADO_ID NUMBER not null,
    MEMBRO_ID NUMBER not null,
    CONVIDADO_NOME varchar2(45)not null,
    CONVIDADO_RG varchar2(9)not null,
    CONVIDADO_LOG_ID NUMBER not null constraint CONVIDADO_LOG_PK primary key,
    CONVIDADO_LOG_ALTERACAO DATE not null
);

create table JOGO_LOG(
    JOGO_ID NUMBER not null,
    JOGO_NOME varchar2(45)not null,
    JOGO_DESCRICAO_PECAS varchar2(256)not null,
    MEMBRO_ID NUMBER,
    JOGO_LOG_ID NUMBER not null constraint JOGO_LOG_PK primary key,
    JOGO_LOG_ALTERACAO DATE not null
);

create table MEMBRO_LOCAL_LOG(
    MEMBRO_ID NUMBER not null,
    LOCAL_ID NUMBER not null,
    RESERVA_INICIO DATE not null,
    RESERVA_FIM DATE not null,
    MEMBRO_LOCAL_LOG_ID NUMBER not null constraint MEMBRO_LOCAL_LOG_PK primary key,
    MEMBRO_LOCAL_LOG_ALTERACAO DATE not null
);

create table DB_LOCAL_LOG(
    LOCAL_ID NUMBER not null,
    LOCAL_NOME varchar2(45)not null,
    LOCAL_DESCRICAO varchar2(256),
    LOCAL_LOG_ID NUMBER not null constraint LOCAL_LOG_PK primary key,
    LOCAL_LOG_ALTERACAO DATE not null
);
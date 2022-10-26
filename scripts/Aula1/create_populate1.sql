-- Criando tabela de aluno
create table ALUNO (
  ID NUMBER not null constraint ALUNO_PK primary key,
  PRIMEIRO_NOME varchar2 (15) not null,
  ULTIMO_NOME varchar2 (15) not null,
  ENDERECO varchar2 (100) not null
);

-- Criando tabela de curso
create table CURSO (
  ID NUMBER not null constraint CURSO_PK primary key,
  NOME varchar2 (30) not null
);

-- Criando conexão entre tabela de aluno e curso
create table CON_ALUNO_CURSO (
  ALUNO_ID NUMBER not null,
  CURSO_ID NUMBER not null
);

-- Criando tabela de mensalidade
create table MENSALIDADE (
  ID NUMBER not null constraint MENSALIDADE_PK primary key,
  ALUNO_ID NUMBER not null,
  DATA_VENCIMENTO DATE not null,
  DATA_EMISSAO DATE not null,
  VALOR NUMBER not null,
  DESCRICAO varchar2 (200)
);

-- Criando tabela de pagamento
create table PAGAMENTO (
  ID NUMBER not null constraint PAGAMENTO_PK primary key,
  DATA_PAGAMENTO DATE not null,
  VALOR_PAGO NUMBER not null
);

-- Criando tabela para fazer relção vários para vários entre mensalidade e pagamento
create table CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID NUMBER not null,
  PAGAMENTO_ID NUMBER not null
);

-- Inserindo aluno
insert into ALUNO (
  ID,
  PRIMEIRO_NOME,
  ULTIMO_NOME,
  ENDERECO
) values (
  1,
  'Guilherme',
  'Casagrande',
  'Rua topzera 1'
);

insert into ALUNO (
  ID,
  PRIMEIRO_NOME,
  ULTIMO_NOME,
  ENDERECO
) values (
  2,
  'Flávia',
  'Jonathan',
  'Rua maneirassa 2'
);

insert into ALUNO (
  ID,
  PRIMEIRO_NOME,
  ULTIMO_NOME,
  ENDERECO
) values (
  3,
  'Felipe',
  'Jonathan',
  'Rua maneirassa 3'
);

-- Inserindo cursos
insert into CURSO (
  ID,
  NOME
) values (
  1,
  'Curso legal 1'
);

insert into CURSO (
  ID,
  NOME
) values (
  2,
  'Curso legal 2'
);

-- Conectando alunos aos cursos
insert into CON_ALUNO_CURSO (
  ALUNO_ID,
  CURSO_ID
) values (
  1,
  1
);

insert into CON_ALUNO_CURSO (
  ALUNO_ID,
  CURSO_ID
) values (
  2,
  1
);

insert into CON_ALUNO_CURSO (
  ALUNO_ID,
  CURSO_ID
) values (
  2,
  2
);

insert into CON_ALUNO_CURSO (
  ALUNO_ID,
  CURSO_ID
) values (
  3,
  2
);

-- Inserindo mensalidade
insert into MENSALIDADE (
  ID,
  ALUNO_ID,
  DATA_VENCIMENTO,
  DATA_EMISSAO,
  VALOR,
  DESCRICAO
) values (
  1,
  1,
  '22-SEP-22',
  '14-SEP-22',
  4512.22,
  'Mensalidade de setembro'
);

insert into MENSALIDADE (
  ID,
  ALUNO_ID,
  DATA_VENCIMENTO,
  DATA_EMISSAO,
  VALOR,
  DESCRICAO
) values (
  2,
  1,
  '22-OCT-22',
  '14-OCT-22',
  200.00,
  'Mensalidade de outubro'
);

insert into MENSALIDADE (
  ID,
  ALUNO_ID,
  DATA_VENCIMENTO,
  DATA_EMISSAO,
  VALOR,
  DESCRICAO
) values (
  3,
  2,
  '22-SEP-22',
  '14-SEP-22',
  4512.22,
  'Mensalidade de setembro'
);

insert into MENSALIDADE (
  ID,
  ALUNO_ID,
  DATA_VENCIMENTO,
  DATA_EMISSAO,
  VALOR,
  DESCRICAO
) values (
  4,
  2,
  '22-OCT-22',
  '14-OCT-22',
  200.00,
  'Mensalidade de outubro'
);

insert into MENSALIDADE (
  ID,
  ALUNO_ID,
  DATA_VENCIMENTO,
  DATA_EMISSAO,
  VALOR,
  DESCRICAO
) values (
  5,
  3,
  '22-AUG-22',
  '14-AUG-22',
  200.00,
  'Mensalidade de agosto'
);

-- Inserindo pagamentos
insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  1,
  '18-SEP-22',
  2500.22
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  2,
  '19-SEP-22',
  12.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  3,
  '20-SEP-22',
  200.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  4,
  '21-OCT-22',
  200.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  5,
  '18-SEP-22',
  2500.22
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  6,
  '19-SEP-22',
  12.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  7,
  '20-SEP-22',
  200.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  8,
  '21-OCT-22',
  200.00
);

insert into PAGAMENTO (
  ID,
  DATA_PAGAMENTO,
  VALOR_PAGO
) values (
  9,
  '21-AUG-22',
  200.00
);

-- Inserindo a conexão entre mensalidade e pagamentos
insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  1,
  1
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  1,
  2
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  1,
  3
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  2,
  4
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  3,
  5
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  3,
  6
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  3,
  7
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  4,
  8
);

insert into CON_MENSALIDADE_PAGAMENTO (
  MENSALIDADE_ID,
  PAGAMENTO_ID
) values (
  5,
  9
);
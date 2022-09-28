 -- Criando tabela de aluno
create table
  aluno (
    id number not null constraint aluno_pk primary key,
    primeiro_nome varchar2 (15) not null,
    ultimo_nome varchar2 (15) not null,
    endereco varchar2 (100) not null
  );

-- Criando tabela de curso
create table
  curso (
    id number not null constraint curso_pk primary key,
    nome varchar2 (30) not null
  );

-- Criando conexão entre tabela de aluno e curso
create table
  con_aluno_curso (
    aluno_id number not null,
    curso_id number not null
  );

-- Criando tabela de mensalidade
create table
  mensalidade (
    id number not null constraint mensalidade_pk primary key,
    aluno_id number not null,
    data_vencimento date not null,
    data_emissao date not null,
    valor number not null,
    descricao varchar2 (200)
  );

-- Criando tabela de pagamento
create table
  pagamento (
    id number not null constraint pagamento_pk primary key,
    data_pagamento date not null,
    valor_pago number not null
  );

-- Criando tabela para fazer relção vários para vários entre mensalidade e pagamento
create table
  con_mensalidade_pagamento (
    mensalidade_id number not null,
    pagamento_id number not null
  );

-- Inserindo aluno
insert into
  aluno (id, primeiro_nome, ultimo_nome, endereco)
values
  (1, 'Guilherme', 'Casagrande', 'Rua topzera 1');

insert into
  aluno (id, primeiro_nome, ultimo_nome, endereco)
values
  (2, 'Flávia', 'Jonathan', 'Rua maneirassa 2');

insert into
  aluno (id, primeiro_nome, ultimo_nome, endereco)
values
  (3, 'Felipe', 'Jonathan', 'Rua maneirassa 3');

-- Inserindo cursos
insert into
  curso (id, nome)
values
  (1, 'Curso legal 1');

insert into
  curso (id, nome)
values
  (2, 'Curso legal 2');

-- Conectando alunos aos cursos
insert into
  con_aluno_curso (aluno_id, curso_id)
values
  (1, 1);

insert into
  con_aluno_curso (aluno_id, curso_id)
values
  (2, 1);

insert into
  con_aluno_curso (aluno_id, curso_id)
values
  (2, 2);

insert into
  con_aluno_curso (aluno_id, curso_id)
values
  (3, 2);

-- Inserindo mensalidade
insert into
  mensalidade (
    id,
    aluno_id,
    data_vencimento,
    data_emissao,
    valor,
    descricao
  )
values
  (
    1,
    1,
    '22-SEP-22',
    '14-SEP-22',
    4512.22,
    'Mensalidade de setembro'
  );

insert into
  mensalidade (
    id,
    aluno_id,
    data_vencimento,
    data_emissao,
    valor,
    descricao
  )
values
  (
    2,
    1,
    '22-OCT-22',
    '14-OCT-22',
    200.00,
    'Mensalidade de outubro'
  );

insert into
  mensalidade (
    id,
    aluno_id,
    data_vencimento,
    data_emissao,
    valor,
    descricao
  )
values
  (
    3,
    2,
    '22-SEP-22',
    '14-SEP-22',
    4512.22,
    'Mensalidade de setembro'
  );

insert into
  mensalidade (
    id,
    aluno_id,
    data_vencimento,
    data_emissao,
    valor,
    descricao
  )
values
  (
    4,
    2,
    '22-OCT-22',
    '14-OCT-22',
    200.00,
    'Mensalidade de outubro'
  );

insert into
  mensalidade (
    id,
    aluno_id,
    data_vencimento,
    data_emissao,
    valor,
    descricao
  )
values
  (
    5,
    3,
    '22-AUG-22',
    '14-AUG-22',
    200.00,
    'Mensalidade de agosto'
  );

-- Inserindo pagamentos
insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (1, '18-SEP-22', 2500.22);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (2, '19-SEP-22', 12.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (3, '20-SEP-22', 200.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (4, '21-OCT-22', 200.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (5, '18-SEP-22', 2500.22);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (6, '19-SEP-22', 12.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (7, '20-SEP-22', 200.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (8, '21-OCT-22', 200.00);

insert into
  pagamento (id, data_pagamento, valor_pago)
values
  (9, '21-AUG-22', 200.00);

-- Inserindo a conexão entre mensalidade e pagamentos
insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (1, 1);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (1, 2);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (1, 3);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (2, 4);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (3, 5);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (3, 6);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (3, 7);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (4, 8);

insert into
  con_mensalidade_pagamento (mensalidade_id, pagamento_id)
values
  (5, 9);
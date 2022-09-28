-- Questão 2: Criar uma view que exiba o nome, o endereço, a data de vencimento e o 
-- valor de todos os alunos que não efetuaram pagamento até a presente 
-- data.
create view
  alunos_faltando_pagar_ate_hoje as
select
  (a.primeiro_nome || ' ' || a.ultimo_nome) as nome_aluno,
  a.endereco as endereco_aluno,
  m.data_vencimento as vencimento_boleto,
  m.valor as valor_boleto,
  sum(p.valor_pago) as total_pago
from
  aluno a
  inner join mensalidade m on a.id = m.aluno_id
  inner join con_mensalidade_pagamento cmp on cmp.mensalidade_id = m.id
  inner join pagamento p on p.id = cmp.pagamento_id
group by
  a.id,
  a.primeiro_nome,
  a.ultimo_nome,
  a.endereco,
  m.id,
  m.data_vencimento,
  m.valor,
  cmp.mensalidade_id
having
  sum(p.valor_pago) != m.valor;

-- Questão 3: Criar uma view que exiba a matricula e o nome dos alunos que não 
-- tenham mensalidades emitidas.
create view
  alunos_que_nao_emitiram_mensalidade as
select
  a.id as matricula_aluno,
  a.primeiro_nome
from
  aluno a
  left join mensalidade m on m.aluno_id = a.id
group by
  a.id,
  a.primeiro_nome,
  to_char (sysdate, 'MM')
having
  to_char (sysdate, 'MM') > max(to_char (m.data_emissao, 'MM'));

-- Questão 4: Criar uma view que exiba o nome do aluno, o nome do curso e a 
-- quantidade de dias entre a data de vencimento e data atual de alunos que 
-- pagam a mensalidade com antecedência
create view
  alunos_intervalo_antecedencia_pagamento_mensalidade as
select
  (a.primeiro_nome || ' ' || a.ultimo_nome) as nome_aluno,
  cur.nome as nome_curso,
  (sysdate - max(p.data_pagamento)) * -1 as diferenca_dias
from
  aluno a
  inner join con_aluno_curso cac on cac.aluno_id = a.id
  inner join curso cur on cur.id = cac.curso_id
  inner join mensalidade m on m.aluno_id = a.id
  inner join con_mensalidade_pagamento cmp on cmp.mensalidade_id = m.id
  inner join pagamento p on p.id = cmp.pagamento_id
group by
  (a.primeiro_nome || ' ' || a.ultimo_nome),
  cur.nome,
  m.valor,
  m.data_vencimento
having
  m.valor = sum(p.valor_pago)
  and m.data_vencimento > max(p.data_pagamento)
  and (sysdate - max(p.data_pagamento)) * -1 >= 0;

-- Questão 5: Consultar estas views usando o comando SELECT
select
  *
from
  alunos_faltando_pagar_ate_hoje;

select
  *
from
  alunos_que_nao_emitiram_mensalidade;

select
  *
from
  alunos_intervalo_antecedencia_pagamento_mensalidade;

-- Questão 6: Apagar a view criada no exercício de número 2
drop
  view alunos_faltando_pagar_ate_hoje;
-- Questão 2: Criar uma view que exiba o nome, o endereço, a data de vencimento e o
-- valor de todos os alunos que não efetuaram pagamento até a presente
-- data.
create view ALUNOS_FALTANDO_PAGAR_ATE_HOJE as
  select
    (A.PRIMEIRO_NOME || ' ' || A.ULTIMO_NOME) as NOME_ALUNO,
    A.ENDERECO                                as ENDERECO_ALUNO,
    M.DATA_VENCIMENTO                         as VENCIMENTO_BOLETO,
    M.VALOR                                   as VALOR_BOLETO,
    sum (P.VALOR_PAGO)                         as TOTAL_PAGO
  from
    ALUNO                     A
    inner join MENSALIDADE M
    on A.ID = M.ALUNO_ID
    inner join CON_MENSALIDADE_PAGAMENTO CMP
    on CMP.MENSALIDADE_ID = M.ID
    inner join PAGAMENTO P
    on P.ID = CMP.PAGAMENTO_ID
  group by
    A.ID,
    A.PRIMEIRO_NOME,
    A.ULTIMO_NOME,
    A.ENDERECO,
    M.ID,
    M.DATA_VENCIMENTO,
    M.VALOR,
    CMP.MENSALIDADE_ID
  having
    sum (P.VALOR_PAGO) != M.VALOR;

-- Questão 3: Criar uma view que exiba a matricula e o nome dos alunos que não
-- tenham mensalidades emitidas.
create view ALUNOS_QUE_NAO_EMITIRAM_MENSALIDADE as
  select
    A.ID as MATRICULA_ALUNO,
    A.PRIMEIRO_NOME
  from
    ALUNO       A
    left join MENSALIDADE M
    on M.ALUNO_ID = A.ID
  group by
    A.ID,
    A.PRIMEIRO_NOME,
    TO_CHAR (SYSDATE,
    'MM')
  having
    TO_CHAR (SYSDATE,
    'MM') > max (TO_CHAR (M.DATA_EMISSAO,
    'MM') );

-- Questão 4: Criar uma view que exiba o nome do aluno, o nome do curso e a
-- quantidade de dias entre a data de vencimento e data atual de alunos que
-- pagam a mensalidade com antecedência
create view ALUNOS_INTERVALO_ANTECEDENCIA_PAGAMENTO_MENSALIDADE as
  select
    (A.PRIMEIRO_NOME || ' ' || A.ULTIMO_NOME) as NOME_ALUNO,
    CUR.NOME                                  as NOME_CURSO,
    (SYSDATE - max (P.DATA_PAGAMENTO) ) * - 1    as DIFERENCA_DIAS
  from
    ALUNO                     A
    inner join CON_ALUNO_CURSO CAC
    on CAC.ALUNO_ID = A.ID
    inner join CURSO CUR
    on CUR.ID = CAC.CURSO_ID
    inner join MENSALIDADE M
    on M.ALUNO_ID = A.ID
    inner join CON_MENSALIDADE_PAGAMENTO CMP
    on CMP.MENSALIDADE_ID = M.ID
    inner join PAGAMENTO P
    on P.ID = CMP.PAGAMENTO_ID
  group by
    (A.PRIMEIRO_NOME
      || ' '
      || A.ULTIMO_NOME),
    CUR.NOME,
    M.VALOR,
    M.DATA_VENCIMENTO
  having
    M.VALOR = sum (P.VALOR_PAGO)
    and M.DATA_VENCIMENTO > max (P.DATA_PAGAMENTO)
    and (SYSDATE - max (P.DATA_PAGAMENTO) ) * - 1 >= 0;

-- Questão 5: Consultar estas views usando o comando SELECT
select
  *
from
  ALUNOS_FALTANDO_PAGAR_ATE_HOJE;

select
  *
from
  ALUNOS_QUE_NAO_EMITIRAM_MENSALIDADE;

select
  *
from
  ALUNOS_INTERVALO_ANTECEDENCIA_PAGAMENTO_MENSALIDADE;

-- Questão 6: Apagar a view criada no exercício de número 2
drop view ALUNOS_FALTANDO_PAGAR_ATE_HOJE;
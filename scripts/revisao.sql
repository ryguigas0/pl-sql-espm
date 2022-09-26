-- 1. Selecione todos os filmes locados em 2006. Traga nos resultados: o nome do filme e a descrição.

select f.titulo, f.descricao, a.data_de_aluguel
from aluguel a
inner join inventario i on i.inventario_id = a.inventario_id
inner join filme f on f.filme_id = i.filme_id
where extract(year from a.data_de_aluguel) = 2006;

-- 2. Selecione todas as locações por cliente. Traga nos resultados: o nome do cliente e o nome dos filmes locados.

select 
	concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_cliente, 
    f.titulo as nome_filme_alugado
from aluguel a
inner join cliente c on c.cliente_id = a.cliente_id
inner join inventario i on i.inventario_id = a.inventario_id
inner join filme f on f.filme_id = i.filme_id;

-- 3. Selecione todos os pagamentos de todos os clientes. Traga nos resultados: o nome do cliente e o pagamento correspondente.

select 
	concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_cliente,
    p.valor as valor_pagamento,
    p.data_de_pagamento as data_pagamento
from pagamento p
inner join cliente c on c.cliente_id = p.cliente_id
order by data_pagamento desc;

-- 4. Construa uma query que traga o nome e o endereço completo (endereço, cidade, estado, país) de todos os clientes.

select
	concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_cliente,
    concat(e.endereco, ', ', ci.cidade, ', ', p.pais) as endereço_cliente
from cliente c
inner join endereco e on e.endereco_id = c.endereco_id
inner join cidade ci on ci.cidade_id = e.cidade_id
inner join pais p on p.pais_id = ci.pais_id;

-- 5. Selecione quantidade de locações por filmes.

select 
	f.titulo as titulo_filme,
	count(f.titulo) as locações
from aluguel a
inner join inventario i on i.inventario_id = a.inventario_id
inner join filme f on f.filme_id = i.filme_id
group by f.titulo;

-- 6. Gere o ranking dos filmes mais alugados.

select 
	f.titulo as titulo_filme,
	count(f.titulo) as locações
from aluguel a
inner join inventario i on i.inventario_id = a.inventario_id
inner join filme f on f.filme_id = i.filme_id
group by f.titulo
order by locações desc;

-- 7. Gere o ranking dos clientes que mais consomem.

select
	concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_cliente,
    count(a.aluguel_id) as qtd_alugueis
from aluguel a
inner join cliente c on c.cliente_id = a.cliente_id
group by nome_cliente
order by qtd_alugueis desc;

-- 8. Descubra a quantidade de locações por categoria de filme e selecione apenas as categorias com mais de 200 locações.

select c.nome as nome_categorira, count(a.aluguel_id) as qtd_alugueis
from aluguel a
inner join inventario i on i.inventario_id = a.inventario_id
inner join filme f on f.filme_id = i.filme_id
inner join filme_categoria fc on fc.filme_id = f.filme_id
inner join categoria c on c.categoria_id = fc.categoria_id
group by c.categoria_id
having qtd_alugueis > 200;

-- 9. Descubra o faturamento e o ticket médio por dia (precisão de 2 casas decimais).

select 
	cast(p.data_de_pagamento as date) as dia_pagamento, 
	sum(p.valor) as faturamento, 
    format(avg(p.valor), 2) as ticket_medio 
from pagamento p
group by dia_pagamento;

-- 10. Apresente o faturamento total por loja.

select l.loja_id, sum(p.valor) as faturamento
from pagamento p
inner join aluguel a on a.aluguel_id = p.aluguel_id
inner join cliente c on c.cliente_id = a.cliente_id
inner join loja l on l.loja_id = c.loja_id
group by l.loja_id;

-- 11. Mostre o total de filmes alugados por dia e por loja.

select 
	l.loja_id as cod_loja,
	cast(a.data_de_aluguel as date) as data_aluguel, 
    count(i.inventario_id) as qtd_filme
from aluguel a
inner join funcionario f on a.funcionario_id = f.funcionario_id
inner join loja l on l.loja_id = f.loja_id
inner join inventario i on i.inventario_id = a.inventario_id
group by cod_loja, data_aluguel;

-- 12. Selecione o nome completo dos clientes e suas cidades de origem.

select
	concat(c.primeiro_nome, ' ', c.ultimo_nome) as nome_cliente, 
    cidade as cidade_origem
from cliente c
inner join endereco e on e.endereco_id = c.endereco_id
inner join cidade ci on ci.cidade_id = e.cidade_id;

-- 13. Descubra a quantidade de cada filme no inventario de cada loja.

select 
	i.loja_id as id_loja,
	f.titulo as nome_filme, 
    count(i.inventario_id) as qtd_inventario
from inventario i
inner join filme f on f.filme_id = i.filme_id
group by i.loja_id, f.filme_id;

-- 14. Selecione todas as categorias de filmes que a atriz MARY TANDY não atua.

select c.nome
from categoria c
where c.categoria_id not in (
	select distinct c.categoria_id
	from ator a
	inner join filme_ator fa on fa.ator_id = a.ator_id
	inner join filme_categoria fc on fc.filme_id = fa.filme_id
	inner join categoria c on c.categoria_id = fc.categoria_id
	where a.primeiro_nome = 'MARY' and a.ultimo_nome = 'TANDY'
);

-- 15. Descubra o faturamento e o ticket médio por dia (exiba apenas uma casa decimal), busque apenas os dias em que o faturamento for maior que 300.

select 
	cast(p.data_de_pagamento as date) as dia_pagamento, 
	sum(p.valor) as faturamento, 
    format(avg(p.valor), 1) as ticket_medio 
from pagamento p
group by dia_pagamento
having faturamento > 300;

-- 16. Descubra o faturamento mensal por cidade e gere o ranking.

select 
	ci.cidade as nome_cidade,
	sum(p.valor) as faturamento_cidade
from pagamento p
inner join cliente c on c.cliente_id = p.cliente_id
inner join endereco e on e.endereco_id = c.endereco_id
inner join cidade ci on ci.cidade_id = e.cidade_id
group by nome_cidade
order by faturamento_cidade desc;


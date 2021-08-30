-- tícket médio de todas as vendas no dia anterior
select tb.data_dia, avg(tb.ticket_medio) as ticket_ontem
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where n.DATA_EMISSAO = date_sub(current_date(), interval 1 day) 
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;



-- tícket médio de todas as vendas na semana corrente (sete dias para trás a partir do dia de ontem)

select avg(tb.ticket_medio) as media_ultimos_7_dias
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval 7 day))
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;



-- tícket médio de todas as vendas no mês corrente (do dia 1 do mês corrente até o dia de ontem)

select avg(tb.ticket_medio) as media_mes_corrente
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval day(current_date()) day))
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;



-- tícket médio das vendas Web no dia anterior

select tb.data_dia, avg(tb.ticket_medio) as ticket_web_ontem
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where n.DATA_EMISSAO = date_sub(current_date(), interval 1 day) and not isnull(n.codigo_pedido)
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;


-- tícket médio das vendas Web na semana corrente (sete dias para trás a partir do dia de ontem)

select avg(tb.ticket_medio) as media_web_ultimos_7_dias
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval 7 day)) and not isnull(n.codigo_pedido)
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;



-- tícket médio das vendas Web no mês corrente (do dia 1 do mês corrente até o dia de ontem)

select avg(tb.ticket_medio) as media_web_mes_corrente
from 
(
select tb_total_nf.data_emissao as data_dia, avg(tb_total_nf.total_nf) as ticket_medio, 'aux'
from 
(
select tb_item.codigo_nf, sum(tb_item.valor_total) as Total_nf, tb_item.data_emissao
from 
(
select in2.CODIGO_ITEM, n.CODIGO_NF , p.DESCRICAO, in2.QUANTIDADE_PRODUTO, pc.VALOR_PRECO as preco_unid, (in2.QUANTIDADE_PRODUTO*pc.VALOR_PRECO) as valor_total, n.DATA_EMISSAO 
from item_nf in2 
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO= pc.CODIGO_PRODUTO)
inner join nf n on (in2.CODIGO_NF=n.CODIGO_NF)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval day(current_date()) day)) and not (isnull(n.codigo_pedido))
order by in2.CODIGO_ITEM  
) tb_item
group by tb_item.codigo_nf
) tb_total_nf
group by tb_total_nf.data_emissao
order by tb_total_nf.data_emissao
) tb
group by 'aux'
;



-- ranking dos produtos com quantidades mais vendidas no dia anterior 

select in2.CODIGO_PRODUTO, p.DESCRICAO , sum(in2.QUANTIDADE_PRODUTO) as qtd_vendidos 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
where (n.DATA_EMISSAO = date_sub(current_date(), interval 1 day))
group by in2.CODIGO_PRODUTO 
order by qtd_vendidos desc
;

-- ranking dos produtos com quantidades mais vendidas na semana corrente (sete dias para trás a partir do dia de ontem)

select in2.CODIGO_PRODUTO, p.DESCRICAO , sum(in2.QUANTIDADE_PRODUTO) as qtd_vendidos 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval 7 day))
group by in2.CODIGO_PRODUTO 
order by qtd_vendidos desc
;

-- ranking dos produtos com quantidades mais vendidas no mês corrente (do dia 1 do mês corrente até o dia de ontem)

select in2.CODIGO_PRODUTO, p.DESCRICAO , sum(in2.QUANTIDADE_PRODUTO) as qtd_vendidos 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval day(current_date()) day))
group by in2.CODIGO_PRODUTO 
order by qtd_vendidos desc
;

-- ranking dos produtos com valores mais vendidos no dia anterior

select in2.CODIGO_PRODUTO, p.DESCRICAO , (sum(in2.QUANTIDADE_PRODUTO)*pc.VALOR_PRECO) as fat_produto 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on(p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO = date_sub(current_date(), interval 1 day))
group by in2.CODIGO_PRODUTO 
order by fat_produto desc
;


-- ranking dos produtos com valores mais vendidos na semana corrente (sete dias para trás a partir do dia de ontem)

select in2.CODIGO_PRODUTO, p.DESCRICAO , (sum(in2.QUANTIDADE_PRODUTO)*pc.VALOR_PRECO) as fat_produto 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on(p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval 7 day))
group by in2.CODIGO_PRODUTO 
order by fat_produto desc
;

-- ranking dos produtos com valores mais vendidos no mês corrente (do dia 1 do mês corrente até o dia de ontem)

select in2.CODIGO_PRODUTO, p.DESCRICAO , (sum(in2.QUANTIDADE_PRODUTO)*pc.VALOR_PRECO) as fat_produto 
from nf n 
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on(p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval day(current_date()) day))
group by in2.CODIGO_PRODUTO 
order by fat_produto desc
;

-- ranking dos clientes que mais compram (valor) no dia anterior
select c.CODIGO_CLIENTE, c.NOME_RAZAO_SOCIAL, sum(pc.VALOR_PRECO*in2.QUANTIDADE_PRODUTO) as total_gasto
from nf n 
inner join clientes c on (c.CODIGO_CLIENTE=n.CODIGO_CLIENTE)
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO = date_sub(current_date(), interval 1 day))
group by c.CODIGO_CLIENTE  
order by total_gasto desc 
;

-- ranking dos clientes que mais compram (valor) na semana corrente (sete dias para trás a partir do dia de ontem)
select c.CODIGO_CLIENTE, c.NOME_RAZAO_SOCIAL, sum(pc.VALOR_PRECO*in2.QUANTIDADE_PRODUTO) as total_gasto
from nf n 
inner join clientes c on (c.CODIGO_CLIENTE=n.CODIGO_CLIENTE)
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval 7 day))
group by c.CODIGO_CLIENTE  
order by total_gasto desc 

-- ranking dos clientes que mais compram (valor) no mês corrente (do dia 1 do mês corrente até o dia de ontem)

select c.CODIGO_CLIENTE, c.NOME_RAZAO_SOCIAL, sum(pc.VALOR_PRECO*in2.QUANTIDADE_PRODUTO) as total_gasto
from nf n 
inner join clientes c on (c.CODIGO_CLIENTE=n.CODIGO_CLIENTE)
inner join item_nf in2 on (n.CODIGO_NF=in2.CODIGO_NF)
inner join produtos p on (p.CODIGO_PRODUTO=in2.CODIGO_PRODUTO)
inner join preco_compra pc on (p.CODIGO_PRODUTO=pc.CODIGO_PRODUTO)
where (n.DATA_EMISSAO<current_date() and n.DATA_EMISSAO > date_sub(current_date(), interval day(current_date()) day))
group by c.CODIGO_CLIENTE  
order by total_gasto desc

























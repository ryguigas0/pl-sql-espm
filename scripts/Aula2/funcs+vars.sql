create or replace function GERAVALORVENDA(
    VAR_VL_CUST in number
)
 -- Escopo das variáveis
 -- nome_var tipo := valor;
return number is
    VAR_VL_VENDA_PRODUTO number := 0;
    TAXA_LUCRO           number := 3.0;
begin
    VAR_VL_VENDA_PRODUTO := VAR_VL_CUST + (VAR_VL_CUST * TAXA_LUCRO);
    return VAR_VL_VENDA_PRODUTO;
end;
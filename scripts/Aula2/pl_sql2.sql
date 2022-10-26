-- 1. Crie uma função que receba dois nomes e retorne o nome composto
create or replace function NOMECOMPOSTO(
    PRIMEIRONOME in varchar,
    ULTIMONOME in varchar
)return varchar is
begin
    return PRIMEIRONOME
        || ' '
        || ULTIMONOME;
end NOMECOMPOSTO;
 -- 2. Crie uma função que calcule a média de três valores
 create or replace function MEDIA3VALORES(NUM1 in number, NUM2 in number, NUM3 in number)return number is
begin
    return(NUM1 + NUM2 + NUM3) / 3;
end MEDIA3VALORES;
 -- 3. Desenvolva uma função que escolha o maior número de uma serie de 5
 -- números
 create or replace function MAIORDE5VALORES(NUM1 in number, NUM2 in number, NUM3 in number, NUM4 in number, NUM5 in number)return number is
    VARRETORNO number;
begin
    if NUM1 >= NUM2 and NUM1 >= NUM3 and NUM1 >= NUM4 and NUM1 >= NUM5 then
        VARRETORNO := NUM1;
    elsif NUM2 >= NUM1 and NUM2 >= NUM3 and NUM2 >= NUM4 and NUM2 >= NUM5 then
        VARRETORNO := NUM2;
    elsif NUM3 >= NUM1 and NUM3 >= NUM2 and NUM3 >= NUM4 and NUM3 >= NUM5 then
        VARRETORNO := NUM3;
    elsif NUM4 >= NUM1 and NUM4 >= NUM3 and NUM4 >= NUM2 and NUM4 >= NUM5 then
        VARRETORNO := NUM4;
    else
        VARRETORNO := NUM5;
    end if;
    return VARRETORNO;
end;
 -- 4. Desenvolva uma função que converta uma string em um float com 2 casa
 -- decimais
 create or replace function STR_TO_FLOAT_2CASAS(STR in varchar)return number is
begin
    return ROUND(TO_NUMBER(STR), 2);
end;
 -- 5. Crie uma função para definir se um número é par ou impar.
 create or replace function PAROUIMPAR(NUM in number)return varchar is
    VARRETORNO varchar;
begin
    if(NUM / 2) != 0 then
        VARRETORNO := 'impar';
    else
        VARRETORNO := 'par';
    end if;
    return VARRETORNO;
end PAROUIMPAR;
 -- 6. Crie uma função para ler o salário de uma pessoa e calcule o imposto de
 -- renda a ser pago obedecendo a seguinte tabela.
 --Create a new Function
 -- Start with function signature
 create or replace function CALC_IMPOSTO_RENDA(SALARIO in number)return number is
    VARIMPOSTO number := 0;
begin
    if SALARIO >= 1500 and SALARIO < 2500 then
        VARIMPOSTO := SALARIO * 0.15;
    elsif SALARIO >= 2500 and SALARIO <= 4500 then
        VARIMPOSTO := SALARIO * 0.20;
    else
        VARIMPOSTO := SALARIO * 0.275;
    end if;
    return VARIMPOSTO;
end CALC_IMPOSTO_RENDA;
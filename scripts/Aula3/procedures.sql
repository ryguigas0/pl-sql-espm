-- Printa nos logs do banco de dados a frase Hello world
create or replace procedure P_HELLO is
begin
    DBMS_OUTPUT.PUT_LINE('Hello world');
end P_HELLO;
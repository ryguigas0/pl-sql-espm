-- Pegando as tabelas e procedures relevantes
CREATE TABLE COUNTRIES AS(
    SELECT * FROM HR.COUNTRIES
);

CREATE TABLE DEPARTMENTS AS(
    SELECT * FROM HR.DEPARTMENTS
);

CREATE TABLE EMPLOYEES AS(
    SELECT * FROM HR.EMPLOYEES
);

CREATE TABLE JOBS AS(
    SELECT * FROM HR.JOBS
);

CREATE TABLE JOB_HISTORY AS(
    SELECT * FROM HR.JOB_HISTORY
);

CREATE TABLE LOCATIONS AS(
    SELECT * FROM HR.LOCATIONS
);

CREATE TABLE REGIONS AS(
    SELECT * FROM HR.REGIONS
);

-- Procedure de adicionar na tabela job history
CREATE

OR REPLACE PROCEDURE ADD_JOB_HISTORY(

P_EMP_ID JOB_HISTORY.EMPLOYEE_ID % TYPE,

P_START_DATE JOB_HISTORY.START_DATE % TYPE,

P_END_DATE JOB_HISTORY.END_DATE % TYPE,

P_JOB_ID JOB_HISTORY.JOB_ID % TYPE,

P_DEPARTMENT_ID JOB_HISTORY.DEPARTMENT_ID % TYPE

) IS BEGIN

INSERT INTO JOB_HISTORY(
    EMPLOYEE_ID,
    START_DATE,
    END_DATE,
    JOB_ID,
    DEPARTMENT_ID
) VALUES (
    P_EMP_ID,
    P_START_DATE,
    P_END_DATE,
    P_JOB_ID,
    P_DEPARTMENT_ID
);

END ADD_JOB_HISTORY;

-- QUESTÃO 1: Criar uma view na base de dados HR que exiba o nome do funcionário, salário,
-- departamento, endereço do departamento e país.
CREATE VIEW DADOS_FUNCIONARIO AS
    SELECT
        (E.FIRST_NAME || ' ' || E.LAST_NAME) AS NOME_FUNCIONARIO,
        E.SALARY                             AS SALARIO_FUNCIONARIO,
        D.DEPARTMENT_NAME                    AS DEPARTAMENTO_FUNCIONARIO,
        L.STREET_ADDRESS                     AS ENDERECO_DEPARTAMENTO,
        L.COUNTRY_ID                         AS PAIS_DEPARTAMENTO
    FROM
        EMPLOYEES   E
        INNER JOIN DEPARTMENTS D
        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        INNER JOIN LOCATIONS L
        ON L.LOCATION_ID = D.LOCATION_ID;

-- QUESTÃO 2: Crie uma função que calcule a média de 4 valores.
CREATE OR REPLACE FUNCTION MEDIA4VALORES(
    N1 IN NUMBER,
    N2 IN NUMBER,
    N3 IN NUMBER,
    N4 IN NUMBER
) RETURN NUMBER IS
    SOMA_VALORES        NUMBER := 0 BEGIN SOMA_VALORES := N1 + N2 + N3 + N4;
    RETURN              SOMA_VALORES / 4;
END;
 -- QUESTÃO 3: Crie uma procedure que gere o Insert, Update e Delete da tabela DEPARTMENTS da
 -- base de dados HR.
 CREATE              OR REPLACE PROCEDURE CUD_DEPARTMENTS(
    VAR_OPR CHAR,
    VAR_DEPARTMENT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE,
    VAR_DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE,
    VAR_MANAGER_ID DEPARTMENTS.MANAGER_ID%TYPE,
    VAR_LOCATION_ID DEPARTMENTS.LOCATION_ID%TYPE
)IS
BEGIN
    IF(VAR_OPR = 'i')THEN
        INSERT INTO DEPARTMENTS(
            DEPARTMENT_ID,
            DEPARTMENT_NAME,
            MANAGER_ID,
            LOCATION_ID
        )VALUES(
            VAR_DEPARTMENT_ID,
            VAR_DEPARTMENT_NAME,
            VAR_MANAGER_ID,
            VAR_LOCATION_ID
        );
    ELSIF(VAR_OPR = 'd')THEN
        DELETE FROM DEPARTMENTS
        WHERE
            DEPARTMENT_ID = VAR_DEPARTMENT_ID;
    ELSIF(VAR_OPR = 'u')THEN
        UPDATE DEPARTMENTS
        SET
            DEPARTMENT_NAME = VAR_DEPARTMENT_NAME,
            MANAGER_ID = VAR_MANAGER_ID,
            LOCATION_ID = VAR_LOCATION_ID
        WHERE
            DEPARTMENT_ID = VAR_DEPARTMENT_ID;
    END IF;
END CUD_DEPARTMENTS; -- QUESTÃO 4: Crie uma trigger que atualize o campo COMMISSION_PCT  da tabela EMPLOYEES, para
 -- 0,6, toda vez que que o campo DEPARTMENT_ID for alterado para 60.
 CREATE              OR REPLACE TRIGGER UPDATE_EMPLOYEES_COMISSION_PCT BEFORE UPDATE OF DEPARTMENT_ID ON EMPLOYEES FOR EACH ROW BEGIN IF :NEW.DEPARTMENT_ID = 60 THEN
    UPDATE EMPLOYEES
    SET
        COMMISSION_PCT = 0.6
    WHERE
        EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
END IF;
END;
 -- QUESTÃO 5: crie uma rotina que calcule o percentual do salário de cada empregado para a média do
 -- MIN_SALARY e MAX_SALARY do seu JOB_ID.
 -- Média = (MIN_SALARY+ MAX_SALARY)/2
 -- Percentual = Salario_Funcionario*100/Média
 DECLARE             CURSOR CURSOR_EMPLOYEES IS
    SELECT
        E.EMPLOYEE_ID,
        E.SALARY,
        J.MIN_SALARY,
        J.MAX_SALARY
    FROM
        EMPLOYEES E
        INNER JOIN JOBS J
        ON J.JOB_ID = E.JOB_ID;
VAR_EMPLOYEE_ID     EMPLOYEES.EMPLOYEE_ID%TYPE;
VAR_EMPLOYEE_SALARY EMPLOYEES.SALARY%TYPE;
VAR_JOB_MINSALARY   JOBS.MIN_SALARY%TYPE;
VAR_JOB_MAXSALARY   JOBS.MAX_SALARY%TYPE;
VAR_MEDIA           NUMBER;
VAR_PERCENTUAL      NUMBER;
BEGIN
    OPEN CURSOR_EMPLOYEES;
    LOOP
        FETCH CURSOR_EMPLOYEES INTO VAR_EMPLOYEE_ID, VAR_EMPLOYEE_SALARY, VAR_JOB_MINSALARY, VAR_JOB_MAXSALARY;
        EXIT WHEN CURSOR_EMPLOYEES%NOTFOUND;
        VAR_MEDIA := (VAR_JOB_MINSALARY + VAR_JOB_MAXSALARY) / 2;
        VAR_PERCENTUAL := (VAR_EMPLOYEE_SALARY * 100) / VAR_MEDIA;
        DBMS_OUTPUT.PUT_LINE( 'ID: '
            || VAR_EMPLOYEE_ID
            || ' PERCENTUAL: '
            || VAR_PERCENTUAL );
    END LOOP;
    CLOSE CURSOR_EMPLOYEES;
END;
 -- QUESTÃO 6: Crie uma rotina que calcule a média dos percentuais calculados no exercício anterior
 CREATE OR REPLACE PROCEDURE MEDIA_PERCENTUAIS IS
    VAR_SOMA_PERCENTUAIS  INTEGER :=0;
    VAR_QUANT_PERCENTUAIS INTEGER :=0;
BEGIN
    DECLARE
        CURSOR CURSOR_EMPLOYEES IS
            SELECT
                E.SALARY,
                J.MIN_SALARY,
                J.MAX_SALARY
            FROM
                EMPLOYEES E
                INNER JOIN JOBS J
                ON J.JOB_ID = E.JOB_ID;
        VAR_EMPLOYEE_SALARY EMPLOYEES.SALARY%TYPE;
        VAR_JOB_MINSALARY   JOBS.MIN_SALARY%TYPE;
        VAR_JOB_MAXSALARY   JOBS.MAX_SALARY%TYPE;
        VAR_MEDIA           NUMBER;
        VAR_PERCENTUAL      NUMBER;
    BEGIN
        OPEN CURSOR_EMPLOYEES;
        LOOP
            FETCH CURSOR_EMPLOYEES INTO VAR_EMPLOYEE_SALARY, VAR_JOB_MINSALARY, VAR_JOB_MAXSALARY;
            EXIT WHEN CURSOR_EMPLOYEES%NOTFOUND;
            VAR_MEDIA := (VAR_JOB_MINSALARY + VAR_JOB_MAXSALARY) / 2;
            VAR_PERCENTUAL := (VAR_EMPLOYEE_SALARY * 100) / VAR_MEDIA;
            VAR_SOMA_PERCENTUAIS := VAR_SOMA_PERCENTUAIS + VAR_PERCENTUAL;
            VAR_QUANT_PERCENTUAIS := VAR_QUANT_PERCENTUAIS + 1;
        END LOOP;
        CLOSE CURSOR_EMPLOYEES;
    END;
    DBMS_OUTPUT.PUT_LINE( 'MÉDIA PERCENTUAIS: '
        || (VAR_SOMA_PERCENTUAIS / VAR_QUANT_PERCENTUAIS) );
END MEDIA_PERCENTUAIS;
 -- QUESTÃO 7: Crie uma rotina que calcule o bônus salarial de todos os funcionários dos departamentos
 -- Administration, Marketing, TI e Sales onde o valor do bônus segue a seguinte regra:
 -- Funcionários de ADM: 2 vezes o salário atual + uma vez e meia o salário atual para cada promoção
 -- que o funcionário ganhou durante sua carreira na empresa
 -- Funcionários de TI: 3 vezes o salário atual + meio salário atual para cada ano de trabalha na
 -- empresa
 -- Funcionários de MKT: 2 vezes o salário atual + duas vezes e meia o salário atual para cada
 -- período de 3 anos que o funcionário trabalhou na empresa.
 -- Funcionários de Sales: 1,5 vezes o salário atual + meio salário atual para cada ano de trabalha na
 -- empresa + o valor estipulado na tabela de bônus conforme sua região de atuação.
 -- Preciso de
 -- Functionario: id, department_id, diff de ano quando ele inciou, quantas promocoes, diff de ano quando ele iniciou / 3, regiao do país do departamento
DECLARE
    CURSOR CURSOR_BONUS_SALARIAL IS
        SELECT
            E.EMPLOYEE_ID,
            E.SALARY,
            D.DEPARTMENT_ID,
            TRUNC((SYSDATE - E.HIRE_DATE) / 365) AS DIFF_ANOS,
            R.REGION_ID
        FROM
            EMPLOYEES   E
            INNER JOIN DEPARTMENTS D
            ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
            INNER JOIN LOCATIONS L
            ON L.LOCATION_ID = D.LOCATION_ID
            INNER JOIN COUNTRIES C
            ON C.COUNTRY_ID = L.COUNTRY_ID
            INNER JOIN REGIONS R
            ON R.REGION_ID = C.REGION_ID
        WHERE
            E.DEPARTMENT_ID IN (10,
            20,
            60,
            80);
    VAR_EMPLOYEE_ID          EMPLOYEES.EMPLOYEE_ID%TYPE;
    VAR_EMPLOYEE_SALARY      EMPLOYEES.SALARY%TYPE;
    VAR_DEPARTMENT_ID        DEPARTMENTS.DEPARTMENT_ID%TYPE;
    VAR_DIFF_ANOS            NUMBER;
    VAR_REGION_ID            REGIONS.REGION_ID%TYPE;
    VAR_BONUS_SALARIO        NUMBER;
    VAR_BONUS_REGIAO         NUMBER;
    VAR_QUANTIDADE_PROMOCOES NUMBER;
BEGIN
    OPEN CURSOR_BONUS_SALARIAL;
    LOOP
        FETCH CURSOR_BONUS_SALARIAL INTO VAR_EMPLOYEE_ID, VAR_EMPLOYEE_SALARY, VAR_DEPARTMENT_ID, VAR_DIFF_ANOS, VAR_REGION_ID;
        EXIT WHEN CURSOR_BONUS_SALARIAL%NOTFOUND;
        CASE VAR_DEPARTMENT_ID
            WHEN 10 THEN
 -- ADM
                SELECT
                    COUNT(EMPLOYEE_ID) INTO VAR_QUANTIDADE_PROMOCOES
                FROM
                    JOB_HISTORY
                WHERE
                    EMPLOYEE_ID = VAR_EMPLOYEE_ID
                GROUP BY
                    EMPLOYEE_ID;
                VAR_BONUS_SALARIO := 2 * VAR_EMPLOYEE_SALARY + (1.5 * VAR_EMPLOYEE_SALARY) * VAR_QUANTIDADE_PROMOCOES;
            WHEN 20 THEN
 -- MKT
                VAR_BONUS_SALARIO := 2 * VAR_EMPLOYEE_SALARY + (2.5 * VAR_EMPLOYEE_SALARY) * (VAR_DIFF_ANOS / 3);
            WHEN 60 THEN
 -- IT
                VAR_BONUS_SALARIO := 3 * VAR_EMPLOYEE_SALARY + (0.5 * VAR_EMPLOYEE_SALARY) * VAR_DIFF_ANOS;
            ELSE
 -- SALES
                CASE VAR_REGION_ID
                    WHEN 1 THEN
                        VAR_BONUS_REGIAO := 6000;
                    WHEN 2 THEN
                        VAR_BONUS_REGIAO := 4500;
                    WHEN 3 THEN
                        VAR_BONUS_REGIAO := 5000;
                    ELSE
                        VAR_BONUS_REGIAO := 3500;
                END CASE;
                VAR_BONUS_SALARIO := 1.5 * VAR_EMPLOYEE_SALARY + (0.5 * VAR_EMPLOYEE_SALARY) * VAR_DIFF_ANOS + VAR_BONUS_REGIAO;
        END CASE;
        DBMS_OUTPUT.PUT_LINE( 'ID: '
            || VAR_EMPLOYEE_ID
            || ' BONUS SALARIO: '
            || VAR_BONUS_SALARIO );
    END LOOP;
    CLOSE CURSOR_BONUS_SALARIAL;
END;
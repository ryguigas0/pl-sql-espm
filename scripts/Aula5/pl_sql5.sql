-- 1. Crie uma rotina que calcule a diferença do salario de cada empregado
-- para a média do MIN_SALARY e MAX_SALARY do seu JOB_ID.

declare
    cursor C_EMPLOYEES_JOBS is
        select
            E.FIRST_NAME,
            E.LAST_NAME,
            E.SALARY,
            J.JOB_TITLE,
            J.MIN_SALARY,
            J.MAX_SALARY
        from
            EMPLOYEES E
            inner join JOBS J
            on E.JOB_ID = J.JOB_ID;
    VAR_EMPLOYEE_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VAR_EMPLOYEE_LAST_NAME  EMPLOYEES.LAST_NAME%TYPE;
    VAR_EMPLOYEE_SALARY     EMPLOYEES.SALARY%TYPE;
    VAR_JOB_TITLE           JOBS.JOB_TITLE%TYPE;
    VAR_JOB_MIN_SALARIO     JOBS.MIN_SALARY%TYPE;
    VAR_JOB_MAX_SALARIO     JOBS.MAX_SALARY%TYPE;
    VAR_MEDIA_SALARIO       JOBS.MIN_SALARY%TYPE;
    VAR_DIFF_SALARIO        JOBS.MIN_SALARY%TYPE;
begin
    open C_EMPLOYEES_JOBS;
    loop
        fetch C_EMPLOYEES_JOBS into VAR_EMPLOYEE_FIRST_NAME, VAR_EMPLOYEE_LAST_NAME, VAR_EMPLOYEE_SALARY, VAR_JOB_TITLE, VAR_JOB_MIN_SALARIO, VAR_JOB_MAX_SALARIO;
        exit when C_EMPLOYEES_JOBS%NOTFOUND;
        VAR_MEDIA_SALARIO := (VAR_JOB_MIN_SALARIO + VAR_JOB_MAX_SALARIO) / 2;
        VAR_DIFF_SALARIO := VAR_EMPLOYEE_SALARY - VAR_MEDIA_SALARIO;
        DBMS_OUTPUT.PUT_LINE(VAR_EMPLOYEE_FIRST_NAME
            || ' '
            || VAR_EMPLOYEE_LAST_NAME
            || ' do cargo '
            || VAR_JOB_TITLE
            || ' e pago '
            || VAR_DIFF_SALARIO
            || ' em relaçao a media do cargo');
    end loop;
end;
/

-- 2. Crie uma rotina que calcule a soma das diferenças do exercício anterior.

declare
    cursor C_EMPLOYEES_JOBS is
        select
            E.SALARY,
            J.MIN_SALARY,
            J.MAX_SALARY
        from
            EMPLOYEES E
            inner join JOBS J
            on E.JOB_ID = J.JOB_ID;
    VAR_EMPLOYEE_SALARY EMPLOYEES.SALARY%TYPE;
    VAR_JOB_MIN_SALARIO JOBS.MIN_SALARY%TYPE;
    VAR_JOB_MAX_SALARIO JOBS.MAX_SALARY%TYPE;
    VAR_MEDIA_SALARIO   JOBS.MIN_SALARY%TYPE;
    VAR_DIFF_SALARIO    JOBS.MIN_SALARY%TYPE;
    VAR_SOMA_DIFF       JOBS.MIN_SALARY%TYPE := 0;
begin
    open C_EMPLOYEES_JOBS;
    loop
        fetch C_EMPLOYEES_JOBS into VAR_EMPLOYEE_SALARY, VAR_JOB_MIN_SALARIO, VAR_JOB_MAX_SALARIO;
        exit when C_EMPLOYEES_JOBS%NOTFOUND;
        VAR_MEDIA_SALARIO := (VAR_JOB_MIN_SALARIO + VAR_JOB_MAX_SALARIO) / 2;
        VAR_DIFF_SALARIO := VAR_EMPLOYEE_SALARY - VAR_MEDIA_SALARIO;
        VAR_SOMA_DIFF := VAR_SOMA_DIFF + VAR_DIFF_SALARIO;
    end loop;
    close C_EMPLOYEES_JOBS;
    DBMS_OUTPUT.PUT_LINE('Soma das diferenças de salário: '
        || VAR_SOMA_DIFF);
end;
/

-- 3. Crie uma rotina que calcule o bônus salarial de todos os funcionários dos
-- departamentos Administration, Marketing e IT onde o valor do bônus
-- segue as seguintes regras: 1. Funcionários de ADM e MKT: 2 vezes o salario atual + uma vez e meia o
-- salario atual para cada promoção que o funcionário ganhou durante sua
-- carreira na empresa 2. Funcionários de TI: 3 vezes o salario atual + meio salário atual para cada ano
-- de trabalha na empresa

-- Funcionários de TI -> Departamento 60
-- Funcionários de Marketing ->  Departamento 20
-- Funcionários de Administração ->  Departamento 10

-- Pegar todos os funcionários
-- Contar quantas promoções esse funcionário teve
-- Diferenciar pelo cargo
-- Pegar a quantidade de anos entre agora e hire_date


declare
    cursor C_BONUS_SALARIO is
        select
            EMPLOYEE_ID,
            SALARY,
            HIRE_DATE,
            DEPARTMENT_ID
        from
            EMPLOYEES
        where
            DEPARTMENT_ID in(60,
            20,
            10);
    VAR_EMPL_ID            EMPLOYEES.EMPLOYEE_ID%TYPE;
    VAR_EMPL_SALARIO       EMPLOYEES.SALARY%TYPE;
    VAR_EMPL_HIRE_DATE     EMPLOYEES.HIRE_DATE%TYPE;
    VAR_EMPL_DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;
    VAR_EMPL_PROMOCOES     number := 0;
    VAR_EMPL_ANOS_EMPRESA  number := 0;
    VAR_BONUS              EMPLOYEES.SALARY%TYPE := 0;
begin
    open C_BONUS_SALARIO;
    loop
        fetch C_BONUS_SALARIO into VAR_EMPL_ID, VAR_EMPL_SALARIO, VAR_EMPL_HIRE_DATE, VAR_EMPL_DEPARTMENT_ID;
        exit when C_BONUS_SALARIO%NOTFOUND;
        if(VAR_EMPL_DEPARTMENT_ID = 20)or(VAR_EMPL_DEPARTMENT_ID = 10)then
            select
                count(EMPLOYEE_ID)into VAR_EMPL_PROMOCOES
            from
                JOB_HISTORY
            where
                EMPLOYEE_ID = VAR_EMPL_ID;
            VAR_BONUS := (2 * VAR_EMPL_SALARIO) + (1.5 * VAR_EMPLOYEE_SALARY * VAR_EMPL_PROMOCOES);
        elsif VAR_EMPL_DEPARTMENT_ID = 60 then
 -- VAR_EMPL_ANOS_EMPRESA := EXTRACT(YEAR from SYSDATE()) - EXTRACT(YEAR from VAR_EMPL_HIRE_DATE);
            VAR_EMPL_ANOS_EMPRESA := ((SYSDATE() - VAR_EMPL_HIRE_DATE) / 365);
            VAR_BONUS := 3 * VAR_EMPL_SALARIO + (0.5 * VAR_EMPL_SALARIO * VAR_EMPL_ANOS_EMPRESA);
        end if;
        DBMS_OUTPUT.PUT_LINE(VAR_EMPL_ID
            || ' do departamento '
            || VAR_EMPL_DEPARTMENT_ID
            || ' recebe um bônus de '
            || VAR_BONUS);
    end loop;
end;
/
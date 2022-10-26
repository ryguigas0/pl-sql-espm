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

-- Funcionários de TI -> contém TI no job_id
-- Funcionários de Marketing -> contém MK no job_id
-- Funcionários de Administração -> contém AD no job_id

-- Pegar todos os funcionários
-- Contar quantas promoções esse funcionário teve
-- Diferenciar pelo cargo
-- Pegar a quantidade de anos entre agora e hire_date


declare
    cursor C_BONUS_SALARIO is
        select
            E.EMPLOYEE_ID,
            E.SALARY,
            E.HIRE_DATE,
            E.JOB_ID,
            count(JH.JOB_ID)
        from
            JOB_HISTORY JH
            inner join EMPLOYEES E
            on E.EMPLOYEE_ID = JH.EMPLOYEE_ID
        group by
            E.EMPLOYEE_ID,
            E.SALARY,
            E.HIRE_DATE,
            E.JOB_ID;
    VAR_EMPL_ID           EMPLOYEES.EMPLOYEE_ID%TYPE;
    VAR_EMPL_SALARIO      EMPLOYEES.SALARY%TYPE;
    VAR_EMPL_HIRE_DATE    EMPLOYEES.HIRE_DATE%TYPE;
    VAR_EMPL_JOB_ID       EMPLOYEES.JOB_ID%TYPE;
    VAR_EMPL_PROMOCOES    number;
    VAR_EMPL_ANOS_EMPRESA number;
    VAR_BONUS             EMPLOYEES.SALARY%TYPE := 0;
begin
    open C_BONUS_SALARIO;
    loop
        fetch C_BONUS_SALARIO into VAR_EMPL_ID, VAR_EMPL_SALARIO, VAR_EMPL_HIRE_DATE, VAR_EMPL_JOB_ID, VAR_EMPL_PROMOCOES;
        exit when C_BONUS_SALARIO%NOTFOUND;
        if(INSTR(VAR_EMPL_JOB_ID, 'MK', 1) > 0)or(INSTR(VAR_EMPL_JOB_ID, 'AD', 1) > 0)then
            VAR_BONUS := (2 * VAR_EMPL_SALARIO) + (1.5 * VAR_EMPL_PROMOCOES);
        elsif INSTR(VAR_EMPL_JOB_ID, 'TI', 1) > 0 then
            VAR_EMPL_ANOS_EMPRESA := EXTRACT(YEAR from SYSDATE()) - EXTRACT(YEAR from VAR_EMPL_HIRE_DATE);
            VAR_BONUS := 3 * VAR_EMPL_SALARIO + (0.5 * VAR_EMPL_SALARIO * VAR_EMPL_ANOS_EMPRESA);
        end if;
        DBMS_OUTPUT.PUT_LINE('Funcionario de ID '
            || VAR_EMPL_ID
            || ' do cargo '
            || VAR_EMPL_JOB_ID
            || ' tem o bonus de '
            || VAR_BONUS);
    end loop;
end;
/
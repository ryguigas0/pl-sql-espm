-- 1. Crie uma trigger que cadastre um registro na tabela
-- JOB_HISTORY toda vez que um registro for inserido na tabela
-- EMPLOYEES

create or replace trigger INSERT_JOB_HISTORY after
    insert on EMPLOYEES for each row
begin
    ADD_JOB_HISTORY (:NEW.EMPLOYEE_ID, :NEW.HIRE_DATE, SYSDATE, :NEW.JOB_ID, :NEW.DEPARTMENT_ID);
end;
/

-- 2. Crie uma trigger que atualize o campo SALARY da tabela
-- EMPLOYEES com o valor do campo MIN_SALARY da tabela
-- JOBS, quando o campo JOB_ID for alterado na tabela
-- EMPLOYEES

create or replace trigger UPDATE_SALARY after
    update of JOB_ID on EMPLOYEES for each row
declare
    VMINSALARY JOBS.MIN_SALARY%TYPE;
begin
 -- Coloca o valor do select dentro de uma variável
    select
        MIN_SALARY into VMINSALARY
    from
        JOBS
    where
        JOB_ID = :NEW.JOB_ID;
    update EMPLOYEES
    set
        SALARY = VMINSALARY
    where
        EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
end;
/

-- 3. Crie uma trigger que atualize o campo COMMISSION_PCT da
-- tabela EMPLOYEES, toda vez que o campo JOB_ID for
-- alterado para SA_REP

create or replace trigger UPDATE_COMMISSION_PCT after
    update of JOB_ID on EMPLOYEES for each row when (NEW.JOB_ID = 'SA_REP')
begin
    update EMPLOYEES
    set
        COMMISSION_PCT = 0.5
    where
        EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
end;
/
-- Copying tables

create table COUNTRIES as(
    select * from HR.COUNTRIES
);

create table DEPARTMENTS as(
    select * from HR.DEPARTMENTS
);

create table EMPLOYEES as(
    select * from HR.EMPLOYEES
);

create table JOBS as(
    select * from HR.JOBS
);

create table JOB_HISTORY as(
    select * from HR.JOB_HISTORY
);

create table LOCATIONS as(
    select * from HR.LOCATIONS
);

create table REGIONS as(
    select * from HR.REGIONS
);

-- Procedure de adicionar na tabela job history

create or replace procedure ADD_JOB_HISTORY(
    P_EMP_ID JOB_HISTORY.EMPLOYEE_ID%TYPE,
    P_START_DATE JOB_HISTORY.START_DATE%TYPE,
    P_END_DATE JOB_HISTORY.END_DATE%TYPE,
    P_JOB_ID JOB_HISTORY.JOB_ID%TYPE,
    P_DEPARTMENT_ID JOB_HISTORY.DEPARTMENT_ID%TYPE
)is
begin
    insert into JOB_HISTORY(
        EMPLOYEE_ID,
        START_DATE,
        END_DATE,
        JOB_ID,
        DEPARTMENT_ID
    )values(
        P_EMP_ID,
        P_START_DATE,
        P_END_DATE,
        P_JOB_ID,
        P_DEPARTMENT_ID
    );
end ADD_JOB_HISTORY;
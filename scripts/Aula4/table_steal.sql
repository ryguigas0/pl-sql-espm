create table MY_TABLE as (
    select * from READ_ONLY_DB.TABLE_TO_STEAL
);
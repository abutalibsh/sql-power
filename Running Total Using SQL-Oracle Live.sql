ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

create table transactions as
select row_number() over (order by created_at) id, x.* from 
(
select round(dbms_random.value()*1000) amount, sysdate-level-dbms_random.value()*100 created_at, 10001 account_id from dual connect by level < 5
union all
select round(dbms_random.value()*1000) amount, sysdate-level-dbms_random.value()*100 created_at, 10002 account_id from dual connect by level < 5
) x

SELECT
   ROW_NUMBER() OVER(
      PARTITION BY account_id
      ORDER BY created_at, id
   ) AS nr,
   id,
   account_id,
   created_at,
   amount,
   SUM(amount) OVER(
       PARTITION BY account_id
       ORDER BY created_at, id
   ) AS balance
FROM transactions
ORDER BY id


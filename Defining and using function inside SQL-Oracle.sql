WITH
--function
FUNCTION function_defined_on_the_fly(p_id IN NUMBER) RETURN NUMBER IS
  BEGIN
  if mod(p_id,2)=0 then return p_id*2;end if;
  return p_id*10;
  END;
  --table
dummy_data as (select level emp_id from dual connect by level <= 5)
--your query
SELECT emp_id,function_defined_on_the_fly(emp_id)
FROM dummy_data

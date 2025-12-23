declare
   ex_low_salary exception;
   v_salary employees.salary%type;
begin
   select salary
     into v_salary
     from employees
    where employee_id = 100;
   if v_salary < 3000 then
      raise ex_low_salary;
   end if;
   dbms_output.put_line('Salaire correct : ' || v_salary);
exception
   when ex_low_salary then
      dbms_output.put_line('Salaire inférieur au minimum acceptable.');
end;
/
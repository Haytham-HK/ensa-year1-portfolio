   SET SERVEROUTPUT ON;
declare
   v_sal employees.salary%type;
begin
   select salary
     into v_sal
     from employees
    where employee_id = 0;
   dbms_output.put_line('Salaire : ' || v_sal);
exception
   when no_data_found then
      dbms_output.put_line('Aucun employé trouvé pour cet ID.');
end;
/
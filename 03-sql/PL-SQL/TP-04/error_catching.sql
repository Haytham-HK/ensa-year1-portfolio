declare
   v_salary number := 12000;
   salary_too_high exception;
   pragma exception_init ( salary_too_high,-20010 );
begin
   if v_salary > 10000 then
      raise_application_error(
         -20010,
         'Salaire dépasse le plafond autorisé.'
      );
   end if;
   dbms_output.put_line('Salaire acceptable : ' || v_salary);
exception
   when salary_too_high then
      dbms_output.put_line('Erreur métier : salaire trop élevé.');
end;
/
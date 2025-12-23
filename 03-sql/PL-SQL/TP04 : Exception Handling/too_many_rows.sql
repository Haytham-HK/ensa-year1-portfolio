declare
   v_name employees.first_name%type;
begin
   select first_name
     into v_name
     from employees; -- sans WHERE -> plusieurs lignes !
   dbms_output.put_line('Nom : ' || v_name);
exception
   when too_many_rows then
      dbms_output.put_line('Erreur : la requête retourne plusieurs employés.');
end;
/
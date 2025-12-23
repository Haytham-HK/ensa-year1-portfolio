declare
   x number := 10;
   y number := 0;
   z number;
begin
   z := x / y;
   dbms_output.put_line('Résultat = ' || z);
exception
   when zero_divide then
      dbms_output.put_line('Erreur : division par zéro interdite.');
end;
/
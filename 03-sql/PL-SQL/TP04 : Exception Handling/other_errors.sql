declare
   v number;
begin
   v := 10 / 0; -- ZERO_DIVIDE
exception
   when others then
      dbms_output.put_line('Erreur inconnue : ' || sqlerrm);
end;
/
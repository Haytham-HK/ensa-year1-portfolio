-- TP01: 


-- Test Connection

SELECT 'Oracle fonctionne!' AS message FROM dual;

-- Hello World PL/SQL

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World depuis PL/SQL !');
END;
/

-- PL/SQL Variables

SET SERVEROUTPUT ON;

DECLARE
    v_name VARCHAR2(50) := 'Bahaa Eddine';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bonjour ' || v_name || ', bienvenue dans PL/SQL!');
END;
/
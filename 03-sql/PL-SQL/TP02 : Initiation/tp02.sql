SET SERVEROUTPUT ON;


-- Example 1: Hello World
PROMPT Running Example 1: Hello World...
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World from PL/SQL!');
END;
/

-- Example 2: Variables & Concatenation
PROMPT Running Example 2: Variables...
DECLARE
    v_name VARCHAR2(30) := 'Bahaa Eddine';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bonjour ' || v_name || ', ravi de vous voir !');
END;
/

-- Example 3: Conditional Logic (IF/ELSIF/ELSE)
PROMPT Running Example 3: Conditions...
DECLARE
    v_n NUMBER := -5;
BEGIN
    IF v_n > 0 THEN
        DBMS_OUTPUT.PUT_LINE('The number is positive');
    ELSIF v_n < 0 THEN
        DBMS_OUTPUT.PUT_LINE('The number is negative');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Zero');
    END IF;
END;
/

-- Exercise 1: Variables + CONCAT
-- Objective: Declare first/last name and print "Bonjour <name>, bienvenue !"

PROMPT Running Exercise 1...
DECLARE
    v_prenom VARCHAR2(50) := 'Haytham';
    v_nom    VARCHAR2(50) := 'Kennouz';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bonjour ' || v_prenom || ' ' || v_nom || ', bienvenue !');
END;
/

-- Exercise 2: Simple Calculation
-- Objective: Sum two numbers a and b.

PROMPT Running Exercise 2...
DECLARE
    v_a NUMBER := 10;
    v_b NUMBER := 25;
    v_sum NUMBER;
BEGIN
    v_sum := v_a + v_b;
    DBMS_OUTPUT.PUT_LINE('The sum of ' || v_a || ' and ' || v_b || ' is: ' || v_sum);
END;
/

-- Exercise 3: Conditions (Minor/Adult)
-- Objective: Print "Mineur" if age < 18, "Adulte" otherwise.

PROMPT Running Exercise 3...
DECLARE
    v_age NUMBER := 20; 
BEGIN
    IF v_age < 18 THEN
        DBMS_OUTPUT.PUT_LINE('Age ' || v_age || ': Mineur');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Age ' || v_age || ': Adulte');
    END IF;
END;
/

-- Exercise 4: Mini Loop
-- Objective: Print numbers 1 to 10.
PROMPT Running Exercise 4...
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('Iteration: ' || i);
    END LOOP;
END;
/

-- Exercise 5: Exception Handling (NO_DATA_FOUND)
-- Objective: Handle error when selecting a non-existent department.
-- Note: The example goal is just to know how to catch errors.

PROMPT Running Exercise 5...
DECLARE
    v_dummy VARCHAR2(50);
BEGIN
    SELECT 'Result' INTO v_dummy
    FROM DUAL
    WHERE 1 = 2; 
    DBMS_OUTPUT.PUT_LINE('Row found: ' || v_dummy);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No data found for this request!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred.');
END;
/
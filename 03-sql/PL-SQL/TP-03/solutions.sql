-- Exercice 1.1: Suppression conditionnelle
DECLARE
BEGIN
    -- 1. Supprime tous les employés du département 40
    DELETE FROM emp WHERE deptno = 40;

    -- 2. Utilise SQL%ROWCOUNT
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nombre d''employés supprimés: ' || SQL%ROWCOUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Aucun employé supprimé.');
    END IF;
    
    -- Rollback pour ne pas casser les autres exos (optionnel mais recommandé)
    ROLLBACK;
END;
/

-- Exercice 1.2: Augmentation avec contrôle
DECLARE
BEGIN
    -- 1. Augmente de 10% le salaire du département 30
    UPDATE emp SET sal = sal * 1.10 WHERE deptno = 30;

    -- 2. Vérification
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Augmentation appliquée à ' || SQL%ROWCOUNT || ' employés.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Aucune augmentation appliquée.');
    END IF;
    
    ROLLBACK;
END;
/

-- PARTIE 2: CURSEUR EXPLICITE SIMPLE

-- Exercice 2.1: Liste des employés (OPEN/FETCH/CLOSE)
DECLARE
    -- Déclaration du curseur explicite
    CURSOR c_emp IS 
        SELECT ename, sal, deptno 
        FROM emp 
        ORDER BY deptno, ename;
        
    -- Variables locales
    v_nom    emp.ename%TYPE;
    v_sal    emp.sal%TYPE;
    v_deptno emp.deptno%TYPE;
BEGIN
    OPEN c_emp;
    
    LOOP
        FETCH c_emp INTO v_nom, v_sal, v_deptno;
        EXIT WHEN c_emp%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('[DEPT ' || v_deptno || '] NOM ' || v_nom || ', SALAIRE = ' || v_sal);
    END LOOP;
    
    CLOSE c_emp;
END;
/

-- Exercice 2.2: Compter les lignes traitées
DECLARE
    CURSOR c_emp IS 
        SELECT ename, sal, deptno 
        FROM emp 
        ORDER BY deptno, ename;
        
    v_nom    emp.ename%TYPE;
    v_sal    emp.sal%TYPE;
    v_deptno emp.deptno%TYPE;
    
    v_nb     NUMBER := 0; -- Compteur manuel
BEGIN
    OPEN c_emp;
    
    LOOP
        FETCH c_emp INTO v_nom, v_sal, v_deptno;
        EXIT WHEN c_emp%NOTFOUND;
        
        v_nb := v_nb + 1; -- Incrémentation
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Nombre total d''employés parcourus: ' || v_nb);
    
    -- Comparaison avec ROWCOUNT (doit être fait avant de fermer le curseur pour être sûr)
    DBMS_OUTPUT.PUT_LINE('Valeur c_emp%ROWCOUNT: ' || c_emp%ROWCOUNT);
    
    CLOSE c_emp;
END;
/

-- PARTIE 3: CURSEUR AVEC %ROWTYPE

-- Exercice 3.1 & 3.2: Filtrage et ROWTYPE
PROMPT --- Exercice 3.1 & 3.2 ---
DECLARE
    CURSOR c_dep10 IS 
        SELECT * FROM emp WHERE deptno = 10;
        
    v_emp c_dep10%ROWTYPE;
    v_count_rich NUMBER := 0;
BEGIN
    OPEN c_dep10;
    
    LOOP
        FETCH c_dep10 INTO v_emp;
        EXIT WHEN c_dep10%NOTFOUND;
        
        -- Exercice 3.1: Affichage standard
        DBMS_OUTPUT.PUT_LINE('EMP [' || v_emp
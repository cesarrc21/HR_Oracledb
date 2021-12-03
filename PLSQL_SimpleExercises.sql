/* PLSQL exerc using HR db */;

--1. Hello world
BEGIN
    DBMS_OUTPUT.PUT_LINE('¡Hello World :) using PLSQL r.n.!');
END;
/

--2. Sum
DECLARE
    a INT := &a; --using & to ask user for int
    b INT := &b;
    resultado INT := a+b;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Sum of var a & b is: '||resultado); 
END;
/

--3. If statement
DECLARE 
    estado VARCHAR2(1) := &estado; -- 
    -- ask for statuts. Input 'A' for active, otherwise inactive
BEGIN
    IF estado = 'A' THEN
    DBMS_OUTPUT.PUT_LINE('Active');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('Inactive');
    END IF;
END;
/

--4. For statement
BEGIN
FOR contador in 1..10
LOOP
DBMS_OUTPUT.PUT_LINE(contador);
END LOOP;
END;
/

--5. Give value to a var(s)
DECLARE 
    nombre VARCHAR2(20);
    apellido VARCHAR2(20); 
    nombre_completo VARCHAR2(40);
BEGIN
    SELECT FIRST_NAME INTO nombre FROM EMPLOYEES WHERE EMPLOYEE_ID=206; --using table employees
    SELECT LAST_NAME INTO apellido FROM EMPLOYEES WHERE EMPLOYEE_ID =206; --Select any id u prefer
    nombre_completo := nombre||' '||apellido;
    DBMS_OUTPUT.PUT_LINE(nombre_completo);
END;
/


--6. Insert 5 new employees (with sequence)

DECLARE
    fecha_ingreso EMPLOYEES.HIRE_DATE%TYPE;
    
BEGIN
    SELECT TRUNC(SYSDATE) INTO fecha_ingreso FROM dual; --using real time date
    --using seq from table employees
    INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Raul','Perez','RPEREZ','515.123.0982',fecha_ingreso,'MK_MAN',9000,null,100,20);
    INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Maria','Ocampo','MOCAMPO','515.123.1314',fecha_ingreso,'MK_MAN',11000,null,100,20);
    INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Luz','Ek','LEK','515.123.7127',fecha_ingreso,'MK_MAN',8000,null,100,20);
    INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Mike','Roh','MROH','515.123.8183',fecha_ingreso,'MK_MAN',12000,null,100,20);
    INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Rosa','Ku','RKU','515.123.8060',fecha_ingreso,'MK_MAN',10000,null,100,20);
END;
/

--7. Declare a cursor 
DECLARE
    hoy EMPLOYEES.HIRE_DATE%TYPE; --using current date
    empleado EMPLOYEES%ROWTYPE; --using row type
    
    CURSOR c_emp IS
        SELECT * FROM EMPLOYEES;

BEGIN
    SELECT TRUNC(SYSDATE) INTO hoy FROM dual; 
    OPEN c_emp;
LOOP
    --verify if hoy employess were hired
    FETCH c_emp INTO empleado;
    IF empleado.HIRE_DATE=hoy AND c_emp%FOUND THEN
    DBMS_OUTPUT.PUT_LINE(empleado.EMPLOYEE_ID||' '||empleado.FIRST_NAME||' '||empleado.LAST_NAME||' '||empleado.EMAIL||' '||empleado.HIRE_DATE);
    END IF;
    EXIT WHEN c_emp%NOTFOUND;
END LOOP;
    CLOSE c_emp;
END;

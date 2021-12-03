/* PLSQL function exercises using HR db */;

--1. To get avg salary

--first run function
CREATE OR REPLACE FUNCTION avgSalary
RETURN float
AS
salary_avg float := 0.0;

BEGIN
SELECT AVG(salary) INTO salary_avg FROM employees;
RETURN round(salary_avg,2); --round
END avgSalary;
/

--then run the outputs
BEGIN
DBMS_OUTPUT.PUT_LINE('The average salary of all employees is: $'||avgSalary());
END;
/

SELECT first_name,last_name,job_id,salary,
CASE 
    WHEN salary>avgSalary() THEN 'Over Avg'
    WHEN salary<avgSalary() THEN 'Under Avg'
    ELSE 'On Avg'
END AS status
FROM employees;



--2. To get info given city 
    --(select city from locations; to see all cities)

DECLARE 
my_city locations.city%type;
c locations.city%type;

FUNCTION atPlace (x IN  locations.city%type)
RETURN locations%rowtype
AS
place locations%rowtype;

BEGIN
my_city := x;
SELECT * INTO place FROM locations WHERE city = my_city;
RETURN place;
END;

--enter input with qmarks '' (ex. 'Roma')
BEGIN
c := &c;
DBMS_OUTPUT.PUT_LINE(atPlace(c).city||': '||atPlace(c).street_address||' with p.c. '||atPlace(c).postal_code||' at '||atPlace(c).country_id);
END;

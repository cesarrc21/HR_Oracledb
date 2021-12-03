/* Part1: Working just with employees table from HR */;

--1. Table description and some info
DESC EMPLOYEES;
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, JOB_ID FROM EMPLOYEES;

--2. Get the max salary (subquery)
--SELECT MAX(SALARY) FROM EMPLOYEES;
SELECT FIRST_NAME,LAST_NAME, EMAIL,PHONE_NUMBER,JOB_ID,SALARY FROM EMPLOYEES WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEES);

--3. Group by job id
SELECT JOB_ID, COUNT(JOB_ID) AS NUM_EMPLOYEES FROM EMPLOYEES GROUP BY JOB_ID ORDER BY NUM_EMPLOYEES DESC;

--4. Insert a new employee (using sequence for id)
INSERT INTO EMPLOYEES VALUES(EMPLOYEES_SEQ.nextval,'Cesar','Romero','CROMERO','515.123.9999','28-OCT-00','MK_MAN',10000,null,100,20);

--5. Update new employee's phone
UPDATE EMPLOYEES SET PHONE_NUMBER = '515.123.9119' WHERE EMAIL = 'CROMERO';

--SELECT * FROM EMPLOYEES;



/* Part2: Working with all HR tables*/;

-- Employees order by salary
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY FROM EMPLOYEES ORDER BY SALARY DESC;

-- Employees' job and salary info
SELECT employees.first_name,employees.last_name,jobs.job_title,employees.salary AS actual_salary,
jobs.min_salary,jobs.max_salary FROM employees INNER JOIN jobs ON employees.job_id=jobs.job_id;

-- Employees' job start and end date info
SELECT employees.first_name,employees.last_name,jobs.job_title,job_history.start_date,job_history.end_date
FROM employees INNER JOIN job_history ON employees.employee_id=job_history.employee_id INNER JOIN jobs ON jobs.job_id=job_history.job_id;

-- Employees' job and department.
SELECT employees.first_name, employees.last_name, jobs.job_title, departments.department_name FROM employees 
INNER JOIN jobs ON employees.job_id = jobs.job_id INNER JOIN departments ON employees.department_id = departments.department_id;

-- Employees' department and city location
SELECT employees.first_name,departments.department_name,locations.city FROM employees INNER JOIN departments 
ON employees.department_id=departments.department_id INNER JOIN locations ON departments.location_id=locations.location_id;

-- City with more employees
SELECT locations.city,COUNT(*) AS total_employees FROM employees 
INNER JOIN departments ON employees.department_id=departments.department_id 
INNER JOIN locations ON departments.location_id=locations.location_id 
GROUP BY locations.city ORDER BY total_employees DESC;

-- City and department which offer best salary
SELECT locations.city,departments.department_name,employees.salary FROM employees INNER JOIN departments 
ON employees.department_id=departments.department_id INNER JOIN locations ON departments.location_id=locations.location_id 
WHERE employees.salary = (SELECT MAX(salary)FROM employees);

-- Popular departments in Seattle
SELECT departments.department_name,COUNT(*) FROM employees  INNER JOIN departments ON employees.department_id=departments.department_id 
INNER JOIN locations ON departments.location_id=locations.location_id  WHERE locations.city='Seattle' GROUP BY departments.department_name;

-- Employees by country
SELECT countries.country_name,COUNT(*) FROM employees INNER JOIN departments ON employees.department_id=departments.department_id
INNER JOIN locations ON departments.location_id=locations.location_id INNER JOIN countries ON locations.country_id=countries.country_id
INNER JOIN regions ON countries.region_id=regions.region_id GROUP BY countries.country_name ORDER BY COUNT(*) DESC;

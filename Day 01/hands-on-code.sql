Full Stack 
	Front End
	Back End 
---------------------------------------------------------------------------	
End-to-End Web Development (Presentation Oriented App Dev) 
		ASP.Dotnet MVC Core
		
		Database - Sql Server (SQL - Programmer Perspective)   SQL Server/ Management Studio
		Language - C# 																				 Visual Studio 
		ASP.NET CORE MVC 
			Entity Framework - Models 
			MVC - Controllers, Views 
		
		REST API (Backend App) / Angular (Frontend App) 
		
---------------------------------------------------------------------------		
SQL Server 
			RDBMS - Relational Database Management System 
						(> File System) 
						
			Database : Collection of Tables 
			Table: Rows and Columns 
						 - collection of records 
								employee (id, age, date-of-birth, job_title, salary, joining_date, dept_id etc)
								project (id, project_name ...)
								employee_project 
										
								- meta data 
							- Columns Defintion +  Rules/Constraints + Rows(Records)
---------------------------------------------------------------------------
SQL - Structured Query Language (ANSI Standardized)
In SQL Server, SQL is named T-SQL (Transact SQL).
		- DDL - Data Definition Language 
						Table, View, Procedure, etc 
						CREATE TABLE 
						CREATE VIEW 
						
						DROP TABLE 
						
						ALTER TABLE 
						
						TRUNCATE 
		- DML / DQL - Data Manipulation Lanaguage
						INSERT 
						UPDATE 
						DELETE 
						
						SELECT 
		- TCL - Transactional Control Language 
						BEGIN TRANSCTION 
						COMMIT TRANSACTION 
						ROLLBACK TRANSACTION 
						
						SAVEPOINT
						
		- DCL - Data Control Language 
						GRANT
						REVOKE 
----------------------------------------------------------
department(department_id, department_name)
10, 'Analysis'
20, 'Design'
30, 'Development'
40, 'Testing'
50, 'Devops'
60, 'Support'
employee(employee_id, employee_name, job_title, joining_date, salary, department_id)
'Rahul Dravid', 'Head', '2020-01-01', 10
'Rohit Sharma', 'Manager', '2022-01-01', 20
'Virat Kohli', 'Development', '2005-01-01', 30
'Siraj', 'Testing', '2020-01-01', 40
'Rahane', 'Development', '2009-01-01', 30
'Shami', 'Testing', '2018-01-01', 40
'Subhman Gill', 'Development', '2021-01-01', 30
'Jadeja', 'Testing', '2015-01-01', 40


/*
-- CREATE TABLE department(department_id INT PRIMARY KEY, department_name VARCHAR(255) NOT NULL);
*/

CREATE TABLE department(
	department_id INT PRIMARY KEY, 
	department_name VARCHAR(255) NOT NULL
);

INSERT INTO department(department_id, department_name) VALUES(10, 'Analysis');
INSERT INTO department(department_id, department_name) VALUES(20, 'Design');

INSERT INTO department(department_id, department_name) VALUES
(30, 'Development'),
(40, 'Testing'),
(50, 'Devops'),
(60, 'Support');

SELECT * FROM department;

sp_help department



CREATE TABLE employee(
	employee_id INT IDENTITY(1,1), 
	employee_name VARCHAR(255) NOT NULL, 
	job_title VARCHAR(100) NOT NULL, 
	joining_date DATETIME NOT NULL, 
	salary FLOAT NOT NULL DEFAULT 0.0, 
	department_id INT,
	CONSTRAINT pk_employee_employee_id PRIMARY KEY(employee_id),
	CONSTRAINT pk_employee_department_department_id 
		FOREIGN KEY(department_id) REFERENCES department(department_id) 
		ON DELETE CASCADE ON UPDATE CASCADE
);

sp_help employee;

INSERT INTO employee(employee_name, job_title, joining_date, department_id)
VALUES
('Rahul Dravid', 'Head', '2020-01-01', 10),
('Rohit Sharma', 'Manager', '2022-01-01', 20),
('Virat Kohli', 'Development', '2005-01-01', 30),
('Siraj', 'Testing', '2020-01-01', 40),
('Rahane', 'Development', '2009-01-01', 30),
('Shami', 'Testing', '2018-01-01', 40),
('Subhman Gill', 'Development', '2021-01-01', 30),
('Jadeja', 'Testing', '2015-01-01', 40);

SELECT * FROM employee;

SELECT * FROM employee WHERE employee_name LIKE 'R%'; /* STARTS WITH */
SELECT * FROM employee WHERE employee_name LIKE '%a'; /* Ends With */
SELECT * FROM employee WHERE employee_name LIKE '%ha%'; /* Contains */

SELECT employee_name, job_title FROM employee WHERE employee_name LIKE '%ha%';

SELECT * FROM employee ORDER BY employee_name ASC; /* A-Z order */
SELECT * FROM employee ORDER BY employee_name DESC; /* Z-A Order */
SELECT * FROM employee ORDER BY job_title;

UPDATE employee SET salary=7500 WHERE employee_name='Rahul Dravid';
UPDATE employee SET salary=6000 WHERE employee_name='Rohit Sharma';
UPDATE employee SET salary=5900 WHERE employee_name='Virat Kohli';
UPDATE employee SET salary=4700 WHERE employee_name='Siraj';
UPDATE employee SET salary=5200 WHERE employee_name='Rahane';
UPDATE employee SET salary=5500 WHERE employee_name='Shami';
UPDATE employee SET salary=3500 WHERE employee_name='Subhman Gill';
UPDATE employee SET salary=4800 WHERE employee_name='Jadeja';

SELECT * FROM employee WHERE salary > 5000;
SELECT * FROM employee WHERE salary < 5000;
SELECT * FROM employee WHERE salary >= 5000 AND salary <= 6000;
SELECT * FROM employee WHERE salary BETWEEN 5000 AND 6000;
SELECT * FROM employee WHERE salary != 6000;	/*		!=			<>		*/

/* employees whose salary is 5500 or 3500 */
SELECT * FROM employee WHERE salary=5500 OR salary=3500;
SELECT * FROM employee WHERE salary IN(5500, 3500);

SELECT * FROM employee WHERE salary NOT BETWEEN 5000 AND 6000;
SELECT * FROM employee WHERE salary NOT IN(5500, 3500);

SELECT * FROM employee WHERE NOT salary > 5000;



/*
	Relational:		<			>			<=			>=		!= <>		=
	Logical:       AND			OR			NOT 
	Other:		   LIKE      NOT LIKE	IS NULL		IS NOT NULL    IN  NOT IN		BETWEEN   NOT BETWEEN
	Arithmetic Operators:		+		-		*		/		
	
	Date Functions
	String Functions
	Mathematical Functions 
*/


-- Aggregations :	Min, Max, Sum, Count, Avg 
SELECT * FROM employee;
SELECT MIN(salary) FROM employee;
SELECT MAX(salary) FROM employee;
SELECT SUM(salary) FROM employee;
SELECT AVG(salary) FROM employee;
SELECT 43100 / 8;
SELECT COUNT(*) FROM employee; 
SELECT SUM(salary)/COUNT(*) FROM employee;
SELECT COUNT(salary) FROM employee;
SELECT COUNT(DISTINCT department_id) FROM employee;

SELECT job_title FROM employee;
SELECT DISTINCT job_title FROM employee;

SELECT * FROM employee 
WHERE salary=(SELECT MIN(salary) FROM employee); /* minimum salaried employee */

SELECT * FROM employee 
WHERE salary=(SELECT MAX(salary) FROM employee); /* maximum salaried employee */

SELECT * FROM employee 
WHERE salary>(SELECT AVG(salary) FROM employee); /* employees whose salary is more than avg salary */

SELECT * FROM employee 
WHERE salary<(SELECT AVG(salary) FROM employee); /* employees whose salary is less than avg salary */


SELECT MIN(salary) FROM employee 
WHERE salary>(SELECT MIN(salary) FROM employee);	/* 2nd min salary */

/* Work */											/* 2nd max salary */

SELECT * FROM employee 
WHERE salary=(SELECT MIN(salary) FROM employee 
			  WHERE salary>(SELECT MIN(salary) FROM employee)
			  );									/* 2nd min salary getter */
			  
/* Work */											/* 2nd max salary getter */


/*	min salary of 
	employees who got below avg salary 
*/
SELECT * FROM employee 
WHERE salary < (SELECT AVG(salary) FROM employee);  -- employees who got below avg salary 

SELECT MIN(salary) FROM employee 
WHERE salary < (SELECT AVG(salary) FROM employee);  -- min salary of  employees who got below avg salary 

SELECT MAX(salary) FROM employee 
WHERE salary < (SELECT AVG(salary) FROM employee);  -- max salary of  employees who got below avg salary

SELECT * FROM employee
WHERE salary=(SELECT MAX(salary) FROM employee 
			  WHERE salary < (SELECT AVG(salary) FROM employee));  -- max salary getter of  employees who got below avg salary
			  
/* joins */	

SELECT * FROM employee WHERE salary > 5000;		/*		modify the query using query designer */

 SELECT     employee_id, employee_name, job_title, joining_date, salary, department_id
FROM         employee
WHERE     (salary > 5000) ;						/* form the query newly using query designer */

-- employees whose salary above 5000 and the job_title is Development

-- employees whose department id 10
SELECT     employee_id, employee_name, job_title, joining_date, salary, department_id
FROM         employee
WHERE     (department_id = 10)


SELECT * FROM employee CROSS JOIN department;	/* each department is joined with all employees */

SELECT employee_name, department_name 
FROM employee INNER JOIN 
	 department ON(employee.department_id = department.department_id);	/* INNER JOIN -> EQUI JOIN */
	 
SELECT employee_name, employee.department_id, department_name 
FROM employee INNER JOIN 
	 department ON(employee.department_id = department.department_id);
	 
SELECT e.employee_name, e.department_id, d.department_name 
FROM employee AS e INNER JOIN 
	 department AS d ON(e.department_id = d.department_id);	 /* alias names in table */	
	 
SELECT e.employee_name name, e.department_id dept_id, d.department_name dept_name
FROM employee e INNER JOIN 
	 department d ON(e.department_id = d.department_id);	/* alias names in columns display */ 	

SELECT MAX(salary)  FROM employee;	 
SELECT MAX(salary) max_salary FROM employee;	 


SELECT e.employee_name, d.department_name, e.salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id);
	 
	 
SELECT e.employee_name, d.department_name, e.salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
ORDER BY d.department_name;	 /* sorted based on depatment_name */ 

SELECT e.employee_name, d.department_name, e.salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
ORDER BY d.department_name, e.salary;	/* sorted by department_name then by salary */

SELECT e.employee_name, d.department_name, e.salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
ORDER BY d.department_name, e.salary DESC;	/* sorted by department_name then by salary  desc */

SELECT e.employee_name, d.department_name, e.salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';

SELECT MIN(e.salary)
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';  

SELECT MAX(e.salary)
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';

SELECT SUM(e.salary)
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';

SELECT AVG(e.salary)
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';



SELECT 'Analysis' dept, MIN(e.salary) min_salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Analysis'
UNION
SELECT 'Design' dept, MIN(e.salary) min_salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Design'
UNION
SELECT 'Development' dept,MIN(e.salary) min_salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Development'
UNION
SELECT 'Testing' dept, MIN(e.salary) min_salary
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
WHERE d.department_name = 'Testing';

/* Group By ===  groups the rows, each group may be applicable for aggregation */
SELECT d.department_name, MIN(e.salary) min_salary, MAX(e.salary) max_salary, 
	SUM(e.salary) total_salary, AVG(e.salary) avg_salary, COUNT(*) employee_count
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
GROUP BY d.department_name	 


SELECT e.department_id, MIN(e.salary) min_salary, MAX(e.salary) max_salary, 
	SUM(e.salary) total_salary, AVG(e.salary) avg_salary, COUNT(*) employee_count
FROM employee e 
GROUP BY e.department_id


/* each job_title's min max avg sum salaries, count */

SELECT e.job_title, MIN(e.salary) min_salary, MAX(e.salary) max_salary, 
	SUM(e.salary) total_salary, AVG(e.salary) avg_salary, COUNT(*) employee_count
FROM employee e 
GROUP BY e.job_title



SELECT employee_name, department_name 
FROM employee RIGHT OUTER JOIN 
	 department ON(employee.department_id = department.department_id);
	 
SELECT employee_name, department_name 
FROM department RIGHT OUTER JOIN 
	 employee ON(employee.department_id = department.department_id);	 
	 
SELECT employee_name, department_name 
FROM department LEFT OUTER JOIN 
	 employee ON(employee.department_id = department.department_id);	 
	 
SELECT employee_name, department_name 
FROM department FULL OUTER JOIN 
	 employee ON(employee.department_id = department.department_id);	 	 
	 
/*
CROSS JOIN	- left table's each record joined with right table's every record
INNER JOIN - left table's each record joined with right table record based on condition (equi join)
LEFT OUTER JOIN - left table's each record joined with right table record based on condition
				  union
				  excess records in the left table  	
RIGHT OUTER JOIN - left table's each record joined with right table record based on condition
				  union
				  excess records in the right table
FULL OUTER JOIN - left table's each record joined with right table record based on condition
				  union
				  excess records in the left table				  
				  union
				  excess records in the right table				  
*/	 



















							
							
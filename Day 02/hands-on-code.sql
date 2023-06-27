vendor{id, name}
	101, 'Dravid'
	102, 'Rohit'
	103, 'Pujara'
	104, 'Shami'
product{product_id, product_name, vendor_id}
	10, 'Raw Cake', 101
	20, 'Cake Cream', 102
	30, 'Ice Cream Powder', 101
	40, 'Coffee Powder', 108
	
CREATE TABLE vendor( 
	id int identity(101,1),
	name varchar(255) not null,
	constraint pk_vendor_id PRIMARY KEY(id)
);
CREATE TABLE product(
  product_id int identity(10,10), 
	product_name varchar(255) not null, 
	vendor_id int not null
);

INSERT INTO vendor(name)
VALUES('Dravid'),('Rohit'),('Pujara'),('Shami');
	
INSERT INTO product(product_name, vendor_id) 
VALUES('Raw Cake', 101),
	('Cake Cream', 102),
	('Ice Cream Powder', 101),
	('Coffee Powder', 108);	

	
,CONSTRAINT fk_product_vendor_id FOREIGN KEY(vendor_id) 
			REFERENCES vendor(id)	

SELECT * FROM vendor;	
SELECT * FROM product;


SELECT p.*, v.*
FROM product p
	INNER JOIN vendor v ON(v.id = p.vendor_id);

SELECT p.*, v.*
FROM product p
	LEFT OUTER JOIN vendor v ON(v.id = p.vendor_id);	

SELECT p.*, v.*
FROM product p
	RIGHT OUTER JOIN vendor v ON(v.id = p.vendor_id);	
	
SELECT p.*, v.*
FROM product p
	FULL OUTER JOIN vendor v ON(v.id = p.vendor_id);
	
------------------------------------------------------------
DDL - CREATE TABLE, DROP TABLE 
DML/DQL - INSERT, UPDATE, 
		SELECT 													columns / expressions 
			- filtering 									WHERE 
			- sorting 										ORDER BY 
			- aggregations 								
			- group by and aggregations 	GROUP BY 
					- having 									HAVING 
------------------------------------------------------------
ALTER 
TRUNCATE 

DELETE  

TRANSACTION 
------------------------------------------------------------
			HAVING CLAUSE 

SELECT d.department_name, MIN(e.salary) min_salary, MAX(e.salary) max_salary, 
	SUM(e.salary) total_salary, AVG(e.salary) avg_salary, COUNT(*) employee_count
FROM employee e 
	 INNER JOIN department d ON(e.department_id = d.department_id)
GROUP BY d.department_name	 
HAVING COUNT(*)=3


SELECT e.department_id, MIN(e.salary) min_salary, MAX(e.salary) max_salary, 
	SUM(e.salary) total_salary, AVG(e.salary) avg_salary, COUNT(*) employee_count
FROM employee e 
GROUP BY e.department_id
HAVING COUNT(*)=3
------------------------------------------------------------
									DELETE STATEMENT 
									
select * from employee;

INSERT INTO employee(employee_name, job_title, joining_date, salary, department_id)
VALUES('Maheswaran', 'Trainer', '2023-06-26', 1000, 60);

/* Check by insert violating foreign key */
INSERT INTO employee(employee_name, job_title, joining_date, salary, department_id)
VALUES('Muralidharan', 'Student', '2023-06-26', 1000, 70);

DELETE employee WHERE employee_id=9;
DELETE employee WHERE employee_name='Maheswaran';		
------------------------------------------------------------
									TRANSACTION 
									
select * from vendor;
select * from product;

BEGIN TRANSACTION 
INSERT INTO vendor(name) VALUES('Siraj');
INSERT INTO product(product_name, vendor_id) VALUES('Burger', 105),('Cheese Burger', 105);
COMMIT TRANSACTION 

BEGIN TRANSACTION 
INSERT INTO vendor(name) VALUES('Jadeja');
INSERT INTO product(product_name, vendor_id) VALUES('Pizza', 106),('Cheeze Pizza', 106);
ROLLBACK TRANSACTION 
------------------------------------------------------------	
											ALTER TABLE 

select * from vendor;
select * from product;

ALTER TABLE vendor 
ADD	
	description VARCHAR(1000) NOT NULL DEFAULT '';

sp_help vendor

ALTER TABLE product 
ADD	CONSTRAINT fk_product_vendor_id FOREIGN KEY(vendor_id) 
	REFERENCES vendor(id);
	
UPDATE product SET vendor_id=105 WHERE vendor_id=108;

sp_help product	


/*  product table refers / in relationship with  "vendor" table 
	can we drop the vendor table?
	Not possible.
	How can I drop the vendor table?
	Frist you drop the product table.
	Then drop the vendor table.
	Or
	Remove the foreign key from product table
	Then drop the vendor table.
	
*/

DROP TABLE vendor;								
------------------------------------------------------------
							TRUNCATE vs DELETE 
							
DROP TABLE vendor;


DELETE FROM product;
INSERT INTO product(product_name, vendor_id) VALUES('Chicken Pizza', 105); 

TRUNCATE TABLE product;
------------------------------------------------------------
Truncate: will deletes all the data from table and reset the structure of the table.		
------------------------------------------------------------					
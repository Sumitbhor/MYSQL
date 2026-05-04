CREATE TABLE branch_master (
    branch_id INT PRIMARY KEY,
    bname VARCHAR(50)
);

CREATE TABLE employee_master (
    emp_no INT PRIMARY KEY,
    e_name VARCHAR(50),
    branch_id INT,
    salary INT,
    dept VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch_master(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employee_master(emp_no) ON DELETE SET NULL
);

CREATE TABLE contact_details (
    emp_id INT,
    emailid VARCHAR(100),
    phnno VARCHAR(15),
    FOREIGN KEY (emp_id) REFERENCES employee_master(emp_no) ON DELETE SET NULL
);

CREATE TABLE emp_address_details (
    emp_id INT,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    FOREIGN KEY (emp_id) REFERENCES employee_master(emp_no) ON DELETE CASCADE
);

CREATE TABLE branch_address (
    branch_id INT,
    city VARCHAR(50),
    state VARCHAR(50),
    FOREIGN KEY (branch_id) REFERENCES branch_master(branch_id) ON DELETE CASCADE
);

INSERT INTO branch_master VALUES
(1, 'Vadgaon'),
(2, 'Pune'),
(3, 'Mumbai'),
(4, 'Delhi');

INSERT INTO branch_address VALUES
(1, 'Pune', 'Maharashtra'),
(2, 'Pune', 'Maharashtra'),
(3, 'Mumbai', 'Maharashtra'),
(4, 'Delhi', 'Delhi');

INSERT INTO employee_master VALUES
(101, 'Amit', 1, 15000, 'Admin', NULL),
(102, 'Neha', 2, 25000, 'HR', 101),
(103, 'Rahul', 1, 12000, 'Admin', 101),
(104, 'Sneha', 3, 30000, 'IT', 102),
(105, 'Kiran', 2, 8000, 'Clerk', 102),
(106, 'Rohit', 1, 18000, 'IT', 103),
(107, 'Pooja', 3, 27000, 'Admin', 104),
(108, 'Vikas', 4, 22000, 'HR', 104);

INSERT INTO contact_details VALUES
(101, 'amit@gmail.com', '9876543210'),
(102, 'neha@gmail.com', '9876543211'),
(103, 'rahul@gmail.com', '9876543212'),
(104, 'sneha@gmail.com', '9876543213'),
(106, 'rohit@gmail.com', '9876543214'),
(107, 'pooja@gmail.com', '9876543215');

INSERT INTO emp_address_details VALUES
(101, 'MG Road', 'Pune', 'Maharashtra'),
(102, 'FC Road', 'Pune', 'Maharashtra'),
(103, 'Karve Nagar', 'Pune', 'Maharashtra'),
(104, 'Andheri', 'Mumbai', 'Maharashtra'),
(105, 'Shivaji Nagar', 'Pune', 'Maharashtra'),
(106, 'Katraj', 'Pune', 'Maharashtra'),
(107, 'Bandra', 'Mumbai', 'Maharashtra'),
(108, 'Connaught Place', 'Delhi', 'Delhi');


SELECT e.emp_no, e.e_name, e.salary, e.dept, b.bname
FROM employee_master e
INNER JOIN branch_master b
ON e.branch_id = b.branch_id
ORDER BY e.emp_no;

SELECT e.emp_no, e.e_name, e.dept, b.bname
FROM employee_master e
INNER JOIN branch_master b
ON e.branch_id = b.branch_id
WHERE e.dept = 'Admin';

SELECT e.e_name, c.phnno, a.city
FROM employee_master e
INNER JOIN contact_details c
ON e.emp_no = c.emp_id
INNER JOIN emp_address_details a
ON e.emp_no = a.emp_id;

SELECT e.e_name, c.emailid, c.phnno
FROM employee_master e
LEFT JOIN contact_details c
ON e.emp_no = c.emp_id;

SELECT e.e_name, c.emailid, c.phnno
FROM employee_master e
RIGHT JOIN contact_details c
ON e.emp_no = c.emp_id;

SELECT e.e_name AS employee, m.e_name AS manager
FROM employee_master e
LEFT JOIN employee_master m
ON e.manager_id = m.emp_no;

SELECT emp_no, e_name, salary, dept, bname
FROM employee_master
NATURAL JOIN branch_master;

SELECT e.e_name, a.city
FROM employee_master e
JOIN branch_master b ON e.branch_id = b.branch_id
JOIN emp_address_details a ON e.emp_no = a.emp_id
WHERE b.bname = 'Vadgaon';


SELECT e.e_name, a.street, a.city
FROM employee_master e
JOIN branch_master b ON e.branch_id = b.branch_id
JOIN emp_address_details a ON e.emp_no = a.emp_id
WHERE b.bname = 'Vadgaon' AND e.salary > 10000;

SELECT e.e_name
FROM employee_master e
JOIN emp_address_details a ON e.emp_no = a.emp_id
JOIN branch_address ba ON e.branch_id = ba.branch_id
WHERE a.city = ba.city;

CREATE VIEW total_employees AS
SELECT COUNT(*) AS total_count
FROM employee_master;

CREATE VIEW emp_count_per_branch AS
SELECT branch_id, COUNT(*) AS total_employees
FROM employee_master
GROUP BY branch_id;

SELECT DISTINCT b.bname
FROM employee_master e
JOIN branch_master b ON e.branch_id = b.branch_id
WHERE e.salary > 25000;

CREATE VIEW salary_stats_per_branch AS
SELECT branch_id,
       AVG(salary) AS avg_salary,
       SUM(salary) AS total_salary
FROM employee_master
GROUP BY branch_id;

CREATE VIEW emp_view AS
SELECT e_name, dept
FROM employee_master;

UPDATE emp_view
SET dept = 'HR'
WHERE e_name = 'Amit';

CREATE VIEW emp_branch_view AS
SELECT e.emp_no, e.e_name, b.bname
FROM employee_master e
JOIN branch_master b
ON e.branch_id = b.branch_id;

UPDATE emp_branch_view
SET bname = 'Pune'
WHERE emp_no = 101;
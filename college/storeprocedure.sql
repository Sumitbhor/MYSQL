
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept VARCHAR(30),
    salary INT,
    bonus INT
);


INSERT INTO employees VALUES
(1,'Amit','IT',50000,NULL),
(2,'Neha','HR',30000,NULL),
(3,'Rahul','IT',40000,NULL),
(4,'Sneha','Finance',60000,NULL),
(5,'Kiran','HR',25000,NULL),
(6,'Pooja','IT',45000,NULL);

DELIMITER //

CREATE PROCEDURE calc_bonus()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE e_id INT;
    DECLARE sal INT;

    DECLARE cur CURSOR FOR 
        SELECT emp_id, salary FROM employees;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO e_id, sal;

        IF done = 1 THEN 
            LEAVE read_loop;
        END IF;

        UPDATE employees
        SET bonus = sal * 0.10
        WHERE emp_id = e_id;

    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL calc_bonus();


DELIMITER //

CREATE FUNCTION count_emp(sal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE s INT;
    DECLARE cnt INT DEFAULT 0;

    DECLARE cur CURSOR FOR 
        SELECT salary FROM employees;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO s;

        IF done = 1 THEN 
            LEAVE read_loop;
        END IF;

        IF s > sal THEN
            SET cnt = cnt + 1;
        END IF;

    END LOOP;

    CLOSE cur;

    RETURN cnt;
END //

DELIMITER ;


SELECT count_emp(35000);

SELECT * FROM employees;
-- 🔷 Create Tables

CREATE TABLE library (
    B_id INT PRIMARY KEY,
    Title VARCHAR(50),
    Authors VARCHAR(50),
    Edition INT,
    no_of_c INT
);

CREATE TABLE library_audit (
    B_id INT,
    Title VARCHAR(50),
    Authors VARCHAR(50),
    Edition INT,
    no_of_c INT,
    date_of_mod DATE,
    type_of_op VARCHAR(10),
    username VARCHAR(50)
);

CREATE TABLE transactions (
    Trans_id INT,
    B_id INT,
    I_R CHAR(1),   -- I = Issue, R = Return
    no_of_c INT
);

-- 🔷 Insert Sample Data

INSERT INTO library VALUES
(1, 'DBMS', 'Korth', 5, 10),
(2, 'OS', 'Galvin', 7, 5),
(3, 'CN', 'Tanenbaum', 4, 8);

-- 🔷 Trigger 1: Track UPDATE

DELIMITER $$

CREATE TRIGGER t_update
AFTER UPDATE ON library
FOR EACH ROW
BEGIN
    INSERT INTO library_audit
    VALUES (
        OLD.B_id,
        OLD.Title,
        OLD.Authors,
        OLD.Edition,
        OLD.no_of_c,
        CURDATE(),
        'UPDATED',
        CURRENT_USER()
    );
END$$

DELIMITER ;

-- 🔷 Trigger 2: Track DELETE

DELIMITER $$

CREATE TRIGGER t_delete
AFTER DELETE ON library
FOR EACH ROW
BEGIN
    INSERT INTO library_audit
    VALUES (
        OLD.B_id,
        OLD.Title,
        OLD.Authors,
        OLD.Edition,
        OLD.no_of_c,
        CURDATE(),
        'DELETED',
        CURRENT_USER()
    );
END$$

DELIMITER ;

-- 🔷 Trigger 3: Check Available Copies Before Issue

DELIMITER $$

CREATE TRIGGER t_check
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE available INT;

    IF NEW.I_R = 'I' THEN
        SELECT no_of_c INTO available
        FROM library
        WHERE B_id = NEW.B_id;

        IF NEW.no_of_c > available THEN
            SET NEW.no_of_c = available;
        END IF;
    END IF;
END$$

DELIMITER ;

-- 🔷 Trigger 4: Update Copies After Issue/Return

DELIMITER $$

CREATE TRIGGER t_update_copies
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.I_R = 'I' THEN
        UPDATE library
        SET no_of_c = no_of_c - NEW.no_of_c
        WHERE B_id = NEW.B_id;
    ELSE
        UPDATE library
        SET no_of_c = no_of_c + NEW.no_of_c
        WHERE B_id = NEW.B_id;
    END IF;
END$$

DELIMITER ;

-- 🔷 Test Queries

-- Update (should log in audit)
UPDATE library 
SET Authors = 'Kapil-Mishra' 
WHERE B_id = 1;

-- Delete (should log in audit)
DELETE FROM library 
WHERE B_id = 3;

-- Issue more copies than available (trigger will adjust)
INSERT INTO transactions VALUES (10,2,'I',7);

-- Return books
INSERT INTO transactions VALUES (12,2,'R',3);

-- 🔷 Final Output

SELECT * FROM library;
SELECT * FROM library_audit;
SELECT * FROM transactions;
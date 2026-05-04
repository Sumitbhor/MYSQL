CREATE TABLE Book (
    Book_ID INT PRIMARY KEY,
    Book_Name VARCHAR(100),
    Author VARCHAR(100),
    Price DECIMAL(8,2),
    Category VARCHAR(50)
);

INSERT INTO Book VALUES
(1, 'Data Structures', 'Mark Allen', 500, 'Programming'),
(2, 'Database Systems', 'Korth', 650, 'Education'),
(3, 'Digital Logic', 'Morris Mano', 400, 'Education'),
(4, 'C Programming', 'Dennis Ritchie', 300, 'Programming'),
(5, 'Design Patterns', 'Erich Gamma', 700, 'Programming'),
(6, 'Discrete Mathematics', 'Rosen', 550, 'Education');
SELECT * FROM Book;
UPDATE Book
SET Price = Price + (Price * 0.10)
WHERE Category = 'Programming';
DELETE FROM Book
WHERE Price < 400;
SELECT Book_Name, Price, Price + 50 AS New_Price
FROM Book;

SELECT *
FROM Book
WHERE Category = 'Education' AND Price > 500;

SELECT *
FROM Book
WHERE Book_Name LIKE 'D%';

SELECT 
UPPER(Book_Name) AS Book_Name_Upper,
LOWER(Author) AS Author_Lower
FROM Book;


SELECT Book_Name, LENGTH(Book_Name) AS Length
FROM Book;


SELECT Book_Name, LENGTH(Book_Name) AS Length
FROM Book;

SELECT Book_Name, SUBSTRING(Book_Name, 1, 5) AS Sub_Name
FROM Book;

CREATE TABLE Issued_Book (
    Book_Name VARCHAR(100)
);

INSERT INTO Issued_Book VALUES
('Data Structures'),
('C Programming'),
('Artificial Intelligence');


SELECT Book_Name FROM Book
UNION
SELECT Book_Name FROM Issued_Book;
SELECT B.Book_Name
FROM Book B
INNER JOIN Issued_Book I
ON B.Book_Name = I.Book_Name;
CREATE USER 'student1'@'localhost' IDENTIFIED BY 'password123';

GRANT SELECT, UPDATE ON Book TO 'student1'@'localhost';

REVOKE UPDATE ON Book FROM 'student1'@'localhost';

START TRANSACTION;

UPDATE Book SET Price = Price + 100 WHERE Book_ID = 1;

SAVEPOINT sp1;

DELETE FROM Book WHERE Book_ID = 2;

-- Rollback to savepoint
ROLLBACK TO sp1;

-- Final commit
COMMIT;
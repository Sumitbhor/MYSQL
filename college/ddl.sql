create table department( dept_id int primary key , dept_name varchar(80) unique not null );
CREATE TABLE Student (
    Stud_ID INT PRIMARY KEY,
    Stud_Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18),
    Email VARCHAR(100) UNIQUE,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

INSERT INTO Department VALUES
(1, 'Computer Engineering'),
(2, 'Mechanical'),
(3, 'Civil'),
(4, 'Electronics');
INSERT INTO Student VALUES
(101, 'Rahul', 20, 'rahul@gmail.com', 1),
(102, 'Sneha', 19, 'sneha@gmail.com', 2),
(103, 'Amit', 21, 'amit@gmail.com', 1),
(104, 'Pooja', 22, 'pooja@gmail.com', 3);

ALTER TABLE Student
ADD City VARCHAR(30);

ALTER TABLE Student
MODIFY Stud_Name VARCHAR(100);

ALTER TABLE Student
CHANGE City Location VARCHAR(30);

ALTER TABLE Student
ALTER Location SET DEFAULT 'Pune';

ALTER TABLE Student
MODIFY Location VARCHAR(30) DEFAULT 'Pune';

RENAME TABLE Student TO Student_Details;

TRUNCATE TABLE Student_Details;

DROP TABLE Student_Details;

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50) NOT NULL UNIQUE,
    Duration INT CHECK (Duration >= 1)
);

CREATE TABLE Student_Course (
    SC_ID INT PRIMARY KEY,
    Stud_ID INT,
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Student_Result (
    Student_ID INT,
    Student_Name VARCHAR(100),
    Subject VARCHAR(50),
    Marks INT,
    Department VARCHAR(50)
);
INSERT INTO Student_Result VALUES
(1, 'Amit', 'Math', 85, 'Computer'),
(2, 'Sumit', 'Math', 78, 'Computer'),
(3, 'Riya', 'Math', 92, 'IT'),
(4, 'Neha', 'Science', 88, 'IT'),
(5, 'Rahul', 'Science', 67, 'Mechanical'),
(6, 'Pooja', 'Science', 73, 'Computer'),
(7, 'Kiran', 'English', 81, 'IT'),
(8, 'Anjali', 'English', 76, 'Mechanical'),
(9, 'Rohit', 'English', 69, 'Computer'),
(10, 'Sneha', 'Math', 95, 'Computer');

SELECT Department, COUNT(Student_ID) AS Total_Students
FROM Student_Result
GROUP BY Department;

SELECT Subject, AVG(Marks) AS Avg_Marks
FROM Student_Result
GROUP BY Subject;

SELECT Subject, MAX(Marks) AS Highest_Marks
FROM Student_Result
GROUP BY Subject;

SELECT Subject, MIN(Marks) AS Lowest_Marks
FROM Student_Result
GROUP BY Subject;

SELECT Department, SUM(Marks) AS Total_Marks
FROM Student_Result
GROUP BY Department;

SELECT Subject, COUNT(Student_ID) AS Student_Count
FROM Student_Result
GROUP BY Subject;

SELECT Department, AVG(Marks) AS Avg_Marks
FROM Student_Result
GROUP BY Department
HAVING AVG(Marks) > 80;

SELECT Subject, COUNT(Student_ID) AS Student_Count
FROM Student_Result
GROUP BY Subject
HAVING COUNT(Student_ID) > 3;

SELECT Department, AVG(Marks) AS Avg_Marks
FROM Student_Result
WHERE Marks > 70
GROUP BY Department;

SELECT Department, MAX(Marks) AS Max_Marks
FROM Student_Result
GROUP BY Department;

SELECT Department, MIN(Marks) AS Min_Marks
FROM Student_Result
GROUP BY Department;

SELECT Department, SUM(Marks) AS Total_Marks
FROM Student_Result
GROUP BY Department
HAVING SUM(Marks) > 400;

SELECT Subject, AVG(Marks) AS Avg_Marks
FROM Student_Result
GROUP BY Subject
HAVING AVG(Marks) > 80;


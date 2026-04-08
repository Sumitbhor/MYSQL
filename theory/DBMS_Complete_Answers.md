# DBMS Question Bank - Comprehensive Detailed Answers

> Complete guide with detailed explanations, examples, diagrams, and SQL code for all 28 questions

---

## Table of Contents

### Database Fundamentals (Q1-9)
1. [Three-Level Architecture and View of Data](#1)
2. [Database System Structure with Components](#2)
3. [Database Languages (DDL, DML) with Examples](#3)
4. [Purpose and Applications of Database Systems](#4)
5. [Enterprise Constraints with Examples](#5)
6. [Data Models and Relational Data Model](#6)
7. [Data Abstraction and Data Independence](#7)
8. [Database Design Process](#8)
9. [Database System Applications](#9)

### ER Modeling (Q10-20)
10. [Types of Attributes in ER Model](#10)
11. [Cardinality and Participation Constraints](#11)
12. [Entity, Attribute, and Relationship Definitions](#12)
13. [Keys and Relationship Constraints in ER Model](#13)
14. [ER Diagram - Company Database](#14)
15. [Specialization and Generalization in EER Model](#15)
16. [ER Diagram - Hospital System](#16)
17. [Steps to Convert ER Diagram into Relational Tables](#17)
18. [ER Diagram - University System](#18)
19. [Extended ER Features with Example](#19)
20. [ER Diagram - Banking System](#20)

### Relational Model & Design (Q21-28)
21. [Relational Data Model with Features](#21)
22. [Compare Conceptual, Logical, and Physical Design](#22)
23. [ER Diagram - Library System](#23)
24. [Relationship Constraints](#24)
25. [Differentiate Physical vs Logical Data Independence](#25)
26. [EER Diagram - Employee Specialization](#26)
27. [Differentiate Database System vs File System](#27)
28. [Steps to Convert ER/EER Diagram into Tables](#28)

---


<a name="1"></a>
## 1. Three-Level Architecture and View of Data in DBMS

The three-level architecture (ANSI/SPARC architecture) is a framework that achieves data independence by separating the user application from the physical database through three levels of abstraction.

### The Three Levels:

**1. External Level (View Level) - User Views**
- Highest level of abstraction
- Different users see different parts of the database
- Each user has a customized view
- Provides security by hiding sensitive data
- Multiple external views can exist

Example:
```sql
-- Student View - sees only their own data
CREATE VIEW StudentView AS
SELECT RollNo, Name, CGPA FROM Student WHERE RollNo = CURRENT_USER;

-- Faculty View - sees all student grades
CREATE VIEW FacultyView AS
SELECT S.Name, E.CourseID, E.Grade
FROM Student S JOIN Enrollment E ON S.RollNo = E.StudentID;
```

**2. Conceptual Level (Logical Level) - Community View**
- Describes what data is stored in the database
- Complete view of entire database
- Describes entities, data types, relationships, constraints
- Only one conceptual schema
- DBA works at this level

Example:
```sql
STUDENT(RollNo INT PRIMARY KEY, Name VARCHAR(50), CGPA DECIMAL(3,2))
COURSE(CourseID VARCHAR(10) PRIMARY KEY, CourseName VARCHAR(100))
ENROLLMENT(StudentID INT, CourseID VARCHAR(10), Grade CHAR(2),
          FOREIGN KEY (StudentID) REFERENCES STUDENT(RollNo))
```

**3. Internal Level (Physical Level) - Storage View**
- Describes how data is physically stored
- File organization, indexing, storage structures
- Access paths and compression
- Lowest level of abstraction

Example Physical Details:
- B-tree index on RollNo
- Hash index on CourseID
- Records stored in 4KB blocks
- Sequential file organization
- Buffer pool: 512 pages

### Benefits:
- Data Independence (physical and logical)
- Security through views
- Multiple user perspectives
- Simplified database interaction

---

<a name="2"></a>
## 2. Database System Structure with Components

A DBMS consists of hardware, software, data, users, and procedures working together.

### Components:

**1. Hardware**
- **Storage:** HDD, SSD, RAID arrays
- **Memory:** RAM for buffers and caching
- **CPU:** Executes database operations
- **I/O Devices:** Keyboards, monitors, printers
- **Network:** Routers, switches for distributed access

**2. Software**
- **DBMS:** Oracle, MySQL, PostgreSQL, SQL Server
  - Query Processor & Optimizer
  - Transaction Manager
  - Storage Manager
  - Buffer Manager
  - Recovery Manager
- **Operating System:** Linux, Windows Server
- **Application Programs:** User interfaces, reports
- **Utilities:** Backup tools, monitoring, migration

**3. Data**
- **User Data:** Actual business data in tables
- **Metadata:** Data dictionary, schema definitions
- **Indexes:** B-tree, hash, bitmap indexes
- **System Catalog:** Database object information

**4. Users**
- **DBA:** Manages entire system, schemas, permissions, backup
- **Application Programmers:** Develop database applications
- **Sophisticated Users:** Use SQL directly for queries
- **End Users:** Use pre-built applications
- **System Analysts:** Design applications, gather requirements

**5. Procedures**
- **Design:** ER modeling, normalization
- **Operational:** Backup schedules, login procedures
- **Maintenance:** Index rebuilding, statistics update
- **Security:** Access control, encryption
- **Recovery:** Crash recovery, rollback procedures

### Database System Architecture Flow:
```
User → Application → Query Processor → Transaction Manager → 
Buffer Manager → Storage Manager → Physical Storage
```

---

<a name="3"></a>
## 3. Database Languages (DDL, DML) with Examples

### Data Definition Language (DDL)
Defines and modifies database structure.

**Commands:** CREATE, ALTER, DROP, TRUNCATE

**Examples:**
```sql
-- CREATE: Create new table
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18),
    Department VARCHAR(30),
    CGPA DECIMAL(3,2)
);

-- ALTER: Modify structure
ALTER TABLE Student ADD Email VARCHAR(100);
ALTER TABLE Student MODIFY Name VARCHAR(100);
ALTER TABLE Student DROP COLUMN Age;

-- DROP: Delete object
DROP TABLE Student;
DROP INDEX idx_name;

-- TRUNCATE: Remove all data, keep structure
TRUNCATE TABLE Student;
```

### Data Manipulation Language (DML)
Manipulates data within database objects.

**Commands:** SELECT, INSERT, UPDATE, DELETE

**Examples:**
```sql
-- SELECT: Retrieve data
SELECT * FROM Student WHERE Department = 'CS';
SELECT AVG(CGPA) FROM Student GROUP BY Department;

-- INSERT: Add new data
INSERT INTO Student VALUES (101, 'John Doe', 20, 'CS', 8.5);
INSERT INTO Student (RollNo, Name) VALUES (102, 'Jane');

-- UPDATE: Modify existing data
UPDATE Student SET CGPA = 9.0 WHERE RollNo = 101;
UPDATE Student SET Department = 'CSE' WHERE Department = 'CS';

-- DELETE: Remove data
DELETE FROM Student WHERE CGPA < 5.0;
DELETE FROM Student WHERE RollNo = 101;
```

### Comparison:
| DDL | DML |
|-----|-----|
| Structure changes | Data changes |
| Auto-committed | Can rollback |
| CREATE, ALTER, DROP | SELECT, INSERT, UPDATE |
| Less frequent | Very frequent |

---

<a name="4"></a>
## 4. Purpose and Applications of Database Systems

### Purpose:

**1. Data Management**
- Centralized storage
- Organized structure
- Easy retrieval

**2. Eliminate Redundancy**
- Single source of truth
- Reduced storage
- Consistent updates

**3. Data Sharing**
- Multi-user access
- Concurrent operations
- Controlled access

**4. Data Integrity**
- Constraints enforcement
- Validation rules
- ACID properties

**5. Security**
- Authentication
- Authorization
- Encryption
- Audit trails

**6. Backup & Recovery**
- Automated backups
- Point-in-time recovery
- Disaster recovery

### Applications:

**1. Banking**
- Account management
- Transactions (deposit, withdrawal)
- Loan processing
- ATM operations
Example: Account(AccNo, Balance, Type), Transaction(TID, AccNo, Amount)

**2. Airlines**
- Flight scheduling
- Seat reservations
- Ticket booking
Example: Flight(FlightNo, Origin, Dest), Booking(BookingID, FlightNo, PassengerID)

**3. Universities**
- Student enrollment
- Course management
- Grade tracking
Example: Student(RollNo, Name), Course(CourseID, Name), Enrollment(StudentID, CourseID, Grade)

**4. E-commerce**
- Product catalog
- Order processing
- Customer management
Example: Product(PID, Name, Price), Order(OrderID, CustomerID, Total)

**5. Healthcare**
- Patient records
- Appointments
- Medical history
Example: Patient(PID, Name), Doctor(DID, Specialization), Appointment(PID, DID, DateTime)

**6. Manufacturing**
- Inventory management
- Supply chain
- Production tracking

**7. Telecommunications**
- Customer accounts
- Call records
- Billing

**8. HR Systems**
- Employee records
- Payroll
- Attendance

---

<a name="5"></a>
## 5. Enterprise Constraints with Examples

Enterprise constraints enforce business rules and maintain data integrity.

### Types:

**1. Domain Constraints**
Restrict values an attribute can take.

Examples:
```sql
-- Age must be between 0 and 120
CREATE TABLE Person (
    Age INT CHECK (Age >= 0 AND Age <= 120)
);

-- Gender must be M, F, or O
ALTER TABLE Person ADD Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O'));

-- Percentage between 0 and 100
CREATE TABLE Marks (
    Percentage DECIMAL(5,2) CHECK (Percentage >= 0 AND Percentage <= 100)
);

-- Email must contain @
ALTER TABLE Student ADD Email VARCHAR(100) CHECK (Email LIKE '%@%');
```

**2. Key Constraints**
Ensure unique identification.

Examples:
```sql
-- Primary Key (unique, not null)
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);

-- Composite Primary Key
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(10),
    PRIMARY KEY (StudentID, CourseID, Semester)
);
```

**3. Entity Integrity**
Primary key cannot be NULL.

```sql
-- Automatically enforced
INSERT INTO Student VALUES (NULL, 'John');  -- ERROR
```

**4. Referential Integrity**
Foreign key must reference existing primary key.

Examples:
```sql
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- ON DELETE CASCADE
CREATE TABLE OrderItems (
    OrderID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

-- ON DELETE SET NULL
CREATE TABLE Employee (
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID) ON DELETE SET NULL
);
```

**5. Semantic Constraints (Business Rules)**

Examples:
```sql
-- Salary cannot exceed manager's salary
-- Withdrawal cannot exceed balance
-- Student cannot enroll in more than 6 courses
-- Loan amount <= 10 * Annual Income

CREATE TABLE Loan (
    Amount DECIMAL(15,2),
    AnnualIncome DECIMAL(15,2),
    CHECK (Amount <= 10 * AnnualIncome)
);

-- Discharge date must be after admission date
CREATE TABLE Patient (
    AdmissionDate DATE,
    DischargeDate DATE,
    CHECK (DischargeDate >= AdmissionDate)
);
```

---

<a name="6"></a>
## 6. Data Models and Relational Data Model

### Data Models

**Definition:** Conceptual tools to describe data, relationships, semantics, and constraints.

### Types of Data Models:

**1. Hierarchical Model**
- Tree structure
- Parent-child relationships
- One-to-many only
- Example: File systems

**2. Network Model**
- Graph structure
- Multiple parents allowed
- Many-to-many relationships
- Complex but flexible

**3. ER Model**
- Entities and relationships
- Graphical representation
- Conceptual design tool

**4. Relational Model**
- Data in tables (relations)
- Rows (tuples) and columns (attributes)
- Mathematical foundation

**5. Object-Oriented Model**
- Objects with methods
- Inheritance and encapsulation
- Complex data types

### Relational Data Model - Detailed

**Proposed by:** E.F. Codd (1970)

**Key Concepts:**

**1. Relation (Table)**
- Collection of tuples
- Fixed set of attributes
- Example: STUDENT table

**2. Tuple (Row)**
- Single record
- Example: One student's data

**3. Attribute (Column)**
- Property of entity
- Has name and domain
- Example: RollNo, Name

**4. Domain**
- Set of allowed values
- Example: Age domain = {0..120}

**5. Degree**
- Number of attributes
- Example: Student(RollNo, Name, Age) has degree 3

**6. Cardinality**
- Number of tuples
- Example: 500 students = cardinality 500

### Features of Relational Model:

**1. Simplicity**
- Easy to understand tables
- Rows and columns intuitive

**2. Data Independence**
- Logical and physical separation
- Structure changes don't affect applications

**3. Mathematical Foundation**
- Set theory
- Relational algebra
- Formal query languages

**4. Powerful Query Language**
- SQL - declarative
- Set-based operations

**5. Data Integrity**
- Constraints supported
- Entity and referential integrity

**6. Flexibility**
- Easy to modify
- Add/remove tables

Example:
```
STUDENT TABLE
┌────────┬────────────┬─────┬──────┐
│ RollNo │ Name       │ Age │ Dept │
├────────┼────────────┼─────┼──────┤
│ 101    │ Alice      │ 20  │ CS   │
│ 102    │ Bob        │ 21  │ IT   │
│ 103    │ Charlie    │ 20  │ ME   │
└────────┴────────────┴─────┴──────┘

Primary Key: RollNo
Degree: 4
Cardinality: 3
```

**Relational Algebra Operations:**
- Selection (σ): Select rows
- Projection (π): Select columns
- Union (∪): Combine relations
- Join (⋈): Combine related tables

---

<a name="7"></a>
## 7. Data Abstraction and Data Independence

### Data Abstraction

**Definition:** Hiding complexity and providing simplified views.

**Three Levels:**

**1. Physical Level (Internal)**
- How data is stored
- File organization, indexes
- Storage structures
Example: B-tree index, 4KB blocks

**2. Logical Level (Conceptual)**
- What data is stored
- Tables, relationships
- Complete database structure
Example: STUDENT(RollNo, Name, DeptID), DEPARTMENT(DeptID, Name)

**3. View Level (External)**
- User-specific views
- Simplified, customized
- Security through restricted access
Example: StudentPortal view shows only own records

### Data Independence

**Definition:** Ability to change schema at one level without affecting higher level.

### Types:

**1. Physical Data Independence**
- Modify physical storage without changing logical schema
- **Easier to achieve**

**Examples:**
```
Changes Allowed:
- HDD to SSD migration
- Add/remove indexes
- Change file organization (heap to hash)
- Modify storage structures
- Change compression methods

Impact: NONE on logical schema or applications

Before:
- Data on single HDD server
- Heap file organization
Query: SELECT * FROM Student WHERE RollNo = 101;

After:
- Data on SSD with RAID
- B-tree indexed organization
Query: SELECT * FROM Student WHERE RollNo = 101;  -- Same query!
```

**2. Logical Data Independence**
- Modify logical schema with minimal impact on views
- **Harder to achieve**

**Examples:**
```
Changes Allowed:
- Add new tables
- Add new attributes
- Split tables (normalization)
- Modify relationships

Achieve through: Views

Before:
STUDENT(RollNo, Name, Street, City, State, Pincode)

After:
STUDENT(RollNo, Name, AddressID)
ADDRESS(AddressID, Street, City, State, Pincode)

View for compatibility:
CREATE VIEW StudentComplete AS
SELECT S.RollNo, S.Name, A.Street, A.City, A.State, A.Pincode
FROM Student S JOIN Address A ON S.AddressID = A.AddressID;

Old applications use StudentComplete view - no changes needed!
```

### Comparison:

| Aspect | Physical Independence | Logical Independence |
|--------|----------------------|---------------------|
| Level | Internal → Conceptual | Conceptual → External |
| Changes | Storage, indexes | Tables, attributes |
| Difficulty | Easier | Harder |
| Frequency | Common | Less common |
| Mechanism | DBMS optimization | Views |

---


<a name="8"></a>
## 8. Database Design Process

Complete systematic approach to creating an efficient database.

### Phases:

**1. Requirements Analysis**
- Gather user needs
- Identify data requirements
- Determine constraints
- Document specifications

Activities:
- Interview stakeholders
- Analyze existing systems
- Define functional requirements
- Specify non-functional requirements (performance, security)

Example Output:
```
Entities needed: Student, Course, Faculty, Department
Operations: Enroll student, assign grade, generate transcript
Constraints: Student can enroll in max 6 courses per semester
Performance: Support 50,000 students, <2 second response time
```

**2. Conceptual Design**
- Create ER diagram
- Identify entities, attributes, relationships
- Determine cardinality
- Independent of DBMS

Example:
```
Entities: STUDENT (RollNo, Name, Email), COURSE (CourseID, CourseName)
Relationship: ENROLLS (M:N between Student and Course)
```

**3. Logical Design**
- Convert ER to relational schema
- Apply normalization
- Define constraints
- Create table structures

Example:
```sql
STUDENT(RollNo, Name, Email, DeptID)
COURSE(CourseID, CourseName, Credits)
ENROLLMENT(StudentID, CourseID, Semester, Grade)
  - PK: (StudentID, CourseID, Semester)
  - FK: StudentID → STUDENT(RollNo)
  - FK: CourseID → COURSE(CourseID)
```

**4. Physical Design**
- Choose storage structures
- Design indexes
- Plan partitioning
- Security implementation

Example:
```sql
-- Indexes
CREATE INDEX idx_student_dept ON STUDENT(DeptID);
CREATE INDEX idx_enrollment_student ON ENROLLMENT(StudentID);

-- Partitioning
PARTITION BY RANGE (Year);

-- Security
GRANT SELECT ON StudentView TO student_role;
```

**5. Implementation**
```sql
CREATE DATABASE UniversityDB;

CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE INDEX idx_student_name ON Student(Name);
```

**6. Testing & Refinement**
- Test queries and transactions
- Performance tuning
- Optimize indexes
- Validate constraints

**7. Deployment & Maintenance**
- Deploy to production
- Monitor performance
- Regular backups
- Updates and modifications

---

<a name="9"></a>
## 9. Database System Applications

Detailed applications across industries:

**1. Banking & Finance**
- Account management, transactions
- Loan processing, credit cards
- ATM operations, online banking
Tables: CUSTOMER, ACCOUNT, TRANSACTION, LOAN

**2. Airlines & Transportation**
- Flight scheduling, reservations
- Ticket booking, seat allocation
- Crew management, maintenance
Tables: FLIGHT, PASSENGER, BOOKING, AIRCRAFT

**3. Universities & Education**
- Student enrollment, grades
- Course management, faculty
- Library, hostel management
Tables: STUDENT, COURSE, ENROLLMENT, FACULTY

**4. E-commerce & Retail**
- Product catalog, inventory
- Order processing, customers
- Payment, shipping
Tables: PRODUCT, CUSTOMER, ORDER, ORDER_ITEMS

**5. Healthcare & Hospitals**
- Patient records, appointments
- Doctor schedules, prescriptions
- Lab tests, billing
Tables: PATIENT, DOCTOR, APPOINTMENT, PRESCRIPTION

**6. Manufacturing**
- Inventory, supply chain
- Production planning, quality control
Tables: RAW_MATERIAL, PRODUCT, SUPPLIER, PRODUCTION

**7. Telecommunications**
- Customer accounts, billing
- Call records, data usage
Tables: CUSTOMER, CALL_DETAIL, PLAN, BILL

**8. HR Management**
- Employee records, payroll
- Attendance, performance
Tables: EMPLOYEE, ATTENDANCE, PAYROLL, LEAVE

**9. Government & Public Services**
- Citizen records, tax collection
- License management, welfare programs
Tables: CITIZEN, TAX, LICENSE, WELFARE

---

<a name="10"></a>
## 10. Types of Attributes in ER Model

**1. Simple Attribute**
- Cannot be divided further
- Atomic value
Examples: Age, RollNo, Price

**2. Composite Attribute**
- Can be divided into smaller subparts
- Has component attributes

Example:
```
Name
  ├── FirstName
  ├── MiddleName
  └── LastName

Address
  ├── Street
  ├── City
  ├── State
  └── Pincode
```

**3. Single-valued Attribute**
- One value per entity
Examples: DateOfBirth, SSN, StudentID

**4. Multi-valued Attribute**
- Multiple values allowed
- Shown with double oval

Examples:
- PhoneNumbers (multiple phone numbers)
- EmailAddresses
- Hobbies
- Skills

Representation:
```
STUDENT
  ┌─────────────┐
  │ RollNo      │ (simple, single-valued)
  │ Name        │ (composite, single-valued)
  │ {{Phone}}   │ (simple, multi-valued) {{double braces}}
  └─────────────┘
```

**5. Derived Attribute**
- Calculated from other attributes
- Shown with dashed oval
- Not stored, computed when needed

Examples:
- Age (derived from DateOfBirth)
- TotalMarks (sum of subject marks)
- Experience (from JoiningDate)

**6. Stored Attribute**
- Actually stored in database
- Base for derived attributes
Examples: DateOfBirth (stored), JoiningDate (stored)

**7. Key Attribute**
- Uniquely identifies entity
- Shown with underline
Examples: RollNo, StudentID, EmployeeID

**8. Complex Attribute**
- Composition of composite and multi-valued

Example:
```
{{Address}}  -- multi-valued
  ├── Street
  ├── City
  └── Pincode
```

**Summary Table:**

| Type | Divisible? | Values | Example |
|------|-----------|--------|---------|
| Simple | No | One | Age |
| Composite | Yes | One | Name |
| Single-valued | - | One | DOB |
| Multi-valued | - | Many | Phone |
| Derived | - | Computed | Age from DOB |
| Stored | - | Saved | DOB |

---

<a name="11"></a>
## 11. Cardinality and Participation Constraints

### Cardinality Ratios

Specifies number of relationship instances an entity can participate in.

**Types:**

**1. One-to-One (1:1)**
- Entity in A relates to at most one in B
- Entity in B relates to at most one in A

Examples:
- Person ←→ Passport (one person, one passport)
- Employee ←→ Desk (one employee assigned one desk)
- Country ←→ Capital (one country, one capital)

Diagram:
```
PERSON ────1:1──── PASSPORT
```

**2. One-to-Many (1:N)**
- Entity in A relates to multiple in B
- Entity in B relates to only one in A

Examples:
- Department ←→ Employee (one dept, many employees)
- Customer ←→ Order (one customer, many orders)
- Teacher ←→ Student (one teacher, many students)

Diagram:
```
DEPARTMENT ────1:N──── EMPLOYEE
```

**3. Many-to-One (N:1)**
- Reverse of 1:N
Examples:
- Employee ←→ Department (many employees, one dept)

**4. Many-to-Many (M:N)**
- Entity in A relates to multiple in B
- Entity in B relates to multiple in A

Examples:
- Student ←→ Course (many students enroll in many courses)
- Doctor ←→ Patient (many doctors treat many patients)
- Author ←→ Book (many authors write many books)

Diagram:
```
STUDENT ────M:N──── COURSE
```

### Participation Constraints

Specifies whether all entities must participate in relationship.

**1. Total Participation (Mandatory)**
- Every entity must participate
- Shown with **double line**
- Minimum cardinality = 1

Examples:
- Every LOAN must have a CUSTOMER
- Every ENROLLMENT must have a STUDENT
- Every EMPLOYEE must work in a DEPARTMENT

Diagram:
```
EMPLOYEE ════1:N════ DEPARTMENT
(double line means total participation)
```

**2. Partial Participation (Optional)**
- Entity may or may not participate
- Shown with **single line**
- Minimum cardinality = 0

Examples:
- Not every STUDENT enrolls in COURSE (some may be on leave)
- Not every EMPLOYEE manages a PROJECT
- Not every CUSTOMER has a LOAN

Diagram:
```
STUDENT ────M:N──── COURSE
(single line means partial participation)
```

### Combined Example:

```
STUDENT ────M──── ENROLLS ────N════ COURSE
(partial)                        (total)

Meaning:
- A student may enroll in 0 or more courses (partial)
- A course must have at least 1 student (total)
- A student can enroll in many courses (M)
- A course can have many students (N)
```

### Notation Summary:

```
Cardinality:
  1:1  →  One-to-One
  1:N  →  One-to-Many
  M:N  →  Many-to-Many

Participation:
  ──── →  Single line (Partial/Optional)
  ════ →  Double line (Total/Mandatory)
```

---

<a name="12"></a>
## 12. Define Entity, Attribute, and Relationship with Example

### Entity

**Definition:** A distinguishable real-world object or thing that exists independently and about which data is stored.

**Characteristics:**
- Has independent existence
- Described by attributes
- Can be physical or conceptual
- Forms a table in relational model

**Types:**

**1. Strong Entity:**
- Exists independently
- Has its own primary key
- Shown with single rectangle

Examples: STUDENT, EMPLOYEE, PRODUCT

**2. Weak Entity:**
- Depends on another entity (owner)
- Partial key + owner's key for identification
- Shown with double rectangle

Example: DEPENDENT (depends on EMPLOYEE)

**Entity Set:** Collection of similar entities
Example: All students form STUDENT entity set

**Examples:**
```
Physical Entities:
- STUDENT: Individual student
- EMPLOYEE: Individual employee
- BOOK: Individual book
- CAR: Individual vehicle

Conceptual Entities:
- COURSE: Academic course
- ACCOUNT: Bank account
- ORDER: Purchase order
- APPOINTMENT: Medical appointment
```

### Attribute

**Definition:** A property or characteristic that describes an entity.

**Characteristics:**
- Has name and domain (set of allowed values)
- Each entity has value for each attribute
- Forms columns in tables

**Examples:**

**STUDENT Entity:**
- RollNo: 101 (simple, key)
- Name: "John Doe" (composite: First + Last)
- Age: 20 (derived from DateOfBirth)
- PhoneNumbers: {9876543210, 8765432109} (multi-valued)
- Department: "Computer Science" (single-valued)

**Representation:**
```
STUDENT
┌────────────────┐
│ *RollNo        │ ← Key attribute (underlined)
│  Name          │ ← Composite attribute
│  {Phone}       │ ← Multi-valued (double brackets)
│  Age           │ ← Derived (dashed oval)
│  Department    │ ← Simple attribute
└────────────────┘
```

### Relationship

**Definition:** An association among two or more entities.

**Characteristics:**
- Connects entities
- Can have own attributes (descriptive)
- Shown with diamond in ER diagram
- Degree: number of entities involved

**Types by Degree:**

**1. Unary (Recursive) - Degree 1:**
- Relationship among entities of same type

Example:
```
EMPLOYEE ──MANAGES──> EMPLOYEE
(An employee manages other employees)

PERSON ──MARRIED_TO──> PERSON
```

**2. Binary - Degree 2:**
- Between two entity types
- Most common

Example:
```
STUDENT ──ENROLLS──> COURSE
EMPLOYEE ──WORKS_IN──> DEPARTMENT
```

**3. Ternary - Degree 3:**
- Among three entities

Example:
```
SUPPLIER ─┐
          │
      SUPPLIES
          │
PROJECT ──┘──> PART
```

**Relationship Attributes:**
- Attributes that describe the relationship itself

Example:
```
EMPLOYEE ──WORKS_ON──> PROJECT
           (Hours, Role) ← Relationship attributes
```

### Complete Example:

**University Database:**

**Entities:**
```
STUDENT
- RollNo (key)
- Name (composite: FirstName, LastName)
- Email
- DateOfBirth
- {PhoneNumbers} (multi-valued)

COURSE
- CourseID (key)
- CourseName
- Credits
- Department

FACULTY
- FacultyID (key)
- Name
- Department
- Specialization
```

**Relationships:**
```
1. ENROLLS (Student, Course) - M:N
   Attributes: EnrollmentDate, Semester, Grade

2. TEACHES (Faculty, Course) - 1:N
   Attributes: Semester, Year, Section

3. ADVISES (Faculty, Student) - 1:N
   Attributes: StartDate
```

**ER Diagram:**
```
┌─────────┐         ┌─────────┐         ┌─────────┐
│ STUDENT │─────M───│ ENROLLS │───N─────│ COURSE  │
└─────────┘         └─────────┘         └─────────┘
     │                                        │
     │                                        │ M
     │ N                                      │
     │                                        │
 ADVISES                                  TEACHES
     │                                        │
     │ 1                                      │ 1
     │                                        │
┌─────────┐                                   │
│ FACULTY │───────────────────────────────────┘
└─────────┘
```

**Relational Tables:**
```sql
STUDENT(RollNo, FirstName, LastName, Email, DOB, DeptID)
STUDENT_PHONE(RollNo, PhoneNumber) -- Multi-valued attribute
COURSE(CourseID, CourseName, Credits, Department)
FACULTY(FacultyID, Name, Department, Specialization)
ENROLLMENT(RollNo, CourseID, Semester, EnrollmentDate, Grade)
TEACHES(FacultyID, CourseID, Semester, Year, Section)
ADVISES(FacultyID, RollNo, StartDate)
```

---

<a name="13"></a>
## 13. Keys and Relationship Constraints in ER Model

### Types of Keys

**1. Super Key**
- Set of one or more attributes that uniquely identify an entity
- Can contain extra attributes

Examples for STUDENT:
- {RollNo}
- {Email}
- {RollNo, Name}
- {RollNo, Name, Department}
- {Email, Name}

**2. Candidate Key**
- Minimal super key
- No proper subset is a super key
- Can be multiple candidate keys

Examples for STUDENT:
- {RollNo} - minimal
- {Email} - minimal
- {SSN} - minimal

**3. Primary Key**
- Selected candidate key
- Uniquely identifies each entity
- Cannot be NULL
- Only ONE per table
- Shown underlined in ER diagram

Example:
```
STUDENT
─────────
*RollNo  ← Primary Key (underlined)
 Name
 Email
```

**4. Alternate Key**
- Candidate keys not chosen as primary key

Example:
If RollNo is primary key, then Email and SSN are alternate keys.

**5. Composite Key**
- Primary key with multiple attributes

Example:
```
ENROLLMENT
──────────────────
*(StudentID, CourseID, Semester) ← Composite Primary Key
  Grade
  EnrollmentDate
```

**6. Foreign Key**
- Attribute referencing primary key of another table
- Maintains referential integrity
- Can be NULL (unless specified otherwise)

Example:
```
STUDENT               DEPARTMENT
─────────            ──────────────
RollNo (PK)         DeptID (PK)
Name                DeptName
DeptID (FK) ─────>  Building
```

**7. Partial Key**
- Attribute in weak entity
- Combined with owner's primary key to uniquely identify

Example:
```
EMPLOYEE (Strong)    DEPENDENT (Weak)
────────────────    ─────────────────
EmpID (PK)         Name (Partial Key)
Name               Age
                   EmpID (FK from owner)
                   
Identification: (EmpID, Name)
```

### Relationship Constraints

**1. Cardinality Constraints**

**One-to-One (1:1):**
```
PERSON ─1─ HAS ─1─ PASSPORT
```
Implementation:
- Add foreign key in either table
- Or merge into one table

**One-to-Many (1:N):**
```
DEPARTMENT ─1─ EMPLOYS ─N─ EMPLOYEE
```
Implementation:
- Add foreign key in "many" side (Employee table gets DeptID)

**Many-to-Many (M:N):**
```
STUDENT ─M─ ENROLLS ─N─ COURSE
```
Implementation:
- Create separate junction table
- ENROLLMENT(StudentID, CourseID, ...)

**2. Participation Constraints**

**Total Participation:**
- Every entity must participate
- Double line in ER diagram

Example:
```
LOAN ══M══ BORROWED_BY ──N── CUSTOMER
(Every loan must have a customer - total participation)
```

Implementation:
- Foreign key NOT NULL

**Partial Participation:**
- Entity may or may not participate
- Single line

Example:
```
EMPLOYEE ──1── MANAGES ──N── PROJECT
(Not every employee manages a project - partial)
```

Implementation:
- Foreign key can be NULL

**3. Key Constraints in Relationships**

For relationship WORKS_ON(Employee, Project):
```
If each employee works on at most one project:
  - Key: EmployeeID
  - This makes it 1:N or 1:1

If no restriction:
  - Key: (EmployeeID, ProjectID)
  - This makes it M:N
```

**4. Existence Dependencies**

Weak entity depends on strong entity:
```
EMPLOYEE ──1─ HAS ─N─ DEPENDENT
               ║
         (Identifying relationship - double diamond)

If employee is deleted, dependents are also deleted.
```

### Complete Example:

**University System Keys:**

```sql
-- Strong Entities with Keys
STUDENT(RollNo PK, Email UK, Name, DeptID FK)
COURSE(CourseID PK, CourseName, Credits)
FACULTY(FacultyID PK, Email UK, Name)
DEPARTMENT(DeptID PK, DeptName UK, Building)

-- Weak Entity
DEPENDENT(EmpID FK, DependentName PK (partial), Age, Relationship)
  Primary Key: (EmpID, DependentName)

-- Relationship Tables (M:N)
ENROLLMENT(RollNo FK, CourseID FK, Semester, Grade)
  Primary Key: (RollNo, CourseID, Semester)
  
TEACHES(FacultyID FK, CourseID FK, Semester, Year)
  Primary Key: (FacultyID, CourseID, Semester, Year)
```

**Constraints:**
```sql
-- Primary Keys
ALTER TABLE STUDENT ADD PRIMARY KEY (RollNo);

-- Foreign Keys with Referential Integrity
ALTER TABLE STUDENT 
ADD FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID);

ALTER TABLE ENROLLMENT
ADD FOREIGN KEY (RollNo) REFERENCES STUDENT(RollNo) ON DELETE CASCADE,
ADD FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID);

-- Unique Keys (Alternate Keys)
ALTER TABLE STUDENT ADD UNIQUE (Email);

-- Total Participation (NOT NULL foreign key)
ALTER TABLE LOAN 
ADD CustomerID INT NOT NULL,
ADD FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustID);
```

---


<a name="14"></a>
## 14. ER Diagram - Company Database

**Requirements:**
- Employees (EmpID, Name, Salary)
- Departments (DeptID, DeptName)
- Projects (ProjectID, ProjectName)
- Each employee works in ONE department
- Each employee may work on MULTIPLE projects

### ER Diagram:

```
                 DEPARTMENT
                ┌────────────┐
                │ *DeptID    │
                │  DeptName  │
                └─────┬──────┘
                      │
                      │ 1
                      │
                 WORKS_IN
                      │
                      │ M
                      │
                ┌─────┴──────┐
                │ EMPLOYEE   │
                ├────────────┤
                │ *EmpID     │
                │  Name      │
                │  Salary    │
                └─────┬──────┘
                      │
                      │ M
                      │
                  WORKS_ON
                      │
                      │ N
                      │
                ┌─────┴──────┐
                │  PROJECT   │
                ├────────────┤
                │ *ProjectID │
                │  ProjName  │
                └────────────┘

Cardinality Ratios:
- Employee : Department = M:1 (Many employees in one department)
- Employee : Project = M:N (Many employees work on many projects)
```

### Relational Schema:

```sql
-- Strong Entities
DEPARTMENT(DeptID, DeptName)
  Primary Key: DeptID

EMPLOYEE(EmpID, Name, Salary, DeptID)
  Primary Key: EmpID
  Foreign Key: DeptID REFERENCES DEPARTMENT(DeptID)

PROJECT(ProjectID, ProjectName)
  Primary Key: ProjectID

-- M:N Relationship requires junction table
WORKS_ON(EmpID, ProjectID, HoursWorked)
  Primary Key: (EmpID, ProjectID)
  Foreign Key: EmpID REFERENCES EMPLOYEE(EmpID)
  Foreign Key: ProjectID REFERENCES PROJECT(ProjectID)
```

### SQL Implementation:

```sql
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    DeptID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

CREATE TABLE PROJECT (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL
);

CREATE TABLE WORKS_ON (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT DEFAULT 0,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID) ON DELETE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID) ON DELETE CASCADE
);
```

### Sample Data:

```sql
INSERT INTO DEPARTMENT VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR');

INSERT INTO EMPLOYEE VALUES
(101, 'John Doe', 50000, 1),
(102, 'Jane Smith', 60000, 2),
(103, 'Bob Johnson', 55000, 2);

INSERT INTO PROJECT VALUES
(201, 'Website Redesign'),
(202, 'Mobile App'),
(203, 'Database Migration');

INSERT INTO WORKS_ON VALUES
(101, 201, 40),
(102, 201, 30),
(102, 202, 35),
(103, 202, 45),
(103, 203, 40);
```

---

<a name="15"></a>
## 15. Specialization and Generalization in EER Model

EER (Enhanced Entity-Relationship) Model extends basic ER with specialization, generalization, and aggregation.

### Specialization

**Definition:** Top-down design approach where higher-level entity is divided into lower-level specialized entities based on distinguishing characteristics.

**Process:**
- Start with superclass (general entity)
- Create subclasses (specialized entities)
- Subclasses inherit attributes from superclass
- Subclasses have additional specific attributes

**Example:**

```
        EMPLOYEE (Superclass)
        ┌──────────────┐
        │ *EmpID       │
        │  Name        │
        │  Email       │
        │  Salary      │
        └──────┬───────┘
               │
      ┌────────┴────────┐
      ↓                 ↓
  MANAGER           ENGINEER
  ┌───────────┐     ┌───────────┐
  │ Bonus     │     │ SkillType │
  │ DeptManage│     │ Certific. │
  └───────────┘     └───────────┘

Notation:
  d = disjoint (employee is EITHER manager OR engineer)
  ∪ = union/overlap (employee can be both)
```

**Constraints in Specialization:**

**1. Disjoint vs Overlapping:**
- **Disjoint (d):** Entity belongs to at most ONE subclass
  Example: EMPLOYEE is either MANAGER or ENGINEER (not both)
- **Overlapping (o):** Entity can belong to MULTIPLE subclasses
  Example: PERSON can be both EMPLOYEE and CUSTOMER

**2. Total vs Partial:**
- **Total:** Every superclass entity MUST be in at least one subclass
- **Partial:** Superclass entity may not belong to any subclass

**Notation:**
```
         PERSON
           │
      ┌────┴────┐
     d,t        (disjoint, total)
      ↓         ↓
  STUDENT   FACULTY
```

### Generalization

**Definition:** Bottom-up design approach where multiple entity types are combined into a higher-level generalized entity based on common features.

**Process:**
- Start with multiple specialized entity types
- Identify common attributes
- Create generalized superclass
- Common attributes move to superclass

**Example:**

```
Before Generalization:

CAR                    TRUCK
┌────────────┐        ┌────────────┐
│ VehicleID  │        │ VehicleID  │
│ Make       │        │ Make       │
│ Model      │        │ Model      │
│ Doors      │        │ Capacity   │
└────────────┘        └────────────┘

After Generalization:

        VEHICLE (Superclass)
        ┌────────────┐
        │ *VehicleID │
        │  Make      │
        │  Model     │
        └──────┬─────┘
               │
        ┌──────┴──────┐
        ↓             ↓
      CAR           TRUCK
   ┌───────┐     ┌──────────┐
   │ Doors │     │ Capacity │
   └───────┘     └──────────┘
```

### Comparison:

| Aspect | Specialization | Generalization |
|--------|---------------|----------------|
| Direction | Top-down | Bottom-up |
| Start | Superclass | Subclasses |
| Process | Divide | Combine |
| Design | Refinement | Synthesis |

### Attribute Inheritance

Subclasses inherit all attributes and relationships from superclass.

Example:
```
PERSON(PersonID, Name, Address)
  ↓
STUDENT inherits: PersonID, Name, Address
        adds: RollNo, Department, CGPA
  
EMPLOYEE inherits: PersonID, Name, Address
         adds: EmpID, Salary, Department
```

### Complete Example - Banking System:

```
                 ACCOUNT (Superclass)
                 ┌──────────────┐
                 │ *AccountNo   │
                 │  Balance     │
                 │  DateOpened  │
                 │  CustomerID  │
                 └──────┬───────┘
                        │
             ┌──────────┼──────────┐
             │          │          │
          SAVINGS   CURRENT    FIXED_DEPOSIT
         ┌────────┐ ┌───────┐ ┌────────────┐
         │MinBal  │ │Overdft│ │ Maturity   │
         │IntRate │ │Charge │ │ IntRate    │
         └────────┘ └───────┘ └────────────┘

Constraints: Disjoint, Total
(Account must be one type, cannot be multiple types)
```

### SQL Implementation:

**Approach 1: Single Table (for all subclasses)**
```sql
CREATE TABLE ACCOUNT (
    AccountNo INT PRIMARY KEY,
    Balance DECIMAL(15,2),
    DateOpened DATE,
    AccountType VARCHAR(20), -- 'SAVINGS', 'CURRENT', 'FD'
    -- Savings specific
    MinBalance DECIMAL(15,2),
    SavingsIntRate DECIMAL(5,2),
    -- Current specific
    OverdraftLimit DECIMAL(15,2),
    OverdraftCharge DECIMAL(5,2),
    -- FD specific
    MaturityDate DATE,
    FDIntRate DECIMAL(5,2)
);
```

**Approach 2: Separate Tables**
```sql
CREATE TABLE ACCOUNT (
    AccountNo INT PRIMARY KEY,
    Balance DECIMAL(15,2),
    DateOpened DATE
);

CREATE TABLE SAVINGS_ACCOUNT (
    AccountNo INT PRIMARY KEY,
    MinBalance DECIMAL(15,2),
    InterestRate DECIMAL(5,2),
    FOREIGN KEY (AccountNo) REFERENCES ACCOUNT(AccountNo)
);

CREATE TABLE CURRENT_ACCOUNT (
    AccountNo INT PRIMARY KEY,
    OverdraftLimit DECIMAL(15,2),
    OverdraftCharge DECIMAL(5,2),
    FOREIGN KEY (AccountNo) REFERENCES ACCOUNT(AccountNo)
);

CREATE TABLE FIXED_DEPOSIT (
    AccountNo INT PRIMARY KEY,
    MaturityDate DATE,
    InterestRate DECIMAL(5,2),
    FOREIGN KEY (AccountNo) REFERENCES ACCOUNT(AccountNo)
);
```

---

<a name="16"></a>
## 16. ER Diagram - Hospital System

**Requirements:**
- Patients (PatientID, Name, Disease)
- Doctors (DoctorID, Name, Specialization)
- Rooms (RoomNo, Type)
- Each patient treated by ONE doctor
- Each patient admitted in ONE room

### ER Diagram:

```
   DOCTOR                PATIENT                ROOM
  ┌──────────┐         ┌──────────┐          ┌──────────┐
  │*DoctorID │         │*PatientID│          │*RoomNo   │
  │ Name     │         │ Name     │          │ Type     │
  │ Special. │         │ Disease  │          │ Capacity │
  └────┬─────┘         └────┬─────┘          └────┬─────┘
       │                    │                     │
       │ 1                  │ 1                   │ 1
       │                    │                     │
    TREATS            ADMITTED_IN              OCCUPIES
       │                    │                     │
       │ M                  │ M                   │ M
       │                    │                     │
       └────────────────────┘─────────────────────┘

Relationships:
- TREATS: Doctor treats Patient (1:M)
- ADMITTED_IN: Patient admitted in Room (1:1 currently, M:1 if multiple patients per room)
```

### Relational Schema:

```sql
DOCTOR(DoctorID, Name, Specialization)
  Primary Key: DoctorID

ROOM(RoomNo, Type, Capacity)
  Primary Key: RoomNo

PATIENT(PatientID, Name, Disease, DoctorID, RoomNo, AdmissionDate)
  Primary Key: PatientID
  Foreign Key: DoctorID REFERENCES DOCTOR(DoctorID)
  Foreign Key: RoomNo REFERENCES ROOM(RoomNo)
```

### SQL Implementation:

```sql
CREATE TABLE DOCTOR (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Specialization VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE ROOM (
    RoomNo VARCHAR(10) PRIMARY KEY,
    Type VARCHAR(20) CHECK (Type IN ('General', 'ICU', 'Private', 'Semi-Private')),
    Floor INT,
    Capacity INT DEFAULT 1
);

CREATE TABLE PATIENT (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Disease VARCHAR(100),
    Age INT,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
    DoctorID INT NOT NULL,
    RoomNo VARCHAR(10) NOT NULL,
    AdmissionDate DATE DEFAULT CURRENT_DATE,
    DischargeDate DATE,
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID),
    FOREIGN KEY (RoomNo) REFERENCES ROOM(RoomNo),
    CHECK (DischargeDate IS NULL OR DischargeDate >= AdmissionDate)
);
```

### Enhanced Version with Additional Entities:

```sql
-- Treatment records
CREATE TABLE TREATMENT (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    TreatmentDate DATE,
    Diagnosis VARCHAR(200),
    Prescription TEXT,
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

-- Lab Tests
CREATE TABLE LAB_TEST (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TestType VARCHAR(50),
    TestDate DATE,
    Results TEXT,
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);

-- Billing
CREATE TABLE BILL (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10,2),
    BillDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);
```

### Sample Data:

```sql
INSERT INTO DOCTOR VALUES
(1, 'Dr. Smith', 'Cardiology', '1234567890', 'smith@hospital.com'),
(2, 'Dr. Johnson', 'Neurology', '2345678901', 'johnson@hospital.com'),
(3, 'Dr. Williams', 'Orthopedics', '3456789012', 'williams@hospital.com');

INSERT INTO ROOM VALUES
('101', 'ICU', 1, 1),
('102', 'General', 1, 4),
('201', 'Private', 2, 1),
('202', 'Semi-Private', 2, 2);

INSERT INTO PATIENT VALUES
(1001, 'Alice Brown', 'Heart Disease', 45, 'F', 1, '101', '2025-02-01', NULL),
(1002, 'Bob Green', 'Migraine', 35, 'M', 2, '201', '2025-02-05', NULL),
(1003, 'Charlie White', 'Fracture', 28, 'M', 3, '102', '2025-02-07', NULL);
```

---

<a name="17"></a>
## 17. Steps to Convert ER Diagram into Relational Tables

Systematic approach to transform ER model into relational schema.

### Step 1: Convert Strong Entities to Tables

**Rule:** Each strong entity becomes a table with its attributes as columns.

Example:
```
ER: STUDENT(RollNo, Name, Age, Department)

Relational:
CREATE TABLE STUDENT (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Department VARCHAR(30)
);
```

### Step 2: Convert Weak Entities to Tables

**Rule:** Include partial key + foreign key of owner entity.

Example:
```
ER: EMPLOYEE ──< DEPENDENT(Name, Age, Relationship)
    (EmpID)      (dependent on Employee)

Relational:
CREATE TABLE DEPENDENT (
    EmpID INT,
    Name VARCHAR(50),
    Age INT,
    Relationship VARCHAR(20),
    PRIMARY KEY (EmpID, Name),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID) ON DELETE CASCADE
);
```

### Step 3: Convert Binary Relationships

**3a. One-to-One (1:1) Relationship**

**Option 1:** Add foreign key in either table
```
ER: EMPLOYEE ─1:1─ MANAGES ─1:1─ DEPARTMENT

Relational (FK in Employee):
EMPLOYEE(EmpID, Name, ManagedDeptID)
  FK: ManagedDeptID → DEPARTMENT(DeptID)

OR (FK in Department):
DEPARTMENT(DeptID, DeptName, ManagerID)
  FK: ManagerID → EMPLOYEE(EmpID)
```

**Option 2:** Merge into one table (if entities are tightly coupled)
```
EMPLOYEE_DEPT(EmpID, Name, DeptID, DeptName)
```

**3b. One-to-Many (1:N) Relationship**

**Rule:** Add foreign key in the "many" side table.

Example:
```
ER: DEPARTMENT ─1─ EMPLOYS ─M─ EMPLOYEE

Relational:
DEPARTMENT(DeptID, DeptName)
EMPLOYEE(EmpID, Name, Salary, DeptID)
  FK: DeptID → DEPARTMENT(DeptID)
```

**3c. Many-to-Many (M:N) Relationship**

**Rule:** Create a separate junction/relationship table.

Example:
```
ER: STUDENT ─M─ ENROLLS ─N─ COURSE

Relational:
STUDENT(RollNo, Name, Department)
COURSE(CourseID, CourseName, Credits)
ENROLLMENT(RollNo, CourseID, Semester, Grade)
  PK: (RollNo, CourseID, Semester)
  FK: RollNo → STUDENT(RollNo)
  FK: CourseID → COURSE(CourseID)
```

### Step 4: Convert Multi-valued Attributes

**Rule:** Create separate table with entity's primary key.

Example:
```
ER: EMPLOYEE has {PhoneNumbers}

Relational:
EMPLOYEE(EmpID, Name, Salary)
EMPLOYEE_PHONE(EmpID, PhoneNumber)
  PK: (EmpID, PhoneNumber)
  FK: EmpID → EMPLOYEE(EmpID)
```

### Step 5: Convert Composite Attributes

**Rule:** Flatten into simple attributes OR keep as single column.

Example:
```
ER: STUDENT has composite attribute Name(FirstName, LastName)

Option 1 (Flatten):
STUDENT(RollNo, FirstName, MiddleName, LastName, ...)

Option 2 (Single column):
STUDENT(RollNo, FullName, ...)
```

Example with Address:
```
ER: Address(Street, City, State, Pincode)

Relational:
CUSTOMER(CustID, Name, Street, City, State, Pincode)
```

### Step 6: Handle Derived Attributes

**Rule:** Generally NOT stored. Computed when needed.

Exception: Store if computation is expensive or frequently accessed.

Example:
```
ER: EMPLOYEE(EmpID, Name, DateOfBirth, Age)
    Age is derived from DateOfBirth

Relational (don't store Age):
EMPLOYEE(EmpID, Name, DateOfBirth)

Calculate Age in query:
SELECT EmpID, Name, 
       TIMESTAMPDIFF(YEAR, DateOfBirth, CURRENT_DATE) AS Age
FROM EMPLOYEE;
```

### Step 7: Convert Ternary Relationships

**Rule:** Create table with foreign keys from all participating entities.

Example:
```
ER: SUPPLIER ─┐
              ├─ SUPPLIES ─> (Quantity, Date)
   PROJECT ───┘─ PART

Relational:
SUPPLIER(SupplierID, Name)
PROJECT(ProjectID, ProjectName)
PART(PartID, PartName)
SUPPLIES(SupplierID, ProjectID, PartID, Quantity, Date)
  PK: (SupplierID, ProjectID, PartID)
  FK: SupplierID → SUPPLIER(SupplierID)
  FK: ProjectID → PROJECT(ProjectID)
  FK: PartID → PART(PartID)
```

### Step 8: Convert Specialization/Generalization

**Approach 1: Single Table (for all subclasses)**
```
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    EmployeeType VARCHAR(20),
    Salary DECIMAL(10,2),
    -- Manager specific
    Bonus DECIMAL(10,2),
    -- Engineer specific
    SkillType VARCHAR(50)
);
```

**Approach 2: Table Per Subclass**
```
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE MANAGER (
    EmpID INT PRIMARY KEY,
    Bonus DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID)
);

CREATE TABLE ENGINEER (
    EmpID INT PRIMARY KEY,
    SkillType VARCHAR(50),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID)
);
```

**Approach 3: Table Per Concrete Class (no superclass table)**
```
CREATE TABLE MANAGER (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);

CREATE TABLE ENGINEER (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2),
    SkillType VARCHAR(50)
);
```

### Complete Conversion Example:

**ER Diagram:**
```
DEPARTMENT ─1─ EMPLOYS ─M─ EMPLOYEE ─M─ WORKS_ON ─N─ PROJECT
                            (has {Phone})
```

**Relational Tables:**
```sql
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(100)
);

CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Salary DECIMAL(10,2),
    DeptID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

-- Multi-valued attribute
CREATE TABLE EMPLOYEE_PHONE (
    EmpID INT,
    PhoneNumber VARCHAR(15),
    PhoneType VARCHAR(20) DEFAULT 'Mobile',
    PRIMARY KEY (EmpID, PhoneNumber),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID) ON DELETE CASCADE
);

CREATE TABLE PROJECT (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Budget DECIMAL(15,2),
    StartDate DATE
);

-- M:N relationship
CREATE TABLE WORKS_ON (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT DEFAULT 0,
    Role VARCHAR(50),
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID) ON DELETE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID) ON DELETE CASCADE
);
```

---


<a name="18"></a>
## 18. ER Diagram - University System

**Requirements:**
- Students (RollNo, Name)
- Courses (CourseID, CourseName)
- Faculty (FacultyID, Name)
- Student enrolls in many courses
- Faculty teaches many courses

### ER Diagram:

```
   STUDENT               COURSE              FACULTY
  ┌──────────┐         ┌──────────┐        ┌──────────┐
  │*RollNo   │         │*CourseID │        │*FacultyID│
  │ Name     │         │ CourseName        │ Name     │
  │ Email    │         │ Credits  │        │ Dept     │
  │ Year     │         │ Dept     │        │ Email    │
  └────┬─────┘         └────┬─────┘        └────┬─────┘
       │                    │                   │
       │ M                  │ M                 │ 1
       │                    │                   │
    ENROLLS             ─────┴────           TEACHES
       │                          │              │
       │ N                        │ M            │ M
       │                          │              │
       └──────────────────────────┘──────────────┘

Relationships:
- ENROLLS: Student enrolls in Course (M:N)
  Attributes: Semester, Year, Grade
  
- TEACHES: Faculty teaches Course (1:M) 
  Attributes: Semester, Year, Section
```

### Relational Schema:

```sql
STUDENT(RollNo, Name, Email, Year, DeptID)
  PK: RollNo
  
COURSE(CourseID, CourseName, Credits, DeptID)
  PK: CourseID
  
FACULTY(FacultyID, Name, Department, Email, Phone)
  PK: FacultyID
  
ENROLLMENT(RollNo, CourseID, Semester, Year, Grade)
  PK: (RollNo, CourseID, Semester, Year)
  FK: RollNo → STUDENT(RollNo)
  FK: CourseID → COURSE(CourseID)
  
TEACHES(FacultyID, CourseID, Semester, Year, Section)
  PK: (FacultyID, CourseID, Semester, Year)
  FK: FacultyID → FACULTY(FacultyID)
  FK: CourseID → COURSE(CourseID)
```

### SQL Implementation:

```sql
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE,
    Building VARCHAR(50)
);

CREATE TABLE STUDENT (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Year INT CHECK (Year BETWEEN 1 AND 4),
    DeptID INT,
    CGPA DECIMAL(3,2),
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

CREATE TABLE COURSE (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits > 0),
    DeptID INT,
    Syllabus TEXT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

CREATE TABLE FACULTY (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department INT,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Specialization VARCHAR(100),
    FOREIGN KEY (Department) REFERENCES DEPARTMENT(DeptID)
);

CREATE TABLE ENROLLMENT (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    RollNo INT NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    Semester VARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    Grade CHAR(2),
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    UNIQUE (RollNo, CourseID, Semester, Year),
    FOREIGN KEY (RollNo) REFERENCES STUDENT(RollNo) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

CREATE TABLE TEACHES (
    TeachingID INT PRIMARY KEY AUTO_INCREMENT,
    FacultyID INT NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    Semester VARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    Section VARCHAR(5),
    Classroom VARCHAR(20),
    UNIQUE (FacultyID, CourseID, Semester, Year, Section),
    FOREIGN KEY (FacultyID) REFERENCES FACULTY(FacultyID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);
```

---

<a name="19"></a>
## 19. Extended ER Features with Example

EER (Enhanced Entity-Relationship) Model adds specialization, generalization, aggregation, and other advanced concepts.

### 1. Specialization & Generalization

Already covered in Question 15. Key points:
- **Specialization:** Top-down (divide superclass)
- **Generalization:** Bottom-up (combine subclasses)
- **Constraints:** Disjoint/Overlapping, Total/Partial

### 2. Attribute Inheritance

Subclasses inherit ALL attributes and relationships from superclass.

Example:
```
PERSON(PersonID, Name, Address, Phone)
  │
  ├─> STUDENT(RollNo, Department, CGPA)
  │    Inherits: PersonID, Name, Address, Phone
  │
  └─> EMPLOYEE(EmpID, Salary, Designation)
       Inherits: PersonID, Name, Address, Phone
```

### 3. Aggregation

**Definition:** Treating a relationship as a higher-level entity.

**Use Case:** When a relationship needs to participate in another relationship.

**Example: Project Management**

```
EMPLOYEE ─── WORKS_ON ─── PROJECT
     (Cannot directly relate to Manager)

Using Aggregation:

EMPLOYEE ────┐
             │ WORKS_ON (Aggregated)
PROJECT ─────┤
             │
         MANAGED_BY
             │
         MANAGER
             
Higher-level relationship: MANAGED_BY
Lower-level relationship: WORKS_ON (treated as entity)
```

**SQL Implementation:**
```sql
-- Original M:N relationship
CREATE TABLE WORKS_ON (
    EmpID INT,
    ProjectID INT,
    Hours INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID)
);

-- Aggregation: Manager manages (Employee, Project) pair
CREATE TABLE PROJECT_MANAGEMENT (
    ManagerID INT,
    EmpID INT,
    ProjectID INT,
    StartDate DATE,
    PRIMARY KEY (ManagerID, EmpID, ProjectID),
    FOREIGN KEY (ManagerID) REFERENCES MANAGER(ManagerID),
    FOREIGN KEY (EmpID, ProjectID) REFERENCES WORKS_ON(EmpID, ProjectID)
);
```

### 4. Multiple Inheritance

Subclass inherits from multiple superclasses.

**Example:**
```
    STUDENT          EMPLOYEE
       │                │
       └────────┬───────┘
                │
         TEACHING_ASSISTANT
         (Inherits from both Student and Employee)
```

**SQL Implementation:**
```sql
CREATE TABLE PERSON (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(200)
);

CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    PersonID INT UNIQUE,
    RollNo VARCHAR(20),
    Department VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);

CREATE TABLE EMPLOYEE (
    EmployeeID INT PRIMARY KEY,
    PersonID INT UNIQUE,
    Salary DECIMAL(10,2),
    Designation VARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);

-- Teaching Assistant inherits from both
CREATE TABLE TEACHING_ASSISTANT (
    TAID INT PRIMARY KEY,
    StudentID INT,
    EmployeeID INT,
    Course VARCHAR(50),
    HoursPerWeek INT,
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);
```

### 5. Union Types (Categories)

**Definition:** Subclass that is a subset of UNION of multiple superclasses.

**Example: Vehicle Registration**

```
CAR ──┐
      ├── VEHICLE_REGISTRATION
TRUCK─┤    (A registration can be for Car OR Truck OR Motorcycle)
      │
MOTORCYCLE─┘

This is a UNION type (category)
```

**SQL Implementation:**
```sql
CREATE TABLE VEHICLE_REGISTRATION (
    RegID INT PRIMARY KEY,
    VehicleType VARCHAR(20), -- 'CAR', 'TRUCK', 'MOTORCYCLE'
    VehicleID INT,
    -- Other common attributes
    RegDate DATE,
    OwnerName VARCHAR(50)
);

CREATE TABLE CAR (
    CarID INT PRIMARY KEY,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Doors INT
);

CREATE TABLE TRUCK (
    TruckID INT PRIMARY KEY,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Capacity INT
);
```

### Complete EER Example: University System

```
                    PERSON
                    ├──────┤
          ┌─────────┤ PID  │─────────┐
          │         │ Name │         │
          │         └──────┘         │
          │ Generalization           │
          ↓                          ↓
       STUDENT                   FACULTY
       ├──────┤                  ├───────┤
       │RollNo│                  │FacultyID
       │Dept  │                  │Salary │
       └──┬───┘                  └───┬───┘
          │                          │
          │                    Specialization
          │                    (d, t)  │
          │                          ↓
          │              ┌──────────────────┐
          │              │                  │
          │          PROFESSOR         LECTURER
          │          ├────────┤       ├────────┤
          │          │Rank    │       │Contract│
          │          └────────┘       └────────┘
          │
          │ Aggregation
          ↓
    ┌─────────┐
    │ENROLLS  │◇──── COURSE
    └─────────┘
         │
    ADVISED_BY
         │
         ↓
      FACULTY
```

---

<a name="20"></a>
## 20. ER Diagram - Banking System

**Requirements:**
- Customers (CustID, Name)
- Accounts (AccNo, Type, Balance)
- Loans (LoanNo, Amount)
- Customer can have multiple accounts and loans

### ER Diagram:

```
         CUSTOMER
         ┌──────────┐
         │*CustID   │
         │ Name     │
         │ Address  │
         │ Phone    │
         └────┬─────┘
              │
       ┌──────┴────────┐
       │               │
       │ M             │ M
       │               │
     HAS_ACCOUNT    HAS_LOAN
       │               │
       │ N             │ N
       │               │
  ┌────┴─────┐    ┌───┴────┐
  │ ACCOUNT  │    │  LOAN  │
  ├──────────┤    ├────────┤
  │*AccNo    │    │*LoanNo │
  │ Type     │    │ Amount │
  │ Balance  │    │ IntRate│
  │ OpenDate │    │ StartDt│
  └──────────┘    └────────┘

Cardinality:
- Customer : Account = 1:M (One customer has many accounts)
- Customer : Loan = 1:M (One customer has many loans)
```

### Relational Schema:

```sql
CUSTOMER(CustID, Name, Address, Phone, Email, DateOfBirth)
  PK: CustID

ACCOUNT(AccNo, Type, Balance, OpenDate, CustID)
  PK: AccNo
  FK: CustID → CUSTOMER(CustID)

LOAN(LoanNo, Amount, InterestRate, StartDate, Duration, CustID)
  PK: LoanNo
  FK: CustID → CUSTOMER(CustID)
```

### SQL Implementation:

```sql
CREATE TABLE CUSTOMER (
    CustID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(200),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE,
    SSN VARCHAR(20) UNIQUE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ACCOUNT (
    AccNo VARCHAR(20) PRIMARY KEY,
    Type VARCHAR(20) CHECK (Type IN ('Savings', 'Current', 'Fixed Deposit', 'Salary')),
    Balance DECIMAL(15,2) DEFAULT 0 CHECK (Balance >= 0),
    OpenDate DATE DEFAULT CURRENT_DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    CustID INT NOT NULL,
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID) ON DELETE CASCADE
);

CREATE TABLE LOAN (
    LoanNo VARCHAR(20) PRIMARY KEY,
    Amount DECIMAL(15,2) CHECK (Amount > 0),
    InterestRate DECIMAL(5,2),
    StartDate DATE DEFAULT CURRENT_DATE,
    Duration INT, -- in months
    Status VARCHAR(20) DEFAULT 'Active',
    CustID INT NOT NULL,
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID)
);

-- Transactions
CREATE TABLE TRANSACTION (
    TransID INT PRIMARY KEY AUTO_INCREMENT,
    AccNo VARCHAR(20) NOT NULL,
    Type VARCHAR(20) CHECK (Type IN ('Deposit', 'Withdrawal', 'Transfer')),
    Amount DECIMAL(15,2) CHECK (Amount > 0),
    TransDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Description VARCHAR(200),
    FOREIGN KEY (AccNo) REFERENCES ACCOUNT(AccNo)
);

-- Loan Payments
CREATE TABLE LOAN_PAYMENT (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    LoanNo VARCHAR(20) NOT NULL,
    Amount DECIMAL(15,2),
    PaymentDate DATE DEFAULT CURRENT_DATE,
    Principal DECIMAL(15,2),
    Interest DECIMAL(15,2),
    FOREIGN KEY (LoanNo) REFERENCES LOAN(LoanNo)
);
```

### Sample Data and Queries:

```sql
-- Insert customers
INSERT INTO CUSTOMER (Name, Address, Phone, Email) VALUES
('John Doe', '123 Main St', '1234567890', 'john@email.com'),
('Jane Smith', '456 Oak Ave', '2345678901', 'jane@email.com');

-- Insert accounts
INSERT INTO ACCOUNT (AccNo, Type, Balance, CustID) VALUES
('ACC001', 'Savings', 50000, 1),
('ACC002', 'Current', 75000, 1),
('ACC003', 'Savings', 100000, 2);

-- Insert loans
INSERT INTO LOAN (LoanNo, Amount, InterestRate, Duration, CustID) VALUES
('LOAN001', 500000, 8.5, 60, 1),
('LOAN002', 1000000, 9.0, 120, 2);

-- Query: Customers with multiple accounts
SELECT C.Name, COUNT(A.AccNo) AS AccountCount
FROM CUSTOMER C
JOIN ACCOUNT A ON C.CustID = A.CustID
GROUP BY C.CustID, C.Name
HAVING COUNT(A.AccNo) > 1;

-- Query: Total balance per customer
SELECT C.Name, SUM(A.Balance) AS TotalBalance
FROM CUSTOMER C
JOIN ACCOUNT A ON C.CustID = A.CustID
GROUP BY C.CustID, C.Name;

-- Query: Customers with both accounts and loans
SELECT DISTINCT C.Name
FROM CUSTOMER C
WHERE EXISTS (SELECT 1 FROM ACCOUNT WHERE CustID = C.CustID)
  AND EXISTS (SELECT 1 FROM LOAN WHERE CustID = C.CustID);
```

---

[Continuing with remaining questions 21-28...]

<a name="21"></a>
## 21. Relational Data Model with Features

(See detailed explanation in Question 6 above)

**Summary:**
- Tables (Relations) with rows (tuples) and columns (attributes)
- Mathematical foundation: Set theory, relational algebra
- Features: Simplicity, data independence, integrity constraints, powerful query language
- Operations: Selection, Projection, Join, Union, etc.

---

<a name="22"></a>
## 22. Compare Conceptual, Logical, and Physical Design

### Conceptual Design

**Purpose:** High-level view independent of DBMS

**Characteristics:**
- Abstract representation
- Uses ER/EER diagrams
- Focus on "what" data, not "how"
- Platform-independent
- Represents business requirements

**Output:** ER Diagram

**Example:**
```
Entities: STUDENT, COURSE
Relationship: ENROLLS (M:N)
Attributes: Student(RollNo, Name), Course(CourseID, Name)
```

**Users:** Business analysts, stakeholders, designers

### Logical Design

**Purpose:** Detailed structure for specific data model (usually relational)

**Characteristics:**
- Converts ER to tables
- Applies normalization
- Defines primary/foreign keys
- Still independent of physical implementation
- Focuses on data organization

**Output:** Relational schema with constraints

**Example:**
```sql
STUDENT(RollNo PK, Name, DeptID FK)
COURSE(CourseID PK, CourseName, Credits)
ENROLLMENT(StudentID FK, CourseID FK, Grade)
  PK: (StudentID, CourseID)
```

**Users:** Database designers, DBAs

### Physical Design

**Purpose:** Implementation details for specific DBMS

**Characteristics:**
- Storage structures and file organization
- Index design and partitioning
- Performance optimization
- DBMS-specific features
- Focuses on "how" to store efficiently

**Output:** Physical schema with indexes, storage parameters

**Example:**
```sql
CREATE TABLE STUDENT (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT
) ENGINE=InnoDB;

CREATE INDEX idx_student_dept ON STUDENT(DeptID) USING BTREE;
PARTITION BY RANGE (Year);
```

**Users:** DBAs, system administrators

### Comparison Table:

| Aspect | Conceptual | Logical | Physical |
|--------|-----------|---------|----------|
| **Abstraction** | Highest | Medium | Lowest |
| **Focus** | What data | How organized | How stored |
| **Tool** | ER Diagram | Relational Schema | DDL Statements |
| **DBMS Dependent** | No | Partially | Yes |
| **Users** | Business Users | Designers | DBAs |
| **Example** | Entity STUDENT | Table STUDENT | B-tree index on RollNo |
| **Details** | Entities, Relationships | Tables, Keys | Files, Indexes |
| **Normalization** | Not applied | Applied (3NF, BCNF) | May denormalize |

---

<a name="23"></a>
## 23. ER Diagram - Library System

**Requirements:**
- Books (BookID, Title, Author)
- Members (MemberID, Name)
- Transactions (IssueDate, ReturnDate)
- Member can borrow multiple books

### ER Diagram:

```
    MEMBER                BOOK
   ┌──────────┐         ┌──────────┐
   │*MemberID │         │*BookID   │
   │ Name     │         │ Title    │
   │ Email    │         │ Author   │
   │ Phone    │         │ ISBN     │
   │ Address  │         │ Publisher│
   └────┬─────┘         └────┬─────┘
        │                    │
        │ M                  │ M
        │                    │
      BORROWS (Transaction)
        │
    Attributes: IssueDate, ReturnDate, Fine

Cardinality: M:N
- One member can borrow many books
- One book can be borrowed by many members (over time)
```

### Relational Schema:

```sql
MEMBER(MemberID, Name, Email, Phone, Address, MembershipDate, Type)
  PK: MemberID

BOOK(BookID, Title, Author, ISBN, Publisher, Category, TotalCopies, AvailableCopies)
  PK: BookID

TRANSACTION(TransactionID, MemberID, BookID, IssueDate, DueDate, ReturnDate, Fine, Status)
  PK: TransactionID
  FK: MemberID → MEMBER(MemberID)
  FK: BookID → BOOK(BookID)
```

### SQL Implementation:

```sql
CREATE TABLE MEMBER (
    MemberID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200),
    MembershipDate DATE DEFAULT CURRENT_DATE,
    MembershipType VARCHAR(20) DEFAULT 'Regular',
    Status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE BOOK (
    BookID VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    Publisher VARCHAR(100),
    Category VARCHAR(50),
    PublicationYear INT,
    TotalCopies INT DEFAULT 1,
    AvailableCopies INT DEFAULT 1,
    CHECK (AvailableCopies >= 0 AND AvailableCopies <= TotalCopies)
);

CREATE TABLE TRANSACTION (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID VARCHAR(20) NOT NULL,
    BookID VARCHAR(20) NOT NULL,
    IssueDate DATE DEFAULT CURRENT_DATE,
    DueDate DATE,
    ReturnDate DATE,
    Fine DECIMAL(10,2) DEFAULT 0,
    Status VARCHAR(20) DEFAULT 'Issued',
    FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
    FOREIGN KEY (BookID) REFERENCES BOOK(BookID),
    CHECK (ReturnDate IS NULL OR ReturnDate >= IssueDate),
    CHECK (DueDate > IssueDate)
);

-- Trigger to update available copies
DELIMITER //
CREATE TRIGGER after_book_issue
AFTER INSERT ON TRANSACTION
FOR EACH ROW
BEGIN
    UPDATE BOOK
    SET AvailableCopies = AvailableCopies - 1
    WHERE BookID = NEW.BookID;
END//

CREATE TRIGGER after_book_return
AFTER UPDATE ON TRANSACTION
FOR EACH ROW
BEGIN
    IF NEW.ReturnDate IS NOT NULL AND OLD.ReturnDate IS NULL THEN
        UPDATE BOOK
        SET AvailableCopies = AvailableCopies + 1
        WHERE BookID = NEW.BookID;
    END IF;
END//
DELIMITER ;
```

---

<a name="24"></a>
## 24. Relationship Constraints

Constraints that govern how entities participate in relationships.

### 1. Cardinality Constraints

Specifies maximum number of relationship instances.

**Types:**
- **1:1 (One-to-One):** Each entity relates to at most one other
- **1:N (One-to-Many):** Entity in "one" side relates to many
- **M:N (Many-to-Many):** Entities on both sides relate to many

(See detailed examples in Question 11)

### 2. Participation Constraints

Specifies minimum participation (whether mandatory or optional).

**Total Participation:**
- Every entity MUST participate
- Minimum = 1
- Double line in ER diagram

**Partial Participation:**
- Entity may or may not participate
- Minimum = 0
- Single line in ER diagram

### 3. Key Constraints on Relationships

Determines primary key of relationship set.

**Example:**
```
EMPLOYEE ── WORKS_ON ── PROJECT

If each employee works on at most one project:
  Key of WORKS_ON: EmployeeID

If each project has at most one employee:
  Key of WORKS_ON: ProjectID

If M:N (many employees on many projects):
  Key of WORKS_ON: (EmployeeID, ProjectID)
```

### 4. Existence Dependencies (Weak Entity)

Weak entity's existence depends on owner entity.

**Example:**
```
EMPLOYEE ──< DEPENDENT
(Dependent cannot exist without Employee)

If employee deleted → dependents also deleted
```

### 5. Structural Constraints

Combination of cardinality and participation.

**Notation:** (min, max)

**Examples:**
```
EMPLOYEE (1,1) WORKS_IN (1,N) DEPARTMENT
- Employee works in exactly 1 department (total participation)
- Department has 1 or more employees

STUDENT (0,6) ENROLLS (0,100) COURSE
- Student can enroll in 0 to 6 courses
- Course can have 0 to 100 students
```

---

<a name="25"></a>
## 25. Differentiate Physical vs Logical Data Independence

(See detailed explanation in Question 7)

### Summary Comparison:

**Physical Data Independence:**
- **Level:** Internal → Conceptual
- **Changes:** Storage, indexes, file organization
- **Impact:** None on logical schema or applications
- **Difficulty:** Easier to achieve
- **Example:** Migrating from HDD to SSD
- **Mechanism:** DBMS handles mapping

**Logical Data Independence:**
- **Level:** Conceptual → External
- **Changes:** Tables, attributes, relationships
- **Impact:** Views may need adjustment
- **Difficulty:** Harder to achieve
- **Example:** Splitting tables (normalization)
- **Mechanism:** Views provide compatibility layer

| Aspect | Physical | Logical |
|--------|----------|---------|
| Changes | Storage | Schema |
| Impact | None | Minimal |
| Frequency | Common | Rare |
| Difficulty | Easy | Hard |
| Example | Add index | Add column |

---

<a name="26"></a>
## 26. EER Diagram - Employee Specialization

**Requirements:**
- Employees specialize into Managers and Engineers
- Managers have Bonus attribute
- Engineers have SkillType attribute

### EER Diagram:

```
           EMPLOYEE (Superclass)
           ┌────────────────┐
           │ *EmployeeID    │
           │  Name          │
           │  Email         │
           │  Salary        │
           │  Department    │
           │  DateOfJoining │
           └────────┬───────┘
                    │
              Specialization
              (disjoint, total)
                    │
           ┌────────┴────────┐
           │                 │
           ↓                 ↓
       MANAGER           ENGINEER
      ┌─────────┐       ┌──────────┐
      │ Bonus   │       │ SkillType│
      │ DeptMgd │       │ Certific.│
      └─────────┘       └──────────┘

Constraints:
d = disjoint (employee is either manager OR engineer, not both)
t = total (every employee must be one of the two)
```

### SQL Implementation:

**Approach 1: Single Table with Type Discriminator**

```sql
CREATE TABLE EMPLOYEE (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    DateOfJoining DATE,
    EmployeeType VARCHAR(20) NOT NULL CHECK (EmployeeType IN ('Manager', 'Engineer')),
    -- Manager attributes
    Bonus DECIMAL(10,2),
    ManagedDepartment VARCHAR(50),
    -- Engineer attributes
    SkillType VARCHAR(50),
    Certifications TEXT
);
```

**Approach 2: Separate Tables**

```sql
-- Superclass table
CREATE TABLE EMPLOYEE (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    DateOfJoining DATE
);

-- Subclass: Manager
CREATE TABLE MANAGER (
    EmployeeID INT PRIMARY KEY,
    Bonus DECIMAL(10,2),
    ManagedDepartment VARCHAR(50),
    ManagementLevel VARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID) ON DELETE CASCADE
);

-- Subclass: Engineer
CREATE TABLE ENGINEER (
    EmployeeID INT PRIMARY KEY,
    SkillType VARCHAR(50),
    Certifications TEXT,
    ProjectsCompleted INT DEFAULT 0,
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID) ON DELETE CASCADE
);
```

**Approach 3: Table Per Class (No Superclass Table)**

```sql
CREATE TABLE MANAGER (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    DateOfJoining DATE,
    Bonus DECIMAL(10,2),
    ManagedDepartment VARCHAR(50)
);

CREATE TABLE ENGINEER (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    DateOfJoining DATE,
    SkillType VARCHAR(50),
    Certifications TEXT
);
```

### Sample Data:

```sql
-- Using Approach 2

INSERT INTO EMPLOYEE VALUES
(1, 'Alice Johnson', 'alice@company.com', 90000, 'IT', '2020-01-15'),
(2, 'Bob Smith', 'bob@company.com', 80000, 'IT', '2019-06-01'),
(3, 'Charlie Brown', 'charlie@company.com', 70000, 'Engineering', '2021-03-10');

INSERT INTO MANAGER VALUES
(1, 15000, 'IT Department', 'Senior Manager');

INSERT INTO ENGINEER VALUES
(2, 'Full Stack Developer', 'AWS Certified, Oracle Certified', 15),
(3, 'DevOps Engineer', 'Kubernetes Certified', 8);

-- Query: All employees with their type
SELECT E.EmployeeID, E.Name, 
       CASE 
           WHEN M.EmployeeID IS NOT NULL THEN 'Manager'
           WHEN EN.EmployeeID IS NOT NULL THEN 'Engineer'
       END AS Type
FROM EMPLOYEE E
LEFT JOIN MANAGER M ON E.EmployeeID = M.EmployeeID
LEFT JOIN ENGINEER EN ON E.EmployeeID = EN.EmployeeID;
```

---

<a name="27"></a>
## 27. Differentiate Database System vs File System

### File System

**Definition:** Traditional approach where data is stored in separate files managed by OS.

**Characteristics:**
- Data stored in flat files
- Each application has own files
- No centralized control
- Application-dependent structure

**Problems:**
1. **Data Redundancy:** Same data in multiple files
2. **Data Inconsistency:** Different values in different files
3. **Difficult Data Access:** Need new programs for new queries
4. **Data Isolation:** Data scattered across files
5. **Atomicity Problems:** Partial updates possible
6. **Concurrent Access Anomalies:** No concurrency control
7. **Security Problems:** Hard to enforce access control

**Example:**
```
Student_File.txt:
101,John,CS,8.5
102,Jane,IT,9.0

Course_File.txt:
CS101,DBMS,4
CS102,OS,3

No relationship enforcement!
Student can have non-existent department.
```

### Database System

**Definition:** Centralized data management with DBMS controlling all access.

**Characteristics:**
- Data stored in integrated database
- Centralized control
- Data independence
- Standard query language

**Advantages:**
1. **Reduced Redundancy:** Normalized storage
2. **Data Consistency:** Single source of truth
3. **Easy Data Access:** SQL queries
4. **Data Sharing:** Multi-user access
5. **Enforced Integrity:** Constraints
6. **Atomicity:** Transactions (all or nothing)
7. **Concurrent Access:** Controlled through DBMS
8. **Security:** Authentication, authorization, encryption
9. **Backup & Recovery:** Automated procedures

**Example:**
```sql
STUDENT(RollNo, Name, DeptID FK, CGPA)
DEPARTMENT(DeptID PK, DeptName)

Relationship enforced!
Cannot insert student with invalid DeptID.
```

### Detailed Comparison:

| Aspect | File System | Database System |
|--------|-------------|-----------------|
| **Data Organization** | Separate files | Integrated database |
| **Data Redundancy** | High | Minimal (normalized) |
| **Data Inconsistency** | Common | Rare (constraints) |
| **Data Access** | Program-dependent | Query language (SQL) |
| **Data Sharing** | Difficult | Easy (multi-user) |
| **Data Independence** | No | Yes (physical & logical) |
| **Integrity** | No enforcement | Constraints enforced |
| **Security** | File-level | User/role/row/column level |
| **Concurrency** | Not managed | Managed (ACID) |
| **Backup/Recovery** | Manual | Automated |
| **Cost** | Low | High (DBMS software) |
| **Complexity** | Simple | Complex |
| **Query Capability** | Limited | Powerful (SQL) |
| **Scalability** | Poor | Excellent |
| **Maintenance** | Difficult | Easier |
| **Example Use** | Small applications | Enterprise systems |

### When to Use File System:

- Very small applications
- Single user
- Simple data structure
- No concurrent access
- Budget constraints
- Temporary storage

### When to Use Database System:

- Multi-user applications
- Complex data relationships
- Need for data integrity
- Concurrent access required
- Security important
- Enterprise applications
- Data sharing across applications

---

<a name="28"></a>
## 28. Steps to Convert ER/EER Diagram into Tables

(Comprehensive coverage in Question 17)

### Summary of Conversion Rules:

**1. Strong Entities → Tables**
```
Entity becomes table, attributes become columns, 
entity key becomes primary key
```

**2. Weak Entities → Tables**
```
Include partial key + owner's primary key as foreign key
Composite primary key: (Owner_PK, Partial_Key)
```

**3. Binary Relationships:**
- **1:1** → Foreign key in either table (or merge)
- **1:N** → Foreign key in "N" side
- **M:N** → Separate junction table

**4. Multi-valued Attributes → Separate Table**
```
TABLE(Entity_PK, Attribute_Value)
Primary Key: (Entity_PK, Attribute_Value)
```

**5. Composite Attributes → Flatten**
```
Address(Street, City, State) → Street, City, State columns
```

**6. Derived Attributes → Don't Store**
```
Age (derived from DOB) → Calculate in queries
```

**7. Specialization/Generalization:**
- Single table approach
- Table per subclass
- Table per concrete class

**8. Ternary Relationships → Table**
```
TABLE(Entity1_PK, Entity2_PK, Entity3_PK, ...)
All three as foreign keys
```

---

## Conclusion

This comprehensive guide covers all 28 DBMS questions with detailed explanations, examples, ER diagrams, SQL implementations, and practical use cases. Each topic builds upon fundamental database concepts to provide a complete understanding of database design and implementation.

**Key Takeaways:**
- Understand three-level architecture for data abstraction
- Master ER modeling for database design
- Apply normalization for optimal schema design
- Implement constraints for data integrity
- Use proper keys and relationships
- Convert ER diagrams to relational tables systematically
- Recognize when to use database vs file systems

---

**END OF DOCUMENT**


# DATABASE SYSTEMS
## A Complete Guide from Fundamentals to Implementation

*Written for students who want to truly understand, not just memorize*

---

# PREFACE

**Why This Book Exists**

When I first learned databases, I was overwhelmed. ER diagrams looked like alien symbols. Normalization seemed like mathematical torture. SQL felt like a secret language everyone else understood except me.

Then one day, my professor said something that changed everything:

*"A database is just a fancy filing cabinet. Everything else is details."*

Suddenly, it all clicked. The three-level architecture? Different people looking at the same filing cabinet from different angles. Primary keys? Labels so you don't mix up files. Relationships? Cross-reference cards between cabinets.

This book is written in that spirit. Every concept is first explained in plain English, using analogies from your daily life. Then we add the technical terms. Then we look at the diagrams. Then we write the code.

**How to Read This Book**

You don't need to read it straight through like a novel. Jump around. Each chapter stands alone. But if you're new to databases, I recommend going in order—each chapter builds on the last.

Throughout these pages, you'll find:

🔹 **"Think of it like..."** — Real-world analogies that make abstract concepts concrete

🔹 **"Watch Out!"** — Common mistakes and how to avoid them

🔹 **"Try This"** — Exercises to test your understanding

🔹 **"Behind the Scenes"** — Deeper dives for the curious

Most importantly, this book respects your time. No fluff. No unnecessary jargon. Just clear explanations that actually explain.

Let's begin.

---

# CHAPTER 1
## The Filing Cabinet That Changed the World

---

### 1.1 Before Databases: The Mess

Imagine you run a small bookstore. You have:

- A notebook for customer names and phone numbers
- Another notebook for books in stock
- A shoebox of receipts for sales
- Index cards for special orders
- A calendar for author events

This works—until you have 100 customers. Then 500. Then 2,000.

Now find me: *"Every customer who bought a mystery novel last month and lives in Chicago."*

Good luck. You'll be flipping through notebooks until next week.

**This is the problem databases solve.**

---

### 1.2 What IS a Database, Really?

Let's strip away all the technical mystique.

**A database is just an organized collection of information.**

That's it. Your phone's contacts app is a database. Spotify's song library is a database. The IRS's tax records are a database (and you really don't want to be in that one).

What makes a *database system* different from a *shoebox of receipts*?

**Three things:**

1. **Structure** — Information is organized in a predictable way
2. **Access** — You can find what you need quickly
3. **Control** — Rules ensure the information stays correct

---

### 1.3 The Three-Level Architecture: A Restaurant Story

Let me tell you about a restaurant. Not just any restaurant—a very well-organized one.

**On the main floor**, customers study menus. Each menu is tailored: kids' menu has pictures and chicken fingers; vegetarian menu has no meat items; gluten-free menu avoids wheat. Customers see only what they need to see.

**Downstairs in the kitchen**, the chef sees the full picture. She knows every recipe: burger needs a bun, patty, lettuce, tomato, cheese. Salad needs lettuce, tomato, cucumber, dressing. The chef doesn't care about dietary restrictions or menu formatting—she cares about ingredients and how to combine them.

**In the back**, there's a storage room. Walk-in fridge at 4°C. Freezer at -18°C. Dry storage for buns and cups. Everything organized—lettuce on top shelf, tomatoes middle, cheese bottom. The storage manager doesn't know or care about recipes. She cares about temperatures, shelf space, and expiration dates.

**Now here's the magic:**

When the restaurant reorganizes the storage room—moves the fridge, adds a freezer, changes shelving—customers don't notice. Their menus look exactly the same.

When the chef modifies a recipe—adds bacon to the burger, swaps cheddar for Swiss—customers see the updated menu, but the storage room organization doesn't change.

**This separation of concerns is genius.** And database systems copied it exactly.

---

#### The Three Levels in Database Terms

**EXTERNAL LEVEL — What users see**
- Different users have different "menus" (views)
- Students see only their grades, not everyone's
- Tellers see account balances, not loan applications
- Managers see aggregated reports, not individual transactions

**CONCEPTUAL LEVEL — What the database contains**
- The complete, logical structure
- All tables, all relationships, all constraints
- One conceptual schema for the entire database
- The "recipe book" for all data

**INTERNAL LEVEL — How data is stored**
- File organization (sequential, heap, hash)
- Index structures (B-trees, hash tables)
- Storage allocation (which disk, which blocks)
- Compression and encryption

---

**Why this matters to YOU:**

When you learn database design, you're learning conceptual level thinking. You don't need to worry about disk blocks or B-tree nodes. You just need to understand what data is needed and how pieces relate.

**That's the beauty of abstraction.** You work at the level that makes sense for your task.

---

### 1.4 Data Independence: The Superpower

If you remember only one concept from this chapter, remember this:

**Physical Independence** = I can change HOW data is stored without changing WHAT data is stored.

**Logical Independence** = I can change WHAT data is stored without changing HOW users see it.

Let me show you what this means in practice.

---

**Physical Independence Example**

*Before optimization:*
```sql
-- Your application code
SELECT * FROM Students WHERE StudentID = 12345;

-- Behind the scenes: Data in heap file, no index
-- Query scans entire table (slow, but works)
```

*After optimization:*
```sql
-- Your application code - IDENTICAL!
SELECT * FROM Students WHERE StudentID = 12345;

-- Behind the scenes: B-tree index on StudentID
-- Query uses index (instant results!)
```

**You changed nothing. Your code didn't know. Your users didn't know. Everything just got faster.**

That's physical independence.

---

**Logical Independence Example**

*Before normalization:*
```sql
-- One table with everything
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Street VARCHAR(50),
    City VARCHAR(30),
    State CHAR(2),
    Zip VARCHAR(10)
);

-- Application code uses this table
```

*After normalization (better design):*
```sql
-- Split into two tables
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    AddressID INT
);

CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    Street VARCHAR(50),
    City VARCHAR(30),
    State CHAR(2),
    Zip VARCHAR(10)
);

-- But old applications still need the old format!
CREATE VIEW Students_With_Address AS
SELECT S.StudentID, S.Name, A.Street, A.City, A.State, A.Zip
FROM Students S
JOIN Addresses A ON S.AddressID = A.AddressID;

-- Old applications query the VIEW, not the TABLE
-- They never know we changed anything!
```

**You restructured your entire database. Old applications still work perfectly.**

That's logical independence.

---

**Watch Out!**

Logical independence is HARD. You can't always achieve it. Adding a new column? Fine. Splitting one table into two? Requires views. Changing the meaning of a column (PhoneNumber used to be home phone, now it's mobile)? Near impossible.

Physical independence is EASY. Modern DBMS handles it automatically. You barely think about it.

---

### 1.5 The Database System: A Complete Picture

Let's assemble everything into one complete diagram:

```
┌─────────────────────────────────────────────────────────────────────┐
│                        USERS (Different Roles)                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐           │
│  │ End User │  │ Program- │  │ Analyst  │  │   DBA    │           │
│  │          │  │   mer    │  │          │  │          │           │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘           │
└───────┼─────────────┼─────────────┼─────────────┼─────────────────┘
        │             │             │             │
        ▼             ▼             ▼             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                     APPLICATION PROGRAMS                           │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐           │
│  │   Web    │  │ Desktop  │  │  Mobile  │  │  Admin   │           │
│  │   App    │  │   App    │  │   App    │  │  Tools   │           │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘           │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         DBMS SOFTWARE                               │
│                                                                     │
│  ┌─────────────────┐    ┌─────────────────┐                       │
│  │ QUERY PROCESSOR │    │  TRANSACTION    │                       │
│  │ • Parsing       │    │    MANAGER      │                       │
│  │ • Optimization  │    │ • ACID          │                       │
│  │ • Execution     │    │ • Concurrency   │                       │
│  └─────────────────┘    └─────────────────┘                       │
│                                                                     │
│  ┌─────────────────┐    ┌─────────────────┐                       │
│  │  STORAGE        │    │    BUFFER       │                       │
│  │   MANAGER       │    │    MANAGER      │                       │
│  │ • File I/O      │    │ • Cache         │                       │
│  │ • Indexes       │    │ • Memory mgmt   │                       │
│  └─────────────────┘    └─────────────────┘                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                       OPERATING SYSTEM                              │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                       PHYSICAL STORAGE                              │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐                │
│  │ HDD  │  │ SSD  │  │ RAID │  │ Tape │  │ Cloud│                │
│  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘                │
└─────────────────────────────────────────────────────────────────────┘
```

**Every layer has a job. Each layer only talks to the layers directly above and below. This is how we manage complexity.**

---

### 1.6 Database Languages: Speaking to the System

If the DBMS is the engine, SQL is the steering wheel. You don't need to understand how fuel injection works to drive a car. You just need to know: turn left to go left, turn right to go right.

**SQL (Structured Query Language)** has two main dialects:

---

**Data Definition Language (DDL)** — Talking about structure

Think of DDL as an architect's language:
- "Build a wall here" → `CREATE TABLE`
- "Add a door to this wall" → `ALTER TABLE ADD COLUMN`
- "Remove this wall" → `DROP TABLE`
- "Clear the room but keep the walls" → `TRUNCATE TABLE`

```sql
-- Architect at work
CREATE TABLE Department (
    DeptID     INT PRIMARY KEY,      -- Unique room number
    DeptName   VARCHAR(50),          -- Name on the door
    Building   VARCHAR(30),          -- Which building
    Floor      INT                  -- Which floor
);
```

---

**Data Manipulation Language (DML)** — Talking about content

Think of DML as an office worker's language:
- "File this document" → `INSERT`
- "Show me that document" → `SELECT`
- "Update this information" → `UPDATE`
- "Remove this document" → `DELETE`

```sql
-- Office worker at work
INSERT INTO Department VALUES (1, 'Sales', 'North Tower', 5);
SELECT * FROM Department WHERE Building = 'North Tower';
UPDATE Department SET Floor = 6 WHERE DeptID = 1;
DELETE FROM Department WHERE DeptID = 1;
```

---

**Watch Out!**

New learners often confuse `DELETE` and `DROP`.

`DELETE FROM Students WHERE StudentID = 101;` — Removes student 101, but the Students table still exists. You can add new students.

`DROP TABLE Students;` — Removes the ENTIRE Students table. Gone. Poof. You cannot add new students because the table doesn't exist anymore.

**DELETE removes the records. DROP removes the table.**

---

### 1.7 Why This All Matters

You might be thinking: *"This is interesting, but do I really need to understand architecture to design a database?"*

**Yes. Absolutely. Here's why:**

When you understand the three-level architecture, you stop fighting your tools. You know why you can add an index and make queries faster without rewriting applications. You know why splitting tables requires views to keep old code working.

When you understand DDL vs DML, you stop mixing them up. You know which commands change structure and which change data. Your `DROP TABLE` finger gets less twitchy.

**Understanding the fundamentals doesn't just help you pass exams. It helps you build better databases.**

---

### Chapter 1 Summary

| Concept | Plain English | Technical Term |
|---------|--------------|----------------|
| Different users see different data | Custom menus | External level |
| Complete database structure | Recipe book | Conceptual level |
| Physical storage details | Kitchen organization | Internal level |
| Change storage, same queries | Move fridge, same menu | Physical independence |
| Change structure, same views | Change recipe, same menu | Logical independence |
| Define structure | Architect | DDL |
| Manipulate data | Office worker | DML |

---

# CHAPTER 2
## Drawing Databases: The ER Model

---

### 2.1 Before You Build, You Draw

Imagine building a house without blueprints. You start pouring concrete, then realize you forgot the kitchen. You add a kitchen, but now the living room is tiny. You expand the living room, but the master bedroom disappears.

**This is exactly what happens when you build a database without a diagram.**

The Entity-Relationship (ER) model is your blueprint. It doesn't care about computers or SQL or performance. It only cares about:

- **What things exist?** (Entities)
- **What are they like?** (Attributes)
- **How are they connected?** (Relationships)

Everything else comes later.

---

### 2.2 Entities: The Nouns

**An entity is a thing you need to remember.**

Not all things—only the ones that matter to your system.

If you're building a university system, you care about:
- Students ✓
- Courses ✓
- Professors ✓
- Classrooms ✓

You don't care about:
- The color of the dean's car ✗
- What students ate for breakfast ✗
- The weather on graduation day ✗

**Entities are the foundation. Get this wrong, and nothing else matters.**

---

**Strong Entities vs Weak Entities**

Most entities are **strong**—they exist on their own. A student exists whether or not they're enrolled in courses. A department exists whether or not it has employees.

Some entities are **weak**—they depend entirely on another entity. A dependent exists only because an employee exists. If the employee quits, their dependents disappear from your database.

```
┌──────────────────┐      ┌──────────────────┐
│    EMPLOYEE      │      │    DEPENDENT     │
│    (Strong)      │─────<│     (Weak)       │
├──────────────────┤      ├──────────────────┤
│ EmployeeID  PK   │      │ EmployeeID  FK   │
│ Name            │      │ DependentName PK │
│ HireDate        │      │ Age              │
└──────────────────┘      │ Relationship     │
                         └──────────────────┘
```

**Weak entities are drawn with double rectangles. Their identifying relationship is a double diamond.**

---

### 2.3 Attributes: The Adjectives

**An attribute describes an entity.**

But not all attributes are created equal. Let me introduce you to the whole family:

---

**Simple Attributes** — Cannot be broken down

```sql
Age INT
Salary DECIMAL(10,2)
Price DECIMAL(8,2)
```

**Composite Attributes** — Made of smaller pieces

```
Name
 ├── FirstName
 ├── MiddleInitial (optional)
 └── LastName

Address
 ├── Street
 ├── City
 ├── State
 └── PostalCode
```

**Multi-valued Attributes** — Can have multiple values

```
PhoneNumbers
 ├── Home: 555-1234
 ├── Work: 555-5678
 └── Mobile: 555-9012

EmailAddresses
 ├── personal@email.com
 ├── work@company.com
 └── backup@gmail.com
```

**Derived Attributes** — Calculated from other attributes

```
Age = TODAY - DateOfBirth
Experience = TODAY - HireDate
TotalPrice = Quantity × UnitPrice
```

**Key Attributes** — Uniquely identify the entity

```
StudentID
SocialSecurityNumber
VehicleIdentificationNumber
ISBN (for books)
```

---

**Try This:**

Look at your driver's license. Identify:

- One simple attribute
- One composite attribute
- One key attribute
- One derived attribute (hint: something on your license is calculated from something else)

---

### 2.4 Relationships: The Verbs

**A relationship connects entities.**

This is where database design gets interesting. The nouns are easy—you can usually look at a system and identify the people, places, and things. The verbs reveal how the system actually works.

---

**Cardinality: How Many?**

**One-to-One (1:1)** — Rare, but important

```
PERSON ───1─── HAS ───1─── PASSPORT
```

Each person has exactly one passport. Each passport belongs to exactly one person. This is exclusive—like marriage (in most countries).

**When to use 1:1:** Subsetting data (public vs private), splitting large tables, handling optional attributes.

---

**One-to-Many (1:N)** — Extremely common

```
DEPARTMENT ───1─── EMPLOYS ───N─── EMPLOYEE
```

One department has many employees. One employee works in one department. This is hierarchical—like parent and children.

**When to use 1:N:** Hierarchies, ownership, categorization.

---

**Many-to-Many (M:N)** — Also very common

```
STUDENT ───M─── ENROLLS ───N─── COURSE
```

One student takes many courses. One course has many students. This is networked—like friends in a social graph.

**When to use M:N:** Complex relationships where both sides can have multiple connections.

---

**Watch Out!**

Many-to-many relationships CANNOT be directly implemented in relational databases. You always need a junction table (also called associative table, bridge table, or link table).

We'll cover this in detail when we get to conversion rules.

---

**Participation: Required vs Optional**

Cardinality tells you the maximum. Participation tells you the minimum.

**Total Participation (Mandatory)** — Every entity MUST participate

```
LOAN ═══M═══ HAS ═══N═══ CUSTOMER
```

Every loan must have a customer. A loan cannot exist in isolation. This makes sense—loans don't spontaneously generate.

**Partial Participation (Optional)** — Entities MAY participate

```
EMPLOYEE ───1─── MANAGES ───N─── PROJECT
```

Not every employee manages a project. Some employees just do their work and go home. This is normal.

---

**Degree: How Many Entities?**

**Unary Relationship (Degree 1)** — Entity relates to itself

```
EMPLOYEE ──MANAGES──> EMPLOYEE
```

One employee manages other employees. This is recursive.

**Binary Relationship (Degree 2)** — Two entities relate

```
DOCTOR ──TREATS──> PATIENT
```

The most common type.

**Ternary Relationship (Degree 3)** — Three entities relate

```
DOCTOR
   │
PRESCRIBES
   │
PATIENT ── MEDICATION
```

All three must participate. This is more complex to implement.

---

### 2.5 Drawing ER Diagrams: The Symbols

Here's your cheat sheet:

```
┌──────────┐     Strong Entity (Rectangle)
│  ENTITY  │
└──────────┘

┌──────────┐     Weak Entity (Double Rectangle)
│  ENTITY  │
└──────────┘

◯──────────◯     Attribute (Oval)
     name

◎──────────◎     Key Attribute (Underlined Oval)
    key

◯───◯───◯        Composite Attribute (Ovals connected to parent)

◉──────────◉     Multi-valued Attribute (Double Oval)
   phone

◯ - - - ◯        Derived Attribute (Dashed Oval)

◇──────────◇     Relationship (Diamond)
  relation

◇═────────═◇     Identifying Relationship (Double Diamond)

───────           Partial Participation (Single line)

═══════           Total Participation (Double line)

→ 1              One cardinality
→ N              Many cardinality
```

---

### 2.6 Building Your First ER Diagram: University System

Let's work through a complete example together.

**Requirements:**
1. We need to track students, courses, and professors
2. Students have an ID, name, email, and enrollment date
3. Courses have an ID, title, credits, and description
4. Professors have an ID, name, department, and office
5. Students enroll in courses and receive grades
6. Professors teach courses
7. A course can be taught by multiple professors over time
8. A student can only enroll in a course once

**Step 1: Identify Entities**

Clear nouns that need tracking:
- STUDENT
- COURSE
- PROFESSOR

**Step 2: Identify Attributes**

For STUDENT:
- StudentID (key)
- Name (composite: First, Last)
- Email (simple, unique)
- EnrollmentDate (simple)

For COURSE:
- CourseID (key)
- Title (simple)
- Credits (simple)
- Description (simple, maybe long)

For PROFESSOR:
- ProfessorID (key)
- Name (composite)
- Department (simple)
- Office (simple)

**Step 3: Identify Relationships**

- STUDENT enrolls in COURSE → Many-to-Many
- PROFESSOR teaches COURSE → Many-to-Many

**Step 4: Identify Relationship Attributes**

- ENROLLS has: Grade, Semester, Year
- TEACHES has: Semester, Year, Section

**Step 5: Draw It!**

```
                    ┌─────────────────────────────────────┐
                    │           PROFESSOR                 │
                    ├─────────────────────────────────────┤
                    │ ● ProfessorID  (PK)                │
                    │   Name (First, Last)               │
                    │   Department                       │
                    │   Office                           │
                    └─────────────────┬───────────────────┘
                                      │
                                      │ M
                                      │
                              ┌───────▼────────┐
                              │    TEACHES     │
                              │  (Relationship)│
                              │  Semester      │
                              │  Year          │
                              │  Section       │
                              └───────┬────────┘
                                      │
                                      │ N
                                      │
                    ┌─────────────────▼───────────────────┐
                    │             COURSE                  │
                    ├─────────────────────────────────────┤
                    │ ● CourseID     (PK)                │
                    │   Title                             │
                    │   Credits                           │
                    │   Description                       │
                    └─────────────────┬───────────────────┘
                                      │
                                      │ N
                                      │
                              ┌───────▼────────┐
                              │    ENROLLS     │
                              │  (Relationship)│
                              │  Grade         │
                              │  Semester      │
                              │  Year          │
                              └───────┬────────┘
                                      │
                                      │ M
                                      │
                    ┌─────────────────▼───────────────────┐
                    │            STUDENT                  │
                    ├─────────────────────────────────────┤
                    │ ● StudentID   (PK)                 │
                    │   Name (First, Last)               │
                    │   Email        (UK)                │
                    │   EnrollmentDate                   │
                    └─────────────────────────────────────┘
```

---

### 2.7 Common Mistakes (And How to Avoid Them)

**Mistake #1: Making everything an attribute**

*Wrong:* Student has attributes: Course1, Course2, Course3

*Why it's wrong:* What happens when a student takes 4 courses? You need to alter the table. What happens when a student takes 0 courses? You have NULLs everywhere. What happens when you need to find all students in a course? Pain.

*Right:* Student and Course are separate entities, connected by ENROLLS relationship.

---

**Mistake #2: Forgetting relationship attributes**

*Wrong:* Just connecting Student and Course

*Why it's wrong:* Where do you put the grade? The semester? The year?

*Right:* Relationships can have attributes too. ENROLLS has Grade, Semester, Year.

---

**Mistake #3: Confusing entities with attributes**

*Wrong:* Phone is an attribute of Customer

*Why it's wrong:* What if a customer has 3 phones? NULLs or comma-separated values (both bad).

*Right:* Phone is a multi-valued attribute or a separate Phone entity.

---

**Mistake #4: Missing relationships**

*Wrong:* Student and Course exist, but no connection

*Why it's wrong:* You can't answer "Which students are in Database course?"

*Right:* Always ask "How do these entities interact?"

---

### 2.8 Try This: Practice Exercise

Draw an ER diagram for a library system with these requirements:

1. Library has books (ISBN, title, author, publisher, year)
2. Library has members (member ID, name, address, phone, email)
3. Members borrow books
4. Each borrowing is recorded with date borrowed, date due, date returned
5. A book can have multiple copies
6. Each copy has its own ID and status (available, borrowed, lost, damaged)

**Take 15 minutes and try this now. Then compare your diagram to the solution in Chapter 8.**

---

### Chapter 2 Summary

| Concept | Remember It As |
|--------|----------------|
| Entity | A noun you need to remember |
| Attribute | An adjective describing the noun |
| Relationship | A verb connecting nouns |
| Cardinality | Maximum possible connections |
| Participation | Minimum required connections |
| Strong Entity | Can exist alone |
| Weak Entity | Depends on another to exist |

---

# CHAPTER 3
## From Drawings to Tables: The Conversion

---

### 3.1 The Bridge Between Design and Implementation

You have a beautiful ER diagram. Now what?

You cannot run an ER diagram. You cannot query it. You cannot store data in it. It's a blueprint, not a building.

**We need to convert our blueprint into an actual database.**

This chapter gives you seven rules. Learn these rules, and you can convert any ER diagram into a working relational database. Every time. Guaranteed.

---

### 3.2 Rule #1: Strong Entities Become Tables

**The Rule:** Each strong entity becomes a table. Its attributes become columns. Its key attribute becomes the primary key.

**Before (ER Diagram):**
```
┌─────────────────┐
│    STUDENT      │
├─────────────────┤
│ ● StudentID  PK │
│   FirstName     │
│   LastName      │
│   Email         │
│   DateOfBirth   │
└─────────────────┘
```

**After (Relational Table):**
```sql
CREATE TABLE Student (
    StudentID    INT PRIMARY KEY,
    FirstName    VARCHAR(50) NOT NULL,
    LastName     VARCHAR(50) NOT NULL,
    Email        VARCHAR(100) UNIQUE,
    DateOfBirth  DATE
);
```

**Watch Out!** 
- `NOT NULL` for required attributes
- `UNIQUE` for alternate keys
- Choose appropriate data types (INT, VARCHAR, DATE, etc.)

---

### 3.3 Rule #2: Weak Entities Become Tables with Composite Keys

**The Rule:** Each weak entity becomes a table. Include the owner's primary key as a foreign key. The weak entity's partial key + owner's primary key becomes the composite primary key.

**Before (ER Diagram):**
```
┌──────────────┐      ┌──────────────┐
│  EMPLOYEE    │      │  DEPENDENT   │
├──────────────┤      │   (Weak)     │
│ ● EmpID   PK │─────<├──────────────┤
│   Name       │      │ ● Name   PK  │
│   HireDate   │      │   Age        │
└──────────────┘      │   Relation   │
                      └──────────────┘
```

**After (Relational Tables):**
```sql
CREATE TABLE Employee (
    EmpID     INT PRIMARY KEY,
    Name      VARCHAR(50) NOT NULL,
    HireDate  DATE
);

CREATE TABLE Dependent (
    EmpID      INT,
    Name       VARCHAR(50),
    Age        INT,
    Relation   VARCHAR(20),
    PRIMARY KEY (EmpID, Name),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID) 
        ON DELETE CASCADE
);
```

**Why ON DELETE CASCADE?** 
If an employee leaves the company, their dependents shouldn't remain in the database. They're gone too.

---

### 3.4 Rule #3: 1:N Relationships Add Foreign Keys

**The Rule:** Add the primary key of the "1" side as a foreign key in the "N" side table.

**Before (ER Diagram):**
```
DEPARTMENT ───1─── EMPLOYS ───N─── EMPLOYEE
```

**After (Relational Tables):**
```sql
CREATE TABLE Department (
    DeptID    INT PRIMARY KEY,
    DeptName  VARCHAR(50),
    Location  VARCHAR(100)
);

CREATE TABLE Employee (
    EmpID     INT PRIMARY KEY,
    Name      VARCHAR(50),
    Salary    DECIMAL(10,2),
    DeptID    INT NOT NULL,  -- Foreign key
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
```

**Why is the foreign key in Employee, not Department?**
Each employee works in ONE department. Each department has MANY employees. It's more efficient to store the department ID once per employee than to store all employee IDs in the department table.

---

### 3.5 Rule #4: 1:1 Relationships Add Foreign Key in Either Table

**The Rule:** Choose one table to host the foreign key. Add a UNIQUE constraint to enforce the one-to-one nature.

**Before (ER Diagram):**
```
PERSON ───1─── HAS ───1─── PASSPORT
```

**After (Relational Tables - Option A):**
```sql
CREATE TABLE Person (
    PersonID   INT PRIMARY KEY,
    Name       VARCHAR(50),
    PassportID INT UNIQUE,  -- Foreign key
    FOREIGN KEY (PassportID) REFERENCES Passport(PassportID)
);

CREATE TABLE Passport (
    PassportID INT PRIMARY KEY,
    Number     VARCHAR(20),
    ExpiryDate DATE
);
```

**After (Relational Tables - Option B):**
```sql
CREATE TABLE Person (
    PersonID   INT PRIMARY KEY,
    Name       VARCHAR(50)
);

CREATE TABLE Passport (
    PassportID INT PRIMARY KEY,
    Number     VARCHAR(20),
    ExpiryDate DATE,
    PersonID   INT UNIQUE,  -- Foreign key
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);
```

**Which option is better?**
Choose based on business logic. If every person MUST have a passport, Option B with `NOT NULL` on PersonID. If passports can exist without owners (unlikely), Option A.

---

### 3.6 Rule #5: M:N Relationships Create Junction Tables

**The Rule:** Create a new table containing foreign keys from both participating entities. The primary key is the combination of both foreign keys (composite key).

**Before (ER Diagram):**
```
STUDENT ───M─── ENROLLS ───N─── COURSE
                (Grade, Semester, Year)
```

**After (Relational Tables):**
```sql
CREATE TABLE Student (
    StudentID  INT PRIMARY KEY,
    Name       VARCHAR(50)
);

CREATE TABLE Course (
    CourseID   INT PRIMARY KEY,
    Title      VARCHAR(100),
    Credits    INT
);

CREATE TABLE Enrollment (
    StudentID  INT,
    CourseID   INT,
    Grade      CHAR(2),
    Semester   VARCHAR(20),
    Year       INT,
    PRIMARY KEY (StudentID, CourseID, Semester, Year),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
```

**Why do we need a separate table?**
Because an M:N relationship cannot be represented with foreign keys alone. If we put CourseID in Student table, a student could only take one course. If we put StudentID in Course table, a course could only have one student. Neither works.

---

### 3.7 Rule #6: Multi-valued Attributes Become Separate Tables

**The Rule:** Create a new table with the entity's primary key and the multi-valued attribute. The primary key is the combination of both.

**Before (ER Diagram):**
```
┌─────────────────┐
│    EMPLOYEE     │
├─────────────────┤
│ ● EmpID      PK │
│   Name          │
│   {PhoneNumber} │  ← Multi-valued
└─────────────────┘
```

**After (Relational Tables):**
```sql
CREATE TABLE Employee (
    EmpID     INT PRIMARY KEY,
    Name      VARCHAR(50)
);

CREATE TABLE Employee_Phone (
    EmpID      INT,
    PhoneNumber VARCHAR(15),
    PhoneType   VARCHAR(10), -- 'Home', 'Work', 'Mobile'
    PRIMARY KEY (EmpID, PhoneNumber),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);
```

**Never, ever store multiple values in a single column as comma-separated text. This violates First Normal Form and will cause you endless pain.**

---

### 3.8 Rule #7: Composite Attributes Are Flattened

**The Rule:** Break composite attributes into their component parts. Each component becomes a separate column.

**Before (ER Diagram):**
```
┌─────────────────┐
│    CUSTOMER     │
├─────────────────┤
│ ● CustID    PK  │
│   Name          │
│   └─ FirstName  │
│   └─ LastName   │
│   Address       │
│   └─ Street     │
│   └─ City       │
│   └─ State      │
│   └─ Zip        │
└─────────────────┘
```

**After (Relational Tables):**
```sql
CREATE TABLE Customer (
    CustID     INT PRIMARY KEY,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Street     VARCHAR(100),
    City       VARCHAR(50),
    State      CHAR(2),
    Zip        VARCHAR(10)
);
```

**Alternative:** Keep full name as one column if you never need to search by first name separately. There's no rule that says you MUST split composite attributes. Design for how the data will be used.

---

### 3.9 Putting It All Together: Complete Example

Let's convert a complete ER diagram step by step.

**The ER Diagram:**
```
                    DEPARTMENT
                    ┌─────────┐
                    │●DeptID  │
                    │ DeptName│
                    └────┬────┘
                         │1
                         │
                    EMPLOYS
                         │
                         │N
                    ┌────┴────┐
                    │EMPLOYEE │
                    ├─────────┤
                    │●EmpID   │
                    │ Name    │
                    │ Salary  │
                    │{Phone}  │
                    └────┬────┘
                         │M
                         │
                    WORKS_ON
                         │
                         │N
                    ┌────┴────┐
                    │PROJECT  │
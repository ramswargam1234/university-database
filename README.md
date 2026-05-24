# University Information Database

A normalized university records system designed and implemented as a group project for **OREM 7353 — Database Management Systems** (Spring 2026).

The database models core university operations — students, faculty, courses, enrollment, advising, and finances — using a 3NF relational design with sample data, analytical queries, and reusable views.

## Team — Group Project

- Alejandro Enriquez
- Abby Caslin
- Ramchandar Rao Swargam

## Project Overview

The system manages six interconnected entities:

- **StudentInformation** — demographics, academic standing, GPA, major/minor
- **FacultyInformation** — faculty members, departments, titles, contact info
- **ClassInformation** — courses, semesters, instructors, schedules
- **StudentAcademicRecords** — enrollment records linking students to classes with grades
- **StudentFinances** — tuition, fees, scholarships, loans, and payment tracking
- **AdvisorInformation** — student-advisor relationships and meeting history

## What's Included

| File | Description |
|------|-------------|
| `University Database.sql` | Complete SQL: table creation, sample data inserts, queries, and views |
| `University Database Report.docx` | Final project report with ER diagram, design rationale, and analysis |
| `University Database Tables.xlsx` | Reference tables and data summaries |
| `University Database.pptx` | Final presentation slides |

## Technical Highlights

- **6 normalized tables** in Third Normal Form (3NF)
- **10+ sample tuples per table** for realistic testing
- **4 CREATE VIEW statements** for common analytical use cases:
  - `StudentFinancialSummary` — outstanding balances per student
  - `ActiveEnrollmentTracker` — students currently enrolled in courses
  - `FacultyAdvisingLoad` — advisee counts per faculty member
  - `ComprehensiveStudentProfile` — consolidated student information
- **Query types demonstrated:** INSERT, DELETE, SELECT, JOIN, GROUP BY, HAVING, aggregate functions
- **Referential integrity** enforced through foreign key constraints
- **Domain constraints** using CHECK clauses for enrollment status, degree level, gender, advisor type, and course type

## How to Run

1. Open `University Database.sql` in MySQL Workbench (or any SQL client).
2. Connect to your MySQL server.
3. Create or select a target database.
4. Execute the script top to bottom. It will:
   - Create all six tables
   - Insert sample data
   - Run example queries
   - Create the four views

To explore the data after loading:

```sql
SELECT * FROM StudentFinancialSummary;
SELECT * FROM ActiveEnrollmentTracker;
SELECT * FROM FacultyAdvisingLoad;
SELECT * FROM ComprehensiveStudentProfile;
```

## Course Context

**OREM 7353 — Database Management Systems**
Spring 2026 Group Project

Requirements satisfied:
- ✅ Minimum 6 tables
- ✅ Minimum 10 tuples per table
- ✅ Minimum 4 CREATE VIEW statements
- ✅ 3NF normalization
- ✅ INSERT, DELETE, SELECT, JOIN, and aggregate queries

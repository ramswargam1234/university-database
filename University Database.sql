-- ============================================================
-- UNIVERSITY INFORMATION DATABASE - FINAL VERSION
-- OREM 7353 Group Project (Spring 2026)
-- Group: Alejandro Enriquez, Abby Caslin, Ramchandar Rao Swargam
-- 
-- Meets OREM 7353 requirements:
--   - 6 tables (minimum 6) ✓
--   - 10+ tuples per table (minimum 10) ✓
--   - 4 CREATE VIEW statements (minimum 4) ✓
--   - 3NF normalized ✓
--   - INSERT, DELETE, SELECT, JOIN, AGGREGATE queries ✓
-- ============================================================

-- ============================================================
-- PART 1: CREATE TABLES (3NF Normalized)
-- ============================================================

CREATE TABLE StudentInformation (
    studentID VARCHAR(10) PRIMARY KEY,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    dob DATE NOT NULL,
    address VARCHAR(120) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Nonbinary', 'Other')),
    phoneNumber VARCHAR(10) NOT NULL,
    email VARCHAR(80) UNIQUE,
    enrollStatus VARCHAR(15) NOT NULL CHECK (enrollStatus IN ('Active', 'Inactive', 'Graduated', 'Leave')),
    degreeLevel VARCHAR(3) CHECK (degreeLevel IN ('BS', 'MS', 'PhD')),
    major VARCHAR(40) NOT NULL,
    minor VARCHAR(40) NULL,
    gpa NUMERIC(3,2) NOT NULL
);

CREATE TABLE FacultyInformation (
    facultyID VARCHAR(10) PRIMARY KEY,
    facultyFirstName VARCHAR(30) NOT NULL,
    facultyLastName VARCHAR(30) NOT NULL,
    department VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    title VARCHAR(40) CHECK (title IN ('Professor', 'Associate Professor', 'Assistant Professor', 'Lecturer', 'Advisor')),
    officeLocation VARCHAR(80) NOT NULL
);

CREATE TABLE ClassInformation (
    classID VARCHAR(10) PRIMARY KEY,
    semester VARCHAR(20) NOT NULL,
    year VARCHAR(4) NOT NULL,
    program VARCHAR(40) NOT NULL,
    facultyID VARCHAR(10),
    finalExamDate DATE NOT NULL,
    courseTitle VARCHAR(80) NOT NULL,
    courseDescription VARCHAR(200) NOT NULL,
    courseType VARCHAR(20) CHECK (courseType IN ('Mandatory', 'Elective')),
    FOREIGN KEY (facultyID) REFERENCES FacultyInformation(facultyID)
);

CREATE TABLE StudentFinances (
    financeID SERIAL PRIMARY KEY,
    studentID VARCHAR(10) NOT NULL,
    term VARCHAR(20) NOT NULL,
    tuitionAmt NUMERIC(10,2) NOT NULL,
    feesAmt NUMERIC(10,2) NOT NULL,
    scholarshipAmt NUMERIC(10,2) NOT NULL,
    loanAmt NUMERIC(10,2) NOT NULL,
    amtPaid NUMERIC(10,2) NOT NULL,
    dueDate DATE NOT NULL,
    FOREIGN KEY (studentID) REFERENCES StudentInformation(studentID)
);

CREATE TABLE StudentAcademicRecords (
    recordID SERIAL PRIMARY KEY,
    studentID VARCHAR(10) NOT NULL,
    classID VARCHAR(10) NOT NULL,
    enrollmentStatus VARCHAR(20) CHECK (enrollmentStatus IN ('Enrolled', 'Dropped', 'Completed', 'Incomplete')),
    grade VARCHAR(2) NULL,
    dateEnrolled DATE NOT NULL,
    dateCompleted DATE NULL,
    FOREIGN KEY (studentID) REFERENCES StudentInformation(studentID),
    FOREIGN KEY (classID) REFERENCES ClassInformation(classID)
);

CREATE TABLE AdvisorInformation (
    advisorAssignID SERIAL PRIMARY KEY,
    studentID VARCHAR(10) NOT NULL,
    facultyID VARCHAR(10) NOT NULL,
    advisorType VARCHAR(20) CHECK (advisorType IN ('Academic', 'Program', 'Thesis')),
    numVisits NUMERIC(3,0) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    FOREIGN KEY (studentID) REFERENCES StudentInformation(studentID),
    FOREIGN KEY (facultyID) REFERENCES FacultyInformation(facultyID)
);


-- ============================================================
-- PART 2: INSERT SAMPLE DATA (10+ tuples per table)
-- Order: parent tables first, then child tables
-- ============================================================

-- 2.1 StudentInformation (12 students)
INSERT INTO StudentInformation 
  (studentID, firstName, lastName, dob, address, gender, phoneNumber, email, enrollStatus, degreeLevel, major, minor, gpa)
VALUES 
  ('1000', 'Dan', 'Strickland', '2000-01-01', '4821 Maple Ridge Drive, Asheville, NC 28803', 'Male', '5403829147', 'dan.strickland@uni.edu', 'Active', 'PhD', 'Math', 'Statistics', 3.42),
  ('1001', 'Mike', 'Mehja', '2001-02-04', '1976 Harbor View Lane, Tacoma, WA 98405', 'Male', '7036152904', 'mike.mehja@uni.edu', 'Active', 'BS', 'Computer Science', 'Cybersecurity', 3.78),
  ('1002', 'Allie', 'Palmer', '2001-04-06', '359 Cedar Bluff Court, Plano, TX 75023', 'Female', '8042275631', 'allie.palmer@uni.edu', 'Active', 'BS', 'Biology', 'Chemistry', 3.15),
  ('1003', 'Sarah', 'Lin', '2000-09-15', '88 Oakwood Ave, Seattle, WA 98101', 'Female', '2065559988', 'sarah.lin@uni.edu', 'Active', 'BS', 'Computer Science', NULL, 3.91),
  ('1004', 'Marcus', 'Johnson', '1999-07-22', '512 Elm Street, Atlanta, GA 30303', 'Male', '4045551020', 'marcus.johnson@uni.edu', 'Active', 'MS', 'Mechanical Engineering', NULL, 3.55),
  ('1005', 'Priya', 'Patel', '2002-03-18', '2241 Sunset Blvd, Los Angeles, CA 90026', 'Female', '3105557788', 'priya.patel@uni.edu', 'Active', 'BS', 'Biology', 'Mathematics', 3.88),
  ('1006', 'Jordan', 'Reyes', '2001-11-30', '67 Pine Hollow Rd, Boston, MA 02115', 'Nonbinary', '6175553344', 'jordan.reyes@uni.edu', 'Active', 'BS', 'Computer Science', 'Math', 3.62),
  ('1007', 'Emily', 'Nguyen', '2000-05-12', '914 Birch Ave, Houston, TX 77002', 'Female', '7135552233', 'emily.nguyen@uni.edu', 'Graduated', 'MS', 'Math', NULL, 3.95),
  ('1008', 'Carlos', 'Ramirez', '2002-08-09', '1330 Desert Trail, Phoenix, AZ 85004', 'Male', '6025554455', 'carlos.ramirez@uni.edu', 'Active', 'BS', 'Mechanical Engineering', 'Math', 3.28),
  ('1009', 'Hannah', 'Brooks', '2001-12-25', '475 River Rd, Portland, OR 97201', 'Female', '5035556677', 'hannah.brooks@uni.edu', 'Leave', 'BS', 'Biology', NULL, 3.05),
  ('1010', 'Tyler', 'Wright', '1999-04-14', '208 Hilltop Ln, Denver, CO 80203', 'Male', '7205558899', 'tyler.wright@uni.edu', 'Active', 'PhD', 'Mechanical Engineering', NULL, 3.71),
  ('1011', 'Olivia', 'Carter', '2002-06-21', '36 Lakeshore Dr, Chicago, IL 60601', 'Female', '3125559900', 'olivia.carter@uni.edu', 'Inactive', 'BS', 'Computer Science', 'Cybersecurity', 2.85);

-- 2.2 FacultyInformation (10 faculty members)
INSERT INTO FacultyInformation 
  (facultyID, facultyFirstName, facultyLastName, department, email, phoneNumber, title, officeLocation)
VALUES 
  ('5001', 'Laura', 'Simmons', 'Computer Science', 'laura.simmons@uni.edu', '5405552101', 'Professor', 'Bldg 300, Rm 210'),
  ('5002', 'David', 'Chen', 'Mechanical Engineering', 'david.chen@uni.edu', '5405552102', 'Associate Professor', 'Bldg 320, Rm 115'),
  ('5003', 'Maria', 'Gonzalez', 'Biology', 'maria.gonzalez@uni.edu', '5405552103', 'Professor', 'Bldg 410, Rm 305'),
  ('5004', 'James', 'Whitaker', 'Math', 'james.whitaker@uni.edu', '5405552104', 'Assistant Professor', 'Bldg 200, Rm 108'),
  ('5005', 'Susan', 'Park', 'Computer Science', 'susan.park@uni.edu', '5405552105', 'Lecturer', 'Bldg 300, Rm 245'),
  ('5006', 'Robert', 'Andrews', 'Mechanical Engineering', 'robert.andrews@uni.edu', '5405552106', 'Professor', 'Bldg 320, Rm 220'),
  ('5007', 'Linda', 'Murphy', 'Biology', 'linda.murphy@uni.edu', '5405552107', 'Associate Professor', 'Bldg 410, Rm 410'),
  ('5008', 'Thomas', 'Reed', 'Math', 'thomas.reed@uni.edu', '5405552108', 'Lecturer', 'Bldg 200, Rm 215'),
  ('5009', 'Karen', 'Singh', 'Computer Science', 'karen.singh@uni.edu', '5405552109', 'Advisor', 'Bldg 300, Rm 102'),
  ('5010', 'Brian', 'Foster', 'Biology', 'brian.foster@uni.edu', '5405552110', 'Assistant Professor', 'Bldg 410, Rm 215');

-- 2.3 ClassInformation (10 classes)
INSERT INTO ClassInformation 
  (classID, semester, year, program, facultyID, finalExamDate, courseTitle, courseDescription, courseType)
VALUES 
  ('ME202-100', 'Fall', '2020', 'Mechanical Engineering', '5002', '2020-12-12', 'Thermodynamics I', 'Introduces energy systems.', 'Mandatory'),
  ('CSE101-100', 'Spring', '2020', 'Computer Science', '5001', '2020-05-08', 'Introduction to Programming', 'Python fundamentals.', 'Mandatory'),
  ('BIO110-100', 'Fall', '2024', 'Biology', '5003', '2024-12-10', 'General Biology I', 'Cell structure and function.', 'Mandatory'),
  ('MTH210-100', 'Fall', '2024', 'Math', '5004', '2024-12-13', 'Linear Algebra', 'Vectors, matrices, transformations.', 'Mandatory'),
  ('CSE350-100', 'Spring', '2024', 'Computer Science', '5005', '2024-05-09', 'Database Systems', 'Relational databases and SQL.', 'Elective'),
  ('ME340-100', 'Spring', '2024', 'Mechanical Engineering', '5006', '2024-05-07', 'Fluid Mechanics', 'Statics and dynamics of fluids.', 'Mandatory'),
  ('BIO250-100', 'Spring', '2024', 'Biology', '5007', '2024-05-08', 'Microbiology', 'Bacteria, viruses, and immunology.', 'Elective'),
  ('MTH320-100', 'Fall', '2024', 'Math', '5008', '2024-12-11', 'Differential Equations', 'ODEs and applications.', 'Elective'),
  ('CSE410-100', 'Fall', '2024', 'Computer Science', '5001', '2024-12-15', 'Cybersecurity Fundamentals', 'Network and software security.', 'Elective'),
  ('BIO330-100', 'Fall', '2024', 'Biology', '5010', '2024-12-09', 'Genetics', 'Heredity and gene expression.', 'Mandatory');

-- 2.4 StudentFinances (12 records)
INSERT INTO StudentFinances 
  (studentID, term, tuitionAmt, feesAmt, scholarshipAmt, loanAmt, amtPaid, dueDate)
VALUES 
  ('1000', 'Fall 2024', 12000.00, 850.00, 3000.00, 5000.00, 4850.00, '2024-08-15'),
  ('1001', 'Fall 2024', 12000.00, 850.00, 2000.00, 6000.00, 4850.00, '2024-08-15'),
  ('1002', 'Fall 2024', 12000.00, 850.00, 1500.00, 7000.00, 4350.00, '2024-08-15'),
  ('1003', 'Fall 2024', 12000.00, 850.00, 5000.00, 3000.00, 4850.00, '2024-08-15'),
  ('1004', 'Fall 2024', 14000.00, 950.00, 2500.00, 7000.00, 5450.00, '2024-08-15'),
  ('1005', 'Fall 2024', 12000.00, 850.00, 4000.00, 4000.00, 4850.00, '2024-08-15'),
  ('1006', 'Fall 2024', 12000.00, 850.00, 3000.00, 5000.00, 3000.00, '2024-08-15'),
  ('1007', 'Spring 2024', 14000.00, 950.00, 6000.00, 4000.00, 4950.00, '2024-01-15'),
  ('1008', 'Fall 2024', 12000.00, 850.00, 2000.00, 6000.00, 2000.00, '2024-08-15'),
  ('1009', 'Spring 2024', 12000.00, 850.00, 1000.00, 8000.00, 3850.00, '2024-01-15'),
  ('1010', 'Fall 2024', 16000.00, 1050.00, 8000.00, 5000.00, 4050.00, '2024-08-15'),
  ('1011', 'Spring 2024', 12000.00, 850.00, 0.00, 10000.00, 2850.00, '2024-01-15');

-- 2.5 StudentAcademicRecords (15 records)
INSERT INTO StudentAcademicRecords 
  (studentID, classID, enrollmentStatus, grade, dateEnrolled, dateCompleted)
VALUES 
  ('1001', 'CSE101-100', 'Completed', 'A', '2020-01-15', '2020-05-08'),
  ('1003', 'CSE101-100', 'Enrolled', NULL, '2024-08-26', NULL),
  ('1000', 'ME202-100', 'Completed', 'B+', '2020-08-26', '2020-12-12'),
  ('1002', 'ME202-100', 'Dropped', NULL, '2020-08-26', NULL),
  ('1005', 'BIO110-100', 'Enrolled', NULL, '2024-08-26', NULL),
  ('1002', 'BIO110-100', 'Enrolled', NULL, '2024-08-26', NULL),
  ('1000', 'MTH210-100', 'Enrolled', NULL, '2024-08-26', NULL),
  ('1006', 'CSE350-100', 'Completed', 'A-', '2024-01-15', '2024-05-09'),
  ('1003', 'CSE350-100', 'Enrolled', NULL, '2024-08-26', NULL),
  ('1004', 'ME340-100', 'Completed', 'B', '2024-01-15', '2024-05-07'),
  ('1008', 'ME340-100', 'Incomplete', 'I', '2024-01-15', NULL),
  ('1005', 'BIO250-100', 'Completed', 'A', '2024-01-15', '2024-05-08'),
  ('1007', 'MTH320-100', 'Completed', 'A', '2023-08-26', '2023-12-13'),
  ('1011', 'CSE410-100', 'Dropped', NULL, '2024-08-26', NULL),
  ('1009', 'BIO330-100', 'Enrolled', NULL, '2024-08-26', NULL);

-- 2.6 AdvisorInformation (10 records)
INSERT INTO AdvisorInformation 
  (studentID, facultyID, advisorType, numVisits, startDate, endDate)
VALUES 
  ('1001', '5001', 'Academic', 5, '2023-09-01', '2025-05-15'),
  ('1003', '5009', 'Academic', 3, '2024-09-01', '2026-05-15'),
  ('1000', '5004', 'Thesis', 12, '2023-09-01', '2026-05-15'),
  ('1004', '5006', 'Thesis', 8, '2023-09-01', '2025-12-15'),
  ('1005', '5003', 'Academic', 4, '2024-01-15', '2026-05-15'),
  ('1006', '5005', 'Program', 6, '2023-09-01', '2025-05-15'),
  ('1007', '5008', 'Thesis', 15, '2022-09-01', '2024-05-15'),
  ('1008', '5002', 'Program', 2, '2024-09-01', '2026-05-15'),
  ('1010', '5006', 'Thesis', 9, '2022-09-01', '2026-05-15'),
  ('1002', '5010', 'Academic', 3, '2024-01-15', '2026-05-15');


-- ============================================================
-- PART 3: BASIC QUERIES (SELECT & DELETE)
-- ============================================================

-- Simple Select: All active Computer Science students
SELECT firstName, lastName, email
FROM StudentInformation
WHERE major = 'Computer Science' AND enrollStatus = 'Active';

-- Delete Operation: Remove a faculty member (no FK conflicts since 5011 doesn't exist)
DELETE FROM FacultyInformation
WHERE facultyID = '5011';


-- ============================================================
-- PART 4: COMPLEX QUERIES (JOINs & AGGREGATES)
-- ============================================================

-- Complex Join: Transcript-style report
SELECT s.firstName, s.lastName, c.courseTitle, r.grade, r.enrollmentStatus
FROM StudentInformation s
JOIN StudentAcademicRecords r ON s.studentID = r.studentID
JOIN ClassInformation c ON r.classID = c.classID
ORDER BY s.lastName;

-- Aggregate Query: Average GPA per major (only majors with > 1 student)
SELECT major, ROUND(AVG(gpa), 2) AS Average_GPA, COUNT(studentID) AS Student_Count
FROM StudentInformation
GROUP BY major
HAVING COUNT(studentID) > 1;


-- ============================================================
-- PART 5: VIEWS (4 required for OREM 7353)
-- ============================================================

-- View 1: StudentFinancialSummary
CREATE VIEW StudentFinancialSummary AS
SELECT studentID, term, (tuitionAmt + feesAmt) AS Total_Charges, amtPaid,
       ((tuitionAmt + feesAmt) - amtPaid) AS Balance_Due
FROM StudentFinances;

-- View 2: ActiveEnrollmentTracker
CREATE VIEW ActiveEnrollmentTracker AS
SELECT s.firstName, s.lastName, c.courseTitle, r.dateEnrolled
FROM StudentInformation s
JOIN StudentAcademicRecords r ON s.studentID = r.studentID
JOIN ClassInformation c ON r.classID = c.classID
WHERE r.grade IS NULL;

-- View 3: FacultyAdvisingLoad
CREATE VIEW FacultyAdvisingLoad AS
SELECT f.facultyFirstName, f.facultyLastName, COUNT(a.studentID) AS Advisee_Count
FROM FacultyInformation f
LEFT JOIN AdvisorInformation a ON f.facultyID = a.facultyID
GROUP BY f.facultyID, f.facultyFirstName, f.facultyLastName;

-- View 4: ComprehensiveStudentProfile
CREATE VIEW ComprehensiveStudentProfile AS
SELECT studentID, firstName, lastName, major, degreeLevel, enrollStatus, gpa
FROM StudentInformation;


-- ============================================================
-- VERIFICATION (uncomment to test views)
-- ============================================================

-- SELECT * FROM StudentFinancialSummary;
-- SELECT * FROM ActiveEnrollmentTracker;
-- SELECT * FROM FacultyAdvisingLoad;
-- SELECT * FROM ComprehensiveStudentProfile;

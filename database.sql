-- Course Registration System - sample MySQL database
CREATE DATABASE IF NOT EXISTS crs_db;
USE crs_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS semesters;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('ADMIN', 'FACULTY', 'STUDENT') NOT NULL,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    student_no VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    program VARCHAR(100) NOT NULL,
    study_year INT NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(120) NOT NULL,
    credit_hours INT NOT NULL,
    department VARCHAR(80) NOT NULL,
    prerequisite_course_id INT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(id) ON DELETE SET NULL
);

CREATE TABLE semesters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    semester VARCHAR(20) NOT NULL,
    academic_year INT NOT NULL,
    registration_start DATE NOT NULL,
    registration_end DATE NOT NULL,
    UNIQUE (semester, academic_year)
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    academic_year INT NOT NULL,
    status ENUM('ENROLLED', 'DROPPED', 'COMPLETED') DEFAULT 'ENROLLED',
    grade ENUM('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F', 'N/A') NULL,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id),
    UNIQUE (student_id, course_id, semester, academic_year)
);

-- Demo users. Passwords are stored using PBKDF2 hashes (100,000 rounds).
INSERT INTO users (username, password_hash, full_name, role) VALUES
('admin',   '100000:Y3JzLWFkbWluLXNhbHQ=:CSEYV5UAQyBT5r3cLCpfsW7r1bSgiilqQR0kUx2kCu8=', 'System Administrator', 'ADMIN'),
('faculty', '100000:Y3JzLWZhY3VsdHktc2FsdA==:LHZ5uy83qKaCinTZHOxOeGga8IgNKCQexPERJMQSws0=', 'Nimal Perera', 'FACULTY'),
('student', '100000:Y3JzLXN0dWRlbnQtc2FsdA==:6KJUGi9ZsphqOjZ1m5JXmHAkdmmmHwibxxsdUKpOtHg=', 'Kavindu Silva', 'STUDENT');

INSERT INTO students (user_id, student_no, full_name, dob, program, study_year, email, phone) VALUES
(3, 'STU2026001', 'Kavindu Silva', '2004-04-12', 'BSc in Information Technology', 2, 'kavindu@example.com', '0771234567'),
(NULL, 'STU2026002', 'Tharushi Fernando', '2003-09-21', 'BSc in Information Technology', 3, 'tharushi@example.com', '0712345678'),
(NULL, 'STU2026003', 'Isuru Jayasinghe', '2004-02-03', 'BSc in Computer Science', 2, 'isuru@example.com', '0763456789');

INSERT INTO courses (course_code, title, credit_hours, department, prerequisite_course_id, capacity) VALUES
('ICT101', 'Introduction to Information Technology', 3, 'Computing', NULL, 40),
('ICT201', 'Object Oriented Programming', 4, 'Computing', 1, 30),
('ICT202', 'Database Management Systems', 3, 'Computing', 1, 35),
('ICT301', 'Software Engineering', 3, 'Computing', 2, 25),
('MGT101', 'Principles of Management', 2, 'Management', NULL, 50);

-- Demonstration registration period. Change these dates for another semester.
INSERT INTO semesters (semester, academic_year, registration_start, registration_end) VALUES
('Semester 1', 2026, '2026-01-01', '2026-12-31'),
('Semester 2', 2026, '2026-01-01', '2026-12-31');

-- Kavindu completed ICT101, so the ICT201 prerequisite is satisfied.
INSERT INTO enrollments (student_id, course_id, semester, academic_year, status, grade) VALUES
(1, 1, 'Semester 1', 2025, 'COMPLETED', 'B'),
(1, 2, 'Semester 1', 2026, 'ENROLLED', NULL),
(2, 1, 'Semester 1', 2026, 'ENROLLED', NULL),
(3, 1, 'Semester 1', 2026, 'ENROLLED', NULL);

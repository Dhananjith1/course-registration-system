# Course Registration System

A simple Java Swing and MySQL project for the CMJD Object Oriented Programming coursework.

## System requirements

- JDK 17 or later
- Apache Maven 3.8 or later
- MySQL Server 8.0 or later

## Project files

The repository contains only the main files needed for this coursework:

- `source-code.zip` – Java source code (the application is kept in one `Main.java` file).
- `database.sql` – MySQL database structure and sample data.
- `pom.xml` – Maven settings and MySQL JDBC driver.
- `README.md` – Setup and user instructions.

## Setup

1. Download or clone this repository.
2. Extract `source-code.zip` into the project folder. This creates `src/Main.java`.
3. Start MySQL Server.
4. Open MySQL Workbench and run `database.sql`.
5. The script creates the `crs_db` database and adds sample users, students, courses, semesters and registrations.
6. The default database connection is username `root` with a blank password. If your MySQL password is different, set these environment variables before running the application:

   **Windows PowerShell**
   ```powershell
   $env:CRS_DB_USER="root"
   $env:CRS_DB_PASSWORD="your_mysql_password"
   ```

   **macOS / Linux**
   ```bash
   export CRS_DB_USER=root
   export CRS_DB_PASSWORD='your_mysql_password'
   ```

## Run the application

Open a terminal in the project folder after extracting the source code, then run:

```bash
mvn clean compile
mvn exec:java
```

Maven downloads the MySQL JDBC driver the first time it runs.

## Sample login accounts

| Role | Username | Password |
|---|---|---|
| Admin | admin | admin123 |
| Faculty | faculty | faculty123 |
| Student | student | student123 |

## How to use

1. Log in using one of the sample accounts.
2. **Courses:** view courses. Admin and Faculty can add or edit courses. Admin can delete courses.
3. **Students:** Admin can add, edit and delete student details.
4. **Registration:** Admin can register a student. A Student can register their own account. The system checks course capacity, prerequisites and registration dates.
5. **Academic Records:** view registrations. Admin and Faculty can enter grades.
6. **Reports:** Admin and Faculty can view course vacancies, academic progress and student schedules.
7. Students can drop their own courses during the registration period.

## Notes

- The semester dates in `database.sql` are sample dates. Change them when testing another academic year.
- Importing `database.sql` drops and recreates the CRS tables. Use it only for a test database because old records in those tables will be removed.
- The sample Student account is linked to the first student record.
- The demo accounts are for coursework testing only. Do not use them for real student data.
- Java classes are kept together in one file to make the project easier to understand and manage.

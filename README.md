# 📚 BookNest – Library Management System

## Project Overview

BookNest is a Database Management System (DBMS) capstone project designed to manage library operations such as book cataloguing, member management, book issuing, book returns, fine calculation, and report generation.

The project uses an Oracle relational database and SQL/PL-SQL for database operations. A basic web-based user interface is developed using HTML, CSS, and JavaScript.

## Objectives

- Maintain organized records of books, authors, categories, and members.
- Manage book copies and their availability.
- Record book issue and return transactions.
- Calculate fines for overdue books.
- Generate library reports using SQL queries.
- Apply database constraints, procedures, functions, and triggers.
- Demonstrate role-based access and library management through a user interface.

## Technologies Used

| Technology | Purpose |
|---|---|
| Oracle Database | Database management |
| SQL | Data definition, manipulation, and queries |
| PL/SQL | Procedures, functions, and triggers |
| HTML | Frontend structure |
| CSS | Frontend styling |
| JavaScript | Frontend interactions |
| Visual Studio Code | Development environment |
| Git & GitHub | Version control and project submission |

## Project Structure

```text
BookNest/
│
├── ER Diagrams/
│   └── BookNest_Phase1_ER_Diagram.png
│
├── Frontend Backend/
│   ├── index.html
│   ├── style.css
│   └── script.js
│
├── Project Documentation/
│
├── Screenshots Reports/
│
└── SQL PL SQL/
    ├── 01_Create_Tables.sql
    ├── 02_Insert_Data_PLSQL.sql
    ├── 03_Procedures.sql
    ├── 04_Functions.sql
    ├── 05_Triggers.sql
    ├── 06_Reports.sql
    └── 07_Security_Testing.sql
```

## Project Phases

### Phase 1 – Data Modeling & Schema Design

- Identified the entities required for a library management system.
- Designed the Entity Relationship (ER) diagram.
- Defined primary keys and foreign keys.
- Designed the relational database schema.

### Phase 2 – Procedural Implementation

- Created database tables using DDL statements.
- Inserted sample data.
- Implemented stored procedures for book issue and return operations.
- Implemented functions for fine calculation and available copy count.
- Created triggers to maintain book copy and issue status.

### Phase 3 – Query & Report Development

- Developed SQL queries for library reports.
- Generated book catalogue and inventory reports.
- Prepared issue history and overdue book reports.
- Developed fine-related reports.
- Used joins, aggregate functions, and filtering conditions.

### Phase 4 – Security, Access Control & Testing

- Prepared database security and testing scripts.
- Planned role-based access for Admin/Librarian and Member.
- Prepared test cases for valid, invalid, and boundary conditions.
- Included transaction handling and error validation requirements.

### Phase 5 – Integration, UI & Final Presentation

- Developed a basic BookNest web interface.
- Added dashboard, book catalogue, member management, issue/return, and reports sections.
- Added navigation and book search functionality.
- Prepared the interface for backend integration.

**Note:** The current frontend is a prototype. Live Oracle database integration and authenticated role-based access must be verified separately before claiming them as completed.

## Database Features

- Book and category management
- Author and book relationship management
- Physical book copy tracking
- Member records
- Book issue and return management
- Fine calculation
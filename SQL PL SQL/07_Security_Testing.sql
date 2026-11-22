/*
========================================================
BOOKNEST - PHASE 4
SECURITY, ACCESS CONTROL & TESTING
========================================================

Project: BookNest Library Management System
Database: Oracle SQL

Run after completing Phases 1, 2 and 3.

Tables:
CATEGORY, BOOK, AUTHOR, BOOK_AUTHOR, BOOK_COPY,
MEMBER, LIBRARIAN, ISSUE, BOOK_RETURN, FINE

Procedures:
ISSUE_BOOK, RETURN_BOOK

Functions:
CALCULATE_FINE, AVAILABLE_COPIES
*/

SET SERVEROUTPUT ON;


/*======================================================
PART 1: VERIFY DATABASE TABLES
======================================================*/

PROMPT 1. Checking BookNest Tables

SELECT TABLE_NAME
FROM USER_TABLES
WHERE TABLE_NAME IN (
    'CATEGORY',
    'BOOK',
    'AUTHOR',
    'BOOK_AUTHOR',
    'BOOK_COPY',
    'MEMBER',
    'LIBRARIAN',
    'ISSUE',
    'BOOK_RETURN',
    'FINE'
)
ORDER BY TABLE_NAME;


/*======================================================
PART 2: VERIFY PROCEDURES, FUNCTIONS AND TRIGGERS
======================================================*/

PROMPT 2. Checking Stored Objects

SELECT OBJECT_NAME,
       OBJECT_TYPE,
       STATUS
FROM USER_OBJECTS
WHERE OBJECT_NAME IN (
    'ISSUE_BOOK',
    'RETURN_BOOK',
    'CALCULATE_FINE',
    'AVAILABLE_COPIES'
)
ORDER BY OBJECT_TYPE, OBJECT_NAME;


/* Check compilation errors */

PROMPT 3. Checking Compilation Errors

SELECT NAME,
       TYPE,
       LINE,
       POSITION,
       TEXT
FROM USER_ERRORS
ORDER BY NAME, SEQUENCE;


/*======================================================
PART 3: CHECK INTEGRITY CONSTRAINTS
======================================================*/

PROMPT 4. Checking Constraints

SELECT TABLE_NAME,
       CONSTRAINT_NAME,
       CONSTRAINT_TYPE,
       STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN (
    'CATEGORY',
    'BOOK',
    'AUTHOR',
    'BOOK_AUTHOR',
    'BOOK_COPY',
    'MEMBER',
    'LIBRARIAN',
    'ISSUE',
    'BOOK_RETURN',
    'FINE'
)
ORDER BY TABLE_NAME;


/*======================================================
PART 4: ROLE-BASED ACCESS CONTROL (RBAC)
======================================================*/

/*
BOOKNEST SECURITY MODEL

1. ADMIN / LIBRARIAN
   - Manage books and categories.
   - Manage member records.
   - Issue books.
   - Return books.
   - View library reports.

2. MEMBER
   - View book catalogue.
   - View available books.
   - View their own issue records.
   - View their own fine details.

3. DATABASE OWNER
   - Create and manage database objects.
   - Manage authorized permissions.

SECURITY RULES

- Follow the principle of least privilege.
- Members should not directly update ISSUE records.
- Members should not directly update BOOK_COPY status.
- Members should not directly modify FINE records.
- Use controlled procedures for issue and return operations.
- Never store database passwords in source code.
*/


/*
ROLE CREATION EXAMPLE

These commands may require DBA privileges.
Execute only if your Oracle account permits them.

CREATE ROLE BOOKNEST_LIBRARIAN;
CREATE ROLE BOOKNEST_MEMBER;

Example permissions:

GRANT SELECT ON BOOK TO BOOKNEST_MEMBER;

GRANT SELECT ON CATEGORY TO BOOKNEST_MEMBER;

GRANT EXECUTE ON ISSUE_BOOK
TO BOOKNEST_LIBRARIAN;

GRANT EXECUTE ON RETURN_BOOK
TO BOOKNEST_LIBRARIAN;

Do not grant members unrestricted UPDATE or DELETE
permissions on circulation tables.
*/


/*======================================================
PART 5: AVAILABLE COPIES TEST
======================================================*/

PROMPT 5. Testing Available Copies Function

SELECT BOOK_ID,
       TITLE,
       AVAILABLE_COPIES(BOOK_ID) AS AVAILABLE_COPIES
FROM BOOK;


/* Check copy status */

PROMPT 6. Checking Book Copy Status

SELECT BOOK_ID,
       COPY_STATUS,
       COUNT(*) AS TOTAL_COPIES
FROM BOOK_COPY
GROUP BY BOOK_ID, COPY_STATUS
ORDER BY BOOK_ID;


/*======================================================
PART 6: ISSUE AND RETURN RECORD CHECK
======================================================*/

PROMPT 7. Checking Issue Records

SELECT *
FROM ISSUE
ORDER BY ISSUE_DATE DESC;


/* Check return records */

PROMPT 8. Checking Return Records

SELECT *
FROM BOOK_RETURN;


/* Check fine records */

PROMPT 9. Checking Fine Records

SELECT *
FROM FINE;


/*======================================================
PART 7: TEST CASES
======================================================*/

/*
TEST CASE 1: VALID BOOK RECORD

Action:
Insert a valid book with an existing category ID.

Expected Result:
The record should be inserted successfully.


TEST CASE 2: INVALID FOREIGN KEY

Action:
Insert a book using a category_id that does not exist.

Expected Result:
Oracle should reject the record due to
foreign key constraint violation.


TEST CASE 3: ISSUE AVAILABLE BOOK

Action:
Call ISSUE_BOOK using valid member, book and
librarian IDs.

Expected Result:
Issue record should be created.
The copy status should become ISSUED.


TEST CASE 4: ISSUE UNAVAILABLE BOOK

Action:
Attempt to issue a book when no copy is available.

Expected Result:
The procedure should display or raise an error.
No incomplete issue record should remain.


TEST CASE 5: RETURN ISSUED BOOK

Action:
Call RETURN_BOOK for an active issue.

Expected Result:
Return record should be created.
Issue status should become RETURNED.
Copy status should become AVAILABLE.


TEST CASE 6: DUPLICATE RETURN

Action:
Attempt to return the same issue again.

Expected Result:
Duplicate return should be rejected
or handled with an appropriate error.


TEST CASE 7: OVERDUE FINE

Action:
Return a book after its due date.

Expected Result:
Fine should be calculated as:

Fine = Overdue Days × ₹10


TEST CASE 8: NEGATIVE FINE

Action:
Attempt to insert a negative fine amount.

Expected Result:
CHECK constraint should reject the record.


TEST CASE 9: DUPLICATE MEMBER EMAIL

Action:
Insert a member with an email already
present in the database.

Expected Result:
UNIQUE constraint should reject the duplicate,
if email is defined as UNIQUE.


TEST CASE 10: UNAUTHORIZED ACCESS

Action:
Attempt a prohibited database operation
using a restricted member account.

Expected Result:
Oracle should deny access if the
permissions have been configured.
*/


/*======================================================
PART 8: TRANSACTION SAFETY
======================================================*/

/*
Transaction handling protects the database
from incomplete operations.

COMMIT:
Saves the transaction permanently.

ROLLBACK:
Cancels uncommitted changes.

Example of a safe test transaction:
*/

SAVEPOINT PHASE4_TEST;

/*
Perform a reversible test operation here.
Verify the result before saving.
*/

ROLLBACK TO PHASE4_TEST;


/*======================================================
PART 9: FINAL VERIFICATION
======================================================*/

PROMPT 10. Checking Disabled Constraints

SELECT TABLE_NAME,
       CONSTRAINT_NAME,
       STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN (
    'CATEGORY',
    'BOOK',
    'AUTHOR',
    'BOOK_AUTHOR',
    'BOOK_COPY',
    'MEMBER',
    'LIBRARIAN',
    'ISSUE',
    'BOOK_RETURN',
    'FINE'
)
AND STATUS <> 'ENABLED';


/* Final stored object status */

PROMPT 11. Final Object Status

SELECT OBJECT_NAME,
       OBJECT_TYPE,
       STATUS
FROM USER_OBJECTS
WHERE OBJECT_NAME IN (
    'ISSUE_BOOK',
    'RETURN_BOOK',
    'CALCULATE_FINE',
    'AVAILABLE_COPIES'
)
ORDER BY OBJECT_TYPE;


/*======================================================
PHASE 4 COMPLETED
======================================================*/

PROMPT BookNest Phase 4 Verification Completed.
PROMPT Record actual test results and screenshots.
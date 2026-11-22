
-- =========================================
-- BOOKNEST - LIBRARY MANAGEMENT SYSTEM
-- PHASE 2: PROCEDURES
-- =========================================

-- PROCEDURE 1: ISSUE A BOOK

CREATE OR REPLACE PROCEDURE ISSUE_BOOK (
    P_BOOK_ID      IN NUMBER,
    P_MEMBER_ID    IN NUMBER,
    P_LIBRARIAN_ID IN NUMBER
)
AS
    V_COPY_ID NUMBER;
BEGIN
    SELECT MIN(COPY_ID)
    INTO V_COPY_ID
    FROM BOOK_COPY
    WHERE BOOK_ID = P_BOOK_ID
      AND STATUS = 'AVAILABLE';

    IF V_COPY_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'No available copy of this book'
        );
    END IF;

    INSERT INTO ISSUE (
        COPY_ID,
        MEMBER_ID,
        LIBRARIAN_ID,
        ISSUE_DATE,
        DUE_DATE,
        ISSUE_STATUS
    )
    VALUES (
        V_COPY_ID,
        P_MEMBER_ID,
        P_LIBRARIAN_ID,
        SYSDATE,
        SYSDATE + 14,
        'ISSUED'
    );

    -- Trigger also updates the copy status
    UPDATE BOOK_COPY
    SET STATUS = 'ISSUED'
    WHERE COPY_ID = V_COPY_ID;

    DBMS_OUTPUT.PUT_LINE('Book issued successfully.');
    DBMS_OUTPUT.PUT_LINE('Copy ID: ' || V_COPY_ID);
END;
/

-- PROCEDURE 2: RETURN A BOOK

CREATE OR REPLACE PROCEDURE RETURN_BOOK (
    P_ISSUE_ID    IN NUMBER,
    P_CONDITION   IN VARCHAR2
)
AS
    V_ISSUE_STATUS VARCHAR2(20);
    V_RETURN_ID   NUMBER;
    V_FINE        NUMBER;
BEGIN
    SELECT ISSUE_STATUS
    INTO V_ISSUE_STATUS
    FROM ISSUE
    WHERE ISSUE_ID = P_ISSUE_ID;

    IF V_ISSUE_STATUS = 'RETURNED' THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'This book has already been returned'
        );
    END IF;

    INSERT INTO BOOK_RETURN (
        ISSUE_ID,
        RETURN_DATE,
        BOOK_CONDITION
    )
    VALUES (
        P_ISSUE_ID,
        SYSDATE,
        P_CONDITION
    )
    RETURNING RETURN_ID INTO V_RETURN_ID;

    -- Trigger updates issue and copy status
    V_FINE := CALCULATE_FINE(P_ISSUE_ID);

    IF V_FINE > 0 THEN
        INSERT INTO FINE (
            RETURN_ID,
            AMOUNT,
            PAYMENT_STATUS
        )
        VALUES (
            V_RETURN_ID,
            V_FINE,
            'UNPAID'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Fine generated: Rs. ' || V_FINE
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE('No fine applicable.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Book returned successfully.');
END;
/

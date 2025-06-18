-- DROP TABLES (в правильном порядке из-за связей)
DROP TABLE InsuranceProducts_BankEmployees;
DROP TABLE Insurance_products;
DROP TABLE Loan_Products;
DROP TABLE Safety;
DROP TABLE Banking_operations;
DROP TABLE Credit_Cards;
DROP TABLE Debit_Cards;
DROP TABLE Transactions;
DROP TABLE Accounts;
DROP TABLE Bank_employees;
DROP TABLE Bank_departments;
DROP TABLE Clients;

-- CREATE TABLES
CREATE TABLE Clients (
    ID INTEGER PRIMARY KEY,
    Name VARCHAR2(50),
    Surname VARCHAR2(50),
    Phone INTEGER
);

CREATE TABLE Accounts (
    ID INTEGER PRIMARY KEY,
    Account_Number INTEGER,
    Amount_of_money INTEGER,
    Clients_ID INTEGER REFERENCES Clients(ID)
);

CREATE TABLE Transactions (
    ID INTEGER PRIMARY KEY,
  Account_Number INTEGER,
    Amount INTEGER,
    SecondClientID INTEGER
);

CREATE TABLE Debit_Cards (
    ID INTEGER PRIMARY KEY,
   Account_Number INTEGER,
    CVV INTEGER,
    Amount INTEGER
);

CREATE TABLE Credit_Cards (
    ID INTEGER PRIMARY KEY,
    Account_Number INTEGER,
    CVV INTEGER,
    Amount INTEGER,
    Limit INTEGER
);

CREATE TABLE Banking_operations (
    ID INTEGER PRIMARY KEY,
    Transactions_ID INTEGER REFERENCES Transactions(ID),
    Accounts_ID INTEGER REFERENCES Accounts(ID),
    Credit_Cards_ID INTEGER REFERENCES Credit_Cards(ID),
    Debit_Cards_ID INTEGER REFERENCES Debit_Cards(ID)
);

CREATE TABLE Safety (
    ID INTEGER PRIMARY KEY,
    Login VARCHAR2(50),
    Password VARCHAR2(50),
    Clients_ID INTEGER REFERENCES Clients(ID)
);

CREATE TABLE Loan_Products (
    ID INTEGER PRIMARY KEY,
    Amount INTEGER,
    DateOfLoan TIMESTAMP,
    Clients_ID INTEGER REFERENCES Clients(ID)
);

CREATE TABLE Insurance_products (
    ID INTEGER PRIMARY KEY,
    Amount INTEGER,
    Safety_ID INTEGER REFERENCES Safety(ID),
    Safety_Clients_ID INTEGER REFERENCES Clients(ID)
);

CREATE TABLE Bank_departments (
    ID INTEGER PRIMARY KEY,
    Name VARCHAR2(50),
    MangersName VARCHAR2(50)
);

CREATE TABLE Bank_employees (
    ID INTEGER PRIMARY KEY,
    Name VARCHAR2(50),
    Surname VARCHAR2(50),
    Phone INTEGER,
    Position VARCHAR2(50),
    Salary INTEGER,
    Bank_departments_ID INTEGER REFERENCES Bank_departments(ID)
);

CREATE TABLE InsuranceProducts_BankEmployees (
    ID INTEGER PRIMARY KEY,
    Bank_employees_ID INTEGER REFERENCES Bank_employees(ID),
    Insurance_products_ID INTEGER REFERENCES Insurance_products(ID)
);

-- INSERT EXAMPLES (по 3 записи в каждую таблицу)
INSERT INTO Clients VALUES (1, 'Alice', 'Smith', 123456789);
INSERT INTO Clients VALUES (2, 'Bob', 'Johnson', 987654321);
INSERT INTO Clients VALUES (3, 'Charlie', 'Williams', 555666777);

INSERT INTO Accounts VALUES (1, 1001, 2000, 1);
INSERT INTO Accounts VALUES (2, 1002, 3500, 2);
INSERT INTO Accounts VALUES (3, 1003, 800, 3);

INSERT INTO Transactions VALUES (1, 5001, 300, 2);
INSERT INTO Transactions VALUES (2, 5002, 500, 3);
INSERT INTO Transactions VALUES (3, 5003, 150, 1);

INSERT INTO Debit_Cards VALUES (1, 1111, 123, 1000);
INSERT INTO Debit_Cards VALUES (2, 2222, 234, 500);
INSERT INTO Debit_Cards VALUES (3, 3333, 345, 750);

INSERT INTO Credit_Cards VALUES (1, 4444, 456, 2000, 5000);
INSERT INTO Credit_Cards VALUES (2, 5555, 567, 3000, 6000);
INSERT INTO Credit_Cards VALUES (3, 6666, 678, 1000, 4000);

INSERT INTO Banking_operations VALUES (1, 1, 1, 1, 1);
INSERT INTO Banking_operations VALUES (2, 2, 2, 2, 2);
INSERT INTO Banking_operations VALUES (3, 3, 3, 3, 3);

INSERT INTO Safety VALUES (1, 'alice_login', 'pass123', 1);
INSERT INTO Safety VALUES (2, 'bob_login', 'pass456', 2);
INSERT INTO Safety VALUES (3, 'charlie_login', 'pass789', 3);

INSERT INTO Loan_Products VALUES (1, 10000, TO_TIMESTAMP('2023-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Loan_Products VALUES (2, 15000, TO_TIMESTAMP('2023-03-10 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Loan_Products VALUES (3, 5000, TO_TIMESTAMP('2023-05-05 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

INSERT INTO Insurance_products VALUES (1, 300, 1, 1);
INSERT INTO Insurance_products VALUES (2, 500, 2, 2);
INSERT INTO Insurance_products VALUES (3, 200, 3, 3);

INSERT INTO Bank_departments VALUES (1, 'Finance', 'Ellen Moore');
INSERT INTO Bank_departments VALUES (2, 'Support', 'David Clark');
INSERT INTO Bank_departments VALUES (3, 'Loans', 'Sarah Lee');

INSERT INTO Bank_employees VALUES (1, 'Emma', 'Brown', 123123123, 'Manager', 90000, 1);
INSERT INTO Bank_employees VALUES (2, 'Liam', 'Davis', 321321321, 'Analyst', 70000, 2);
INSERT INTO Bank_employees VALUES (3, 'Olivia', 'Miller', 456456456, 'Clerk', 60000, 3);

INSERT INTO InsuranceProducts_BankEmployees VALUES (1, 1, 1);
INSERT INTO InsuranceProducts_BankEmployees VALUES (2, 2, 2);
INSERT INTO InsuranceProducts_BankEmployees VALUES (3, 3, 3);

-- SQL Queries for Assignment
-- 1. SELECT with JOIN and WHERE
SELECT C.Name, A."Number"
FROM Clients C
JOIN Accounts A ON C.ID = A.Clients_ID
WHERE A.Amount_of_money > 1500;

-- 2. SELECT with JOIN and WHERE
SELECT E.Name, D.Name AS NameofDepartment
FROM Bank_employees E
JOIN Bank_departments D ON E.Bank_departments_ID = D.ID
WHERE D.Name = 'Finance';

-- 3. SELECT with GROUP BY and HAVING
SELECT D.Name AS Department, AVG(E.Salary) AS AvgSalary
FROM Bank_employees E
JOIN Bank_departments D ON E.Bank_departments_ID = D.ID
GROUP BY D.Name
HAVING AVG(E.Salary) > 70000;

-- 4. SELECT with GROUP BY and HAVING
SELECT A.Clients_ID, COUNT(*) AS TotalTransactions
FROM Banking_operations B
JOIN Accounts A ON A.ID = B.Accounts_ID
GROUP BY A.Clients_ID
HAVING COUNT(*) > 0;

-- 5. SELECT with correlated subquery
SELECT C.Name, (
    SELECT COUNT(*)
    FROM Banking_operations BO
    WHERE BO.Accounts_ID IN (
        SELECT ID FROM Accounts WHERE Clients_ID = C.ID
    )
) AS Operation_count
FROM Clients C;

-- 6. SELECT with subquery (average salary)
SELECT E.Name
FROM Bank_employees E
WHERE E.Salary > (
    SELECT AVG(Salary)
    FROM Bank_employees
);

-- 7. SELECT with subquery (balance > client 2)
SELECT C.Name
FROM Clients C
WHERE C.ID <> 2
AND C.ID IN (
    SELECT A.Clients_ID
    FROM Accounts A
    WHERE A.Amount_of_money > (
        SELECT Amount_of_money
        FROM Accounts
        WHERE Clients_ID = 2
    )
);

-- 8. UPDATE with correlated subquery
UPDATE Accounts A
SET Amount_of_money = Amount_of_money + (
    SELECT SUM(T.Amount)
    FROM Transactions T
    WHERE T.AMOUNT = A.AMOUNT_OF_MONEY
)
WHERE EXISTS (
    SELECT 1
    FROM Transactions T
    WHERE T.Amount = A.AMOUNT_OF_MONEY
);

-- 9. DELETE with subquery
DELETE FROM Clients
WHERE NOT EXISTS (
    SELECT 1
    FROM Accounts
    WHERE Accounts.Clients_ID = Clients.ID
);

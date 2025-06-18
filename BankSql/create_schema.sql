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
    Number INTEGER,
    Amount_of_money INTEGER,
    Clients_ID INTEGER REFERENCES Clients(ID)
);

CREATE TABLE Transactions (
    ID INTEGER PRIMARY KEY,
    Number INTEGER,
    Amount INTEGER,
    SecondClientID INTEGER
);

CREATE TABLE Debit_Cards (
    ID INTEGER PRIMARY KEY,
    Number INTEGER,
    CVV INTEGER,
    Amount INTEGER
);

CREATE TABLE Credit_Cards (
    ID INTEGER PRIMARY KEY,
    Number INTEGER,
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

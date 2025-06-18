
SELECT C.Name, A."Number"
FROM CLIENTS C
JOIN Accounts A ON C.ID = A.Clients_ID
WHERE A.Amount_of_money > 1500;


SELECT E.Name, D.NameofDepartment
FROM Bank_employees E
JOIN Bank_departments D ON E.Bank_departments_ID = D.ID
WHERE D.NameofDepartment = 'Finance';

SELECT D.NameofDepartment, AVG(E.Salary) AS AvgSalary
FROM Bank_employees E
JOIN Bank_departments D ON E.Bank_departments_ID = D.ID
GROUP BY D.NameofDepartment
HAVING AVG(E.Salary) > 70000;


SELECT ID, COUNT(*) AS "TOTALTRANSACTIONS"
FROM Transactions
GROUP BY ID
HAVING COUNT(*) > 0;



SELECT C.Name, (
    SELECT COUNT(*)
    FROM Banking_operations BO
    WHERE BO.Accounts_iD = C.ID
) AS Operation_count
FROM Clients C;

SELECT E.Name
FROM Bank_employees E
WHERE E.Salary > (
    SELECT AVG(Salary)
    FROM Bank_employees
);

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

--

UPDATE Accounts A
SET Amount_of_money = Amount_of_money + (
    SELECT SUM(T.Amount)
    FROM Transactions T
    WHERE T."Number" = A."Number"
)
WHERE EXISTS (
    SELECT 1
    FROM Transactions T
    WHERE T."Number" = A."Number"
);

SELECT * FROM Accounts;

--
DELETE FROM CLIENTS
WHERE NOT EXISTS (
    SELECT 1
    FROM ACCOUNTS
    WHERE ACCOUNTS.clients_ID = CLIENTS.ID
);




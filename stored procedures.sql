CREATE PROCEDURE GetCustomerSummary(IN CountryName NVARCHAR(50))
BEGIN

    -- Step 1: remove nulls

    IF EXISTS(SELECT 1 FROM Customers WHERE Score IS NULL AND Country = CountryName)
    THEN
        UPDATE Customers
        SET Score = 0
        WHERE Score IS NULL AND Country = CountryName;
    ELSE
        SELECT 'No NULL scores found' AS ' ';
    END IF;

    -- Step 2: generate summary reports

    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Customers
    WHERE Country = CountryName;

    -- Step 3: calculate total number of orders and total sales for a specific country

    SELECT
        COUNT(OrderID) AS TotalOrders,
        SUM(Sales) AS TotalSales
    FROM Orders as o 
    JOIN Customers as c
    ON c.CustomerID = o.CustomerID
    WHERE c.Country = CountryName;

END

CALL GetCustomerSummary('Germany')

CALL GetCustomerSummary('USA')

DROP PROCEDURE GetCustomerSummary

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY,
    EmployeeID INT,
    LogDate DATE
)

CREATE TRIGGER trg_AfterInsertEmployee AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLogs (LogID, EmployeeID, LogDate)
    VALUES(
        EmployeeID,
        GETDATE()
    );
END;

SELECT * FROM EmployeeLogs

INSERT INTO Employees 
VALUES(7, '1988-01-12')

DROP TABLE EmployeeLogs

DROP TRIGGER trg_AfterInsertEmployee

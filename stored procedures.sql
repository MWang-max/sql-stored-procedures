CREATE PROCEDURE GetCustomerSummary(IN CountryName NVARCHAR(50))
BEGIN

-- remove nulls

IF EXISTS(SELECT 1 FROM Customers WHERE Score IS NULL AND Country = CountryName)
THEN
    UPDATE Customers
    SET Score = 0
    WHERE Score IS NULL AND Country = CountryName;
ELSE
    SELECT 'No NULL scores found' AS ' ';
END IF;

SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
FROM Customers
WHERE Country = CountryName;

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

DROP Procedure GetCustomerSummary
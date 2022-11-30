-- Table expression - An expression that creates a table
-- divide queries into multiple parts to make them easier
-- views, TVF's, Derived Tables, CTE's temp tableand table variavbles
-- Like cast convert and parse they all do similar things but with minor differences you cant user order by in views unless your using the TOP Command.

USE Northwind

CREATE VIEW dbo.ReportsToPlus AS (
SELECT m.FirstName + ' ' + m.LastName AS ManagerName, m.FirstName + ' ' + m.LastName AS EmployeeName FROM Employees AS e
JOIN Employees AS m 
ON e.ReportsTo = m.EmployeeID
)
GO
SELECT * FROM dbo.ReportsToPlus

-- TVF's
-- TOP 50 ordersbut you can specify a START YEAR and customer ID
-- TOP 50 orders placed by a customer fter a certain date


CREATE FUNCTION dbo.RevenuePerYear(@StartYear INT)
RETURNS @Revenue TABLE(FinancialYear INT, Revenue MONEY)
	BEGIN --START
	INSERT INTO @Revenue
		SELECT YEAR(OrderDate)AS [Year], sum(UnitPrice * Quantity) AS TotalRevenue
		FROM dbo.Orders AS o JOIN dbo.[Order Details] AS od ON o.OrderID = od.OrderID
		WHERE YEAR(OrderDate) >= @StartYear
		GROUP BY YEAR(OrderDate)
		ORDER BY [Year] ASC
	RETURN
END -- STOP
GO
SELECT * FROM dbo.RevenuePerYear(1998) ORDER BY FinancialYear ASC
GO

-- Derived Tables
--You do one query and give it an alias then you do a select from the aliased query.
-- Fire and forget once the other query finishes the derived table ceases to exist

SELECT * FROM (

	SELECT TOP 3 CustomerId FROM Orders GROUP BY CustomerID ORDER BY count(CustomerID)

) AS DerivedTable

--Find all the products that are priced above average for their category.
SELECT CategoryID, AVG(UnitPrice) AS AveragePrice FROM PRODUCTS HAVING UnitPrice > AVG(UnitPrice)

-- CTE Common table expression
--Temp tables

drop table #AverageLocal

CREATE TABLE #AverageLocal (
	[Year] INT,
	Average MONEY

)

INSERT INTO #AverageLocal
	SELECT	
		YEAR(o.orderDate)

select * from #AverageLocal
YEAR(o.orderDate) AS OrderYear
MONTH(o.OrderDate) AS OrderMonth
SUM(Quantity * Un) AS OrderMonth
-- 
select * from dbo.Orders AS o
INNER JOIN
dbo.order [Order Details] AS od
ON o.OrderID = od.OrderID 

-- FIND TOTAL ORDERS PER YEAR AND TOTAL ORDERS FOR LAST YEAR
SELECT 
YEAR(OrderDate), 
COUNT(OrderDate) AS ORDERYEAR,
LAG(COUNT(OrderID),1, NULL) OVER(ORDER BY YEAR(Orderdate)) AS LASTYEAR
FROM DBO.Orders
GROUP BY YEAR(OrderDate)
ORDER BY ORDERYEAR ASC


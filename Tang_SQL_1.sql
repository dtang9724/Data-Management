
-- Problem 1 | Part A
SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC;

-- Problem 1 | Part B
SELECT DISTINCT JobTitle
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager%' OR JobTitle LIKE '%Supervisor%' OR JobTitle LIKE '%Chief%' OR JobTitle LIKE '%Vice President%'
ORDER BY JobTitle ASC;

-- Problem 1 | Part C
SELECT COUNT(NationalIDNumber) AS 'Managers'
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager%' OR JobTitle LIKE '%Supervisor%' OR JobTitle LIKE '%Chief%' OR JobTitle LIKE '%Vice President%'
;

-- Problem 1 | Part D 
SELECT BusinessEntityID AS 'EmployeeID', JobTitle, BirthDate
FROM HumanResources.Employee
WHERE CurrentFlag = 1 and datediff(DAY, BirthDate, GETDATE()) > 60*365 -- Use 'DAY' because this will also count those who have already turned 60 as of today.
ORDER BY BirthDate DESC;

-- Problem 1 | Part E
SELECT BusinessEntityID AS 'EmployeeID', JobTitle, BirthDate, HireDate, datediff(DAY, HireDate, GETDATE())/365 as 'EmploymentYears'
FROM HumanResources.Employee
WHERE CurrentFlag = 1 and datediff(DAY, BirthDate, GETDATE()) > 60*365 and datediff(DAY, HireDate, GETDATE())/365 >= 7 -- Use 'DAY' because it is required to show full years.
ORDER BY EmploymentYears DESC;

-- Problem 2 | Part A
SELECT Name, ListPrice, SafetyStockLevel
FROM Production.Product
WHERE FinishedGoodsFlag = 1 AND SellEndDate is null
ORDER BY SafetyStockLevel ASC, NAME ASC;

-- Problem 2 | Part B
SELECT Name, Color
FROM Production.Product
WHERE NAME LIKE '%Yellow%' AND Color != 'Yellow'
ORDER BY Name ASC;

-- Problem 2 | Part C
SELECT Name, SellStartDate
FROM Production.Product
WHERE SellStartDate > '2013-01-01' AND SellStartDate < '2013-05-31'
ORDER BY Name ASC;

-- Problem 2 | Part D
-- Method 1 (Display weekday as a number)
SET DATEFIRST 1
SELECT Name, SellStartDate, DATEPART(WEEKDAY, SellStartDate) AS 'Weekday'
FROM Production.Product
WHERE DATEPART(WEEKDAY, SellStartDate) >= 3
ORDER BY SellStartDate ASC, NAME DESC;
-- Method 2 (Display weekday as text)
SET DATEFIRST 1
SELECT Name, SellStartDate, DATENAME(WEEKDAY,DATEPART(WEEKDAY, SellStartDate)-1) AS 'Weekday'
FROM Production.Product
WHERE DATEPART(WEEKDAY, SellStartDate) >= 3
ORDER BY SellStartDate ASC, NAME DESC;


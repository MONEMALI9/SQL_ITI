--Part-2: Use AdventureWorks DB

--1. Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema)
	--to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
SELECT salesorderid,shipdate
	FROM Sales.SalesOrderHeader
	WHERE OrderDate BETWEEN '7/28/2002' AND '7/29/2014';

--2. Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
SELECT productid,name
	FROM Production.Product
	WHERE StandardCost < 110;

--3. Display ProductID, Name if its weight is unknown
SELECT productid,name
	FROM Production.Product
	WHERE Weight IS NULL;

--4. Display all Products with a Silver, Black, or Red Color
SELECT *
	FROM Production.Product
	WHERE color IN ('silver','black','red');

--5. Display any Product with a Name starting with the letter B
SELECT *
	FROM Production.Product
	WHERE name LIKE 'b%';

--6. Run the following Query UPDATE Production.ProductDescription , SET Description = 'Chromoly steel_High of defects'
	--WHERE ProductDescriptionID = 3 Then write a query that displays any Product description with underscore value in its description.
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

SELECT * 
	FROM Production.ProductDescription
	WHERE Description LIKE '%[_]%';

--7. Calculate sum of TotalDue for each OrderDate in Sales.
	--SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'
SELECT SUM(totaldue) AS sum_total,orderdate
	FROM sales.SalesOrderHeader
	WHERE OrderDate BETWEEN '7/1/2001' AND '7/31/2014'
	GROUP BY OrderDate;

--8. Display the Employees HireDate (note no repeated values are allowed)
SELECT DISTINCT hiredate
	FROM HumanResources.Employee;

--9. Calculate the average of the unique ListPrices in the Product table
SELECT AVG(DISTINCT listprice) AS unique_avg
	FROM Production.Product;

--10. Display the Product Name and its ListPrice within the values of 100 and 120 the list should has 
	--the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)
SELECT concat('the [',name ,'] is only!',' [',listprice,']') AS product_name_price
	FROM Production.Product
	WHERE ListPrice BETWEEN 100 AND 120
	ORDER BY ListPrice;

--11  a)Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
	--Note: Check your database to see the new table and how many rows in it?
	--b)	Try the previous query but without transferring the data? 
SELECT *into store_Archive
	FROM Sales.Store
	SELECT *into store_Archivee
		FROM Sales.Store
		WHERE 1 = 2;

--12. Using union statement, retrieve the today’s date in different styles


select convert(varchar(20),getdate())
union
select cast(getdate() as varchar(20))
union
select convert(varchar(20),getdate(),102)
union
select convert(varchar(20),getdate(),103)
union
select convert(varchar(20),getdate(),104)
union
select convert(varchar(20),getdate(),105)

select format(getdate(),'dd-MM-yyyy')
union
select format(getdate(),'dddd MMMM yyyy')
union
select format(getdate(),'ddd MMM yy')
union
select format(getdate(),'dddd')
union
select format(getdate(),'MMMM')
union
select format(getdate(),'hh:mm:ss')
union
select format(getdate(),'HH')
union
select format(getdate(),'hh tt')
union
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')
union
select format(getdate(),'dd')

select day(getdate())

select eomonth(getdate())

select format(eomonth(getdate()),'dddd')
union
select format(eomonth(getdate()),'dd')
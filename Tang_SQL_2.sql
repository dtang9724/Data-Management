use AdventureWorks2014

-- problem 1 | part A
select st.Name, cast(round(sum(soh.SubTotal),0) as decimal(10,0)) as SalesRevenueByTerritory
from sales.SalesOrderHeader soh, sales.SalesTerritory st
where soh.TerritoryID = st.TerritoryID
group by st.Name
order by SalesRevenueByTerritory desc;

-- problem 1 | part B
select st.Name AS NameOfTheTerritory,
	   datepart(MM,soh.orderdate) AS Month,
	   datepart(YY,soh.orderdate) AS Year,
	   cast(round(sum(soh.SubTotal),0) as decimal(10,0)) as SalesRevenueByTerritory
from sales.SalesOrderHeader soh, sales.SalesTerritory st
where soh.TerritoryID = st.TerritoryID and datepart(YY,soh.orderdate) = 2013
group by st.Name,datepart(MM,soh.orderdate),datepart(YY,soh.orderdate)
order by st.Name asc,
		 Month asc;

-- problem 1 | part C
select DISTINCT st.Name AS AwardWinners
from sales.SalesOrderHeader soh, sales.SalesTerritory st
where soh.TerritoryID = st.TerritoryID and datepart(YY,soh.orderdate) = 2013
group by st.Name,datepart(MM,soh.orderdate),datepart(YY,soh.orderdate)
having cast(round(sum(soh.SubTotal),0) as decimal(10,0)) > 750000
order by st.Name asc;

-- problem 1 | part D
select distinct name as Underperformers
from sales.salesterritory
except 
	select DISTINCT st.Name AS AwardWinners
	from sales.SalesOrderHeader soh, sales.SalesTerritory st
	where soh.TerritoryID = st.TerritoryID and datepart(YY,soh.orderdate) = 2013
	group by st.Name,datepart(MM,soh.orderdate),datepart(YY,soh.orderdate)
	having cast(round(sum(soh.SubTotal),0) as decimal(10,0)) > 750000
order by name asc
;

-- problem 2 | part A
select p.Name, sum(sod.OrderQty) as UnitsOrdered
from Production.Product p, Sales.SalesOrderDetail sod
where p.productID = sod.productID and p.FinishedGoodsFlag = 1
group by p.Name
having sum(sod.OrderQty) < 50
order by sum(sod.OrderQty) desc
;

-- problem 2 | part B
select (CASE
		WHEN
			st.Name = 'Northwest' OR st.Name = 'Southwest' or st.Name = 'Southeaest' or st.Name = 'Southeast' or st.Name ='Central' or st.Name ='Northeast' 
			THEN 'United States'
		ELSE st.Name
		END) AS CountryName,
		max(tax.TaxRate) as MaxTaxRate
from Sales.SalesTaxRate tax, Sales.SalesTerritory st, Person.StateProvince sp
where tax.StateProvinceID = sp.StateProvinceID and sp.TerritoryID = st.TerritoryID
group by 
(CASE
		WHEN
			st.Name = 'Northwest' OR st.Name = 'Southwest' or st.Name = 'Southeaest' or st.Name = 'Southeast' or st.Name ='Central' or st.Name ='Northeast' 
			THEN 'United States'
		ELSE st.Name
		END)
order by max(tax.TaxRate) desc
;

-- problem 2 | part C
select distinct sto.name as StoreName, ste.name as TerritoryName
from sales.store sto, sales.salesterritory ste, sales.salesorderheader soh, sales.salesorderdetail sod, sales.customer cust, production.product p
where 
	  sto.businessentityid = cust.storeid and
	  cust.territoryid = ste.territoryid and
	  soh.customerid = cust.customerid and
	  soh.salesorderid = sod.salesorderid and
	  sod.productid = p.productid and
	  p.name like '%helmet%' and
	  soh.shipdate between '2014-02-01' and '2014-02-05'
order by territoryname asc,
		 storename asc;

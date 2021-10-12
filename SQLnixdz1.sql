/****** 1 ******/
SELECT  ProductName
  FROM Northwind.dbo.Products as p
 where p.CategoryID = 1
 AND UnitPrice = (SELECT MAX(UnitPrice) FROM Northwind.dbo.Products)
 /****** 2 ******/
 SELECT ShipCity
 FROM Northwind.dbo.Orders as o
 WHERE DAY(o.ShippedDate) - DAY(o.OrderDate) > 10
 /****** 3 ******/
 SELECT CustomerID
 FROM Northwind.dbo.Orders as o
 WHERE o.ShippedDate IS NULL
 /****** 4 ******/
 select count(CustomerID)
 from Northwind.dbo.Orders as o
 where OrderID = (Select max(OrderID) from Northwind.dbo.Orders)
 group by EmployeeID
 
 /****** 5 ******/
 select COUNT(City)
 from Northwind.dbo.Employees as e 
 inner join Northwind.dbo.Orders as o on o.EmployeeID = e.EmployeeID
where o.EmployeeID = 1
and ShipCountry = 'FRANCE'
and year(o.OrderDate) = 1997 

/****** 6 ******/
select distinct ShipCountry
from Northwind.dbo.Orders as o
group by ShipCountry, ShipCity
having count(OrderID) > 2
/****** 7 ******/
select ProductName
from Northwind.dbo.Products as p
join Northwind.dbo.[Order Details] as od on od.ProductID = p.ProductID
where Quantity = (select max(Quantity) from Northwind.dbo.[Order Details]) 
and Quantity < 1000
group by ProductName

/****** 8 ******/
select FirstName, LastName
from Northwind.dbo.Employees as e
join Northwind.dbo.Orders as o on e.EmployeeID = o.EmployeeID
where e.City !=o.ShipCity
group by FirstName, LastName
/****** 9 ******/
select CategoryName
from Northwind.dbo.Categories as cat
join Northwind.dbo.Products as p on cat.CategoryID = p.CategoryID
join Northwind.dbo.[Order Details] as od on od.ProductID = p.ProductID
join Northwind.dbo.Orders as o on o.OrderID = od.OrderID
join Northwind.dbo.Customers as cus on cus.CustomerID = o.CustomerID
where year(o.OrderDate) = 1997
and cus.Fax is not null
and Quantity = (select max(Quantity) from Northwind.dbo.[Order Details])
group by CategoryName
/****** 10 ******/
select LastName, FirstName, sum(od.Quantity) as AllQuantity
from Northwind.dbo.Employees as e
join Northwind.dbo.Orders as o on e.EmployeeID = o.EmployeeID
join Northwind.dbo.[Order Details] as od on o.OrderID = od.OrderID
where year(o.OrderDate) = 1996 and month(o.OrderDate) between 9 and 11
group by LastName, FirstName
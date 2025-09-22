-- QUERY 10 Soal

-- 1. Display Customer Name (obtained from the CustomerName starts with ‘Mr./Mrs. ’), Staff Name (obtained from StaffID concat by ‘ - ’ and StaffName), and Total Transaction Made (obtained from total number of sales) for each sales date occurred in 2023 and Customer that born on 1999.

SELECT CustomerName AS [Customer Name],
	   CONCAT(st.StaffID, ' - ', StaffName) AS [Staff Name],
	   COUNT(SaleID) AS [Total Transaction Made]
FROM Sale sh
	   INNER JOIN Customer c ON sh.CustomerID = c.CustomerID
	   INNER JOIN Staff st ON sh.StaffID = st.StaffID
WHERE YEAR(TransactionDate) = 2023 AND
	  YEAR(CustomerDOB) = 1999 AND
	  (CustomerName LIKE 'Mr. %' OR CustomerName LIKE 'Mrs. %')
GROUP BY CustomerName, CONCAT(st.StaffID, ' - ', st.StaffName);


-- 2. Display the Sales ID (obtained by replacing 'SH' in the salesID with 'SalesID '), ProductName, and Total Product Sold (obtained from the sum of quantity) for each SalesID where the last three digits are even, and the quantity sold was between 1 and 5 (inclusive).

SELECT REPLACE(sh.SaleID, 'SH', 'SalesID ') AS [Sales ID],
	   ProductName,
	   SUM(Quantity) AS [Total Product Sold]
FROM Sale sh
	   INNER JOIN SaleDetail sd ON sh.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
WHERE RIGHT(sh.SaleID, 3) % 2 = 0 AND
	  Quantity BETWEEN 1 AND 5
GROUP BY REPLACE(sh.SaleID, 'SH', 'SalesID '), ProductName;


-- 3. Display the PurchaseID, Staff Email (obtained by replacing the ‘@example.com’ with ‘@DigiBoxZ.com’), VendorName, Total Purchases Made (obtained from the total number of purchases), and Total Quantity (obtained from the sum of quantity) for each staff whose name length more than 5 characters and whose purchase quantity was between 1 and 5 (inclusive).

SELECT p.PurchaseID, 
	   REPLACE(StaffEmail, '@example.com', '@DigiBoxZ.com') AS [Staff Email],
	   VendorName,
	   COUNT(p.PurchaseID) AS [Total Purchases Made],
	   SUM(Quantity) AS [Total Quantity]
FROM Purchase p
	   INNER JOIN Staff s ON p.StaffID = s.StaffID
	   INNER JOIN Vendor v ON p.VendorID = v.VendorID
	   INNER JOIN PurchaseDetail pd ON p.PurchaseID = pd.PurchaseID
WHERE LEN(StaffName) > 5
GROUP BY p.PurchaseID, REPLACE(StaffEmail, '@example.com', '@DigiBoxZ.com'), VendorName
HAVING SUM(Quantity) BETWEEN 1 AND 5;


-- 4. Display the Sales ID (obtained by replacing the ‘SH’ with ‘SalesID ’), CustomerName, Sales Date (obtained from salesDate formatted as ‘MON DD, YYYY’), Sales Date Quarter (obtained from the quarter of the sales date), Total Product Sold (obtained from the sum of quantity), and Total Sales Transactions Made (obtained from total number of sales) for each sale that occurred in the 1st or 2nd quarter of 2023.

SELECT REPLACE(sh.SaleID, 'SH', 'SalesID ') AS [Sales ID], 
	   CustomerName,
	   FORMAT(TransactionDate, 'MMM dd, yyyy') AS [Sales Date],
	   DATENAME(QUARTER, TransactionDate) AS [Sales Date Quarter],
	   SUM(Quantity) AS [Total Product Sold],
	   COUNT(sh.SaleID) AS [Total Sales Transactions Made]
FROM Sale sh
	   INNER JOIN Customer c ON sh.CustomerID = c.CustomerID
	   INNER JOIN SaleDetail sd ON sh.SaleID = sd.SaleID
WHERE DATENAME(QUARTER, TransactionDate) IN (1,2) AND YEAR(TransactionDate) = 2023
GROUP BY REPLACE(sh.SaleID, 'SH', 'SalesID '), CustomerName, TransactionDate, DATENAME(QUARTER, TransactionDate);


-- 5. Display Product ID (obtained from the last 3 digits of productID), Staff Name (obtained from replacing ‘ST’ of StaffID with ‘Staff’ and concatenating it with ‘ - ’ and StaffName), Product Name (obtained by replacing ‘PT’ with ‘Product’ and concatenating it with ‘ - ’ and ProductName), Product Price, and Average Price (calculated from the average of ProductPrice) for each PurchaseID where the last three digits are odd and ProductPrice more than Average Price.

SELECT RIGHT(p.ProductID, 3) AS [Product ID], 
       CONCAT(REPLACE(st.StaffID, 'ST', 'StaffID'), ' - ', StaffName) AS [Staff Name],
	   CONCAT(REPLACE(ProductName, 'PT', 'Product'), ' - ', ProductName) AS [Product Name],
	   ProductPrice,
	   (SELECT AVG(ProductPrice) FROM Product) AS [Average Price]
FROM Product p
	   INNER JOIN SaleDetail sd ON p.ProductID = sd.ProductID
	   INNER JOIN Sale s ON sd.SaleID = s.SaleID
	   INNER JOIN Staff st ON s.StaffID = st.StaffID
WHERE RIGHT(p.ProductID, 3) % 2 = 1
GROUP BY RIGHT(p.ProductID, 3), 
       CONCAT(REPLACE(st.StaffID, 'ST', 'StaffID'), ' - ', StaffName),
	   CONCAT(REPLACE(ProductName, 'PT', 'Product'), ' - ', ProductName),
	   ProductPrice
HAVING ProductPrice > (SELECT AVG(ProductPrice) FROM Product);


-- 6. Display SalesID, Sales Date (obtained from salesDate formatted as ‘DD MON YYYY’), ProductName, CategoryName, Quantity (obtained from concatenating Quantity with ‘ PCS’), and Product Price (obtained from concatenating ProductPrice with ‘$ ’ in front of ProductPrice) for each sales occurred on 2023 and TotalPrice(obtained from total of all product price) subtract by ProductPrice must be more than 14000.

SELECT SaleID, 
       FORMAT(TransactionDate, 'dd MMM yyyy') AS [Sales Date],
	   ProductName,
	   CategoryName,
	   CONCAT(Quantity, ' PCS') AS [Quantity],
	   CONCAT('$ ', ProductPrice) AS [Product Price]
FROM (SELECT s.SaleID, TransactionDate, ProductName, CategoryName, Quantity, ProductPrice FROM Sale s
	   INNER JOIN SaleDetail sd ON s.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
	   INNER JOIN ProductCategory pc ON p.CategoryID = pc.CategoryID
       WHERE YEAR(TransactionDate) = 2023 AND 
	   (SELECT SUM(ProductPrice) FROM Product) - ProductPrice > 14000) AS Sales2023



-- 7. Display SalesID, Customer Email (obtained by replacing '@example.com' with '@DigiBoxZ.com'), Sales Date (obtained from SalesDate formatted as 'MON DD, YYYY' ), ProductName, ProductPrice, and Result of MaxPrice – MinPrice (obtained from maximum of ProductPrice substract by minimum of ProductPrice) for every sales quantity is more than 4 and the product price is less than or equal to the Result of Max Price - Min Price.

SELECT s.SaleID, 
       REPLACE(CustomerEmail, '@example.com', '@DigiBoxZ.com') AS [Customer Email],
	   FORMAT(TransactionDate, 'MMM dd, yyyy') AS [Sales Date],
	   ProductName,
	   ProductPrice,
	   (SELECT MAX(ProductPrice) - MIN(ProductPrice) FROM Product) AS [Result of MaxPrice - MinPrice]
FROM Sale s
	   INNER JOIN Customer c ON s.CustomerID = c.CustomerID
	   INNER JOIN SaleDetail sd ON s.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
WHERE quantity > 4
GROUP BY s.SaleID, 
       REPLACE(CustomerEmail, '@example.com', '@DigiBoxZ.com'),
	   FORMAT(TransactionDate, 'MMM dd, yyyy'),
	   ProductName,
	   ProductPrice
HAVING ProductPrice <= (SELECT MAX(ProductPrice) - MIN(ProductPrice) FROM Product)

-- 8. Display SalesID, VIP Customer (obtained from 'VIP CUSTOMER', ‘ - ’ concatenated with the CustomerName in uppercase format), Month (obtained from the month of the SalesDate), Total Expenses (obtained by casting the total multiplication of ProductPrice and Quantity and adding '$ ' in front of Total Expenses) for every sales that the Sales Month occurred in February, April, or July, and the total multiplication of ProductPrice and Quantity is greater than the average total multiplication of ProductPrice and Quantity.

SELECT SaleID,
       CONCAT('VIP CUSTOMER', ' - ', UPPER(CustomerName)) AS [VIP Customer],
	   MONTH(TransactionDate) AS [Month],
	   CONCAT('$ ', CAST(SUM(ProductPrice*Quantity) AS varchar)) AS [Total Expenses]
FROM (SELECT s.SaleID, CustomerName, TransactionDate, ProductPrice, Quantity FROM Sale s
       INNER JOIN Customer c ON s.CustomerID = c.CustomerID
	   INNER JOIN SaleDetail sd ON s.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
       WHERE DATENAME(MONTH, TransactionDate) IN ('February', 'April', 'July') AND
       ProductPrice*Quantity > (SELECT AVG(ProductPrice*Quantity) 
	   FROM Product p 
	   INNER JOIN SaleDetail sd ON p.ProductID = sd.ProductID)) AS MontlySales
GROUP BY SaleID,
         CONCAT('VIP CUSTOMER', ' - ', UPPER(CustomerName)),
	     MONTH(TransactionDate);


-- 9. Create a view named ‘MostAndLessBoughtProductPerCustomer’ to display Sales ID (obtained from replacing ‘SH’ of SalesID with ‘Sales ID ’), ProductID (obtained from replacing ‘PT’ of ProductID with ‘Product ID ’), SalesDate (obtained from SalesDate formatted as ‘MON DD, YYYY’), Most Bought Product (obtained from maximum of Quantity), and Less Bought Product (obtained from minimum of Quantity) for every product that the product weight is more than 180 and the product price is more than 1500.p
	   
CREATE VIEW MostAndLessBoughtProductPerCustomer AS
SELECT REPLACE(s.SaleID, 'SH', 'Sales ID ') AS [Sales ID], 
       REPLACE(p.ProductID, 'PT', 'Product ID ') AS [ProductID],
	   FORMAT(TransactionDate, 'MMM dd, yyyy') AS [SalesDate],
	   (SELECT MAX(Quantity) FROM SaleDetail WHERE ProductID = p.ProductID) AS [Most Bought Product],
	   (SELECT MIN(Quantity) FROM SaleDetail WHERE ProductID = p.ProductID) AS [Less Bought Product]
FROM Sale s
       INNER JOIN SaleDetail sd ON s.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
WHERE ProductWeight > 180 AND ProductPrice > 1500
GROUP BY s.SaleID, 
         p.ProductID,
	     TransactionDate;

		 
-- 10. Create a view named ‘SpentAboveMaximumTotalSalesCustomerIn2023’ to display Customer Name (obtained from uppercase CustomerName), Total Transaction (obtained from total multiplication of ProductPrice and Quantity), and Max Total Transaction (obtained from max of multiplication ProductPrice and Quantity) for each Sales that occurred in 2023 and the Total multiplication of ProductPrice and Quantity is more than maximum of multiplication ProductPrice and Quantity

CREATE VIEW SpentAboveMaximumTotalSalesCustomerIn2023 AS
SELECT UPPER(CustomerName) AS [Customer Name],
       SUM(ProductPrice*Quantity) AS [Total Transaction],
	   MAX(ProductPrice*Quantity) AS  [Max Total Transaction]
FROM Sale s
	   INNER JOIN Customer c ON s.CustomerID = c.CustomerID
       INNER JOIN SaleDetail sd ON s.SaleID = sd.SaleID
	   INNER JOIN Product p ON sd.ProductID = p.ProductID
WHERE YEAR(TransactionDate) = 2023
GROUP BY CustomerName
HAVING SUM(ProductPrice*Quantity) > MAX(ProductPrice*Quantity);

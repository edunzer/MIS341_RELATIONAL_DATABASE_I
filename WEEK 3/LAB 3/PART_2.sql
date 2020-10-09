-- QUESTION 1

/* 
Create a view named CustomerAddresses that shows the shipping and billing addresses for each customer in the MyGuitarShop database.
This view should return these columns from the Customers table: CustomerID, EmailAddress, LastName and FirstName.
This view should return these columns from the Addresses table: BillLine1, BillLine2, BillCity, BillState, BillZip, ShipLine1, ShipLine2, ShipCity, ShipState, and ShipZip.
Use the BillingAddressID and ShippingAddressID columns in the Customers table to determine which addresses are billing addresses and which are shipping addresses. 
*/

CREATE VIEW CustomerAddresses AS
SELECT c.CustomerID, EmailAddress, LastName, FirstName, 
    ba.Line1 AS BillLine1, ba.Line2 AS BillLine2, 
    ba.City AS BillCity, ba.State AS BillState, ba.ZipCode AS BillZip, 
    sa.Line1 AS ShipLine1, sa.Line2 AS ShipLine2, 
    sa.City AS ShipCity, sa.State AS ShipState, sa.ZipCode AS ShipZip 
FROM Customers c 
    JOIN Addresses ba ON c.BillingAddressID  = ba.AddressID
    JOIN Addresses sa ON c.ShippingAddressID = sa.AddressID

-- QUESTION 2

/*
Write a SELECT statement that returns these columns from the CustomerAddresses view that you created in exercise 1: CustomerID, LastName, FirstName, BillLine1.
*/

SELECT CustomerID, LastName, FirstName, BillLine1

FROM CustomerAddresses

-- QUESTION 3

/*
Write an UPDATE statement that updates the CustomerAddresses view you created in exercise 1 so it sets the first line of the shipping address to “1990 Westwood Blvd.” for the customer with an ID of 8.
*/

UPDATE CustomerAddresses

SET BillLine1 = '1990 Westwood Blvd.'
WHERE CustomerID = 8

-- QUESTION 4

/*
Create a view named OrderItemProducts that returns columns from the Orders, OrderItems, and Products tables.
This view should return these columns from the Orders table: OrderID, OrderDate, TaxAmount, and ShipDate.
This view should return these columns from the OrderItems table: ItemPrice, DiscountAmount, FinalPrice (the discount amount subtracted from the item price), Quantity, and ItemTotal (the calculated total for the item).
This view should return the ProductName column from the Products table.
*/

CREATE VIEW OrderItemProducts

AS
SELECT o.OrderID, OrderDate, TaxAmount, ShipDate, 
       ProductName, ItemPrice, DiscountAmount, ItemPrice - DiscountAmount AS FinalPrice, Quantity, 
       (ItemPrice - DiscountAmount) * Quantity AS ItemTotal       
FROM Orders o
    JOIN OrderItems li ON o.OrderID = li.OrderID
    JOIN Products p ON li.ProductID = p.ProductID

-- QUESTION 5

/*
Create a view named ProductSummary that uses the view you created in exercise 4. This view should return some summary information about each product.
Each row should include these columns: ProductName, OrderCount (the number of times the product has been ordered), and OrderTotal (the total sales for the product).
*/

CREATE VIEW ProductSummary

AS
SELECT ProductName, COUNT(ProductName) AS OrderCount, SUM(ItemTotal) AS OrderTotal
FROM OrderItemProducts
GROUP BY ProductName

-- QUESTION 6

/*
Write a SELECT statement that uses the view that you created in exercise 5 to get total sales for the five best selling products.
*/

SELECT TOP 5 ProductName, OrderTotal
FROM ProductSummary 
ORDER BY OrderTotal DESC

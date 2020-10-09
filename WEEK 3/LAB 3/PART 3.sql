-- QUESTION 1

/*
Write a script that declares a variable and sets it to the count of all products in the Products table. If the count is greater than or equal to 7, the script should display a message that says, “The number of products is greater than or equal to 7”. Otherwise, it should say, “The number of products is less than 7”.
*/

USE MyGuitarShop;
DECLARE @ProductCount int;
SET @ProductCount = (SELECT COUNT(ProductName)
FROM Products);
IF @ProductCount > 0 PRINT'The number of products is greater than or equal to 7';
ELSE PRINT'The number of products is less than 7';


-- QUESTION 2

/*
Write a script that uses two variables to store (1) the count of all of the products in the Products table and (2) the average list price for those products. If the product count is greater than or equal to 7, the script should print a message that displays the values of both variables. Otherwise, the script should print a message that says, “The number of products is less than 7”.
*/

USE MyGuitarShop;
DECLARE @Product_Count int;
DECLARE @AvgList_Price int;
SET @Product_Count = (SELECT COUNT(ProductName)
FROM Products);
SET @AvgList_Price = (SELECT AVG(ListPrice) FROM Products);
IF @Product_Count>=7 PRINT CONCAT('product count : ', @Product_Count);
ELSE PRINT CONCAT('list price average: ', @AvgList_Price);



-- QUESTION 3

/*
Write a script that calculates the common factors between 10 and 20. To find a common factor, you can use the modulo operator (%) to check whether a number can be evenly divided into both numbers. Then, this script should print lines that display the common factors like this:
Common factors of 10 and 20

1

2

5
*/


USE MyGuitarShop;
DECLARE @COUNTER INT
DECLARE @FACT10 INT
DECLARE @FACT20 INT
DECLARE @FACTORS varchar (100)

SET @FACT10 = 10;
SET @FACT20 = 20;
SET @COUNTER = 1;
SET @FACTORS = 'Factors of 10 and 20: ' + CHAR(13);

WHILE (@COUNTER <= 10/2)
BEGIN
IF ( @FACT10 %  @COUNTER = 0 AND @FACT20 % @COUNTER = 0)
SET @FACTORS = CONCAT (@FACTORS, @COUNTER, ' ', CHAR(13));
SET @COUNTER = @COUNTER + 1;
END
SELECT @FACTORS
	   
-- QUESTION 4

/*
Write a script that attempts to insert a new category named “Guitars” into the Categories table. If the insert is successful, the script should display this message:
SUCCESS: Record was inserted.

If the update is unsuccessful, the script should display a message something like this:

FAILURE: Record was not inserted.

Error 2627: Violation of UNIQUE KEY constraint 'UQ__Categori__8517B2E0A87CE853'. Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key value is (Guitars).
*/

USE MyGuitarShop;
GO
DECLARE @ERR INT = 0;

INSERT INTO Categories 
  (CategoryID, CategoryName)
VALUES 
  (5, 'Guitars');

SET @ERR = @@ERROR;
IF (@ERR = 0)
BEGIN
PRINT 'SUCCESS: Record was inserted';
END
ELSE IF (@ERR = 2627)
BEGIN
PRINT 'FAILURE: Record was not inserted.';
PRINT 'Error 2627: Violation of UNIQUE KEY constraint ''UQ__Categori__8517B2E0A87CE853''.' ;
PRINT 'Cannot insert duplicate key in object ''dbo.Categories''. The duplicate key value ';
END
ELSE
BEGIN
PRINT 'FAILURE: Record was not inserted.';
PRINT 'Error ' + STR(@ERR, 6, 0) + ' was not gracefully handled';
END
GO

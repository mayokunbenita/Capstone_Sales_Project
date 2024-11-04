CREATE DATABASE CAPSTONEPROJECT

SELECT * FROM [dbo].[SALESDATA]

DELETE FROM [dbo].[SALESDATA] 
WHERE Customer_Id IS NULL AND REGION IS NULL AND QUANTITY IS NULL


1-----TOTAL SALES OF EACH PRODUCT CATEGORY------------ 

SELECT SUM(SALES) AS TOTAL_SALES_SHIRT FROM [dbo].[SALESDATA] WHERE PRODUCT = 'SHIRT'
SELECT SUM(SALES) AS TOTAL_SALES_SHOES FROM [dbo].[SALESDATA] WHERE PRODUCT = 'SHOES'
SELECT SUM(SALES) AS TOTAL_SALES_HAT FROM [dbo].[SALESDATA] WHERE PRODUCT = 'HAT'
SELECT SUM(SALES) AS TOTAL_SALES_SOCKS FROM [dbo].[SALESDATA] WHERE PRODUCT = 'SOCKS'
SELECT SUM(SALES) AS TOTAL_SALES_JACKET FROM [dbo].[SALESDATA] WHERE PRODUCT = 'JACKET'
SELECT SUM(SALES) AS TOTAL_SALES_GLOVES FROM [dbo].[SALESDATA] WHERE PRODUCT = 'GLOVES'

2----------NUMBER OF SALES TRANSACTION IN EACH REGION-------- 

SELECT region,
COUNT(OrderID) AS REGIONALSALES FROM [dbo].[SALESDATA]
GROUP BY REGION
ORDER BY REGIONALSALES DESC


3-------- HIGHEST SELLING PRODUCT BY TOTAL SALES VALUE-------------

SELECT TOP 1 (PRODUCT), 
SUM(SALES) AS TOTALSALES FROM[dbo].[SALESDATA]
GROUP BY PRODUCT

4--------CALCULATE TOTAL REVENUE PER PRODUCT--------

SELECT PRODUCT,
SUM(SALES) AS TOTALREVENUE FROM[dbo].[SALESDATA]
GROUP BY PRODUCT
ORDER BY TOTALREVENUE DESC

5-------CALCULATE MONTHLY SALES TOTALS FOR THE CURRENT YEAR-------

SELECT MONTH(ORDERDATE) AS MONTH,
SUM(SALES) AS MONTHLY_TOTAL_SALES
FROM [dbo].[SALESDATA]
WHERE YEAR(ORDERDATE)=YEAR(GETDATE())
GROUP BY MONTH(ORDERDATE)
ORDER BY MONTH

6-------TOP 5 CUSTOMERS BY TOTAL PURCHASE AMOUNT------

SELECT TOP (5) Customer_Id,
SUM(SALES) as Total_Purchase
FROM [dbo].[SALESDATA]
GROUP BY Customer_id
ORDER BY Total_Purchase DESC

7---------PERCENTAGE OF TOTAL SALES CONTRIBUTED BY EACH REGION------

SELECT REGION,
SUM(SALES) AS PECENTAGE_REG_SALES,
(SUM (SALES)*100.0/(SELECT SUM(SALES)
FROM[dbo].[SALESDATA])) AS PERCENTAGE_REG_SALES FROM[dbo].[SALESDATA]
GROUP BY REGION
ORDER BY PERCENTAGE_REG_SALES DESC

8-------PRODUCTS WITH NO SALES IN THE LAST QUARTER----------


SELECT DISTINCT PRODUCT FROM [dbo].[SALESDATA]
GROUP BY PRODUCT HAVING SUM(CASE WHEN ORDERDATE BETWEEN '2024-06-01' AND '2024-08-31'
THEN 1 ELSE 0 END) = 0

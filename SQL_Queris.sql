---Examine the first few rows of the table.

SELECT * FROM default.sales_data_sample_csv
LIMIT 10 

  
--- Check for missing Values in teh dataset

SELECT
      COUNT(*) AS Total_Orders,
      COUNT(*) - COUNT(QUANTITYORDERED) AS QUANTITYORDERED_Null,
      COUNT(*) - COUNT(PRICEEACH) AS PRICEEACH_Null,
      COUNT(*) - COUNT(ORDERLINENUMBER) AS ORDERLINENUMBER_Null,
      COUNT(*) - COUNT(SALES) AS SALES_Null,
      COUNT(*) - COUNT(ORDERDATE) AS ORDERDATE_Null,
      COUNT(*) - COUNT(STATUS) AS STATUS_Null,
      COUNT(*) - COUNT(QTR_ID) AS QTR_ID_Null,
      COUNT(*) - COUNT(MONTH_ID) AS MONTH_ID_Null,
      COUNT(*) - COUNT(YEAR_ID) AS YEAR_ID_Null,
      COUNT(*) - COUNT(PRODUCTLINE) AS PRODUCTLINE_Null,
      COUNT(*) - COUNT(MSRP) AS MSRP_Null,
      COUNT(*) - COUNT(PRODUCTCODE) AS PRODUCTCODE_Null,
      COUNT(*) - COUNT(CUSTOMERNAME) AS CUSTOMERNAME_Null,
      COUNT(*) - COUNT(PHONE) AS PHONE_Null,
      COUNT(*) - COUNT(ADDRESSLINE1) AS ADDRESSLINE1_Null,
      COUNT(*) - COUNT(ADDRESSLINE2) AS ADDRESSLINE2_Null,
      COUNT(*) - COUNT(CITY) AS CITY_Null,
      COUNT(*) - COUNT(STATE) AS STATE_Null,
      COUNT(*) - COUNT(POSTALCODE) AS POSTALCODE_Null,
      COUNT(*) - COUNT(COUNTRY) AS COUNTRY_Null,
      COUNT(*) - COUNT(TERRITORY) AS TERRITORY_Null,
      COUNT(*) - COUNT(CONTACTLASTNAME) AS CONTACTLASTNAME_Null,
      COUNT(*) - COUNT(CONTACTFIRSTNAME) AS CONTACTFIRSTNAME_Null,
      COUNT(*) - COUNT(DEALSIZE) AS DEALSIZE_Null
FROM default.sales_data_sample_csv


--- Decide on an appropriate strategy based on teh extent of missing values and time constraints, such as filtering or basic imputation. 
SELECT 
      ORDERNUMBER,
      CITY,
      STATE,
      POSTALCODE
FROM default.sales_data_sample_csv
WHERE STATE IS NULL
      OR POSTALCODE IS NULL

--- Find out the percentage of Null Values in dataset. 

WITH sub_sales AS (
    SELECT 
      COUNT(*) AS Total_Orders,
      COUNT(*) - COUNT(ADDRESSLINE2) AS ADDRESSLINE2_Null,
      COUNT(*) - COUNT(STATE) AS STATE_Null,
      COUNT(*) - COUNT(POSTALCODE) AS POSTALCODE_Null
FROM default.sales_data_sample_csv
) 
SELECT
      ROUND((ADDRESSLINE2_Null / Total_Orders) * 100,2) AS Per_Addressline2_of_Null,
      ROUND((STATE_Null / Total_Orders) * 100,2) AS Per_State_of_Null,
      ROUND((POSTALCODE_Null / Total_Orders) * 100,2) AS Per_PostalCode_of_Null
FROM sub_sales

  --- Change the Null Values to "N/A", "Uknown","00000"

SELECT
      ORDERNUMBER,
      COALESCE(ADDRESSLINE2, 'N/A') AS ADDRESSLINE2_Clean,
      COALESCE(STATE, "Uknown") AS STATE_Clean,
      COALESCE(POSTALCODE, "00000") AS POSTALCODE_Clean
FROM default.sales_data_sample_csv



--- Examine teh data types of each column, ensuring 'Order Date' is a date type and numerical columns like Sales and Quantity are numeric.

DESCRIBE TABLE default.sales_data_sample_csv

---- Change the type of the columns to the required type such "INT","FLOAT","DOUBLE" and etc..

SELECT 
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(QUANTITYORDERED AS INT) AS Quantity_Ordered_Clean,
      CAST(PRICEEACH AS FLOAT) AS Price_Each_Clean,
      CAST(ORDERLINENUMBER AS INT) AS Order_Line_Number_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean,
      CAST(ORDERDATE as DATE) AS Order_date_Clean
 FROM default.sales_data_sample_csv

--- Cleaning the dataset:

SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(QUANTITYORDERED AS INT) AS Quantity_Ordered_Clean,
      CAST(PRICEEACH AS FLOAT) AS Price_Each_Clean,
      CAST(ORDERLINENUMBER AS INT) AS Order_Line_Number_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      STATUS,
      QTR_ID,
      MONTH_ID,
      YEAR_ID,
      PRODUCTLINE,
      MSRP,
      PRODUCTCODE,
      CUSTOMERNAME,
      PHONE,
      ADDRESSLINE1,
      COALESCE(ADDRESSLINE2, 'N/A') AS ADDRESSLINE2_Clean,
      CITY,
      COALESCE(STATE, "Uknown") AS STATE_Clean,
      COALESCE(POSTALCODE, "00000") AS POSTALCODE_Clean,
      COUNTRY,
      TERRITORY,
      CONTACTLASTNAME,
      CONTACTFIRSTNAME,
      DEALSIZE
FROM default.sales_data_sample_csv


---Identify and handle duplicate records using SQL queries with Group By and COUNT(*) or DataFrame methods like dropDuplicates().

SELECT 
    ORDERNUMBER,
    COUNT(*) AS COUNT
FROM default.sales_data_sample_csv
GROUP BY ORDERNUMBER
HAVING COUNT(*) > 1


--- Show the order number that is order one time.

SELECT * FROM default.sales_data_sample_csv
WHERE ORDERNUMBER IN (SELECT ORDERNUMBER FROM default.sales_data_sample_csv
GROUP BY ORDERNUMBER
HAVING COUNT(*) = 1)

--- Calculate basic descriptive statistics for relavant numerical columns using SQL functions such as COUNT(), AVG(), MIN(), and MAX().
  
WITH Clean_data AS (
  SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(QUANTITYORDERED AS INT) AS Quantity_Ordered_Clean,
      CAST(PRICEEACH AS FLOAT) AS Price_Each_Clean,
      CAST(ORDERLINENUMBER AS INT) AS Order_Line_Number_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      STATUS,
      QTR_ID,
      MONTH_ID,
      YEAR_ID,
      PRODUCTLINE,
      MSRP,
      PRODUCTCODE,
      CUSTOMERNAME,
      PHONE,
      ADDRESSLINE1,
      COALESCE(ADDRESSLINE2, 'N/A') AS ADDRESSLINE2_Clean,
      CITY,
      COALESCE(STATE, "Uknown") AS STATE_Clean,
      COALESCE(POSTALCODE, "00000") AS POSTALCODE_Clean,
      COUNTRY,
      TERRITORY,
      CONTACTLASTNAME,
      CONTACTFIRSTNAME,
      DEALSIZE
FROM default.sales_data_sample_csv
)
SELECT
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Sales_clean),2) AS Avg_sales,
    MIN(Sales_clean) AS Min_sales,
    MAX(Sales_clean) AS Max_sales,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data


--- Based on the GlobalMart scenario, identify metrics to analyze total sales, regional performance, top-selling products and slaes trends over time.

WITH Clean_data AS (
  SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(QUANTITYORDERED AS INT) AS Quantity_Ordered_Clean,
      CAST(PRICEEACH AS FLOAT) AS Price_Each_Clean,
      CAST(ORDERLINENUMBER AS INT) AS Order_Line_Number_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      STATUS,
      QTR_ID,
      MONTH_ID,
      YEAR_ID,
      PRODUCTLINE,
      MSRP,
      PRODUCTCODE,
      CUSTOMERNAME,
      PHONE,
      ADDRESSLINE1,
      COALESCE(ADDRESSLINE2, 'N/A') AS ADDRESSLINE2_Clean,
      CITY,
      COALESCE(STATE, "Uknown") AS STATE_Clean,
      COALESCE(POSTALCODE, "00000") AS POSTALCODE_Clean,
      COUNTRY,
      TERRITORY,
      CONTACTLASTNAME,
      CONTACTFIRSTNAME,
      DEALSIZE
FROM default.sales_data_sample_csv
)
SELECT
    COUNT(DISTINCT OrderNumber_Clean) AS Total_Orders,
    SUM(Quantity_Ordered_Clean) AS Total_Quantity,
    ROUND(SUM(Sales_clean),2) AS Total_sales,
    SUM(Sales_clean) / COUNT(DISTINCT OrderNumber_Clean) AS Avg_Order_Value
FROM Clean_data


---Sales Trend Over Time: Extract time components (Using OrderDate, Month_ID, QTR_ID, and Year_ID) and aggregate sales by month.

WITH Clean_data AS (
  SELECT
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      CAST(QTR_ID AS INT) AS QTR_ID_Clean,
      CAST(MONTH_ID AS INT)AS Month_ID_Clean,
      CAST(YEAR_ID AS INT) AS Year_ID_Clean
FROM default.sales_data_sample_csv
)
SELECT
    Year_ID_Clean,
    Month_ID_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY Year_ID_Clean, Month_ID_Clean
ORDER BY Year_ID_Clean, Month_ID_Clean


---Sales Trend Over Time: Extract time components (Using OrderDate, Month_ID, QTR_ID, and Year_ID) and aggregate sales by quarter*/

WITH Clean_data AS (
  SELECT
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      CAST(QTR_ID AS INT) AS QTR_ID_Clean,
      CAST(MONTH_ID AS INT)AS Month_ID_Clean,
      CAST(YEAR_ID AS INT) AS Year_ID_Clean
FROM default.sales_data_sample_csv
)
SELECT
    Year_ID_Clean,
    QTR_ID_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY Year_ID_Clean, QTR_ID_Clean
ORDER BY Year_ID_Clean, QTR_ID_Clean


--- Top 10 highest Orders by Sales:

WITH Clean_data AS (
  SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean
FROM default.sales_data_sample_csv
)
SELECT
    OrderNumber_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY OrderNumber_Clean
ORDER BY Total_sales DESC
LIMIT 10

/* KPI Widgets: 
1. Total Sales Revenue.
2. Number of Orders
3. Aver Order Value */

WITH Clean_data AS (
  SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean
FROM default.sales_data_sample_csv
)
SELECT
    COUNT(DISTINCT OrderNumber_Clean) AS Number_Of_Orders,
    ROUND(SUM(Sales_clean),2) AS Total_sales_Revenue,
    ROUND(SUM(Sales_clean) / COUNT(DISTINCT OrderNumber_Clean),2) AS Avg_Order_Value
FROM Clean_data


--- Sales Trend Over Time Sales Revenue per quarter and year:

WITH Clean_data AS (
  SELECT
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      CAST(QTR_ID AS INT) AS QTR_ID_Clean,
      CAST(MONTH_ID AS INT)AS Month_ID_Clean,
      CAST(YEAR_ID AS INT) AS Year_ID_Clean
FROM default.sales_data_sample_csv
)
SELECT
    Year_ID_Clean,
    QTR_ID_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY Year_ID_Clean, QTR_ID_Clean
ORDER BY Year_ID_Clean, QTR_ID_Clean

--- Sales (Revenue) Per month and year.

WITH Clean_data AS (
  SELECT
      CAST(SALES AS DOUBLE) AS Sales_clean,
      TO_DATE(SPLIT(ORDERDATE, ' ')[0],'M/d/yyy') AS Order_date_Clean,
      CAST(QTR_ID AS INT) AS QTR_ID_Clean,
      CAST(MONTH_ID AS INT)AS Month_ID_Clean,
      CAST(YEAR_ID AS INT) AS Year_ID_Clean
FROM default.sales_data_sample_csv
)
SELECT
    Year_ID_Clean,
    Month_ID_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY Year_ID_Clean, Month_ID_Clean
ORDER BY Year_ID_Clean, Month_ID_Clean

--- Find the top 5 Orderes per Sale:

WITH Clean_data AS (
  SELECT
      CAST(ORDERNUMBER AS INT ) AS OrderNumber_Clean,
      CAST(SALES AS DOUBLE) AS Sales_clean
FROM default.sales_data_sample_csv
)
SELECT
    OrderNumber_Clean,
    ROUND(SUM(Sales_clean),2) AS Total_sales
FROM Clean_data
GROUP BY OrderNumber_Clean
ORDER BY Total_sales DESC
LIMIT 5

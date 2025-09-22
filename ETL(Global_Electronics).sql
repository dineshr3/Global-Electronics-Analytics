USE global_electronics_retailer;

-- Create Modified Sales Table
CREATE TABLE New_Sales_modified
LIKE Sales;

INSERT new_sales_modified
SELECT *
FROM Sales;

-- Create Modified Products Table
CREATE TABLE product_modified
LIKE products;

Insert product_modified 
select * 
From products;

-- Removing Duplicates within Tables
WITH Sales_CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY `Order Number`, `Line Item`, `ProductKey`, `StoreKey`, `CustomerKey`
           ) AS Row_Num
    FROM new_sales_modified
)
SELECT *
FROM Sales_CTE
WHERE Row_Num > 1;

SELECT * From Products;

WITH Product_CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY `ProductKey`, `Product Name`, `Brand`, `Color`, `SubcategoryKey`, `CategoryKey`
           ) AS Row_Num
    FROM product_modified
)
SELECT *
FROM Product_CTE
WHERE Row_Num > 1;

WITH Customers_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY CustomerKey, Gender, Name, 
                   City, State, Country) AS Row_Num
FROM customers
)
SELECT *
FROM customers_CTE
WHERE Row_Num > 1;

-- Updating Date Columns (Customers)
SELECT Birthday,
STR_TO_DATE(Birthday, '%m/%d/%Y')
FROM customers;
UPDATE customers
SET Birthday = STR_TO_DATE(Birthday, '%m/%d/%Y');

SELECT * From customers;

-- Updating Date Columns (stores)
SELECT `Open Date`, STR_TO_DATE(`Open Date`, '%m/%d/%Y') AS OpenDate_Formatted
FROM stores;

ALTER TABLE stores MODIFY COLUMN `Open Date` VARCHAR(10);

-- Then update all rows to MM/DD/YYYY
UPDATE stores
SET `Open Date` = DATE_FORMAT(
    CASE
        WHEN `Open Date` LIKE '%/%' THEN STR_TO_DATE(`Open Date`, '%m/%d/%Y')
        WHEN `Open Date` LIKE '%-%' THEN STR_TO_DATE(`Open Date`, '%Y-%m-%d')
        ELSE NULL
    END,
    '%m/%d/%Y'
);

UPDATE stores
SET `Square Meters` = NULL
WHERE `Square Meters` = '';
SELECT * FROM stores;

-- Updating Date Columns (Exchange Rates)
SELECT * FROM exchange_rates;
SELECT `Date`,
STR_TO_DATE(`Date`, '%m/%d/%Y')
FROM exchange_rates;

UPDATE exchange_rates 
set `Date` = str_to_date(`Date`,'%m/%d/%Y');

-- Updating Date Columns (New_sales_modified)
SELECT `Order Date`, STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
  `Delivery Date`, STR_TO_DATE(`Delivery Date`, '%m/%d/%Y')
FROM new_sales_modified;
UPDATE new_sales_modified set `Order Date` = str_to_date(`Order Date`, '%m/%d/%Y');
UPDATE new_sales_modified
SET `Delivery Date` = CASE
    WHEN `Delivery Date` LIKE '%/%' THEN STR_TO_DATE(`Delivery Date`, '%m/%d/%Y')
    WHEN `Delivery Date` LIKE '%-%' THEN STR_TO_DATE(`Delivery Date`, '%m-%d-%Y')
    ELSE NULL
END
WHERE `Delivery Date` != '';
UPDATE new_sales_modified
SET `Delivery Date` = NULL
WHERE `Delivery Date` = '';


Select * From new_sales_modified;

-- Updating Date Columns (New_Sales)
SELECT `Order Date`, STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
  `Delivery Date`, STR_TO_DATE(`Delivery Date`, '%m/%d/%Y')
FROM sales;
UPDATE sales
SET `Order Date` = CASE
    WHEN `Order Date` LIKE '%/%' THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    WHEN `Order Date` LIKE '%-%' THEN STR_TO_DATE(`Order Date`, '%m-%d-%Y')
    ELSE NULL
END
WHERE `Order Date` IS NOT NULL AND `Order Date` != '';
UPDATE sales
SET `Delivery Date` = NULL
WHERE `Delivery Date` = '';

UPDATE sales
SET `Delivery Date` = STR_TO_DATE(`Delivery Date`, '%m/%d/%Y')
WHERE `Delivery Date` IS NOT NULL;

-- Recent Exchange Rates
CREATE TABLE Recent_Exchange_Rates
LIKE exchange_rates;

INSERT Recent_Exchange_Rates
SELECT *
FROM exchange_rates
WHERE `Date` = '2021-02-20';

-- Modifying UnitCost & UnitPrice columns
UPDATE product_modified
SET `Unit Price USD` = CAST(REPLACE(`Unit Price USD`, '$', '') AS DECIMAL);

UPDATE product_modified
SET `Unit Cost USD` = CAST(REPLACE(`Unit Cost USD`, '$', '') AS DECIMAL);

Select * From product_modified;
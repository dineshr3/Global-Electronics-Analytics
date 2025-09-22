USE global_electronics_retailer;

-- Types of products sold, and customers location?
SELECT DISTINCT  Category, Subcategory, COUNT(category) AS Quantity
FROM product_modified
GROUP BY Category, Subcategory
ORDER BY Category;

-- Count of Customers by Continent and Country 
SELECT Continent, Country, 
  COUNT(Country) AS Count
FROM customers
GROUP BY Continent, Country;

-- Seasonal Patterns & Trends for Order Volume and Revenue
SELECT Month_Name, 
        Year_Name,
        SUM(QTY) AS Order_Volume, 
        ROUND(SUM(Revenue),2) AS Total_Revenue_USD From
(SELECT monthname(sal.`Order Date`) as month_name,year(sal.`Order Date`) as year_name,sum(sal.Quantity) as QTY,sum(sal.Quantity * prod.`Unit Cost USD` * Exchange) as Revenue
From
new_sales_modified as sal left join product_modified as prod
on sal.ProductKey=prod.ProductKey left join recent_exchange_rates as exc
on exc.Currency=sal.`Currency Code`
group by monthname(sal.`Order Date`), year(sal.`Order Date`)
  ) AS agg_table
  GROUP BY Year_Name, Month_Name
;

-- Average Delivery Time in Days
SELECT AVG(Delivery_Time) as AVG_Delivery_Time From(
SELECT `Order Date`,`Delivery Date`,CAST(datediff(`Delivery Date`,`Order Date`) AS SIGNED) AS Delivery_Time FROM new_sales_modified
where `Delivery Date` is Not null) as Agg_Table2;

-- Trend of Average Delivery Time by Month and Years
WITH Delivery_CTE AS (
    SELECT 
        YEAR(`Delivery Date`) AS Delivery_year,
        MONTH(`Delivery Date`) AS Delivery_month_number,
        MONTHNAME(`Delivery Date`) AS Delivery_month,
        AVG(DATEDIFF(`Delivery Date`, `Order Date`)) AS Avg_Delivery_Time
    FROM new_sales_modified
    WHERE `Delivery Date` IS NOT NULL
      AND `Order Date` IS NOT NULL
    GROUP BY YEAR(`Delivery Date`), MONTH(`Delivery Date`), MONTHNAME(`Delivery Date`)
)
SELECT *
FROM Delivery_CTE
ORDER BY Delivery_year, Delivery_month_number;

-- Average Order Value for In-Store & Online Sales
WITH Store_CTE AS (
    SELECT
        CASE
            WHEN st.Country = 'Online' OR st.Country IS NULL THEN 'Online'
            ELSE 'In-Store'
        END AS Stores,
        SUM(sal.Quantity) AS Order_Volume,
        SUM(sal.Quantity * prod.`Unit Cost USD` * exc.Exchange) AS Revenue
    FROM new_sales_modified AS sal
    LEFT JOIN stores AS st
        ON sal.StoreKey = st.StoreKey
    JOIN product_modified AS prod
        ON prod.ProductKey = sal.ProductKey
    JOIN recent_exchange_rates AS exc
        ON exc.Currency = sal.`Currency Code`
    GROUP BY CASE
        WHEN st.Country = 'Online' OR st.Country IS NULL THEN 'Online'
        ELSE 'In-Store'
    END
)
SELECT Stores, ROUND((Revenue / Order_Volume), 2) AS Avg_Order_Value
FROM Store_CTE;

-- Customers Age Range
create view Customers_Age_and_Gender as
Select name, gender,timestampdiff(YEAR,Birthday,CURDATE()) as Age
From Customers;


SELECT gender,Avg(Age) From Customers_Age_and_Gender group by Gender;

-- Total Orders & Revenue by Customers
Select name,Country, sum(Quantity) as Total_Orders,
round(sum(Revenue),2) as Total_revenue_USD
From
(SELECT name,
Quantity,
Country,
(Quantity*`Unit Cost USD`*Exchange) as Revenue
From new_sales_modified as Sal 
join Customers as Cus on Sal.CustomerKey = Cus.CustomerKey
join product_modified as prod on Sal.ProductKey = prod.ProductKey
join recent_exchange_rates as exc on exc.Currency=Sal.`Currency Code`
) As Agg_table5
group by Name, Country
order by name;

-- Total Gender Count of Customers
SELECT Gender, COUNT(Gender) AS Count
FROM customers_age_and_gender
GROUP BY Gender;

-- Total Orders for Online & In-Strore Sales
WITH All_Stores_CTE AS (
    SELECT 
        CASE
            WHEN st.StoreKey IS NULL OR country = 'Online' THEN 'Online'
            ELSE 'In-store'
        END AS Stores,
        SUM(Quantity) AS Order_Volume
    FROM new_sales_modified AS sal
    LEFT JOIN stores AS st
        ON st.StoreKey = sal.StoreKey
    GROUP BY 
        CASE
            WHEN st.StoreKey IS NULL OR country = 'Online' THEN 'Online'
            ELSE 'In-store'
        END
)
SELECT Stores, Order_Volume AS Total_Order_Volume
FROM All_Stores_CTE;

-- Profit, Revenue, Total Cost, Average Order Value by Products Category
WITH Products_CTE AS
        (SELECT Quantity, 
                Category,
                (Quantity * `Unit Price USD` *Exchange) AS Revenue,
                (Quantity * `Unit Cost USD` * Exchange) AS Cost
        FROM new_sales_modified AS sal
        LEFT JOIN product_modified AS prod
              ON prod.ProductKey = sal.ProductKey 
        LEFT JOIN recent_exchange_rates AS exc
              ON exc.Currency = sal.`Currency Code`
        )
SELECT Category AS Product_Category,
        SUM(Quantity) AS Total_Order_Vol,
        ROUND(SUM(Cost),2) AS Total_Cost_USD, 
        ROUND(SUM(Revenue),2) AS Total_Revenue_USD,
        ROUND(SUM(Revenue - Cost),2) AS Profit_USD,
        ROUND(SUM(Revenue)/SUM(Quantity),2) AS Avg_Order_Value
FROM Products_CTE
GROUP BY Category
ORDER BY Category
;

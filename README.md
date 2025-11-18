# 📊 Global Electronics Retailer – Power BI & SQL Project

## 📌 Project Overview

This Power BI project analyzes six years of sales, customer behavior, product performance, and delivery efficiency across global regions such as North America, Europe, and Australia. The dashboard is designed to help business leaders quickly understand overall performance and give regional managers the insights they need to make better decisions. One key part of the report is Average Delivery Days (4.53 days), which helps track operational efficiency and customer experience. Combined with sales and customer insights, it offers a holistic view of how the business performs end-to-end.
---

## 🗄 SQL Data Preparation

Before visualization, the raw dataset was cleaned and transformed in MySQL:

- Imported CSV tables into MySQL database.
- Created modified tables for Sales, Products, Customers, and Stores.
- Removed duplicates using `ROW_NUMBER()` and CTEs.
- Converted string dates to `DATE` format using `STR_TO_DATE`.
- Cleaned missing values (NULL handling).
- Converted `UnitPrice` and `UnitCost` columns to numeric values for calculations.
- Extracted the most recent exchange rates for analysis.

---

## 🔗 Connecting MySQL to Power BI

- Used Power BI’s MySQL connector to establish a direct connection.
- Imported cleaned tables: Sales, Products, Customers, Stores, Exchange_Rates.
- Built a Calendar Lookup table in Power BI for time intelligence.
- Created relationships between the fact table (Sales) and dimension tables (Products, Customers, Stores).

---

## 📈 Power BI Development

Designed interactive dashboards with slicers and visuals to explore:

- Sales performance across years, regions, and categories.
- Customer demographics (age, gender, country).
- Revenue & Profit trends (monthly & yearly).
- Delivery performance (order date vs. delivery date).
- Seasonal insights and forecasting.
- Customer-specific KPIs: Total Revenue and Orders per customer.
- Product-specific KPIs: Total products and quantity by category.
- Regional analysis: Orders by country and continent.
- Monthly KPIs: Orders, Revenue, Profit with goals and % difference.
- Price adjustment simulation to forecast revenue/profit impact.

---
## 🏠 Page 1 – Business Overview Dashboard
<img width="1141" height="661" alt="image" src="https://github.com/user-attachments/assets/d6f69ea7-a1fd-42da-adc8-136bb4d266c4" />

This page provides the complete business summary at a glance. It covers six years of global performance with KPIs including Total Revenue (₹55.76M), Total Profit (₹32.66M), and Total Orders (26K).
A yearly order trend line helps identify peak demand seasons, and visuals like category-wise order distribution and age-based customer segments show who buys the most and what products drive demand.

## 👥 Page 2 – Customer Insights & Regional Breakdown
<img width="1141" height="663" alt="image" src="https://github.com/user-attachments/assets/4c9dc040-7ad5-46da-8920-c4542f2c407e" />

This page focuses on customer behavior and country-level performance.
It highlights key metrics such as Total Customers (15K) and Total Unique Products (2492).
The dashboard includes:

-Top customers ranked by revenue contribution

-Country-wise total orders and profit

-Age and gender demographics

-Continent-based order distribution
This page helps decision-makers identify high-value customers and regions with potential for targeted marketing.

## 📈 Page 3 – Performance Analysis & Forecasting
<img width="1145" height="661" alt="image" src="https://github.com/user-attachments/assets/a69d3340-e262-4d2d-b42f-3eb1259c5a3f" />

This page dives deeper into operational trends and forecasting:

-Monthly Orders, Revenue, and Profit vs Goal performance with % achievement

-Revenue and Profit trends over years with seasonality patterns

-Top revenue-generating customers filtered by date selection

-Price Adjustment Simulation — helps forecast how pricing changes can affect profitability 
Users can drill down by Year, Month, and Day, making this page ideal for business strategy and financial planning.

## 🛠 Page 4 – Custom Tooltip KPI Summary
<img width="347" height="234" alt="image" src="https://github.com/user-attachments/assets/e32171fb-15b5-47f8-9056-da55d75d955e" />

The final visual offers an interactive tooltip experience — when users hover over key charts, they instantly see:

-Total Orders

-Total Profit

-Total Revenue

-Total Quantity

-Total Cost

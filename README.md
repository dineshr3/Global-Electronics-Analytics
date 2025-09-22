# 📊 Global Electronics Retailer – Power BI & SQL Project

This project analyzes a Global Electronics Retailer dataset (2016–2021) containing sales, products, customers, stores, and exchange rates. The dataset provides a complete view of transactions, customer demographics, and product performance.

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

## 🧮 Key DAX Measures

```DAX
-- Total Revenue
Total Revenue = SUM(Sales[Quantity] * Sales[UnitPrice])

-- Total Profit
Total Profit = SUM(Sales[Quantity] * (Sales[UnitPrice] - Sales[UnitCost]))

-- Total Orders
Total Orders = COUNTROWS(Sales)

-- Previous Month Revenue / Profit / Orders
Previous Month Revenue = CALCULATE([Total Revenue], DATEADD(Calendar[Date], -1, MONTH))
Previous Month Profit = CALCULATE([Total Profit], DATEADD(Calendar[Date], -1, MONTH))
Previous Month Orders = CALCULATE([Total Orders], DATEADD(Calendar[Date], -1, MONTH))

-- Price Adjustment Parameter
Price Adjustment = GENERATESERIES(-0.1, 0.1, 0.01)  -- ±10% adjustment
```
## ✅ Outcome

With this pipeline, the project demonstrates how SQL preprocessing + Power BI analytics can provide valuable insights for decision-making, including:

- **Total Revenue:** $83.73M
- **Total Orders:** 127K
- **Total Profit:** $39.76M
- **Total Customers:** 15K+
- **Total Products:** 2,517+
- **Category-wise Quantity:** Home Appliances, Computers, Cameras, Cell Phones, TV & Video, Audio, Games, Music
- **Customer demographics:** Gender distribution (Male/Female)
- **Regional insights:** Orders per country and continent
- **Monthly KPIs:** Orders, Revenue, Profit vs goals (+% improvement)
- **Interactive Price Adjustment** simulation for revenue/profit forecasting

## 📸 Screenshots

- **Main Dashboard**  
<img width="1088" height="611" alt="image" src="https://github.com/user-attachments/assets/2fd142e4-679c-4247-b835-58fd77235d4a" />


- **Overview Dashboard**  
<img width="1087" height="614" alt="image" src="https://github.com/user-attachments/assets/999a2927-7020-4e01-9acf-b320bd58efbe" />


- **Analysis Dashboard**  
<img width="1085" height="613" alt="image" src="https://github.com/user-attachments/assets/c73a486a-464a-4750-8e40-5f36ff18d31b" />


- **Custom Tooltip Dashboard**  
<img width="436" height="182" alt="image" src="https://github.com/user-attachments/assets/0233ee7e-1cc5-41fe-b4b8-7cefa5e8545f" />


## 🔧 How to Run

1. Import the CSV tables into MySQL.
2. Clean and transform the data as described in **SQL Data Preparation**.
3. Connect Power BI to MySQL using the MySQL connector.
4. Import the cleaned tables and create relationships between fact and dimension tables.
5. Load dashboards and use slicers to explore data.
6. Use the **Price Adjustment** simulation to forecast revenue and profit.
7. Save your Power BI file and optionally publish to Power BI Service for sharing dashboards.


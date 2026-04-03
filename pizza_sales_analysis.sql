-- PIZZA SALES DATA ANALYSIS (SQL PROJECT)

-- A. KEY PERFORMANCE INDICATORS (KPIs)

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT 
CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;


-- B. HOURLY TREND

SELECT 
DATEPART(HOUR, order_time) AS order_hour,
SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;


-- C. WEEKLY TREND

SELECT 
DATEPART(ISO_WEEK, order_date) AS WeekNumber,
YEAR(order_date) AS Year,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY Year, WeekNumber;


-- D. SALES BY CATEGORY (%)

SELECT 
pizza_category,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
CAST(SUM(total_price) * 100 / 
    (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category;


-- E. SALES BY SIZE (%)

SELECT 
pizza_size,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
CAST(SUM(total_price) * 100 / 
    (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- F. TOTAL PIZZAS SOLD BY CATEGORY

SELECT 
pizza_category,
SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G. TOP 5 PIZZAS BY REVENUE

SELECT TOP 5 
pizza_name,
SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;


-- H. BOTTOM 5 PIZZAS BY REVENUE

SELECT TOP 5 
pizza_name,
SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;


-- I. TOP 5 PIZZAS BY QUANTITY

SELECT TOP 5 
pizza_name,
SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;


-- J. BOTTOM 5 PIZZAS BY QUANTITY

SELECT TOP 5 
pizza_name,
SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC;


-- K. TOP 5 PIZZAS BY TOTAL ORDERS

SELECT TOP 5 
pizza_name,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


-- L. BOTTOM 5 PIZZAS BY TOTAL ORDERS

SELECT TOP 5 
pizza_name,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


-- OPTIONAL FILTER EXAMPLE

SELECT TOP 5 
pizza_name,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders DESC;
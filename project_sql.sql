create table public.sales_canada
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

create table public.sales_china
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

create table public.sales_china
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

	create table public.sales_nigeria
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

create table public.sales_Pakistan
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

	create table public.sales_uk
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);


	create table public.sales_us
(
	Transaction_ID text primary key,
	Date	date,
	Country	text,
	Product_ID	text,
	Product_Name	text,
	Category	text,
	Price_per_Unit numeric,
	Quantity_Purchased integer,
	Cost_Price	numeric,
	Discount_Applied	numeric,
	Payment_Method	text,
	Customer_Age_Group	text,
	Customer_Gender	text,
	Store_Location	text,
	Sales_Rep	text);

-- Unite all the tables

CREATE TABLE sales_data AS 
SELECT * FROM sales_canada
UNION ALL
SELECT * FROM sales_china
UNION ALL
SELECT * FROM sales_nigeria
UNION ALL
SELECT * FROM sales_pakistan
UNION ALL
SELECT * FROM sales_uk
UNION ALL
SELECT * FROM sales_us;


-- Data Cleaning

-- Checking For Nulls

SELECT * FROM sales_data
WHERE 
country IS NULL
OR  price_per_unit IS NULL
OR quantity_purchased IS NULL
OR cost_price IS NULL
OR discount_applied IS NULL;


UPDATE sales_data 
SET quantity_purchased = 3
WHERE transaction_id = '00a30472-89a0-4688-9d33-67ea8ccf7aea';


UPDATE sales_data 
SET price_per_unit = (
SELECT AVG(price_per_unit)
FROM sales_data
WHERE price_per_unit IS NOT NULL)
WHERE transaction_id = '001898f7-b696-4356-91dc-8f2b73d09c63';

-- Checking For Duplicates

SELECT transaction_id,COUNT(*)
FROM sales_data
GROUP BY transaction_id
HAVING COUNT(*)>1

-- Adding New Columns

ALTER TABLE sales_data
ADD COLUMN total_amount NUMERIC(10,2);

ALTER TABLE sales_data
ADD COLUMN profit NUMERIC(10,2);

UPDATE sales_data
SET total_amount = (price_per_unit * quantity_purchased) * discount_applied;

UPDATE sales_data
SET profit = (total_amount-cost_price);

-- Analyze & Generate Business Insights (Weekly)

SELECT
	country,
	SUM(total_amount) AS total_revenue,
	SUM(profit) AS total_profit
	FROM sales_data
	WHERE date  BETWEEN '2025-02-10' AND '2025-02-14'
	GROUP BY country
	ORDER BY total_revenue DESC;


-- Top 5 Best Selling Products


SELECT 
	product_name,
	SUM(quantity_purchased) AS total_unit_sold
FROM sales_data
	WHERE date  BETWEEN '2025-02-10' AND '2025-02-14'
	GROUP BY product_name
	ORDER BY total_unit_sold DESC
	LIMIT 5;

-- Best Sales Representative

SELECT 
	sales_rep,
	SUM(total_amount) AS total_sales
FROM sales_data
	WHERE date  BETWEEN '2025-02-10' AND '2025-02-14'
	GROUP BY sales_rep
	ORDER BY total_sales DESC
	LIMIT 5;


-- Which Stores Location Generates Highest Sales

SELECT 
	store_location,
	SUM(total_amount) AS total_sales,
	SUM(profit) AS total_profit
FROM sales_data
	WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
	GROUP BY store_location 
	ORDER BY total_sales DESC
	LIMIT 5;

-- What Are The Key Sales & Profit Insights For Selected Period?


SELECT
	MAX(total_amount) AS max_sales,
	MIN(total_amount) AS min_sales,
	ROUND(AVG(total_amount),2) AS avg_sale,
	MAX(profit) AS max_profit,
	MIN(profit) AS min_profit,
	ROUND(AVG(profit),2) AS avg_proft
FROM sales_data;















































































































	
	



	



	
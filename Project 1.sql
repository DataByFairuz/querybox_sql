SELECT * FROM Project_01.Sales_Data;
SELECT 
COUNT(*)
FROM Sales_Data

-- 
--- Data Cleaning 
SELECT *
FROM Sales_Data
where transaction_id is null
--
SELECT *
FROM Sales_Data
where quantity is null


--- Data Exploration 
-- How many sales do we have?
SELECT COUNT(*) AS total_sale from Sales_Data 
-- How many unique customers do we have?

SELECT DISTINCT category from Sales_Data 
--- Data Analysis and Business Problems 
-- Questions
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM sales_data where sale_date = '2022-11-05'

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM Sales_Data WHERE category = 'Clothing' AND TO CHAR (sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4 

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, 
SUM(total_sale) as net_sale, 
COUNT(*) AS Total_Orders 
FROM Sales_Data 
Group BY 1

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT 
ROUND(AVG(age)) as Average_Age 
FROM Sales_Data
where category = 'Beauty' 

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM Sales_Data WHERE total_sale >= 1000

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, 
Gender, 
COUNT(*) as Total_Transaction 
FROM Sales_Data 
GROUP BY category, gender 

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
year, month, avg_sale
FROM
(
SELECT 
Year(sale_date) as year, Month(sale_date) as month,
AVG(total_sale) as avg_sale,  
RANK() OVER(PARTITION BY Year(sale_date) ORDER BY AVG(total_sale) DESC) AS Top
FROM Sales_Data 
Group by 1,2 
Order by 1,3 DESC  
) as T1
WHERE Top = 1

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id, sum(total_sale) as total_sales 
From Sales_Data 
Group by 1 
Order by 2 DESC 
LIMIT 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
category,
COUNT(DISTINCT customer_id) AS Unique_Customer
from Sales_Data
Group by 1 
-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH Hourly_Sale 
as 
(
SELECT *,
CASE 
WHEN HOUR (sale_time) < 12 THEN 'Morning' 
WHEN Hour (sale_time) between 12 and 17 THEN 'Afternoon' 
ELSE 'Evening' 
END as Shift 
FROM Sales_Data 
)
SELECT 
Shift, 
COUNT(*) AS Total_Orders 
from Hourly_Sale 
GROUP BY Shift 

--- END OF PROJECT 


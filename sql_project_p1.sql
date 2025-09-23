create table retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,	
total_sale FLOAT
);
SELECT * FROM retail_sales;
SELECT COUNT(*) as total_sale FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- write a sql query to retrieve all columns for sales made on 2022-11-05. 
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- write a sql query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND
quantiy >= 4;

-- write a sql query to calculate the total sale (total_sale) for each category. 
SELECT category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- write a sql query to find the average age of customers who puchased items from the 'Beauty' category. 
SELECT 
ROUND(AVG(age) , 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- write a sql query to find all the transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- write a sql query to find the total number of transaction(transaction_id) made by each gender in each category. 
SELECT
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY
category,
gender
ORDER BY 1;

-- write a sql query to calculate the average sale for each month. Find out best selling month in each year. 
SELECT
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC

-- write a sql query to find the top 5 customers based on the highest total sales.
SELECT customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- write a sql query to find the number of unique custimers who purchased item from each category.
SELECT 
category,
COUNT(DISTINCT customer_id) as cant_unique_cs
FROM retail_sales
GROUP BY category;

-- write a sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 & 17, Evening >17)
	WITH hourly_sale
	AS
	(
	SELECT *, 
	CASE
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END AS shift
	FROM retail_sales
	)
	SELECT
	shift,
	COUNT(*) as total_orders
	FROM hourly_sale
	GROUP BY shift 
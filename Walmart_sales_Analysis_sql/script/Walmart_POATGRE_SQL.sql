-------selecting the data base----------
SELECT current_database();

-----Creating table as per the data----------
CREATE TABLE sales (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL,
    vat NUMERIC(6,4) NOT NULL,
    total NUMERIC(12,4) NOT NULL,
    date TIMESTAMP NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs NUMERIC(10,2) NOT NULL,
    gross_margin_pct NUMERIC(11,9),
    gross_income NUMERIC(12,4),
    rating NUMERIC(3,1)
);

------ overview of table colums
select * from sales;

------------------- importing the data from the pc to the database---------------
COPY sales FROM 'C:/Users/mownesh s/Downloads/Walmart Sales Data.csv'
DELIMITER ',' 
CSV HEADER;

------cross verifying the table with data------
select * from sales;

------------------- Feature Engineering -----------------------------

1. Time_of_day

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day =
case 
WHEN "time" BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
WHEN "time" BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
ELSE 'Evening' 
end;

2.Day_name

 alter table sales add column day_name varchar(10);

 update sales
 set day_name = to_char(date,'day');

 3.Momth_name

 alter table sales add column month_name varchar(15);

update sales
 set month_name = to_char(date,'month');

select column_name
from information_schema.columns
where table_name='sales'

----------------Exploratory Data Analysis (EDA)----------------------
Generic Questions
-- 1.How many distinct cities are present in the dataset?
select distinct city from sales;

-- 2.In which city is each branch situated?
select distinct branch,city from sales;

Product Analysis
-- 1.How many distinct product lines are there in the dataset?
select count (distinct product_line ) from sales;

-- 2.What is the most common payment method?
select payment,count(payment ) as comman_payment_method 
from sales
group by payment 
order by comman_payment_method desc
limit 1

-- 3.What is the most selling product line?
select product_line,count(*) as most_selling_product
from sales 
group by product_line
order by most_selling_product desc
limit 1;

-- 4.What is the total revenue by month?
select month_name ,sum(total) as total_revenue
from sales 
group by month_name 
order by total_revenue desc;

-- 5.Which month recorded the highest Cost of Goods Sold (COGS)?
select month_name,sum(cogs)as highest_cogs
from sales
group by month_name 
order by highest_cogs desc;

-- 6.Which product line generated the highest revenue?
select product_line,sum(total) as total_revenue
from sales
group by product_line 
order by total_revenue desc 
limit 1;

-- 7.Which city has the highest revenue?
select city,sum(total) as total_revenue
from sales
group by city  
order by total_revenue desc
limit 1;

-- 8.Which product line incurred the highest VAT?
select product_line,sum(VAT) as highest_vat
from sales
group by product_line  
order by highest_vat desc
limit 1;

-- 9.Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,'based on whether its sales are above the average.
SELECT product_line,  
       SUM(total) AS total_sales,  
       CASE  
           WHEN SUM(total) > (SELECT AVG(total) FROM sales) THEN 'Good'  
           ELSE 'Bad'  
       END AS product_category  
FROM sales  
GROUP BY product_line;

-- 10.Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS total_products  
FROM sales  
GROUP BY branch  
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- 11.What is the most common product line by gender?
SELECT gender, product_line, COUNT(*) AS count  
FROM sales  
GROUP BY gender, product_line  
ORDER BY gender, count DESC;

-- 12.What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating  
FROM sales  
GROUP BY product_line  
ORDER BY avg_rating DESC;

Sales Analysis
-- 1.Number of sales made in each time of the day per weekday
SELECT day_name, time_of_day, COUNT(invoice_id) AS total_sales
FROM sales GROUP BY day_name, time_of_day HAVING day_name NOT IN ('Sunday','Saturday');

SELECT day_name, time_of_day, COUNT(*) AS total_sales
FROM sales WHERE day_name NOT IN ('Saturday','Sunday') GROUP BY day_name, time_of_day;

-- 2.Identify the customer type that generates the highest revenue.
SELECT customer_type, SUM(total) AS total_revenue  
FROM sales  
GROUP BY customer_type  
ORDER BY total_revenue DESC  
LIMIT 1;

-- 3.Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, sum(vat) as total_vat
from sales
group by city 
order by total_vat 
limit 1;

-- 4.Which customer type pays the most in VAT?
select customer_type,sum(vat) as total_vat
from sales
group by customer_type 
order by total_vat
limit 1;

Customer Analysis

-- 1.How many unique customer types does the data have?
select count(distinct customer_type) as unique_customer_type from sales;

-- 2.How many unique payment methods does the data have?
select count(distinct payment) as unique_payment_method from sales;

-- 3.Which is the most common customer type?
select customer_type,count(*) as most_comman
from sales
group by customer_type
order by most_comman desc
limit 1;

-- 4.Which customer type buys the most?
SELECT customer_type, SUM(quantity) AS total_quantity  
FROM sales  
GROUP BY customer_type  
ORDER BY total_quantity DESC  
LIMIT 1;

-- 5.What is the gender of most of the customers?
SELECT gender, COUNT(*) AS count  
FROM sales  
GROUP BY gender  
ORDER BY count DESC  
LIMIT 1;

-- 6.What is the gender distribution per branch?
SELECT branch, gender, COUNT(*) AS count  
FROM sales  
GROUP BY branch, gender  
ORDER BY branch, count DESC;

-- 7.Which time of the day do customers give most ratings?
SELECT time_of_day, COUNT(rating) AS rating_count  
FROM sales  
WHERE rating IS NOT NULL  
GROUP BY time_of_day  
ORDER BY rating_count DESC  
LIMIT 1;

-- 8.Which time of the day do customers give most ratings per branch?
SELECT branch, time_of_day, COUNT(rating) AS rating_count  
FROM sales  
WHERE rating IS NOT NULL  
GROUP BY branch, time_of_day  
ORDER BY branch, rating_count DESC;

-- 9.Which day of the week has the best avg ratings?
SELECT day_name, ROUND(AVG(rating), 2) AS avg_rating  
FROM sales  
WHERE rating IS NOT NULL  
GROUP BY day_name  
ORDER BY avg_rating DESC  
LIMIT 1;

-- 10.Which day of the week has the best average ratings per branch?
SELECT branch, day_name, ROUND(AVG(rating), 2) AS avg_rating  
FROM sales  
WHERE rating IS NOT NULL  
GROUP BY branch, day_name  
ORDER BY branch, avg_rating DESC;


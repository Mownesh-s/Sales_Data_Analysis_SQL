# Walmart Sales Data Analysis using PostgreSQL

## Project Overview
This project performs a comprehensive analysis of Walmart sales data using PostgreSQL. The dataset includes transaction details such as branch locations, customer types, products, sales revenue, and payment methods. The objective is to analyze sales trends, customer behavior, and revenue patterns.

## Dataset Information
The dataset used in this project contains sales transactions with the following key attributes:
- **invoice_id**: Unique transaction ID
- **branch**: Store branch identifier
- **city**: City of the store branch
- **customer_type**: Membership status of customers
- **gender**: Customer gender
- **product_line**: Category of products purchased
- **unit_price**: Price per unit of product
- **quantity**: Number of units purchased
- **VAT**: Value-added tax on the total purchase
- **total**: Final amount including tax
- **date**: Date of purchase
- **time**: Time of transaction
- **payment**: Payment method used (Cash, Credit card, E-wallet)
- **cogs**: Cost of goods sold
- **gross_margin_pct**: Gross profit margin percentage
- **gross_income**: Profit earned per transaction
- **rating**: Customer rating of the transaction

## Project Steps
### 1. Database Setup
- Selected the PostgreSQL database to store the sales data.
- Created a `sales` table with appropriate data types and constraints.

### 2. Data Import
- Loaded the dataset into the PostgreSQL table using the `COPY` command.
- Verified the data integrity with `SELECT * FROM sales`.

### 3. Data Analysis Queries
Performed several SQL queries to extract insights, including:
- **Total Revenue Analysis**:  
  ```sql
  SELECT SUM(total) FROM sales;

- ** Branch-wise Sales Performance:
  ```sql
  SELECT branch, SUM(total) FROM sales GROUP BY branch;

- **Popular Product Lines:
   ```sql
  SELECT product_line, COUNT(*) FROM sales GROUP BY product_line ORDER BY COUNT(*) DESC;

- **Customer Spending Behavior:
   ```sql
  SELECT customer_type, AVG(total) FROM sales GROUP BY customer_type;

- **Sales by Payment Method:
   ```sql
  SELECT payment, COUNT(*) FROM sales GROUP BY payment;

## Insights and Findings
- ✅ Identified top-performing branches based on sales revenue.  
- ✅ Determined the most frequently purchased product categories.  
- ✅ Analyzed peak sales hours and days for better inventory planning.  
- ✅ Compared spending patterns between different customer segments.  
- ✅ Examined the preferred payment methods among customers.  

## Tools Used
- **Database**: PostgreSQL  
- **Query Execution**: pgAdmin / psql CLI  
- **Data Source**: Walmart Sales Data (CSV Format)  

## How to Run the Project
1. Install PostgreSQL on your system.  
2. Create a new database in PostgreSQL.  
3. Run the SQL script (`Walmart_POATGRE_SQL.sql`) to create the table and load the data.  
4. Execute the analysis queries to derive insights.  

## Future Improvements
- 🚀 Perform advanced analytics using joins and window functions.  
- 📊 Visualize sales trends using Power BI or Tableau.  
- 🖥️ Build an interactive dashboard for real-time sales monitoring.  

## Conclusion
This project provides valuable insights into Walmart’s sales trends and customer behavior using SQL queries. It demonstrates how SQL can be leveraged for data analysis in a structured and efficient manner.



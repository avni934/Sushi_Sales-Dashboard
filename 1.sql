CREATE TABLE sushi_sales (
    sushi_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    sushi_name_id VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    sushi_size VARCHAR(10),
    sushi_category VARCHAR(50),
    sushi_ingredients TEXT,
    sushi_name VARCHAR(255)
); 

select sum(total_price) as Total_Revenue from sushi_sales

SELECT SUM(total_price)/COUNT(DISTINCT order_id) as AVG_Order_Value from sushi_sales

select sum(quantity) as Total_Sushi_Sold from sushi_sales

select count(DISTINCT order_id) from sushi_sales

SELECT cast(cast(sum(quantity) as DECIMAL(10,2))/
cast(count(DISTINCT order_id) as DECIMAL(10,2)) as DECIMAL(10,2)) as Avg_Sushi_per_order from sushi_sales 


--Daily Trends
select to_char(order_date,'day') as order_day, count(distinct order_id) as total_orders
from sushi_sales group by to_char(order_date,'day');

--Hourly Trends
SELECT EXTRACT(HOUR from order_time) as order_hours, count(DISTINCT order_id) as Hourly_Time
from sushi_sales 
group by order_hours
ORDER BY order_hours ASC

--Percentage by sushi_category
select sushi_category, sum(total_price)*100/(select sum(total_price) from sushi_sales) as Percentage_by_Category
from sushi_sales 
group by sushi_category

select sushi_category, sum(total_price)*100/
(select sum(total_price) from sushi_sales where EXTRACT(month from order_date)=1) as Percentage_by_Category
from sushi_sales 
where EXTRACT(month from order_date)=1
group by sushi_category

select sushi_size, sum(total_price)*100/(select sum(total_price) from sushi_sales) as Percentage_by_Size
from sushi_sales
group by sushi_size

select sushi_size, sum(total_price)*100/
(select sum(total_price) from sushi_sales where EXTRACT(QUARTER from order_date)=1) as Percentage_by_Size
from sushi_sales
where EXTRACT(QUARTER from order_date)=1
group by sushi_size

select sushi_category, sum(quantity) as Total_Sushis_Sold_By_Category
from sushi_sales
group by sushi_category

select sushi_name, sum(quantity) as top_5
from sushi_sales
group by sushi_name
order by top_5 DESC
limit 5

select sushi_name, sum(quantity) as worst_5
from sushi_sales
group by sushi_name
order by worst_5 
limit 5
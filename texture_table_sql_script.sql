create database case3;
use case3;
select * from product_details;

 ## What was the total quantity sold for all products?
 
select p.product_name as 'Name_of_product',
sum(s.qty) as 'product_Number' 
from sales s inner join
product_details p 
on p.product_id=s.prod_id
group by p.product_name
order by 'product_name' desc;

## What is the total generated revenue for all products before discounts?
select sum(qty*price) as 'no_discounted_revenue' from sales ;

## What was the total discount amount for all products?
select sum((qty*price*discount)/100) as 'Total_discount' from sales;

## How many unique transactions were there?
select count(distinct txn_id) as 'unique_tansaction' from sales;

## What are the average unique products purchased in each transaction?
with average_unique_product_purchase as 
(select txn_id,
count(distinct prod_id) as product_count 
from sales
group by txn_id)
 
select round(avg(product_count))as avg_unique_product from average_unique_product_purchase ;

## What is the average discount value per transaction?
with avg_discount_value_per_transaction as 
(select txn_id,
sum(discount) as discount_value
from sales
group by txn_id)
select round(avg(discount_value))as avg_discount_value
from avg_discount_value_per_transaction;
 
 

## What is the average revenue for member transactions and nonmember transactions?
with avg_rev_member as 
(select member,txn_id,sum(price*qty) as revenue
from sales
group by member,txn_id)
select member,round(avg(revenue))as avg_revenue
from avg_rev_member 
group by member; 

## What are the top 3 products by total revenue before discount?
select p.product_name,
sum(s.price*s.qty)as revenue
from sales s inner join
product_details p on 
p.product_id=s.prod_id
group by p.product_name
order by revenue desc
limit 3;

## What are the total quantity, revenue and discount for each segment?
select p.segment_id,
p.segment_name,
sum(s.qty) as total_quantity,
sum(s.price*s.qty) as revenue,
sum(s.discount) as discount
from sales s inner join
product_details p
on p.product_id=s.prod_id
group by p.segment_id,p.segment_name; 

##What is the top selling product for each segment?
select 
 p.segment_name, 
p.product_name,
sum(s.qty)as item_sold
from sales s inner join
product_details p on 
p.product_id=s.prod_id
group by p.segment_name,p.product_name
order by item_sold desc;

## What are the total quantity, revenue and discount for each category?
select p.category_id,
p.category_name,
sum(s.qty) as total_quantity,
sum(s.price*s.qty) as revenue,
sum(s.price*s.qty*s.discount)/100 as discount
from sales s inner join 
product_details p on
p.product_id=s.prod_id
group by p.category_id,p.category_name;


## What is the top selling product for each category?
select p.category_id,
p.category_name,
sum(s.qty) as quantity_sold
from sales s inner join
product_details p 
on p.product_id=s.prod_id
group by p.category_id,category_name 
order bY  quantity_sold desc;
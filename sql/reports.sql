SELECT name, email
FROM Customers;

SELECT * FROM ORDERS 
WHERE order_date > '2024-01-01';

SELECT MAX(price) FROM Products;

SELECT COUNT(*) AS [Number of Orders], customer_id
FROM Orders
GROUP BY customer_id;

SELECT COUNT(employee_id), department_id
FROM Employees
GROUP BY department_id
HAVING COUNT(employee_id) > 5;

SELECT Customers.*, COUNT(Orders.order_id) AS [Total no. of Orders], 
  COALESCE(SUM(Orders.total_amount), 0) AS [Total Spending]
FROM Customers
LEFT JOIN Orders
ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.name;

select Products.*, Categories.category_name,
  case when stock_quantity < 50 then 'needs restocking'
  else 'no restocking needed'
  end as restocking_needed
from Products 
left join Categories
on Products.category_id = Categories.category_id;

select strftime('%Y-%m', order_date) as Month, count(*) as [Total no. of Orders], SUM(total_amount) as [Total Revenue]
from Orders where Month between '2024-01' and '2024-12'
group by Month;

-- Q1 and 2 RANK(), DENSE_RANK(), Day Count, LAG and LEAD
select *,
rank() over (
  partition by department_id order by salary desc) 
  as dept_sal_rank,
dense_rank() over (
  partition by department_id order by salary desc) 
  as dept_sal_rank_dense,
(julianday(max(hire_date) over (partition by department_id)) - 
  julianday(hire_date)) as department_hire_comparision,
LAG (first_name || ' ' || last_name, 1, 'NA') over (partition by department_id order by hire_date)
  as previous_employee_dept_hire,
LEAD (first_name || ' ' || last_name, 1, 'NA') over (partition by department_id order by hire_date)
  as next_employee_dept_hire
from Employees;

-- Q3 Sales Analysis
select *,
sum(amount) over (partition by employee_id order by sale_date) 
  as cumulavite_sum_employee,
case when row_number() over (partition by employee_id order by sale_date) = 1 or
  row_number() over (partition by employee_id order by sale_date) = count(*) over (partition by employee_id)
  then null
else avg(amount) over (partition by employee_id order by sale_date rows between 1 preceding and 1 following)
  end as three_sale_moving_employee,
avg(amount) over (partition by employee_id) 
  as avg_sale_employee,
max(amount) over (partition by employee_id) 
  as max_sale_employee,
min(amount) over (partition by employee_id) 
  as min_sale_employee
from Sales;

-- Q4 Department Analysis Report
select employee_id, Departments.department_name as department, 
  first_name || ' ' || last_name as employee,
  salary,
  round(avg(salary) over (partition by Employees.department_id), -2) as avg_dept_salary,
  round(abs(salary - avg(salary) over (partition by Employees.department_id)), -2) as difference_frm_avg,
  rank() over (partition by Employees.department_id order by salary desc) as dept_sal_rank
from Employees
left join Departments on Employees.department_id = Departments.department_id
order by employee_id;

-- Q5 Customer and Order Trends
select *,
sum(total_amount) over (partition by customer_id order by order_date) as running_total_customer,
case when order_Date = '2023-12-15' then 0
else julianday(order_date) - julianday(LAG(order_date, 1, 0) over (order by order_date)) 
end as days_between_previous_order,
last_value(order_id) over (partition by customer_id order by order_date
  rows between unbounded preceding and unbounded following) as recent_order_id_customer
from Orders;

-- Q6 Product Popularity and Ranking
select *,
rank() over (partition by category_id order by stock_quantity desc) as product_pop_cat
from Products;

with ranked as(
select *,
rank() over (partition by category_id order by stock_quantity desc) as product_pop_cat
from Products)
select *
from ranked
where product_pop_cat <=2;

-- Q7 Order and Sales Correlation
with order_month as(select strftime('%Y-%m', order_date) as month,
sum(total_amount) as orders_monthly_total
from Orders where month between '2024-01' and '2024-12'
group by month),
ytd_order as(
select month,
orders_monthly_total,
sum(orders_monthly_total) over 
(order by month rows between unbounded preceding and current row) as ytd_total_order
from order_month)
select month, orders_monthly_total, round(ytd_total_order, 2) as ytd_total_order, 
  round((orders_monthly_total*100.0)/ytd_total_order, 2) as percentage_ytd_order
from ytd_order
order by month;

with sale_month as(select strftime('%Y-%m', sale_date) as month,
sum(amount) as sales_monthly_total
from Sales
group by month),
ytd_sale as(
select month,
sales_monthly_total,
sum(sales_monthly_total) over 
(order by month rows between unbounded preceding and current row) as ytd_total_sale
from sale_month)
select month, sales_monthly_total, round(ytd_total_sale, 2) as ytd_total_sale, 
  round((sales_monthly_total*100.0)/ytd_total_sale, 2) as percentage_ytd_sale
from ytd_sale
order by month;

-- Q8 Challenge
with dept_emp as(
  select *, Departments.department_name
  from Employees
  left join Departments on Employees.department_id = Departments.department_id
),
dept_emp_sales as (
  select *, first_name || ' ' || last_name as full_name, Sales.amount
  from dept_emp
  right join Sales on dept_emp.employee_id = Sales.employee_id
)
select  distinct full_name, email, department_name,
sum(amount) over (partition by full_name) as total_sales
from dept_emp_sales
order by total_sales desc;
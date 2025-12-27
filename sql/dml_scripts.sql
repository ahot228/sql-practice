-- Departments table fixing
delete from departments_raw where rowid in(
    select rowid from (
        select rowid,
        row_number() over (
          partition by department_id
          order by lower(department_name)
          ) as rn
        from departments_raw
        )
    where rn > 1
    );
update departments_raw set 
  department_name = case 
    when department_id = 1 then 'Engineering'
    when department_id = 2 then 'Marketing'
    when department_id = 9 then 'Sales'
    when TRIM(department_name) = '' then null
    else department_name
    end,
  location = case 
    when TRIM(location) = '' then null
    else location
    end;
  delete from departments_raw where department_name is null;

-- Employees table fixing
update employees_raw set
  department_id = case
    when department_id = '' then null
    else department_id
    end,
  email = case
    when TRIM(email) like '%@%.%' then lower(email)
    else null
    end,
  salary = abs(salary),
  hire_date = case
    when hire_date between '2000-01-01' and date('now') then hire_date
    else null
    end;

-- Customers table fixing
update customers_raw set
  name = case
    when instr(trim(name), ' ') > 0 then
    upper(substr(trim(name), 1, 1)) || lower(substr(trim(name), 2, instr(trim(name), ' ') - 2))
    || ' ' || upper(substr(trim(name), instr(trim(name), ' ')+1, 1)) || lower(substr(trim(name), instr(trim(name), ' ') + 2))
    else null
    end,
  email = case
    when TRIM(email) like '%@%.%' then lower(email)
    else null
    end,
  age = case
    when abs(age) between 10 and 120 then abs(age)
    else null
    end,
  phone = case
    when TRIM(phone) like '%-%' then phone
    else null
    end,
  registration_date = case
    when registration_date between '2000-01-01' and date('now') then registration_date
    else null
    end;
delete from customers_raw where name is null;
-- Categories table fixing
delete from categories_raw where rowid in(
    select rowid from (
        select rowid,
        row_number() over (
          partition by category_id
          order by category_name desc
          ) as rn
        from categories_raw
        )
    where rn > 1 or category_name = 'Elctronics'
    );

-- Products table fixing
update products_raw set
  product_name = case
    when trim(product_name) = '' then null
    else trim(product_name)
    end,
  category_id = case
  when category_id= -18 then category_id = 3
  else category_id
  end,
  price = case
  when price = 0.0 then null
  else  abs(price)
  end,
  stock_quantity = case
  when stock_quantity = '' then null
  else abs(stock_quantity)
  end;

-- Orders table fixing
update orders_raw set
  customer_id = case 
    when customer_id = '' then null
    else customer_id
    end,
  order_date = case
    when order_date between '2000-01-01' and date('now') then order_date
    else null
    end,
  total_amount = case
    when total_amount = '' then null
    else abs(total_amount)
    end,
  status = case
    when TRIM(status) = '' then null
    else TRIM(status)
    end;

-- Order items table fixing
update order_items_raw set
  product_id = case
  when product_id = '' or product_id = 99.0 then null
  else product_id
  end,
  quantity = abs(quantity),
  price = case 
  when price = '' then null
  else price
  end;

-- Sales table fixing
delete from sales_raw where employee_id = 99;
update sales_raw set
  sale_date = case
    when sale_date between '2000-01-01' and date('now') then sale_date
    else null
    end,
  amount = case
    when amount = '' then null
    else abs(amount)
    end;

-- Inserting data
insert into employees (first_name,last_name,email,salary,department_id,hire_date)
select first_name,last_name,email,salary,department_id,hire_date
from employees_raw;

insert into departments (department_name,location)
select department_name, location
from departments_raw;

insert into customers (name,email,phone,age,registration_date)
select name,email,phone,age,registration_date
from customers_raw;

insert into products (product_name,category_id,price,stock_quantity)
select product_name,category_id,price,stock_quantity
from products_raw;

insert into categories (category_name)
select category_name
from categories_raw;

insert into orders (customer_id,order_date,total_amount,status)
select customer_id,order_date,total_amount,status
from orders_raw;

insert into order_items (order_id,product_id,quantity,price)
select  order_id,product_id,quantity,price
from order_items_raw;

insert into sales (employee_id,sale_date,amount)
select employee_id,sale_date,amount
from sales_raw;
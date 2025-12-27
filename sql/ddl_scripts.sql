<<<<<<< HEAD
create table if not exists Employees(
  employee_id integer primary key,
  first_name varchar(255),
=======
create table if not exists employees(
  employee_id integer primary key autoincrement,
  first_name varchar(255) not null,
>>>>>>> 4e47c78 (Added ddl and dml scripts and altered messy tables)
  last_name varchar(255),
  email varchar(255),
  salary decimal,
  department_id integer,
  hire_date date,
<<<<<<< HEAD
  foreign key (department_id) references Departments(department_id)
);
create table if not exists Departments(
  department_id integer primary key,
  department_name varchar(255),
  location varchar(255)
);
create table if not exists Customers(
  customer_id integer primary key,
  name varchar(255),
=======
  foreign key (department_id) references departments(department_id)
  on update cascade
);
create table if not exists departments(
  department_id integer primary key autoincrement,
  department_name varchar(255) not null,
  location varchar(255)
);
create table if not exists customers(
  customer_id integer primary key autoincrement,
  name varchar(255) not null,
>>>>>>> 4e47c78 (Added ddl and dml scripts and altered messy tables)
  email varchar(255),
  phone varchar(255),
  age integer,
  registration_date date
);
<<<<<<< HEAD
create table if not exists Products(
  product_id integer primary key,
=======
create table if not exists products(
  product_id integer primary key autoincrement,
>>>>>>> 4e47c78 (Added ddl and dml scripts and altered messy tables)
  product_name varchar(255),
  category_id integer,
  price decimal,
  stock_quantity integer,
<<<<<<< HEAD
  foreign key (category_id) references Categories(category_id)
);
create table if not exists Categories(
  category_id integer primary key,
  category_name varchar(255)
);
create table if not exists Orders(
  order_id integer primary key,
=======
  foreign key (category_id) references categories(category_id)
  on update cascade
);
create table if not exists categories(
  category_id integer primary key autoincrement,
  category_name varchar(255) not null
);
create table if not exists orders(
  order_id integer primary key autoincrement,
>>>>>>> 4e47c78 (Added ddl and dml scripts and altered messy tables)
  customer_id integer,
  order_date date,
  total_amount decimal,
  status varchar(255),
<<<<<<< HEAD
  foreign key (customer_id) references Customers(customer_id)
);
create table if not exists Order_items(
  order_item_id integer primary key,
  order_id integer,
  product_id integer,
  quantity integer,
  price decimal,
  foreign key (order_id) references Orders(order_id),
  foreign key (product_id) references Products(product_id)
);
create table if not exists Sales(
  sales_id integer primary key,
  employee_id integer,
  sale_date date,
  amount decimal,
  foreign key (employee_id) references Employees(employee_id)
);
INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'Engineering', 'San Francisco'),
(2, 'Marketing', 'New York'),
(3, 'Sales', 'Chicago'),
(4, 'Human Resources', 'Boston'),
(5, 'Finance', 'Los Angeles');
INSERT INTO Employees (employee_id, first_name, last_name, email, salary, department_id, hire_date) VALUES
(1, 'John', 'Smith', 'john.smith@company.com', 75000.00, 1, '2022-03-15'),
(2, 'Sarah', 'Johnson', 'sarah.j@company.com', 82000.00, 1, '2021-06-20'),
(3, 'Mike', 'Williams', 'mike.w@company.com', 68000.00, 2, '2023-01-10'),
(4, 'Emily', 'Brown', 'emily.b@company.com', 71000.00, 2, '2022-09-05'),
(5, 'David', 'Jones', 'david.j@company.com', 79000.00, 3, '2020-11-12'),
(6, 'Lisa', 'Garcia', 'lisa.g@company.com', 73000.00, 3, '2021-04-18'),
(7, 'Robert', 'Miller', 'robert.m@company.com', 85000.00, 1, '2019-08-22'),
(8, 'Jennifer', 'Davis', 'jennifer.d@company.com', 67000.00, 4, '2023-02-14'),
(9, 'William', 'Rodriguez', 'william.r@company.com', 91000.00, 5, '2020-05-30'),
(10, 'Maria', 'Martinez', 'maria.m@company.com', 77000.00, 1, '2022-07-08'),
(11, 'James', 'Hernandez', 'james.h@company.com', 70000.00, 1, '2023-03-25'),
(12, 'Patricia', 'Lopez', 'patricia.l@company.com', 69000.00, 2, '2021-10-15'),
(13, 'Michael', 'Wilson', 'michael.w@company.com', 76000.00, 3, '2022-12-01'),
(14, 'Linda', 'Anderson', 'linda.a@company.com', 72000.00, 3, '2023-04-20'),
(15, 'Thomas', 'Taylor', 'thomas.t@company.com', 80000.00, 1, '2021-02-28');
INSERT INTO Customers (customer_id, name, email, phone, age, registration_date) VALUES
(1, 'Alice Cooper', 'alice.cooper@email.com', '555-0101', 28, '2023-05-15'),
(2, 'Bob Thompson', 'bob.t@email.com', '555-0102', 35, '2023-08-20'),
(3, 'Carol White', 'carol.white@email.com', '555-0103', 42, '2023-06-10'),
(4, 'Daniel Green', 'daniel.g@email.com', '555-0104', 31, '2024-01-05'),
(5, 'Eva Martinez', 'eva.m@email.com', '555-0105', 26, '2023-11-22'),
(6, 'Frank Harris', 'frank.h@email.com', '555-0106', 39, '2024-02-14'),
(7, 'Grace Lee', 'grace.lee@email.com', '555-0107', 33, '2023-09-08'),
(8, 'Henry Clark', 'henry.c@email.com', '555-0108', 45, '2023-07-30');
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Garden'),
(5, 'Sports & Outdoors');
INSERT INTO Products (product_id, product_name, category_id, price, stock_quantity) VALUES
(1, 'Laptop Pro 15', 1, 1299.99, 45),
(2, 'Wireless Mouse', 1, 29.99, 150),
(3, 'USB-C Cable', 1, 14.99, 200),
(4, 'Cotton T-Shirt', 2, 19.99, 300),
(5, 'Denim Jeans', 2, 49.99, 120),
(6, 'The Great Novel', 3, 24.99, 80),
(7, 'Cooking Guide', 3, 18.99, 65),
(8, 'Garden Tool Set', 4, 89.99, 40),
(9, 'LED Desk Lamp', 4, 39.99, 95),
(10, 'Yoga Mat', 5, 34.99, 110),
(11, '4K Monitor', 1, 399.99, 30),
(12, 'Winter Jacket', 2, 129.99, 55);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2023-12-15', 149.97, 'Delivered'),
(2, 2, '2023-12-20', 1329.98, 'Delivered'),
(3, 1, '2024-01-10', 89.99, 'Delivered'),
(4, 3, '2024-01-15', 54.98, 'Shipped'),
(5, 4, '2024-02-01', 399.99, 'Delivered'),
(6, 2, '2024-02-10', 169.98, 'Delivered'),
(7, 5, '2024-02-15', 74.98, 'Processing'),
(8, 1, '2024-03-01', 439.98, 'Delivered'),
(9, 6, '2024-03-05', 219.98, 'Shipped'),
(10, 7, '2024-03-10', 129.99, 'Delivered'),
(11, 3, '2024-03-20', 89.99, 'Delivered'),
(12, 4, '2024-04-01', 299.99, 'Processing');
INSERT INTO Order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 2, 2, 29.99),
(2, 1, 3, 3, 14.99),
(3, 1, 4, 2, 19.99),
(4, 2, 1, 1, 1299.99),
(5, 2, 2, 1, 29.99),
(6, 3, 8, 1, 89.99),
(7, 4, 6, 1, 24.99),
(8, 4, 7, 1, 18.99),
(9, 4, 4, 1, 19.99),
(10, 5, 11, 1, 399.99),
(11, 6, 5, 2, 49.99),
(12, 6, 4, 3, 19.99),
(13, 7, 10, 1, 34.99),
(14, 7, 9, 1, 39.99),
(15, 8, 11, 1, 399.99),
(16, 8, 9, 1, 39.99),
(17, 9, 12, 1, 129.99),
(18, 9, 8, 1, 89.99),
(19, 10, 12, 1, 129.99),
(20, 11, 8, 1, 89.99),
(21, 12, 1, 1, 1299.99);
INSERT INTO Sales (sales_id, employee_id, sale_date, amount) VALUES
(1, 5, '2024-01-15', 1500.00),
(2, 6, '2024-01-20', 2200.00),
(3, 5, '2024-02-05', 1800.00),
(4, 13, '2024-02-10', 3100.00),
(5, 14, '2024-02-15', 2700.00),
(6, 6, '2024-03-01', 1900.00),
(7, 5, '2024-03-05', 2400.00),
(8, 13, '2024-03-10', 3300.00),
(9, 14, '2024-03-15', 2100.00),
(10, 6, '2024-04-01', 2800.00);
=======
  foreign key (customer_id) references customers(customer_id)
  on update cascade
);
create table if not exists order_items(
  order_item_id integer primary key autoincrement,
  order_id integer not null,
  product_id integer,
  quantity integer,
  price decimal,
  foreign key (order_id) references orders(order_id)
  on update cascade,
  foreign key (product_id) references products(product_id)
  on update cascade
);
create table if not exists sales(
  sales_id integer primary key autoincrement,
  employee_id integer,
  sale_date date,
  amount decimal,
  foreign key (employee_id) references employees(employee_id)
  on update cascade
);
>>>>>>> 4e47c78 (Added ddl and dml scripts and altered messy tables)

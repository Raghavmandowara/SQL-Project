CREATE TABLE goldusers_signup(user_id integer,gold_signup_date date);

INSERT INTO goldusers_signup values 
(1,'09-22-2017'),
(3,'04-21-2017');

CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users VALUES  
(1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');

CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales VALUES
(1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);

CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

-- 1 . What is the total amount each customer spent on zomato ?

Select a.userid,SUM(b.price) total_amt_spent from sales a 
JOIN product b ON a.product_id = b.product_id
GROUP BY a.userid

--2. How many days has each customer visited zomato ?

Select userid,COUNT(DISTINCT created_date) distinct_days from sales
GROUP BY userid

--3. What was the first product purchased by each customer ?

Select userid,product_id from
(Select *,rank() OVER(partition by userid order by created_date) rnk from sales) 
where rnk = 1

--4. What is the most purchased item in the menu ?

Select product_id from sales
GROUP BY product_id
ORDER BY COUNT(product_id) desc
LIMIT 1

--5. How many times the most purchased product was purchased by each customer ?
 
Select userid,COUNT(product_id) from sales where product_id =
(Select product_id from sales 
GROUP BY product_id
ORDER BY COUNT(product_id) desc 
LIMIT 1) 
GROUP BY userid







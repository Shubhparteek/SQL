/********************************************************************/
/* line 1 to line 173 code has been made by DANLI HUANG: 6213339    */
/* line 174 to line 524 code has been made by Shubhparteek Singh    */
/* line 527 to line 668 code has been made by Zhu, Ruiqing          */
/* line 669 to  line 721 code has been made by Al Sadoon, Mohamad   */
/* 

/*****************************************************/
/* This parts has been made by Danli Huang           */
/*****************************************************/

/*****************************************************/
/* trigger: shipment_insert_audit                    */
/* trigger condition: after insert shipment table    */
/* trigger insert table: shipmentfinished_audit table*/
/*****************************************************/

use online_shoestore_ordering_system;
DROP TABLE IF EXISTS shipmentfinished_audit;
CREATE TABLE shipmentfinished_audit (
	audit_no int primary key auto_increment,
    shipment_id INT NOT NULL 
);

use online_shoestore_ordering_system;
drop trigger shipment_insert;

create trigger shipment_insert
after insert on shipment for each row
insert into shipmentfinished_audit 
set shipment_id = new.shipment_id;

insert into shipment (shipment_cost, shipment_start_date, shipment_end_date, delivery_company_id) 
values 
(199, '2022-11-18','2022-11-18', 4);
SET SQL_SAFE_UPDATES = 0;
delete  from shipment where shipment_cost=199;
SET SQL_SAFE_UPDATES = 1;
select * from shipmentfinished_audit;

/**************************************************************************/
/* function name: deliverydays(p_order_id int)                            */
/* description: give deliverydays for inout paramater (order_id)          */
/**************************************************************************/

/* calculate deliverydays by order_id */
use online_shoestore_ordering_system;
drop function deliverydays;
delimiter $$
CREATE Function deliverydays(p_order_id int)
RETURNS int
DETERMINISTIC 
BEGIN
  DECLARE result_days int;
  select to_days(shipment_end_date)-to_days(shipment_start_date)+1 into result_days 
  from shipment s
  inner join `order` o on o.shipment_id=s.shipment_id
  and o.order_id=p_order_id;
  return (result_days); 
 END $$

delimiter ;
select deliverydays(order_id), order_id from `order`;


/* display max deliverydays, min deliverydays and average deliverydays for all orders */
use online_shoestore_ordering_system;
drop procedure maxminavgdeliverydays;
delimiter $$
create procedure maxminavgdeliverydays()
begin
	select max(deliverydays(order_id)) 'MaxDelivaryDay',min(deliverydays(order_id)) 'MinDeliveryDay', avg (deliverydays(order_id)) 
    from `order`;
end $$
delimiter ;
call maxminavgdeliverydays();


-- List all delivery days, customer_id, customer's province name 
-- and customer's country name for each order
select deliverydays(o.order_id) as 'deliverydays',
		o.order_id,c.customer_name,
	   p.province_name,co.country_name
from customer c
inner join province p
on p.province_id=c.customer_province_id
inner join country co
on co.country_id = p.country_id
inner join `order` o
on c.customer_id=o.customer_id
order by deliverydays;

-- list the avg deliverydays spend in each province

select avg(deliverydays(o.order_id)) as 'deliverydays',
		c.customer_province_id,p.province_name,co.country_name
from customer c
inner join province p
on p.province_id=c.customer_province_id
inner join country co
on co.country_id = p.country_id
inner join `order` o
on c.customer_id=o.customer_id

group by c.customer_province_id 
order by deliverydays;

-- list delivery company and it's benefits and order by this benefits. 
select sum(s.shipment_cost) as 'benefits',s.delivery_company_id,d.company_name 
from delivery_company d 
inner join shipment s
on s.delivery_company_id = d.company_id
group by d.company_id
order by  benefits DESC;

-- list delivery company who has no buisness happened;
select d.company_id, d.company_name,s.delivery_company_id 
from delivery_company d
left join shipment s
on s.delivery_company_id=d.company_id
and s.delivery_company_id is null;


/* give a shipment discount for a specific delivery company */
drop procedure shipment_discount;
DELIMITER $$
CREATE PROCEDURE shipment_discount(IN in_discountdate date,IN in_delivery_company_id int,IN in_discount decimal(10,2))
BEGIN
  DECLARE v_discount decimal(10,2) DEFAULT 0.20;
  DECLARE v_shipment_id int;
  declare v_shipment_cost decimal(10,2);
  declare v2_shipment_cost decimal(10,2);
  declare v_shipment_start_date date;
  declare v_shipment_end_date date;
  declare v_delivery_company_id int;
  declare v_shipment_company_name varchar(300);
  declare done int default 0;
  declare curDiscountShipment cursor for
	select s.shipment_id,s.shipment_cost,s.shipment_start_date,
    s.shipment_end_date,s.delivery_company_id,d.company_name
  from shipment s
  inner join delivery_company d
  on s.delivery_company_id = d.company_id
  and s.shipment_start_date=in_discountdate;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN curDiscountShipment;
  label: LOOP
    FETCH curDiscountShipment INTO 
		v_shipment_id, v_shipment_cost,
        v_shipment_start_date, v_shipment_end_date,v_delivery_company_id,
        v_shipment_company_name;
    IF done = 1 THEN
        LEAVE label;
    END IF;
    if v_delivery_company_id= in_delivery_company_id then
    set v_shipment_cost = v_shipment_cost *(1- in_discount);
    end if;
SELECT 
    v_shipment_id,
    v_shipment_cost,
    v_shipment_start_date,
    v_shipment_end_date,
    v_delivery_company_id,
    v_shipment_company_name;
    END LOOP label;
   CLOSE curDiscountShipment;
END $$

DELIMITER ;
-- give delivery company discount  20% off if company_id=2 
call shipment_discount('2022-11-18',2,0.2);


/****************************************************/
/** This parts has been made by Shubhparteek Singh  */
/****************************************************/
USE online_shoestore_ordering_system;
-- Richii part
-- List all orders whose buyers are from Quebec using Visa Credit as payment method
SELECT
    o.order_id 'Order ID',
    p.product_name 'Product Name',
    pm.payment_method 'Payment Method',
    c.customer_name 'Customer Name',
    pv.province_name 'Province'
FROM
    `order` o
        INNER JOIN
    order_detail od ON o.order_detail_id = od.order_detail_id
        INNER JOIN
    product p ON od.product_id = p.product_id
        INNER JOIN
    payment pm ON o.payment_id = pm.payment_id
        INNER JOIN
    customer c ON o.customer_id = c.customer_id
        INNER JOIN
    province pv ON c.customer_province_id = pv.province_id
WHERE
    pm.payment_method = 'Visa Credit'
        AND pv.province_name = 'Quebec';
-- List all shoes of size 5.0 that are sold in the year 2022
SELECT
    p.product_name, sc.size_desc, o.order_date
FROM
    product p
        INNER JOIN
    size_chart sc ON p.size_id = sc.size_id
        INNER JOIN
    order_detail od ON p.product_id = od.product_id
        INNER JOIN
    `order` o ON od.order_detail_id = o.order_detail_id
WHERE
    sc.size_desc = '5.0'
        AND o.order_date LIKE '2022%';
-- List the total quantity of female shoes sold in the year of 2022
SELECT
    COUNT(o.order_id) 'Total orders', g.gender_name
FROM
    product p
        INNER JOIN
    gender g ON p.gender_id = g.gender_id
        INNER JOIN
    order_detail od ON p.product_id = od.product_id
        INNER JOIN
    `order` o ON od.order_detail_id = o.order_detail_id
WHERE
    o.order_date LIKE '2022%'
GROUP BY g.gender_name
HAVING g.gender_name = 'F';
-- View:
CREATE VIEW qc_cust_visa AS
    SELECT
        o.order_id 'Order ID',
        p.product_name 'Product Name',
        pm.payment_method 'Payment Method',
        c.customer_name 'Customer Name',
        pv.province_name 'Province'
    FROM
        `order` o
            INNER JOIN
        order_detail od ON o.order_detail_id = od.order_detail_id
            INNER JOIN
        product p ON od.product_id = p.product_id
            INNER JOIN
        payment pm ON o.payment_id = pm.payment_id
            INNER JOIN
        customer c ON o.customer_id = c.customer_id
            INNER JOIN
        province pv ON c.customer_province_id = pv.province_id
    WHERE
        pm.payment_method = 'Visa Credit'
            AND pv.province_name = 'Quebec';
-- Procedure: check first 3 digits of phone number of a given customer. if it's 444 (for example), it belongs to Quebec.
DELIMITER $$
CREATE PROCEDURE CheckPhone(IN p_name VARCHAR(20))
BEGIN
    DECLARE pre_number VARCHAR(3);
    DECLARE provinceName VARCHAR(30);
    SELECT SUBSTRING(customer_phone_number, 1, 3)
    INTO pre_number
    FROM customer
    WHERE customer_name = p_name;
    IF pre_number = '444' THEN
        SET provinceName = 'Quebec';
    END IF;
    SELECT provincename;
END $$    
DELIMITER ;
CALL CheckPhone('Evelyn Mccall');
-- Function: mark a customer as "Attention Needed" if the order date is older than 183 days; "Under the Radar" if newer than 183 days but older than 60 days; and "Active Customer" if newer than 60 days.
DELIMITER $$
CREATE FUNCTION Customer_Status(
    order_date DATE  
)
RETURNS VARCHAR(20)
DETERMINISTIC  
BEGIN
    DECLARE customer_status VARCHAR(20);
    IF order_date < CURDATE() - INTERVAL 183 DAY THEN  
        SET customer_status = 'Attention Needed';
    ELSEIF order_date >= CURDATE() - INTERVAL 183 DAY AND
            order_date < CURDATE() - INTERVAL 60 DAY THEN  
        SET customer_status = 'Under the Radar';
    ELSEIF order_date >= CURDATE() - INTERVAL 60 DAY THEN  
        SET customer_status = 'Active Customer';
    END IF;
    RETURN (customer_status);
END $$  
DELIMITER ;
-- Call the function
SELECT
    o.customer_id 'Customer ID',
    c.customer_name 'Customer Name',
    o.order_id 'Order ID',
    o.order_date 'Order Date',
    CUSTOMER_STATUS(order_date) 'Customer Status'
FROM
    `order` o
        INNER JOIN
    customer c ON o.customer_id = c.customer_id
ORDER BY order_date;
-- Trigger: Convert newly inserted Customer Name to be all capital letters.
CREATE
    TRIGGER  upper_insert
 BEFORE INSERT ON customer FOR EACH ROW 
    SET NEW . customer_name = UPPER(NEW.customer_name);
-- Test the trigger: John Doo appears as JOHN DOO.
INSERT INTO customer (customer_name, customer_address, customer_province_id)
VALUES
('John Doo', '123 abc street', '2');
SELECT
    *
FROM
    customer
ORDER BY customer_id DESC;


# shubh 6213361
-- List all the orders of the customers who live in canada, ordered by province name-------------
SELECT
    ord.order_id 'Order ID',
	cus.customer_name 'Customer Name',
    pv.province_name 'Province',
    co.country_name 'Country'
    
FROM
    `order` ord
    INNER JOIN
    customer cus ON ord.customer_id = cus.customer_id
	INNER JOIN
    province pv ON cus.customer_province_id = pv.province_id
    INNER JOIN
    country co ON pv.country_id = co.country_id
WHERE
   co.country_name= 'canada'
ORDER BY pv.province_name;

-- List all the customers without any order 
SELECT
    cus.customer_name 'Customer Name',
    cus.customer_id 'Customer id'
FROM
    customer cus
    left JOIN
    `order` ord  ON ord.customer_id = cus.customer_id
WHERE
   cus.customer_id NOT IN (select customer_id from `order`);
   
--  Display the total order price before tax, sorty by higest price order-------------------

  SELECT
    ord.order_id 'Order ID',
	cus.customer_name 'Customer Name',
    pro.product_name 'Product name',
    pro.price 'Price of product',
    od.product_quantity 'Quantity',
    (pro.price*od.product_quantity) 'Order Price'
FROM
    `order` ord
    INNER JOIN
    customer cus ON ord.customer_id = cus.customer_id
	INNER JOIN
    order_detail od ON ord.order_detail_id= od.order_detail_id
    INNER JOIN
    product pro ON pro.product_id = od.product_id
ORDER BY (pro.price*od.product_quantity) DESC;

-- view
CREATE VIEW customer_without_orders 
AS
SELECT
    cus.customer_name 'Customer Name',
    cus.customer_id 'Customer id'
FROM
    customer cus
    left JOIN
    `order` ord  ON ord.customer_id = cus.customer_id
WHERE
   cus.customer_id NOT IN (select customer_id from `order`);

-- test the view   
SELECT * FROM customer_without_orders;

-- get the payment method used by customer to pay for order by passing the customer id------------
DELIMITER $$
CREATE PROCEDURE GetOrderinfo(IN cust_id INT)
BEGIN
  SELECT
     cus.customer_id 'Customer ID',
     cus.customer_name 'Customer Name',
     ord.order_id 'Order ID',
     pay.payment_method 'Payment Method'
 FROM
    customer cus
    INNER JOIN
    `order` ord  ON ord.customer_id = cus.customer_id
    INNER JOIN
    payment pay ON ord.payment_id = pay.payment_id
    WHERE cus.customer_id = cust_id;

END$$
DELIMITER ;
-- drop PROCEDURE GetOrderinfo;
CALL GetOrderinfo(8);

-- procedure to calculate total price with tax for orders------------------
DELIMITER $$
CREATE PROCEDURE getOrderTotal(order_id INT)

BEGIN
 -- DECLARE customerLevel VARCHAR(30);
   SELECT
    ord.order_id 'Order ID',
	cus.customer_name 'Customer Name',
    pro.product_name 'Product name',
    pro.price 'Price of product',
    od.product_quantity 'Quantity',
    (pro.price*od.product_quantity) 'Order Price',
    pv.province_tax 'Province tax rate',
    co.fedral_tax 'Fedral tax rate',
    (pro.price*od.product_quantity)+(pro.price*od.product_quantity*((pv.province_tax+co.fedral_tax)/100)) 'Total Price with tax'
    FROM
    `order` ord
    INNER JOIN
    customer cus ON ord.customer_id = cus.customer_id
	INNER JOIN
    order_detail od ON ord.order_detail_id= od.order_detail_id
    INNER JOIN
    product pro ON pro.product_id = od.product_id
    INNER JOIN
    province pv ON cus.customer_province_id = pv.province_id
    INNER JOIN
    country co ON pv.country_id = co.country_id
    WHERE  ord.order_id = order_id;  
END $$
DELIMITER ;
-- drop PROCEDURE getOrderTotal;
call getOrderTotal(2)

-- function to give discount for more than 2 orders------------------
DELIMITER $$
CREATE Function getDiscount(order_unit INT)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
  DECLARE discount DECIMAL;
  
    IF order_unit >= 3 THEN
        SET discount = 20;
    ELSEIF (order_unit = 2) THEN
        SET discount = 10;
    END IF;
    
    RETURN (discount);
END $$

DELIMITER ;

-- testing discount function with discount procedure ---------------------
DELIMITER $$
CREATE PROCEDURE getOrderTotal_with_discount(order_id INT)

BEGIN
   SELECT
    ord.order_id 'Order ID',
	pro.product_name 'Product name',
    pro.price 'Price of product',
    od.product_quantity 'Quantity',
    (pro.price*od.product_quantity) 'Order Price',
    ((pro.price*od.product_quantity)+(pro.price*od.product_quantity*((pv.province_tax+co.fedral_tax)/100))) 'Total Price with tax',
    (SELECT getDiscount(od.product_quantity)) 'Discount % applied',
    (((pro.price*od.product_quantity)+(pro.price*od.product_quantity*((pv.province_tax+co.fedral_tax)/100)))- ((pro.price*od.product_quantity)*((SELECT getDiscount(od.product_quantity))/100))) 'Total after discount'
    
    FROM
    `order` ord
    INNER JOIN
    customer cus ON ord.customer_id = cus.customer_id
	INNER JOIN
    order_detail od ON ord.order_detail_id= od.order_detail_id
    INNER JOIN
    product pro ON pro.product_id = od.product_id
    INNER JOIN
    province pv ON cus.customer_province_id = pv.province_id
    INNER JOIN
    country co ON pv.country_id = co.country_id
    WHERE  ord.order_id = order_id;  
END $$
DELIMITER ;
-- DROP PROCEDURE getOrderTotal_with_discount;
 call getOrderTotal_with_discount(10);
 
 -- address change trigger--------------------
 
CREATE TABLE customer_address_backup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerNumber INT NOT NULL,
    customerName VARCHAR(50) NOT NULL,
    customerAddress VARCHAR(50) NOT NULL,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_customer_address_update
BEFORE UPDATE  ON customer
    FOR EACH ROW
    INSERT INTO customer_address_backup
    SET action = 'update',
     customerNumber = OLD.customer_id,
     customerName = OLD.customer_name,
     customerAddress = OLD.customer_address,
     changedate = NOW();
	
-- checking the triger     
UPDATE customer
SET
    customer_address = '1234 highway 50'
WHERE
    customer_id = 2;
    
SELECT * 
FROM customer
where  customer_id = 2;

  
  
/*****************************************************/
/* This parts has been made by ZhuRui Qing           */
/*****************************************************/

 -- List all orders whose buyers are from Quebec using Visa Credit as payment method
SELECT
    o.order_id 'Order ID',
    p.product_name 'Product Name',
    pm.payment_method 'Payment Method',
    c.customer_name 'Customer Name',
    pv.province_name 'Province'
FROM
    `order` o
        INNER JOIN
    order_detail od ON o.order_detail_id = od.order_detail_id
        INNER JOIN
    product p ON od.product_id = p.product_id
        INNER JOIN
    payment pm ON o.payment_id = pm.payment_id
        INNER JOIN
    customer c ON o.customer_id = c.customer_id
        INNER JOIN
    province pv ON c.customer_province_id = pv.province_id
WHERE
    pm.payment_method = 'Visa Credit'
        AND pv.province_name = 'Quebec';
-- List all shoes of size 5.0 that are sold in the year 2022
SELECT
    p.product_name, sc.size_desc, o.order_date
FROM
    product p
        INNER JOIN
    size_chart sc ON p.size_id = sc.size_id
        INNER JOIN
    order_detail od ON p.product_id = od.product_id
        INNER JOIN
    `order` o ON od.order_detail_id = o.order_detail_id
WHERE
    sc.size_desc = '5.0'
        AND o.order_date LIKE '2022%';
-- List the total quantity of female shoes sold in the year of 2022
SELECT
    COUNT(o.order_id) 'Total orders', g.gender_name
FROM
    product p
        INNER JOIN
    gender g ON p.gender_id = g.gender_id
        INNER JOIN
    order_detail od ON p.product_id = od.product_id
        INNER JOIN
    `order` o ON od.order_detail_id = o.order_detail_id
WHERE
    o.order_date LIKE '2022%'
GROUP BY g.gender_name
HAVING g.gender_name = 'F';
-- View:
CREATE VIEW qc_cust_visa AS
    SELECT
        o.order_id 'Order ID',
        p.product_name 'Product Name',
        pm.payment_method 'Payment Method',
        c.customer_name 'Customer Name',
        pv.province_name 'Province'
    FROM
        `order` o
            INNER JOIN
        order_detail od ON o.order_detail_id = od.order_detail_id
            INNER JOIN
        product p ON od.product_id = p.product_id
            INNER JOIN
        payment pm ON o.payment_id = pm.payment_id
            INNER JOIN
        customer c ON o.customer_id = c.customer_id
            INNER JOIN
        province pv ON c.customer_province_id = pv.province_id
    WHERE
        pm.payment_method = 'Visa Credit'
            AND pv.province_name = 'Quebec';
-- Procedure: check first 3 digits of phone number of a given customer. if it's 444 (for example), it belongs to Quebec.
DELIMITER $$
CREATE PROCEDURE CheckPhone(IN p_name VARCHAR(20))
BEGIN
    DECLARE pre_number VARCHAR(3);
    DECLARE provinceName VARCHAR(30);
    SELECT SUBSTRING(customer_phone_number, 1, 3)
    INTO pre_number
    FROM customer
    WHERE customer_name = p_name;
    IF pre_number = '444' THEN
        SET provinceName = 'Quebec';
    END IF;
    SELECT provincename;
END $$    
DELIMITER ;
CALL CheckPhone('Evelyn Mccall');
-- Function: mark a customer as "Attention Needed" if the order date is older than 183 days; "Under the Radar" if newer than 183 days but older than 60 days; and "Active Customer" if newer than 60 days.
DELIMITER $$
CREATE FUNCTION Customer_Status(
    order_date DATE  
)
RETURNS VARCHAR(20)
DETERMINISTIC  
BEGIN
    DECLARE customer_status VARCHAR(20);
    IF order_date < CURDATE() - INTERVAL 183 DAY THEN  
        SET customer_status = 'Attention Needed';
    ELSEIF order_date >= CURDATE() - INTERVAL 183 DAY AND
            order_date < CURDATE() - INTERVAL 60 DAY THEN  
        SET customer_status = 'Under the Radar';
    ELSEIF order_date >= CURDATE() - INTERVAL 60 DAY THEN  
        SET customer_status = 'Active Customer';
    END IF;
    RETURN (customer_status);
END $$  
DELIMITER ;
-- Call the function
SELECT
    o.customer_id 'Customer ID',
    c.customer_name 'Customer Name',
    o.order_id 'Order ID',
    o.order_date 'Order Date',
    CUSTOMER_STATUS(order_date) 'Customer Status'
FROM
    `order` o
        INNER JOIN
    customer c ON o.customer_id = c.customer_id
ORDER BY order_date;
-- Trigger: Convert newly inserted Customer Name to be all capital letters.
CREATE
    TRIGGER  upper_insert
 BEFORE INSERT ON customer FOR EACH ROW 
    SET NEW . customer_name = UPPER(NEW.customer_name);
-- Test the trigger: John Doo appears as JOHN DOO.
INSERT INTO customer (customer_name, customer_address, customer_province_id)
VALUES
('John Doo', '123 abc street', '2');
SELECT
    *
FROM
    customer
ORDER BY customer_id DESC;


/*****************************************************/
/* This parts has been made Al Sadoon, Mohamad       */
/*****************************************************/
-- Mohamad Al Sadoon 1212531
-- 3 queries
-- list all the shoes that contain Nike and are casual type
SELECT *
FROM product 
where product_name like '%nike%' and product_category_id = 1;
-- list all the shoes that are priced over $150 and for Female Gender and sort by most expensive
Select product_name, price
from product
where price > 150 and gender_id = 2
order by price desc;
-- list all shoes that are for men and are of size 8.5 and more.
Select product_name, size_desc
from product
where size_id >= 8.5 and gender_id = 1;
-- View table
Create view product_view as
select product_name, price, size_desc, gender_name
from product
inner join gender using (gender_id)
inner join size_chart using (size_id);
select * from product_view;
-- Procedure -> get shoes names for specific sizes
DELIMITER $$
CREATE PROCEDURE getShoeSize(IN s_shoe_size VARCHAR(50))
BEGIN
select product_name, price, size_desc
from product
inner join size_chart using (size_id)
Where size_desc = s_shoe_size;
END$$
DELIMITER ;
drop procedure getShoeSize;
Call getShoeSize('8.0');
######-- function -> discount on shoes for christmas sale
DELIMITER $$
CREATE FUNCTION shoeSale(price decimal, discount decimal) returns decimal
DETERMINISTIC
BEGIN
DECLARE sale_price decimal(10,2);
SET sale_price = price / discount;
RETURN sale_price;
END$$
DELIMITER ;
select *, shoeSale(price, 1.5) as Sale_Price from product;
#######-- Triggers -> Uppercase the product name before insertion
Create trigger tr_ins_product_name
before insert on product
for each row
set new.product_name = upper(new.product_name);

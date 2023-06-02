-- richi part--
INSERT INTO `country` (`country_name`,`fedral_tax`)
VALUES
  ('Canada', 5),
  ('USA', 4);
  
 
INSERT INTO `province` (`province_name`,`province_tax`, `country_id`)
VALUES
  ('British Columbia',7, 1),
  ('Alberta',0, 1),
  ('Manitoba',7, 1),
  ('Saskatchewan',6, 1),
  ('Ontario',8, 1),
  ('Quebec',9.98, 1),
  ('New Brunswick',10,1),
  ('Nova Scotia',10, 1),
  ('Prince Edward Island',10, 1),
  ('Newfoundland and Labrador',10, 1),
  ('New York',8, 2),
  ('Massachusetts',5, 2),
  ('Florida',9, 2),
  ('Georgia',7, 2),
  ('California',12, 2),
  ('Texas',10, 2),
  ('Illinois',3, 2),
  ('Maine',0, 2),
  ('Nevada',8, 2),
  ('New Hampshire',0, 2);
INSERT INTO `customer` (`customer_name`,`customer_address`,`customer_province_id`,`customer_phone_number`,`customer_email`)
VALUES
  ("Kaye Terry","Ap #826-7031 Eget Rd.",19,"3436675428","nisl.arcu.iaculis@google.com"),
  ("Candace Durham","Ap #291-5506 Interdum St.",2,"5547147531","vulputate@google.ca"),
  ("Lamar Forbes","288-8595 Vitae, St.",9,"4854218897","augue.scelerisque@hotmail.edu"),
  ("Joan Workman","Ap #956-5384 Class Rd.",5,"3066341968","ut.lacus@google.com"),
  ("Leila Bowman","275-7826 Dignissim St.",14,"3795948438","vivamus.euismod.urna@outlook.com"),
  ("Grant Giles","701-7495 Luctus Avenue",15,"4472695641","id.sapien.cras@icloud.edu"),
  ("Ezra Baldwin","316-3927 Gravida Ave",15,"6412851449","parturient.montes@icloud.org"),
  ("Marshall Wilkins","986-8847 Penatibus Rd.",1,"7035420203","mi.felis@aol.com"),
  ("Hedwig Norman","Ap #785-5923 Blandit. St.",14,"0448515366","ipsum.primis@hotmail.org"),
  ("Alexandra Wiggins","P.O. Box 249, 7159 Ullamcorper, Av.",6,"0822353879","ac.sem.ut@hotmail.com"),
  ("Evelyn Mccall","Ap #544-2925 Et, St.",6,"4441919355","sem.egestas@yahoo.edu"),
  ("Tarik Travis","Ap #228-5541 Non, Road",9,"5037252363","suspendisse@icloud.org"),
  ("Priscilla Moody","659-2010 Vivamus Rd.",10,"4454694493","fringilla.ornare@outlook.ca"),
  ("Ahmed Collins","479-9070 Ullamcorper. Avenue",4,"6823727501","elit@outlook.org"),
  ("Madison Hensley","P.O. Box 491, 2296 Donec Rd.",12,"5162255316","amet.faucibus@protonmail.edu"),
  ("McKenzie Justice","P.O. Box 350, 9599 Leo. Rd.",12,"8282818685","at.augue.id@yahoo.net"),
  ("Olivia Lowe","Ap #717-1689 Lobortis Road",5,"1455669521","eget.volutpat.ornare@yahoo.org"),
  ("Abbot Maxwell","Ap #608-5519 Et St.",11,"6215411113","lorem.semper.auctor@protonmail.com"),
  ("Giacomo Francis","P.O. Box 382, 7254 Ac, Ave",3,"4854364167","pretium.neque@google.ca"),
  ("Quail Sanchez","Ap #837-2115 Sed, Ave",12,"3403067325","in.lobortis@outlook.org");

-- mohamad part--
insert into gender (gender_name)
values
  ('M'), ('F');
insert into product_category (
  product_category_name, product_category_description
)
values
  ('Casual', 'Casual shoes'),
  ('Running', 'Running shoes'),
  ('Boots', 'Boots shoes'),
  (
    'Basketball', 'Basketball shoes'
  ),
  ('Soccer', 'Soccer shoes'),
  ('Sandals', 'Sandals shoes'),
  ('Slides', 'Slides shoes'),
  (
    'Dress Shoes', 'Dress Shoes shoes'
  );
insert into size_chart (size_desc)
values
  ('5.0'),
  ('5.5'),
  ('6.0'),
  ('6.5'),
  ('7.0'),
  ('7.5'),
  ('8.0'),
  ('8.5'),
  ('9.0'),
  ('9.5'),
  ('10.0'),
  ('10.5'),
  ('11.0');
insert into product (
  product_name, gender_id, feature_detail,
  product_category_id, size_id, price
)
values
  (
    "Nike Air Force 1 '07", '1', "Nike's groundbreaking sneaker keeps you looking good with its timeless style.",
    '1', '2', '100.00'
  ),
  (
    "Nike Blazer Mid '77 Vintage", '1', 
    "Old-school vibes with a modern twist!", 
    '2', '5', '140.00'
  ), 
  (
    "Nike Air Max 270", '1', "Introducing the first-ever Max Air unit designed specifically for Nike Sportswear.", 
    '3', '1', '210.00'
  ), 
  (
    "Nike Air Vapormax Plus", '1', "In 1998 the Nike Air Max Plus debuted its Tuned Air technology and gradient fade and in the process became a bit of a cult classic", 
    '4', '3', '300.00'
  ), 
  (
    "Nike Air Force 1 Mid '07 LE", '1',
    "Nike's groundbreaking sneaker keeps you looking cool with its timeless style.", 
    '5', '4', '120.00'
  ), 
  (
    'Timberland 6" Premium Waterproof Boots', 
    '1', "Don't let cold, wet weather dictate your style. Kick it fresh year-round with classic Timberland's.", 
    '6', '6', '100.00'
  ), 
  (
    "adidas NMD V3", '1', "The adidas NMD V3 is where sport meets style.", 
    '7', '7', '140.00'
  ), 
  (
    "Vans Classic Slip On", '1', "Originally known as the #98, Vans Classic Slip-Ons became a staple for skaters and BMX riders shortly after their release in 1977.", 
    '8', '8', '120.00'
  ), 
  (
    "Converse Chuck Taylor 70 Hi", '1', 
    "The Converse Canada Chuck 70 High Top Shoe is an original, revamped.", 
    '1', '9', '100.00'
  ), 
  (
    "Reebok Club C 85", '1', "Put on classic style from Reebok.", 
    '2', '10', '90.00'
  ), 
  (
    "adidas Originals Stan Smith Casual Shoes", 
    '1', "Carry on the tradition of the timeless Stan Smith with the adidas Originals Stan Smith.", 
    '3', '11', '80.00'
  ), 
  (
    "adidas Ultraboost 22 GTX", '1', 
    "Braze the trail in style even in the harshest weather with the adidas Ultraboost 22 GTX.", 
    '4', '12', '100.00'
  ), 
  (
    "Nike Air Force 1 High", '2', "The Nike Air Force One High offers timeless style in a sleek package.", 
    '5', '2', '110.00'
  ), 
  (
    "New Balance 574", '2', "The New Balance 574 never goes out of style with its clean lines and impressive cushioning.", 
    '6', '12', '110.00'
  ), 
  (
    "Converse All Star HI Nomad", '2', 
    "Explore your everyday adventures in style with the Converse All Star HI Nomad.", 
    '7', '1', '100.00'
  ), 
  (
    "ASICS GEL-Quantum 180 VII", '2', 
    "Hustle every day in style with the ASICS Gel-Quantum 180 VII.", 
    '8', '6', '200.00'
  ), 
  (
    "adidas Originals Top Ten RB Casual Sneakers", 
    '2', "Inspired by the best of the best.", 
    '1', '8', '150.00'
  ), 
  (
    "PUMA Mayze Stack Suede", '2', "Add the newest edition to your all-inclusive rotation with the PUMA Mayze Stack Suede.", 
    '5', '6', '110.00'
  ), 
  (
    "Merrell Hydro Runner", '2', "Make every day your kind of athletic meet-up with the Merrell Hydro RN.", 
    '6', '7', '130.00'
  ), 
  (
    "Sorel Explorer II Joan", '2', "Get unique style and undeniable comfort with the Sorel Explorer II Joan.", 
    '3', '2', '110.00'
  );
  
  -- Dan part--

insert into delivery_company (company_name, company_detail, company_address) 
values
('Keefe-Auer Inc.', 'Delivery from 2011-06-06', '1 Sunbrook Lane'),
( 'Gorczany Inc.', 'Delivery from 2021-03-01', '22 saint laurent'),
('Rolfson Inc', 'Delivery from 2013-02-01', '23 Kennedy Lane'),
( 'Denesik Inc', 'Delivery from 2016-03-01', '3 Saint Paul Park'),
( 'Keebler Inc', 'Delivery from 2010-09-01', '50 International Crossing'),
( 'Ferry-Lemke Inc', 'Delivery from 2019-04-01', '12 Sunbrook Lane'),
( 'Bednar Inc', 'Delivery from 2017-05-01', '220 saint laurent'),
( 'GleichnerInc', 'Delivery from 2015-08-01', '23 Kennedy Lane'),
( 'Champlin-Roob Inc', 'Delivery from 2014-05-01', '50 International Crossing'),
( 'Renner-Hansen Inc', 'Delivery from 2022-02-01', '506 International Crossing');

 insert into shipment (shipment_cost, shipment_start_date, shipment_end_date, delivery_company_id) 
values 
(99, '2022-11-18','2022-11-18', 2),
(54, '2021-12-08','2021-12-10', 2),
(16, '2022-04-24','2022-04-30', 2),
(41, '2022-10-04','2022-10-06', 1),
(98, '2022-11-24','2022-11-25', 2),
(69, '2022-11-03','2022-11-03', 2), 
(47, '2022-07-11','2022-07-15', 3),
(61,'2022-05-12','2022-05-13', 1),
(75, '2022-08-08','2022-08-09', 5), 
(23, '2022-03-01','2022-03-02',3);

-- shubh part --
INSERT INTO `online_shoestore_ordering_system`.`payment`
(`payment_method`)
VALUES
('Visa Credit'),('American Express'),('Visa Debit'), ('PayPal'), ('MasterCard'),('Interac'),('Paybright');

INSERT INTO `online_shoestore_ordering_system`.`order_detail`
(`product_id`,`product_quantity`)
VALUES
(2,1),(10,2),(3,1),(15,2),(18,5),(1,1),(10,3),(8,5),(19,1),(2,1),(4,1),(5,2),(6,3),(7,2),(8,1),(9,3),(11,4),(12,1);

INSERT INTO `online_shoestore_ordering_system`.`order`
(`payment_id`,
`order_detail_id`,
`order_date`,
`shipment_id`,
`customer_id`,
`process_start_date`)
VALUES
(7,1,'2022-11-18',1,2,'2022-11-18'),
(1,18,'2021-12-08',2,1,'2021-12-10'),
(2,10,'2022-04-24',3,5,'2022-04-30'),
(3,15,'2022-10-04',4,8,'2022-10-06'),
(5,11,'2022-11-24',5,6,'2022-11-25'),
(6,9,'2022-11-03',6,8,'2022-11-03'),
(1,16,'2022-07-11',7,10,'2022-07-15'),
(2,1,'2022-05-12',8,3,'2022-05-13'),
(1,4,'2022-08-08',9,4,'2022-08-09'),
(7,7,'2022-03-01',10,7,'2022-03-02');



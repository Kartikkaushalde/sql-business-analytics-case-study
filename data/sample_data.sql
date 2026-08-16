USE business_analytics;

INSERT INTO departments VALUES
(1,'Sales'),(2,'Marketing'),(3,'Operations'),(4,'Technology'),(5,'Finance');

INSERT INTO employees VALUES
(101,'Aarav Sharma',1,'2022-01-10',NULL),
(102,'Meera Kapoor',1,'2022-03-15',101),
(103,'Rohan Verma',1,'2023-02-20',101),
(104,'Ishita Singh',2,'2021-07-12',NULL),
(105,'Kabir Mehta',2,'2023-04-18',104),
(106,'Ananya Rao',3,'2020-11-02',NULL),
(107,'Vivek Jain',3,'2022-09-05',106),
(108,'Sara Khan',4,'2021-05-24',NULL),
(109,'Arjun Nair',4,'2024-01-08',108),
(110,'Nisha Gupta',5,'2020-06-01',NULL);

INSERT INTO customers VALUES
(201,'Alpha Retail','Enterprise','Delhi','2022-01-12','alpha@example.com'),
(202,'Bright Stores','SMB','Mumbai','2022-05-17',NULL),
(203,'Core Systems','Enterprise','Bengaluru','2021-09-20','core@example.com'),
(204,'Delta Foods','Mid-Market','Pune','2023-02-11','delta@example.com'),
(205,'Evergreen Labs','Enterprise','Hyderabad','2022-08-05',NULL),
(206,'Future Mart','SMB','Delhi','2024-01-14','future@example.com'),
(207,'Galaxy Traders','Mid-Market','Jaipur','2023-06-22','galaxy@example.com'),
(208,'Horizon Media','SMB','Kolkata','2024-02-18',NULL),
(209,'Insight Corp','Enterprise','Chennai','2021-03-09','insight@example.com'),
(210,'Jupiter Works','Mid-Market','Noida','2023-10-04','jupiter@example.com');

INSERT INTO products VALUES
(301,'Analytics Platform','Software',1200.00),
(302,'CRM Suite','Software',950.00),
(303,'BI Dashboard','Software',700.00),
(304,'Support Package','Services',400.00),
(305,'Data Connector','Software',550.00),
(306,'Training Package','Services',300.00);

INSERT INTO orders VALUES
(1001,201,102,'2024-01-05','Completed'),
(1002,202,103,'2024-01-12','Completed'),
(1003,203,102,'2024-01-22','Completed'),
(1004,204,103,'2024-02-03','Completed'),
(1005,205,102,'2024-02-14','Completed'),
(1006,206,103,'2024-02-27','Completed'),
(1007,207,102,'2024-03-04','Completed'),
(1008,208,103,'2024-03-16','Completed'),
(1009,209,102,'2024-03-28','Completed'),
(1010,210,103,'2024-04-07','Completed'),
(1011,201,102,'2024-04-18','Completed'),
(1012,203,102,'2024-04-26','Completed'),
(1013,205,102,'2024-05-05','Completed'),
(1014,206,103,'2024-05-21','Cancelled'),
(1015,207,103,'2024-06-02','Completed');

INSERT INTO order_items VALUES
(1001,301,2,1200,5),(1001,304,1,400,0),
(1002,302,1,950,0),(1002,306,2,300,10),
(1003,301,3,1200,8),(1003,303,2,700,0),
(1004,305,2,550,0),(1004,304,2,400,5),
(1005,301,4,1200,12),(1005,306,2,300,0),
(1006,303,1,700,0),(1006,305,2,550,5),
(1007,302,2,950,5),(1007,304,1,400,0),
(1008,306,3,300,0),(1008,305,1,550,0),
(1009,301,2,1200,10),(1009,303,1,700,0),
(1010,302,3,950,8),(1010,306,1,300,0),
(1011,301,1,1200,0),(1011,304,3,400,5),
(1012,303,3,700,5),(1012,305,2,550,0),
(1013,301,2,1200,10),(1013,302,1,950,0),
(1014,303,2,700,0),
(1015,302,1,950,0),(1015,306,3,300,5);

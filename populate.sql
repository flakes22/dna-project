INSERT INTO street_details (street, city, zipcode) VALUES
('Blue Farm Rd','Wellsbury','02901'),
('Maple Way','Wellsbury','02902'),
('Oak Avenue','Wellsbury','02903'),
('Pine Street','Wellsbury','02904'),
('Riverfront Blvd','Wellsbury','02905'),
('Main St','Wellsbury','02906'),
('School Ln','Wellsbury','02907'),
('Mill Road','Wellsbury','02908'),
('Harbor Drive','Wellsbury','02909'),
('Industrial Park Rd','Wellsbury','02910'),
('Elm Terrace','Wellsbury','02911'),
('Cedar Court','Wellsbury','02912');


INSERT INTO people (ssn, fname, lname, age, sex, email, street, city, phone) VALUES
('WSB0001','Georgia','Noble','31','F','georgia.noble@example.com','Maple Way','Wellsbury','5551001'),
('WSB0002','Ginny','Miller','16','F','ginny.miller@example.com','Maple Way','Wellsbury','5551002'),
('WSB0003','Austin','Conte','22','M','austin.conte@example.com','Blue Farm Rd','Wellsbury','5551003'),
('WSB0004','Mayor','Paul','52','M','paul.randolph@example.com','Main St','Wellsbury','5551004'),
('WSB0005','Joe','Carpenter','44','M','joe.carpenter@example.com','Riverfront Blvd','Wellsbury','5551005'),
('WSB0006','Cynthia','Parker','38','F','cynthia.parker@example.com','Oak Avenue','Wellsbury','5551006'),
('WSB0007','Marcus','Delgado','34','M','marcus.delgado@example.com','Pine Street','Wellsbury','5551007'),
('WSB0008','Maxine','Reed','29','F','maxine.reed@example.com','Blue Farm Rd','Wellsbury','5551008'),
('WSB0009','Zion','Perez','18','M','zion.perez@example.com','School Ln','Wellsbury','5551009'),
('WSB0010','Bracia','Lopez','21','F','bracia.lopez@example.com','Elm Terrace','Wellsbury','5551010'),
('WSB0011','Hunter','Bell','24','M','hunter.bell@example.com','Cedar Court','Wellsbury','5551011'),
('WSB0012','Nick','Harris','30','M','nick.harris@example.com','Mill Road','Wellsbury','5551012'),
('WSB0013','Linda','Foster','45','F','linda.foster@example.com','Harbor Drive','Wellsbury','5551013'),
('WSB0014','Sam','Whitaker','50','M','sam.whitaker@example.com','Main St','Wellsbury','5551014'),
('WSB0015','Rosa','Mendoza','33','F','rosa.mendoza@example.com','Oak Avenue','Wellsbury','5551015'),
('WSB0016','Ethan','Cole','40','M','ethan.cole@example.com','Industrial Park Rd','Wellsbury','5551016'),
('WSB0017','Tanya','Griffin','27','F','tanya.griffin@example.com','Maple Way','Wellsbury','5551017'),
('WSB0018','Aaron','Kim','35','M','aaron.kim@example.com','Blue Farm Rd','Wellsbury','5551018'),
('WSB0019','Sofia','Ramirez','28','F','sofia.ramirez@example.com','Pine Street','Wellsbury','5551019'),
('WSB0020','Victor','Lane','48','M','victor.lane@example.com','Riverfront Blvd','Wellsbury','5551020'),
('WSB0021','Olivia','Park','26','F','olivia.park@example.com','School Ln','Wellsbury','5551021'),
('WSB0022','Derek','Miles','37','M','derek.miles@example.com','Mill Road','Wellsbury','5551022'),
('WSB0023','Hannah','Stone','19','F','hannah.stone@example.com','Elm Terrace','Wellsbury','5551023'),
('WSB0024','Gina','Ortiz','42','F','gina.ortiz@example.com','Cedar Court','Wellsbury','5551024'),
('WSB0025','Caleb','Ford','31','M','caleb.ford@example.com','Main St','Wellsbury','5551025'),
('WSB0026','Priya','Singh','36','F','priya.singh@example.com','Maple Way','Wellsbury','5551026'),
('WSB0027','Ralph','King','55','M','ralph.king@example.com','Harbor Drive','Wellsbury','5551027'),
('WSB0028','Emilia','Grant','23','F','emilia.grant@example.com','Oak Avenue','Wellsbury','5551028'),
('WSB0029','Garrett','Voss','46','M','garrett.voss@example.com','Industrial Park Rd','Wellsbury','5551029'),
('WSB0030','Abby','Marshall','20','F','abby.marshall@example.com','School Ln','Wellsbury','5551030'),
('WSB0031','Detective','Holland','42','M','holland.detective@example.com','Main St','Wellsbury','5551031'),
('WSB0032','Officer','Reyes','39','M','reyes.officer@example.com','Main St','Wellsbury','5551032'),
('WSB0033','Gabriel','Wright','50','M','gabriel.wright@example.com','Pine Street','Wellsbury','5551033'),
('WSB0034','Maya','Lopez','17','F','maya.lopez@example.com','Elm Terrace','Wellsbury','5551034'),
('WSB0035','Eva','Dunn','28','F','eva.dunn@example.com','Cedar Court','Wellsbury','5551035'),
('WSB0036','Felix','Hart','31','M','felix.hart@example.com','Riverfront Blvd','Wellsbury','5551036');

INSERT INTO contact_details (ssn, contact) VALUES
('WSB0001','555-1001'),
('WSB0002','555-1002'),
('WSB0003','555-1003'),
('WSB0004','555-1004'),
('WSB0005','555-1005'),
('WSB0006','555-1006'),
('WSB0007','555-1007'),
('WSB0008','555-1008'),
('WSB0009','555-1009'),
('WSB0010','555-1010'),
('WSB0011','555-1011'),
('WSB0012','555-1012'),
('WSB0013','555-1013'),
('WSB0014','555-1014');

INSERT INTO business (business_name, owner_ssn, revenue) VALUES
('Blue Farm Cafe','WSB0005',200000.00),
('Joe''s Diner','WSB0005',125000.00),
('Wellsbury High School','WSB0014',800000.00),
('Harbor Auto','WSB0029',150000.00),
('Maple Pharmacy','WSB0013',95000.00),
('Cedar Boutique','WSB0024',60000.00),
('Riverfront Logistics','WSB0029',300000.00),
('Wellsbury Books','WSB0013',45000.00),
('Sunset Bakery','WSB0008',70000.00),
('Atlas Security Services','WSB0022',180000.00),
('Grant IT Solutions','WSB0028',220000.00),
('City Hall Wellsbury','WSB0004',0.00);

INSERT INTO employment_records (ssn, organisation_name, occupation, salary) VALUES
('WSB0001','Maple Pharmacy','Barista (public)','30000.00'),
('WSB0002','Wellsbury High School','Student','0.00'),
('WSB0003','Blue Farm Cafe','Line Cook','28000.00'),
('WSB0004','City Hall Wellsbury','Mayor','95000.00'),
('WSB0005','Joe''s Diner','Owner','70000.00'),
('WSB0006','Cedar Boutique','Manager','42000.00'),
('WSB0007','Riverfront Logistics','Freight Coordinator','48000.00'),
('WSB0008','Sunset Bakery','Baker','32000.00'),
('WSB0009','Wellsbury High School','Student','0.00'),
('WSB0010','Wellsbury Books','Sales Associate','26000.00'),
('WSB0011','Harbor Auto','Mechanic','35000.00'),
('WSB0012','Atlas Security Services','Security Supervisor','54000.00'),
('WSB0013','Maple Pharmacy','Pharmacist','62000.00'),
('WSB0014','Wellsbury High School','Principal','88000.00'),
('WSB0015','Grant IT Solutions','Systems Admin','56000.00'),
('WSB0016','Riverfront Logistics','Engineer','64000.00'),
('WSB0017','Blue Farm Cafe','Waitstaff','24000.00'),
('WSB0018','Atlas Security Services','Analyst','50000.00'),
('WSB0019','Sunset Bakery','Cashier','22000.00'),
('WSB0020','City Hall Wellsbury','Tax Officer','60000.00'),
('WSB0021','Wellsbury High School','Teacher','42000.00'),
('WSB0022','Atlas Security Services','Contract Manager','58000.00'),
('WSB0023','Cedar Boutique','Apprentice','18000.00'),
('WSB0024','Cedar Boutique','Owner','52000.00'),
('WSB0025','Harbor Auto','Sales','34000.00'),
('WSB0026','Blue Farm Cafe','Assistant Manager','46000.00'),
('WSB0027','Riverfront Logistics','Retired','0.00'),
('WSB0028','Grant IT Solutions','Developer','68000.00'),
('WSB0029','Harbor Auto','Owner','90000.00'),
('WSB0030','Wellsbury High School','Student','0.00'),
('WSB0031','City Hall Wellsbury','Detective (public)','52000.00'),
('WSB0032','City Hall Wellsbury','Police Officer (public)','48000.00'),
('WSB0033','Maple Pharmacy','Delivery Driver','30000.00'),
('WSB0034','Wellsbury High School','Student','0.00'),
('WSB0035','Sunset Bakery','Barista','25000.00'),
('WSB0036','Riverfront Logistics','Dock Manager','65000.00');

INSERT INTO secret_agent (ssn, actual_name, post) VALUES
('WSB0017','Agent Aurora Blake','Field Agent'),   -- public: Tanya Griffin (barista)
('WSB0018','Agent Marcus Vale','Analyst'),        -- public: Aaron Kim (analyst)
('WSB0012','Agent Cassian Roebuck','Handler'),    -- public: Nick Harris (security sup)
('WSB0022','Agent Elena Cross','Operations'),     -- public: Derek Miles (contract mgr)
('WSB0007','Agent Jonah Pike','Field Officer'),   -- public: Marcus Delgado
('WSB0031','Agent Henry Lowell','Lead Investigator'), -- public: Detective Holland
('WSB0032','Agent Carla Nguyen','Liaison'),       -- public: Officer Reyes
('WSB0006','PI_Linda_Brooks','Private Investigator'), -- public: Cynthia Parker; actual_name is PI (diff)
('WSB0009','PI_Thomas_Ridge','Private Investigator'), -- public: Zion Perez; actual_name is PI (diff)
('WSB0033','Agent Vera Quinn','Forensics');       -- public: Gabriel Wright

INSERT INTO pi_data (pi_data_id, collected_info) VALUES
(1001,'Observed high-frequency visitors to Blue Farm Cafe late nights — possible meeting spot.'),
(1002,'CCTV capture of a silver van unloading boxes at Riverfront Warehouse #3.'),
(1003,'Phone intercept: suspicious conversation referencing "Maple drop" and "parcel A".'),
(1004,'Anonymous tip: individual seen leaving Joe''s Diner with a sealed envelope.'),
(1005,'Financial anomaly: frequent small transfers from an off-shore to Sunset Bakery vendor account.'),
(1006,'Witness: loud argument at Harbor Auto the night of 2025-10-08.'),
(1007,'DNA partial match from hair fiber found at Oak Avenue property.'),
(1008,'Forensics: toolmark on lock that matches Harbor Auto mechanics tools.'),
(1009,'Undercover: purchase of chemicals at Maple Pharmacy in small quantities.'),
(1010,'Social media monitoring: account @wellsrumor spreading false city council minutes.'),
(1011,'Surveillance: Agent saw Mayor Paul departing via side entrance late at night with a package.'),
(1012,'Bank cheque traced to Riverfront Logistics owner showing payment to unnamed consultant.'),
(1013,'Interview: former employee alleges payroll irregularities at Grant IT Solutions.'),
(1014,'CCTV: two masked persons entering a storage unit at Industrial Park Rd.'),
(1015,'Recovered message: "Meet at School Ln at dawn" in suspect''s phone.'),
(1016,'Recovered photo: map with property coordinates near Harbor Drive.'),
(1017,'Witness statement: Ginny Miller was offered a cash gift by unknown person.'),
(1018,'Anonymous tip: illegal weapons transaction coordinated through Harbor Auto.'),
(1019,'Forensics: latent fingerprint match from Sunset Bakery to known offender WSB0040.'),
(1020,'Recorded audio: heated conversation between Cynthia Parker and unknown caller re: "loan".');

INSERT INTO report_summary (report_date, officer, summary) VALUES
('2025-10-08','WSB0031','Report filed re: disturbance at Harbor Auto; witness statements collected.'),
('2025-10-10','WSB0032','Report filed: suspicious vehicle activity near Riverfront Logistics.'),
('2025-10-12','WSB0031','Report: alleged assault near Elm Terrace; medical samples taken.'),
('2025-10-14','WSB0032','Report: missing property report from Cedar Boutique.'),
('2025-10-16','WSB0031','Report: CCTV review requested for Joe''s Diner incident.'),
('2025-10-20','WSB0032','Report: theft at Sunset Bakery; evidence logged.');

INSERT INTO criminal_records (ssn, report_id) VALUES
('WSB0033',1),  -- Gabriel Wright linked to report 1
('WSB0029',2),  -- Garrett Voss linked to report 2
('WSB0006',3),  -- Cynthia Parker linked to report 3
('WSB0008',6),  -- Maxine Reed linked to report 6 (theft assoc)
('WSB0019',6),  -- Sofia Ramirez linked to report 6
('WSB0002',5),  -- Ginny Miller linked to the Joe's Diner incident (investigation)
('WSB0011',1),  -- Hunter Bell (mechanic) linked to disturbance
('WSB0025',4),  -- Caleb Ford linked to missing property
('WSB0023',4),  -- Hannah Stone linked to missing property
('WSB0034',5);  -- Maya Lopez (witness turned subject)


INSERT INTO expenditure_records (money_spent, transaction_date) VALUES
(1500.00,'2025-09-01'),
(50000.00,'2025-09-05'),
(320.00,'2025-09-07'),
(7800.00,'2025-09-10'),
(12000.00,'2025-09-12'),
(250.00,'2025-09-13'),
(9800.00,'2025-09-15'),
(450.00,'2025-09-16'),
(60000.00,'2025-09-20'),
(2200.00,'2025-09-22'),
(15000.00,'2025-09-24'),
(50.00,'2025-09-25'),
(110000.00,'2025-09-30'),
(8000.00,'2025-10-02'),
(300.00,'2025-10-05');

INSERT INTO expenditure_by_people (transaction_id, ssn) VALUES
(1,'WSB0010'),
(3,'WSB0003'),
(6,'WSB0017'),
(8,'WSB0019'),
(10,'WSB0015'),
(12,'WSB0023'),
(15,'WSB0026');

INSERT INTO expenditure_by_business (transaction_id, business_id) VALUES
(2,1),   -- Blue Farm Cafe paid 50000 on tx 2
(4,4),   -- Harbor Auto 7800
(5,11),  -- Grant IT Solutions 12000
(7,7),   -- Riverfront Logistics 9800
(9,12),  -- City Hall Wellsbury 60000
(11,3),  -- Wellsbury High School 15000
(13,12); -- City Hall large project 110000

INSERT INTO expenditure_by_government (transaction_id) VALUES
(13);  -- tx 13 is government (City Hall)

INSERT INTO evidence_collection (chain_of_custody_status, collection_date, evidence_type) VALUES
('COLLECTED','2025-09-08','FINGERPRINT'),
('SEALED','2025-09-09','DNA'),
('IN_TRANSIT','2025-09-10','WEAPON'),
('RECEIVED','2025-09-11','PHOTO'),
('PROCESSING','2025-09-12','DIGITAL_DEVICE'),
('ANALYZED','2025-09-13','BLOOD_SAMPLE'),
('STORED','2025-09-14','TOOLMARK'),
('TRANSFERRED','2025-09-15','VIDEO_RECORDING'),
('USED_IN_REPORT','2025-09-16','DOCUMENT'),
('RELEASED','2025-09-17','PROPERTY_ITEM'),
('CLOSED','2025-09-18','FINANCIAL_RECORD'),
('DISPOSED','2025-09-19','CHEMICAL_SUBSTANCE'),
('COLLECTED','2025-09-20','MOBILE_PHONE'),
('PROCESSING','2025-09-21','STORAGE_MEDIA'),
('ANALYZED','2025-09-22','AUDIO_RECORDING'),
('STORED','2025-09-23','PHOTO'),
('COLLECTED','2025-09-24','DRUGS'),
('COLLECTED','2025-09-25','FIREARM'),
('PROCESSING','2025-09-26','VEHICLE_PART'),
('STORED','2025-09-27','BIOLOGICAL');


-- Use employee_id as per secret_agent insert order (1..10)
INSERT INTO evidence_gathering (employee_id, subject_ssn, found_at_property_id, stored_at_business_id, evidence_id) VALUES
(1,'WSB0002',1,1,1),
(2,'WSB0029',10,4,2),
(3,'WSB0033',6,4,3),
(4,'WSB0006',4,6,4),
(5,'WSB0007',7,7,5),
(6,'WSB0001',1,1,6),
(7,'WSB0008',11,9,7),
(8,'WSB0009',9,9,8),
(9,'WSB0019',5,9,9),
(10,'WSB0023',2,2,10),
(1,'WSB0011',6,4,11),
(2,'WSB0025',3,4,12),
(3,'WSB0034',9,9,13),
(4,'WSB0036',7,7,14),
(5,'WSB0006',4,11,15),
(6,'WSB0002',1,1,16),
(7,'WSB0010',11,8,17),
(8,'WSB0020',9,12,18),
(9,'WSB0005',2,2,19),
(10,'WSB0006',4,6,20);



INSERT INTO investigates (subject_ssn, employee_id, pi_data_id) VALUES
('WSB0002',1,1001),
('WSB0029',2,1002),
('WSB0006',3,1003),
('WSB0008',4,1004),
('WSB0019',5,1005),
('WSB0033',6,1006),
('WSB0001',7,1007),
('WSB0011',1,1008),
('WSB0025',2,1009),
('WSB0034',3,1010),
('WSB0002',4,1011),
('WSB0005',5,1012),
('WSB0028',6,1013),
('WSB0016',7,1014),
('WSB0010',8,1015),
('WSB0013',9,1016),
('WSB0002',2,1017),
('WSB0006',3,1018),
('WSB0019',4,1019),
('WSB0020',5,1020);


INSERT INTO financial_analysis (employee_id, source_ssn, business_id, transaction_id, analysis_date, analysis_note) VALUES
(2,'WSB0006',11,5,'2025-09-14','Analysis: possible diversion of funds to third-party vendor.'),
(4,'WSB0013',7,7,'2025-09-16','Audit: unexplained transfers traced to offshore account.'),
(6,'WSB0005',1,2,'2025-09-18','Review: large purchase by Blue Farm Cafe needs invoice verification.'),
(1,'WSB0029',4,2,'2025-09-20','Review: logistics payment irregularity flagged.'),
(3,'WSB0015',3,11,'2025-09-22','School procurement audit initiated.'),
(5,'WSB0001',1,1,'2025-09-24','Low-value repeated transfers suspicious; flagged for PI.'),
(7,'WSB0002',9,12,'2025-09-25','Transaction linked to theft case at Sunset Bakery.'),
(8,'WSB0012',12,13,'2025-09-26','City Hall project expenditure verification.');


INSERT INTO contact_details (ssn, contact) VALUES
('WSB0004','555-2004'),
('WSB0005','555-2005'),
('WSB0006','555-2006'),
('WSB0002','555-2002-alt');

INSERT INTO property_records (property_id, bought_when, worth) VALUES
(1, '2010-05-12', 180000.00),   -- Maple Way house
(2, '2012-03-08',  95000.00),   -- Blue Farm Rd apartment
(3, '2015-09-20', 220000.00),   -- Main St home
(4, '2018-11-01', 145000.00);   -- Oak Avenue property

INSERT INTO property_records (property_id, bought_when, worth) VALUES
(5, '2015-03-10', 150000.00),   -- Blue Farm Café storage barn
(6, '2018-06-12', 220000.00),   -- Joe’s Diner kitchen facility
(7, '2020-11-01', 300000.00),   -- Wellsbury High School annex
(8, '2016-08-22', 185000.00),   -- Harbor Auto service unit
(9, '2019-01-15', 275000.00);   -- Maple Pharmacy retail building

INSERT INTO property_records (property_id, bought_when, worth) VALUES
(10, '2001-01-01', 900000.00),   -- City Hall Wellsbury
(11, '1995-06-01', 500000.00),   -- Wellsbury Public Park facility
(12, '1985-09-15', 1200000.00);  -- Wellsbury Police Department

INSERT INTO property_owned_by_people (property_id, ssn) VALUES
(1, 'WSB0001'),
(2, 'WSB0003'),
(3, 'WSB0004'),
(4, 'WSB0006');

INSERT INTO property_owned_by_business (property_id, business_id) VALUES
(5, 1),
(6, 2),
(7, 3),
(8, 4),
(9, 5);

INSERT INTO property_owned_by_government (property_id) VALUES
(10),
(11),
(12);


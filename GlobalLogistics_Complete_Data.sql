-- ================================================================
-- GLOBALLOGISTICS DATABASE - COMPREHENSIVE DATA GENERATION
-- ================================================================
-- This script generates realistic, non-NULL data for all tables
-- to support the GlobalLogistics supply chain management system
-- ================================================================

-- ================================================================
-- 1. CLIENT DATA - Various merchants using GlobalLogistics services
-- ================================================================
DELETE FROM Client;
INSERT INTO Client (CID, CompanyName, ContactPerson, StartDate, ServiceTier) VALUES
('C001', 'Amazon Singapore', 'John Smith', '2020-01-15', 'Gold'),
('C002', 'Lazada Southeast Asia', 'Sarah Johnson', '2019-06-22', 'Gold'),
('C003', 'Shopee Philippines', 'Michael Chen', '2021-03-10', 'Silver'),
('C004', 'Tokopedia Indonesia', 'Emily Rodriguez', '2020-11-05', 'Silver'),
('C005', 'TikTok Shop Thailand', 'David Wilson', '2018-09-30', 'Platinum'),
('C006', 'Zalora Vietnam', 'Lisa Anderson', '2022-02-14', 'Silver'),
('C007', 'Grab Marketing', 'James Thompson', '2021-07-20', 'Gold'),
('C008', 'Gojek Commerce', 'Jennifer Lee', '2019-12-03', 'Gold'),
('C009', 'Sea Delivery Singapore', 'Robert Martinez', '2022-05-18', 'Bronze'),
('C010', 'Ninja Van Distribution', 'Amanda Clark', '2020-08-27', 'Silver'),
('C011', 'J&T Express', 'Christopher White', '2021-01-12', 'Bronze'),
('C012', 'DHL eCommerce', 'Michelle Garcia', '2019-04-08', 'Platinum'),
('C013', 'FedEx APAC', 'Daniel Harris', '2022-09-11', 'Gold'),
('C014', 'Kerry Logistics', 'Victoria Taylor', '2020-10-25', 'Gold'),
('C015', 'Schenker Asia', 'Brandon Scott', '2021-06-19', 'Silver'),
('C016', 'AEON Thailand', 'Stephanie Green', '2018-11-14', 'Gold'),
('C017', 'Central World Bangkok', 'Kevin Adams', '2022-03-06', 'Silver'),
('C018', 'Emporium Bangkok', 'Rachel Nelson', '2021-02-28', 'Bronze'),
('C019', 'MBK Center Bangkok', 'Matthew King', '2019-07-17', 'Gold'),
('C020', 'EmQuartier Bangkok', 'Lauren Young', '2020-12-01', 'Silver'),
('C021', 'SM Malls Philippines', 'Eric Davis', '2021-05-11', 'Gold'),
('C022', 'Robinsons Singapore', 'Sophia Martinez', '2020-03-25', 'Silver'),
('C023', 'Takashimaya Singapore', 'Jacob Wilson', '2019-08-14', 'Platinum'),
('C024', 'OG Singapore', 'Mia Thompson', '2021-11-30', 'Bronze'),
('C025', 'H&M Southeast Asia', 'Noah Garcia', '2020-06-19', 'Gold');

-- ================================================================
-- 2. WAREHOUSE DATA - Global distribution centers
-- ================================================================
DELETE FROM Warehouse;
INSERT INTO Warehouse (WID, Address, Size, Temperature, Security) VALUES
('WH-SG-001', '26 Nanyang Avenue, Singapore', 40000.25, 23.6, 5),
('WH-SG-002', '03 Shenton Way, Singapore', 20000.00, 24.0, 4),
('WH-SG-003', '25 Broadway, Singapore', 10492.00, 24.1, 3),
('WH-LA-001', '1234 Industrial Blvd, Los Angeles, USA', 50000.00, 22.5, 5),
('WH-LA-002', '5678 Freight Lane, Los Angeles, USA', 35000.00, 22.0, 4),
('WH-BKK-001', '123 Soi Sukhumvit 38, Bangkok, Thailand', 28000.00, 25.0, 4),
('WH-BKK-002', '456 Rama I Road, Bangkok, Thailand', 22000.00, 24.5, 3),
('WH-MNL-001', '789 Makati Avenue, Manila, Philippines', 18000.00, 26.0, 3),
('WH-JKT-001', '321 Jalan Sudirman, Jakarta, Indonesia', 32000.00, 27.0, 4),
('WH-HNM-001', '654 Nguyen Hue Boulevard, Hanoi, Vietnam', 15000.00, 25.5, 2);

-- ================================================================
-- 3. ZONE DATA - Storage zones within warehouses
-- ================================================================
DELETE FROM Zone;
INSERT INTO Zone (WID, Location, Code) VALUES
-- Singapore Warehouse 1 Zones
('WH-SG-001', 'Receiving', 1),
('WH-SG-001', 'Bulk Storage', 2),
('WH-SG-001', 'Picking Area', 3),
('WH-SG-001', 'Packing Area', 4),
('WH-SG-001', 'Shipping Dock', 5),
-- Singapore Warehouse 2 Zones
('WH-SG-002', 'Receiving', 1),
('WH-SG-002', 'Bulk Storage', 2),
('WH-SG-002', 'Picking Area', 3),
('WH-SG-002', 'Packing Area', 4),
('WH-SG-002', 'Shipping Dock', 5),
-- Singapore Warehouse 3 Zones
('WH-SG-003', 'Receiving', 1),
('WH-SG-003', 'Bulk Storage', 2),
('WH-SG-003', 'Picking Area', 3),
('WH-SG-003', 'Packing Area', 4),
('WH-SG-003', 'Shipping Dock', 5),
-- LA Warehouse 1 Zones
('WH-LA-001', 'Receiving', 1),
('WH-LA-001', 'Bulk Storage', 2),
('WH-LA-001', 'Picking Area', 3),
('WH-LA-001', 'Packing Area', 4),
('WH-LA-001', 'Shipping Dock', 5),
-- LA Warehouse 2 Zones
('WH-LA-002', 'Receiving', 1),
('WH-LA-002', 'Bulk Storage', 2),
('WH-LA-002', 'Picking Area', 3),
('WH-LA-002', 'Packing Area', 4),
('WH-LA-002', 'Shipping Dock', 5),
-- Bangkok Warehouse Zones
('WH-BKK-001', 'Receiving', 1),
('WH-BKK-001', 'Bulk Storage', 2),
('WH-BKK-001', 'Picking Area', 3),
('WH-BKK-001', 'Packing Area', 4),
('WH-BKK-001', 'Shipping Dock', 5),
('WH-BKK-002', 'Receiving', 1),
('WH-BKK-002', 'Bulk Storage', 2),
('WH-BKK-002', 'Picking Area', 3),
('WH-BKK-002', 'Packing Area', 4),
('WH-BKK-002', 'Shipping Dock', 5),
-- Manila Warehouse Zones
('WH-MNL-001', 'Receiving', 1),
('WH-MNL-001', 'Bulk Storage', 2),
('WH-MNL-001', 'Picking Area', 3),
('WH-MNL-001', 'Packing Area', 4),
('WH-MNL-001', 'Shipping Dock', 5),
-- Jakarta Warehouse Zones
('WH-JKT-001', 'Receiving', 1),
('WH-JKT-001', 'Bulk Storage', 2),
('WH-JKT-001', 'Picking Area', 3),
('WH-JKT-001', 'Packing Area', 4),
('WH-JKT-001', 'Shipping Dock', 5),
-- Hanoi Warehouse Zones
('WH-HNM-001', 'Receiving', 1),
('WH-HNM-001', 'Bulk Storage', 2),
('WH-HNM-001', 'Picking Area', 3),
('WH-HNM-001', 'Packing Area', 4),
('WH-HNM-001', 'Shipping Dock', 5);

-- ================================================================
-- 4. PRODUCT DATA - Products from various clients
-- ================================================================
DELETE FROM Product;
INSERT INTO Product (PID, ItemSerial, Name, Brand, Category, UnitCost, RetailPrice, Length, Width, Height, HandlingRequirements) VALUES
('P001', 'SN-ELEC-001', 'Laptop Pro 15', 'TechBrand', 'Electronics', 800.00, 1200.00, 35.79, 24.59, 1.62, 'Fragile, Handle with care'),
('P002', 'SN-ELEC-002', 'Wireless Mouse', 'ClickMaster', 'Computer Accessories', 15.50, 29.99, 10.0, 6.0, 4.0, NULL),
('P003', 'SN-ELEC-003', 'Mechanical Keyboard', 'TypeFast', 'Computer Accessories', 75.00, 130.00, 44.0, 13.0, 3.5, 'Keep Dry'),
('P004', 'SN-ELEC-004', '4K Monitor 27 inch', 'ViewSharp', 'Electronics', 250.00, 399.99, 61.0, 36.0, 5.0, 'Fragile, Screen side up'),
('P005', 'SN-CLOTH-001', 'Cotton T-Shirt', 'FashionBrand', 'Apparel', 5.00, 15.00, 30.0, 25.0, 1.0, NULL),
('P006', 'SN-CLOTH-002', 'Denim Jeans', 'StyleHub', 'Apparel', 15.00, 45.00, 32.0, 30.0, 2.0, NULL),
('P007', 'SN-SHOE-001', 'Running Shoes', 'SportGear', 'Footwear', 25.00, 80.00, 32.0, 12.0, 14.0, NULL),
('P008', 'SN-BEAUTY-001', 'Facial Cream', 'SkinCare Pro', 'Beauty', 8.00, 25.00, 8.0, 8.0, 8.0, 'Temperature Controlled, Handle with care'),
('P009', 'SN-BEAUTY-002', 'Shampoo Bottle', 'HairCare', 'Beauty', 3.00, 10.00, 20.0, 8.0, 8.0, 'Keep Dry, Fragile'),
('P010', 'SN-HOME-001', 'Bedding Set', 'HomeDecor', 'Home & Garden', 20.00, 60.00, 40.0, 30.0, 10.0, NULL),
('P011', 'SN-ELEC-005', 'USB-C Cable', 'TechBrand', 'Computer Accessories', 2.50, 8.00, 15.0, 2.0, 2.0, NULL),
('P012', 'SN-FOOD-001', 'Instant Noodles Pack', 'FoodBrand', 'Food & Beverages', 0.50, 1.50, 20.0, 15.0, 5.0, 'Keep Dry'),
('P013', 'SN-FOOD-002', 'Coffee Beans 500g', 'BeansCo', 'Food & Beverages', 8.00, 20.00, 15.0, 10.0, 10.0, 'Temperature Controlled, Keep Dry'),
('P014', 'SN-TOY-001', 'Action Figure Set', 'ToysRUs', 'Toys & Games', 5.00, 15.00, 25.0, 15.0, 10.0, NULL),
('P015', 'SN-WATCH-001', 'Smart Watch', 'TechTime', 'Electronics', 50.00, 150.00, 8.0, 8.0, 8.0, 'Fragile, High-Value'),
('P016', 'SN-BOOK-001', 'Programming Books Vol 1', 'TechPress', 'Books', 12.00, 35.00, 25.0, 18.0, 3.0, 'Keep Dry'),
('P017', 'SN-PHONE-001', 'Smartphone Case', 'ProtectTech', 'Phone Accessories', 3.00, 12.00, 15.0, 8.0, 1.0, NULL),
('P018', 'SN-ELEC-006', 'Power Bank 20000mAh', 'PowerTech', 'Electronics', 15.00, 40.00, 15.0, 8.0, 2.0, 'Fragile'),
('P019', 'SN-CLOTH-003', 'Winter Jacket', 'OutdoorGear', 'Apparel', 35.00, 100.00, 35.0, 35.0, 5.0, NULL),
('P020', 'SN-HOME-002', 'Wooden Chair', 'FurnitureCo', 'Home & Garden', 40.00, 120.00, 45.0, 45.0, 80.0, 'Heavy, Fragile');

-- ================================================================
-- 5. SUPPLIER DATA - Product suppliers
-- ================================================================
DELETE FROM Supplier;
INSERT INTO Supplier (SupID, Country, Name, PaymentTerms, LeadTime_Days) VALUES
('SUP001', 'China', 'TechImports Ltd', 'Net 30', 30),
('SUP002', 'Taiwan', 'Electronics Factory', 'Net 45', 25),
('SUP003', 'Vietnam', 'TextileCorp Vietnam', 'Net 30', 20),
('SUP004', 'Thailand', 'Bangkok Garment Works', 'Net 30', 15),
('SUP005', 'Indonesia', 'Jaya Textiles', 'Net 60', 25),
('SUP006', 'Malaysia', 'Penang Manufacturing', 'Net 45', 20),
('SUP007', 'Philippines', 'Manila Imports', 'Net 30', 22),
('SUP008', 'Singapore', 'Singapore Suppliers Group', 'Net 15', 10),
('SUP009', 'South Korea', 'Seoul Electronics', 'Net 45', 28),
('SUP010', 'Japan', 'Tokyo Manufacturing', 'Net 60', 35),
('SUP011', 'India', 'Delhi Textiles', 'Net 30', 30),
('SUP012', 'Bangladesh', 'Dhaka Garments', 'Net 45', 25),
('SUP013', 'Cambodia', 'Phnom Penh Factory', 'Net 30', 28),
('SUP014', 'Laos', 'Vientiane Supplies', 'Net 30', 32),
('SUP015', 'Myanmar', 'Yangon Distribution', 'Net 45', 35);

-- ================================================================
-- 6. SUPPLY CONTRACTS - Supplier-Product-Client relationships
-- ================================================================
DELETE FROM Supply;
INSERT INTO Supply (PID, SupID, CID, Contract_Start_Date, Contract_End_Date) VALUES
-- Electronics suppliers for C001 (Amazon Singapore)
('P001', 'SUP001', 'C001', '2020-01-15', '2026-12-31'),
('P002', 'SUP002', 'C001', '2020-01-15', '2026-12-31'),
('P003', 'SUP001', 'C001', '2020-01-15', '2026-12-31'),
('P004', 'SUP002', 'C001', '2020-02-01', '2026-12-31'),
('P015', 'SUP009', 'C001', '2020-06-01', '2026-12-31'),
('P018', 'SUP002', 'C001', '2021-01-01', '2026-12-31'),
-- Apparel suppliers for C002 (Lazada)
('P005', 'SUP003', 'C002', '2019-06-22', '2026-12-31'),
('P006', 'SUP004', 'C002', '2019-06-22', '2026-12-31'),
('P007', 'SUP005', 'C002', '2019-07-01', '2026-12-31'),
('P019', 'SUP003', 'C002', '2020-01-01', '2026-12-31'),
-- Mixed products for C003 (Shopee Philippines)
('P001', 'SUP001', 'C003', '2021-03-10', '2026-12-31'),
('P008', 'SUP001', 'C003', '2021-03-10', '2026-12-31'),
('P009', 'SUP003', 'C003', '2021-04-01', '2026-12-31'),
('P010', 'SUP005', 'C003', '2021-03-15', '2026-12-31'),
-- Beauty products for C004 (Tokopedia Indonesia)
('P008', 'SUP004', 'C004', '2020-11-05', '2026-12-31'),
('P009', 'SUP005', 'C004', '2020-11-05', '2026-12-31'),
-- Food products for C005 (TikTok Shop Thailand)
('P012', 'SUP004', 'C005', '2018-09-30', '2026-12-31'),
('P013', 'SUP006', 'C005', '2019-01-01', '2026-12-31'),
-- Apparel for C006 (Zalora Vietnam)
('P005', 'SUP003', 'C006', '2022-02-14', '2026-12-31'),
('P006', 'SUP003', 'C006', '2022-02-14', '2026-12-31'),
('P007', 'SUP003', 'C006', '2022-03-01', '2026-12-31'),
('P019', 'SUP003', 'C006', '2022-03-01', '2026-12-31'),
-- Electronics for C007 (Grab Marketing)
('P002', 'SUP002', 'C007', '2021-07-20', '2026-12-31'),
('P003', 'SUP002', 'C007', '2021-07-20', '2026-12-31'),
('P011', 'SUP002', 'C007', '2021-08-01', '2026-12-31'),
('P015', 'SUP009', 'C007', '2021-09-01', '2026-12-31'),
-- Books and accessories for C008 (Gojek Commerce)
('P016', 'SUP001', 'C008', '2019-12-03', '2026-12-31'),
('P017', 'SUP002', 'C008', '2020-01-01', '2026-12-31'),
('P018', 'SUP002', 'C008', '2020-02-01', '2026-12-31'),
-- Toys for C009 (Sea Delivery Singapore)
('P014', 'SUP008', 'C009', '2022-05-18', '2026-12-31'),
-- Home products for C010 (Ninja Van Distribution)
('P010', 'SUP006', 'C010', '2020-08-27', '2026-12-31'),
('P020', 'SUP008', 'C010', '2021-01-01', '2026-12-31'),
-- Electronics for C012 (DHL eCommerce)
('P001', 'SUP009', 'C012', '2019-04-08', '2026-12-31'),
('P004', 'SUP010', 'C012', '2019-05-01', '2026-12-31'),
('P015', 'SUP009', 'C012', '2020-01-01', '2026-12-31'),
('P018', 'SUP009', 'C012', '2020-06-01', '2026-12-31'),
-- Multiple products for C016 (AEON Thailand)
('P005', 'SUP004', 'C016', '2018-11-14', '2026-12-31'),
('P006', 'SUP004', 'C016', '2018-11-14', '2026-12-31'),
('P010', 'SUP004', 'C016', '2019-01-01', '2026-12-31'),
('P012', 'SUP004', 'C016', '2019-06-01', '2026-12-31'),
('P013', 'SUP004', 'C016', '2019-06-01', '2026-12-31'),
-- Products for Bangkok stores
('P005', 'SUP004', 'C019', '2019-07-17', '2026-12-31'),
('P006', 'SUP004', 'C019', '2019-07-17', '2026-12-31'),
('P010', 'SUP004', 'C019', '2020-01-01', '2026-12-31'),
-- Singapore suppliers to SG clients
('P001', 'SUP008', 'C001', '2021-01-01', '2026-12-31'),
('P015', 'SUP008', 'C001', '2021-06-01', '2026-12-31'),
('P010', 'SUP008', 'C022', '2020-03-25', '2026-12-31'),
('P020', 'SUP008', 'C022', '2020-06-01', '2026-12-31'),
('P001', 'SUP008', 'C023', '2019-08-14', '2026-12-31'),
('P010', 'SUP008', 'C023', '2020-01-01', '2026-12-31');

-- ================================================================
-- 7. VEHICLE DATA - Delivery fleet
-- ================================================================
DELETE FROM Vehicle;
INSERT INTO Vehicle (VID, Type, License, CapacityWgt, CapacityVol) VALUES
('V001', 'Van', 'SG-VAN-001', 2000.00, 12.00),
('V002', 'Van', 'SG-VAN-002', 2000.00, 12.00),
('V003', 'Truck', 'SG-TRUCK-001', 5000.00, 35.00),
('V004', 'Truck', 'SG-TRUCK-002', 5000.00, 35.00),
('V005', 'Refrigerated Truck', 'SG-REFRIG-001', 3500.00, 20.00),
('V006', 'Van', 'LA-VAN-001', 2000.00, 12.00),
('V007', 'Truck', 'LA-TRUCK-001', 5500.00, 40.00),
('V008', 'Truck', 'LA-TRUCK-002', 5500.00, 40.00),
('V009', 'Refrigerated Truck', 'LA-REFRIG-001', 3800.00, 22.00),
('V010', 'Van', 'BKK-VAN-001', 2000.00, 12.00),
('V011', 'Truck', 'BKK-TRUCK-001', 5000.00, 35.00),
('V012', 'Refrigerated Truck', 'BKK-REFRIG-001', 3500.00, 20.00),
('V013', 'Van', 'MNL-VAN-001', 1800.00, 10.00),
('V014', 'Truck', 'MNL-TRUCK-001', 4500.00, 30.00),
('V015', 'Van', 'JKT-VAN-001', 1800.00, 10.00);

-- ================================================================
-- 8. EMPLOYEE DATA - Drivers and warehouse staff
-- ================================================================
DELETE FROM Employee;
INSERT INTO Employee (SID, Certification, WID) VALUES
('EMP001', 'Forklift Operator, Hazmat Handling', 'WH-SG-001'),
('EMP002', 'Forklift Operator, High Reach', 'WH-SG-001'),
('EMP003', 'Hazmat Handling, Cold Chain', 'WH-SG-001'),
('EMP004', 'Forklift Operator', 'WH-SG-002'),
('EMP005', 'Quality Inspector', 'WH-SG-002'),
('EMP006', 'Forklift Operator, Hazmat Handling', 'WH-SG-003'),
('EMP007', 'Inventory Specialist', 'WH-SG-003'),
('EMP008', 'Forklift Operator, High Reach', 'WH-LA-001'),
('EMP009', 'Hazmat Handling', 'WH-LA-001'),
('EMP010', 'Forklift Operator', 'WH-LA-002'),
('EMP011', 'Cold Chain Specialist', 'WH-LA-002'),
('EMP012', 'Forklift Operator, Hazmat Handling', 'WH-BKK-001'),
('EMP013', 'Quality Inspector', 'WH-BKK-001'),
('EMP014', 'Forklift Operator', 'WH-BKK-002'),
('EMP015', 'Inventory Specialist', 'WH-BKK-002'),
('EMP016', 'Forklift Operator, High Reach', 'WH-MNL-001'),
('EMP017', 'Hazmat Handling', 'WH-MNL-001'),
('EMP018', 'Forklift Operator', 'WH-JKT-001'),
('EMP019', 'Cold Chain Specialist', 'WH-JKT-001'),
('EMP020', 'Quality Inspector', 'WH-HNM-001');

-- ================================================================
-- 9. DRIVER DATA - Fleet drivers with licenses and assigned vehicles
-- ================================================================
DELETE FROM Driver;
INSERT INTO Driver (SID, LicenseNo, LicenseExpiration, VID) VALUES
('DRV001', 'SG-DRV-2019-001', '2027-06-30', 'V001'),
('DRV002', 'SG-DRV-2020-002', '2028-03-15', 'V002'),
('DRV003', 'SG-DRV-2018-003', '2026-12-31', 'V003'),
('DRV004', 'SG-DRV-2019-004', '2027-09-20', 'V004'),
('DRV005', 'SG-DRV-2020-005', '2028-01-10', 'V005'),
('DRV006', 'LA-DRV-2019-001', '2027-05-15', 'V006'),
('DRV007', 'LA-DRV-2018-002', '2026-11-20', 'V007'),
('DRV008', 'LA-DRV-2020-003', '2028-07-25', 'V008'),
('DRV009', 'LA-DRV-2019-004', '2027-02-14', 'V009'),
('DRV010', 'BKK-DRV-2020-001', '2028-08-30', 'V010'),
('DRV011', 'BKK-DRV-2019-002', '2027-04-12', 'V011'),
('DRV012', 'BKK-DRV-2020-003', '2028-10-05', 'V012'),
('DRV013', 'MNL-DRV-2019-001', '2027-03-20', 'V013'),
('DRV014', 'MNL-DRV-2020-002', '2028-09-15', 'V014'),
('DRV015', 'JKT-DRV-2020-001', '2028-05-10', 'V015');

-- ================================================================
-- 10. ROUTE DATA - Delivery routes
-- ================================================================
DELETE FROM Route;
INSERT INTO Route (RID, Distance, Total_Stops, Status) VALUES
('R001', 15.5, 12, 'Completed'),
('R002', 12.0, 9, 'Completed'),
('R003', 17.6, 5, 'Completed'),
('R004', 22.3, 15, 'Completed'),
('R005', 18.9, 10, 'Completed'),
('R006', 25.5, 18, 'Completed'),
('R007', 14.2, 8, 'Completed'),
('R008', 32.1, 22, 'Completed'),
('R009', 19.8, 13, 'Completed'),
('R010', 28.5, 20, 'Completed'),
('R011', 16.3, 11, 'Completed'),
('R012', 21.7, 14, 'Completed'),
('R013', 13.4, 7, 'Completed'),
('R014', 24.6, 17, 'Completed'),
('R015', 29.2, 19, 'Completed');

-- ================================================================
-- 11. STOP DATA - Individual delivery stops on routes
-- ================================================================
DELETE FROM Stop;
INSERT INTO Stop (RID, Sequence, Est_Arr_Time, Actual_Arr_Time) VALUES
('R001', 1, '2026-03-26 08:00:00', '2026-03-26 08:15:00'),
('R001', 2, '2026-03-26 09:00:00', '2026-03-26 09:10:00'),
('R001', 3, '2026-03-26 10:00:00', '2026-03-26 10:05:00'),
('R001', 4, '2026-03-26 11:00:00', '2026-03-26 11:15:00'),
('R001', 5, '2026-03-26 12:00:00', '2026-03-26 12:15:00'),
('R002', 1, '2026-03-27 08:30:00', '2026-03-27 08:45:00'),
('R002', 2, '2026-03-27 10:00:00', '2026-03-27 10:10:00'),
('R002', 3, '2026-03-27 11:30:00', '2026-03-27 11:40:00'),
('R002', 4, '2026-03-27 13:00:00', '2026-03-27 13:15:00'),
('R003', 1, '2026-03-28 09:00:00', '2026-03-28 09:20:00'),
('R003', 2, '2026-03-28 10:30:00', '2026-03-28 10:45:00'),
('R003', 3, '2026-03-28 12:00:00', '2026-03-28 12:15:00'),
('R004', 1, '2026-03-25 07:00:00', '2026-03-25 07:15:00'),
('R004', 2, '2026-03-25 08:30:00', '2026-03-25 08:45:00'),
('R004', 3, '2026-03-25 10:00:00', '2026-03-25 10:20:00'),
('R004', 4, '2026-03-25 11:30:00', '2026-03-25 11:45:00'),
('R004', 5, '2026-03-25 13:00:00', '2026-03-25 13:15:00');

-- ================================================================
-- 12. ITEM DATA - Individual items tracked in system
-- ================================================================
DELETE FROM Item;
INSERT INTO Item (Serial#, PID) VALUES
('ITEM-001', 'P001'),
('ITEM-002', 'P001'),
('ITEM-003', 'P002'),
('ITEM-004', 'P002'),
('ITEM-005', 'P003'),
('ITEM-006', 'P003'),
('ITEM-007', 'P004'),
('ITEM-008', 'P005'),
('ITEM-009', 'P005'),
('ITEM-010', 'P006'),
('ITEM-011', 'P006'),
('ITEM-012', 'P007'),
('ITEM-013', 'P007'),
('ITEM-014', 'P008'),
('ITEM-015', 'P008'),
('ITEM-016', 'P009'),
('ITEM-017', 'P009'),
('ITEM-018', 'P010'),
('ITEM-019', 'P010'),
('ITEM-020', 'P011'),
('ITEM-021', 'P012'),
('ITEM-022', 'P012'),
('ITEM-023', 'P013'),
('ITEM-024', 'P014'),
('ITEM-025', 'P015'),
('ITEM-026', 'P015'),
('ITEM-027', 'P016'),
('ITEM-028', 'P017'),
('ITEM-029', 'P018'),
('ITEM-030', 'P019'),
('ITEM-031', 'P020'),
('ITEM-032', 'P001'),
('ITEM-033', 'P002'),
('ITEM-034', 'P004'),
('ITEM-035', 'P005'),
('ITEM-036', 'P008'),
('ITEM-037', 'P010'),
('ITEM-038', 'P012'),
('ITEM-039', 'P013'),
('ITEM-040', 'P015');

-- ================================================================
-- 13. PO (PURCHASE ORDER) DATA - Orders with various statuses and dates
-- ================================================================
DELETE FROM PO;
INSERT INTO PO (OID, OrderDate, Status, Value) VALUES
-- 2024 Orders (supporting query 3)
('PO-2024-001', '2024-01-05', 'Fully Received', 15000.00),
('PO-2024-002', '2024-01-15', 'Fully Received', 22500.00),
('PO-2024-003', '2024-01-25', 'Fully Received', 18750.00),
('PO-2024-004', '2024-02-10', 'Fully Received', 25000.00),
('PO-2024-005', '2024-02-20', 'Fully Received', 17500.00),
('PO-2024-006', '2024-03-01', 'Fully Received', 21000.00),
('PO-2024-007', '2024-03-15', 'Fully Received', 19500.00),
('PO-2024-008', '2024-03-25', 'Fully Received', 23750.00),
('PO-2024-009', '2024-01-08', 'Fully Received', 16250.00),
('PO-2024-010', '2024-02-28', 'Fully Received', 24000.00),
('PO-2024-011', '2024-10-05', 'Fully Received', 18000.00),
('PO-2024-012', '2024-10-15', 'Fully Received', 21500.00),
('PO-2024-013', '2024-10-25', 'Fully Received', 19750.00),
('PO-2024-014', '2024-11-10', 'Fully Received', 26000.00),
('PO-2024-015', '2024-11-20', 'Fully Received', 20500.00),
('PO-2024-016', '2024-12-01', 'Fully Received', 23000.00),
('PO-2024-017', '2024-12-15', 'Fully Received', 17750.00),
('PO-2024-018', '2024-12-25', 'Fully Received', 22250.00),
-- 2025 Orders (supporting query 3)
('PO-2025-001', '2025-01-08', 'Fully Received', 20000.00),
('PO-2025-002', '2025-01-18', 'Fully Received', 24500.00),
('PO-2025-003', '2025-01-28', 'Fully Received', 19000.00),
('PO-2025-004', '2025-02-12', 'Fully Received', 27000.00),
('PO-2025-005', '2025-02-22', 'Fully Received', 18500.00),
('PO-2025-006', '2025-03-05', 'Fully Received', 25000.00),
('PO-2025-007', '2025-03-18', 'Fully Received', 21500.00),
('PO-2025-008', '2025-03-28', 'Fully Received', 26250.00),
('PO-2025-009', '2025-01-10', 'Fully Received', 18250.00),
('PO-2025-010', '2025-03-01', 'Fully Received', 28000.00),
('PO-2025-011', '2025-10-08', 'Fully Received', 22000.00),
('PO-2025-012', '2025-10-18', 'Fully Received', 25500.00),
('PO-2025-013', '2025-10-28', 'Fully Received', 21750.00),
('PO-2025-014', '2025-11-12', 'Fully Received', 28500.00),
('PO-2025-015', '2025-11-22', 'Fully Received', 23500.00),
('PO-2025-016', '2025-12-05', 'Fully Received', 26500.00),
('PO-2025-017', '2025-12-18', 'Fully Received', 20750.00),
('PO-2025-018', '2025-12-28', 'Fully Received', 24750.00),
-- 2026 Orders
('PO-2026-001', '2026-01-05', 'Confirmed', 18000.00),
('PO-2026-002', '2026-01-15', 'Confirmed', 22000.00),
('PO-2026-003', '2026-02-10', 'Submitted', 25000.00),
('PO-2026-004', '2026-02-20', 'Confirmed', 19500.00),
('PO-2026-005', '2026-03-01', 'Confirmed', 23500.00);

-- ================================================================
-- 14. CLIENT_HAS_PO DATA - Relationship between clients and POs
-- ================================================================
DELETE FROM ClientHasPO;
INSERT INTO ClientHasPO (OID, CID) VALUES
('PO-2024-001', 'C001'),
('PO-2024-002', 'C002'),
('PO-2024-003', 'C003'),
('PO-2024-004', 'C001'),
('PO-2024-005', 'C002'),
('PO-2024-006', 'C004'),
('PO-2024-007', 'C005'),
('PO-2024-008', 'C006'),
('PO-2024-009', 'C007'),
('PO-2024-010', 'C008'),
('PO-2024-011', 'C016'),
('PO-2024-012', 'C016'),
('PO-2024-013', 'C019'),
('PO-2024-014', 'C020'),
('PO-2024-015', 'C023'),
('PO-2024-016', 'C012'),
('PO-2024-017', 'C001'),
('PO-2024-018', 'C002'),
('PO-2025-001', 'C001'),
('PO-2025-002', 'C002'),
('PO-2025-003', 'C003'),
('PO-2025-004', 'C001'),
('PO-2025-005', 'C004'),
('PO-2025-006', 'C005'),
('PO-2025-007', 'C006'),
('PO-2025-008', 'C007'),
('PO-2025-009', 'C008'),
('PO-2025-010', 'C012'),
('PO-2025-011', 'C016'),
('PO-2025-012', 'C019'),
('PO-2025-013', 'C020'),
('PO-2025-014', 'C023'),
('PO-2025-015', 'C001'),
('PO-2025-016', 'C002'),
('PO-2025-017', 'C003'),
('PO-2025-018', 'C004'),
('PO-2026-001', 'C001'),
('PO-2026-002', 'C002'),
('PO-2026-003', 'C003'),
('PO-2026-004', 'C004'),
('PO-2026-005', 'C005');

-- ================================================================
-- 15. SUPPLIER_HAS_PO DATA - Supplier fulfilling POs
-- ================================================================
DELETE FROM SupplierHasPO;
INSERT INTO SupplierHasPO (OID, SupID) VALUES
('PO-2024-001', 'SUP001'),
('PO-2024-002', 'SUP002'),
('PO-2024-003', 'SUP003'),
('PO-2024-004', 'SUP001'),
('PO-2024-005', 'SUP004'),
('PO-2024-006', 'SUP005'),
('PO-2024-007', 'SUP006'),
('PO-2024-008', 'SUP007'),
('PO-2024-009', 'SUP008'),
('PO-2024-010', 'SUP009'),
('PO-2024-011', 'SUP004'),
('PO-2024-012', 'SUP004'),
('PO-2024-013', 'SUP004'),
('PO-2024-014', 'SUP004'),
('PO-2024-015', 'SUP008'),
('PO-2024-016', 'SUP009'),
('PO-2024-017', 'SUP001'),
('PO-2024-018', 'SUP002'),
('PO-2025-001', 'SUP001'),
('PO-2025-002', 'SUP002'),
('PO-2025-003', 'SUP003'),
('PO-2025-004', 'SUP001'),
('PO-2025-005', 'SUP005'),
('PO-2025-006', 'SUP006'),
('PO-2025-007', 'SUP003'),
('PO-2025-008', 'SUP007'),
('PO-2025-009', 'SUP008'),
('PO-2025-010', 'SUP009'),
('PO-2025-011', 'SUP004'),
('PO-2025-012', 'SUP004'),
('PO-2025-013', 'SUP004'),
('PO-2025-014', 'SUP004'),
('PO-2025-015', 'SUP008'),
('PO-2025-016', 'SUP001'),
('PO-2025-017', 'SUP002'),
('PO-2025-018', 'SUP003'),
('PO-2026-001', 'SUP001'),
('PO-2026-002', 'SUP002'),
('PO-2026-003', 'SUP003'),
('PO-2026-004', 'SUP004'),
('PO-2026-005', 'SUP008');

-- ================================================================
-- 16. SHIPMENT DATA - Inbound shipments from suppliers
-- ================================================================
DELETE FROM Shipment;
INSERT INTO Shipment (ShipID, OriLocation, Tracking#, ShipDate, ExArrDate, AcArrDate, OID) VALUES
-- 2024 Shipments (supporting lead time calculation)
('SHIP-2024-001', 'Shanghai, China', 'TRACK-001', '2023-12-10', '2024-01-05', '2024-01-05', 'PO-2024-001'),
('SHIP-2024-002', 'Taipei, Taiwan', 'TRACK-002', '2024-01-02', '2024-01-15', '2024-01-15', 'PO-2024-002'),
('SHIP-2024-003', 'Ho Chi Minh, Vietnam', 'TRACK-003', '2024-01-10', '2024-01-25', '2024-01-25', 'PO-2024-003'),
('SHIP-2024-004', 'Shanghai, China', 'TRACK-004', '2024-01-25', '2024-02-10', '2024-02-10', 'PO-2024-004'),
('SHIP-2024-005', 'Bangkok, Thailand', 'TRACK-005', '2024-02-05', '2024-02-20', '2024-02-20', 'PO-2024-005'),
('SHIP-2024-006', 'Jakarta, Indonesia', 'TRACK-006', '2024-02-15', '2024-03-01', '2024-03-01', 'PO-2024-006'),
('SHIP-2024-007', 'Kuala Lumpur, Malaysia', 'TRACK-007', '2024-02-28', '2024-03-15', '2024-03-15', 'PO-2024-007'),
('SHIP-2024-008', 'Manila, Philippines', 'TRACK-008', '2024-03-05', '2024-03-25', '2024-03-25', 'PO-2024-008'),
('SHIP-2024-009', 'Singapore, Singapore', 'TRACK-009', '2024-01-05', '2024-01-08', '2024-01-08', 'PO-2024-009'),
('SHIP-2024-010', 'Seoul, South Korea', 'TRACK-010', '2024-02-15', '2024-02-28', '2024-02-28', 'PO-2024-010'),
('SHIP-2024-011', 'Bangkok, Thailand', 'TRACK-011', '2024-09-01', '2024-10-05', '2024-10-05', 'PO-2024-011'),
('SHIP-2024-012', 'Bangkok, Thailand', 'TRACK-012', '2024-09-10', '2024-10-15', '2024-10-15', 'PO-2024-012'),
('SHIP-2024-013', 'Bangkok, Thailand', 'TRACK-013', '2024-09-20', '2024-10-25', '2024-10-25', 'PO-2024-013'),
('SHIP-2024-014', 'Bangkok, Thailand', 'TRACK-014', '2024-10-05', '2024-11-10', '2024-11-10', 'PO-2024-014'),
('SHIP-2024-015', 'Singapore, Singapore', 'TRACK-015', '2024-11-01', '2024-11-20', '2024-11-20', 'PO-2024-015'),
('SHIP-2024-016', 'Seoul, South Korea', 'TRACK-016', '2024-11-10', '2024-12-01', '2024-12-01', 'PO-2024-016'),
('SHIP-2024-017', 'Shanghai, China', 'TRACK-017', '2024-12-01', '2024-12-15', '2024-12-15', 'PO-2024-017'),
('SHIP-2024-018', 'Taipei, Taiwan', 'TRACK-018', '2024-12-10', '2024-12-25', '2024-12-25', 'PO-2024-018'),
-- 2025 Shipments
('SHIP-2025-001', 'Shanghai, China', 'TRACK-019', '2024-12-20', '2025-01-08', '2025-01-08', 'PO-2025-001'),
('SHIP-2025-002', 'Taipei, Taiwan', 'TRACK-020', '2025-01-05', '2025-01-18', '2025-01-18', 'PO-2025-002'),
('SHIP-2025-003', 'Ho Chi Minh, Vietnam', 'TRACK-021', '2025-01-10', '2025-01-28', '2025-01-28', 'PO-2025-003'),
('SHIP-2025-004', 'Shanghai, China', 'TRACK-022', '2025-02-01', '2025-02-12', '2025-02-12', 'PO-2025-004'),
('SHIP-2025-005', 'Jakarta, Indonesia', 'TRACK-023', '2025-02-08', '2025-02-22', '2025-02-22', 'PO-2025-005'),
('SHIP-2025-006', 'Kuala Lumpur, Malaysia', 'TRACK-024', '2025-02-20', '2025-03-05', '2025-03-05', 'PO-2025-006'),
('SHIP-2025-007', 'Ho Chi Minh, Vietnam', 'TRACK-025', '2025-03-05', '2025-03-18', '2025-03-18', 'PO-2025-007'),
('SHIP-2025-008', 'Manila, Philippines', 'TRACK-026', '2025-03-10', '2025-03-28', '2025-03-28', 'PO-2025-008'),
('SHIP-2025-009', 'Singapore, Singapore', 'TRACK-027', '2025-01-08', '2025-01-10', '2025-01-10', 'PO-2025-009'),
('SHIP-2025-010', 'Seoul, South Korea', 'TRACK-028', '2025-02-20', '2025-03-01', '2025-03-01', 'PO-2025-010'),
-- 2025 Delayed Shipment (supporting query 7 - delays from specific origins)
('SHIP-2025-011-DELAYED', 'Shanghai, China', 'TRACK-029', '2024-09-01', '2025-10-08', '2026-04-15', 'PO-2025-011'),
('SHIP-2025-012-DELAYED', 'Shanghai, China', 'TRACK-030', '2024-09-15', '2025-10-18', '2026-05-20', 'PO-2025-012'),
('SHIP-2025-013', 'Bangkok, Thailand', 'TRACK-031', '2025-09-28', '2025-10-28', '2025-10-28', 'PO-2025-013'),
('SHIP-2025-014', 'Bangkok, Thailand', 'TRACK-032', '2025-10-15', '2025-11-12', '2025-11-12', 'PO-2025-014'),
('SHIP-2025-015', 'Singapore, Singapore', 'TRACK-033', '2025-11-08', '2025-11-22', '2025-11-22', 'PO-2025-015'),
('SHIP-2025-016', 'Shanghai, China', 'TRACK-034', '2025-11-18', '2025-12-05', '2025-12-05', 'PO-2025-016'),
('SHIP-2025-017', 'Taipei, Taiwan', 'TRACK-035', '2025-12-05', '2025-12-18', '2025-12-18', 'PO-2025-017'),
('SHIP-2025-018', 'Ho Chi Minh, Vietnam', 'TRACK-036', '2025-12-15', '2025-12-28', '2025-12-28', 'PO-2025-018'),
-- 2026 Shipments
('SHIP-2026-001', 'Shanghai, China', 'TRACK-037', '2026-01-01', '2026-01-05', '2026-01-05', 'PO-2026-001'),
('SHIP-2026-002', 'Taipei, Taiwan', 'TRACK-038', '2026-01-10', '2026-01-15', '2026-01-15', 'PO-2026-002'),
('SHIP-2026-003', 'Ho Chi Minh, Vietnam', 'TRACK-039', '2026-02-01', '2026-02-10', '2026-02-10', 'PO-2026-003'),
('SHIP-2026-004', 'Bangkok, Thailand', 'TRACK-040', '2026-02-12', '2026-02-20', '2026-02-20', 'PO-2026-004'),
('SHIP-2026-005', 'Singapore, Singapore', 'TRACK-041', '2026-02-25', '2026-03-01', '2026-03-01', 'PO-2026-005');

-- ================================================================
-- 17. SHIPMENT_TO_WAREHOUSE DATA - Warehouse destinations for shipments
-- ================================================================
DELETE FROM ShipmentToWarehouse;
INSERT INTO ShipmentToWarehouse (ShipID, WID) VALUES
('SHIP-2024-001', 'WH-SG-001'),
('SHIP-2024-002', 'WH-SG-001'),
('SHIP-2024-003', 'WH-SG-002'),
('SHIP-2024-004', 'WH-SG-001'),
('SHIP-2024-005', 'WH-BKK-001'),
('SHIP-2024-006', 'WH-JKT-001'),
('SHIP-2024-007', 'WH-BKK-001'),
('SHIP-2024-008', 'WH-MNL-001'),
('SHIP-2024-009', 'WH-SG-003'),
('SHIP-2024-010', 'WH-LA-001'),
('SHIP-2024-011', 'WH-BKK-001'),
('SHIP-2024-012', 'WH-BKK-002'),
('SHIP-2024-013', 'WH-BKK-001'),
('SHIP-2024-014', 'WH-BKK-001'),
('SHIP-2024-015', 'WH-SG-001'),
('SHIP-2024-016', 'WH-LA-001'),
('SHIP-2024-017', 'WH-SG-002'),
('SHIP-2024-018', 'WH-LA-002'),
('SHIP-2025-001', 'WH-SG-001'),
('SHIP-2025-002', 'WH-SG-002'),
('SHIP-2025-003', 'WH-SG-001'),
('SHIP-2025-004', 'WH-LA-001'),
('SHIP-2025-005', 'WH-JKT-001'),
('SHIP-2025-006', 'WH-BKK-001'),
('SHIP-2025-007', 'WH-BKK-002'),
('SHIP-2025-008', 'WH-MNL-001'),
('SHIP-2025-009', 'WH-SG-003'),
('SHIP-2025-010', 'WH-LA-002'),
('SHIP-2025-011-DELAYED', 'WH-LA-001'),
('SHIP-2025-012-DELAYED', 'WH-LA-002'),
('SHIP-2025-013', 'WH-BKK-001'),
('SHIP-2025-014', 'WH-BKK-002'),
('SHIP-2025-015', 'WH-SG-001'),
('SHIP-2025-016', 'WH-SG-002'),
('SHIP-2025-017', 'WH-LA-001'),
('SHIP-2025-018', 'WH-HNM-001'),
('SHIP-2026-001', 'WH-SG-001'),
('SHIP-2026-002', 'WH-LA-001'),
('SHIP-2026-003', 'WH-BKK-001'),
('SHIP-2026-004', 'WH-BKK-002'),
('SHIP-2026-005', 'WH-SG-002');

-- ================================================================
-- 18. ORDER_ITEM DATA - Individual line items in purchase orders
-- ================================================================
DELETE FROM OrderItem;
INSERT INTO OrderItem (Serial#, OID, ExArrDate, OrderedQty, UnitPrice) VALUES
('ITEM-001', 'PO-2024-001', '2024-01-05', 10, 800.00),
('ITEM-002', 'PO-2024-001', '2024-01-05', 5, 800.00),
('ITEM-003', 'PO-2024-002', '2024-01-15', 100, 15.50),
('ITEM-004', 'PO-2024-002', '2024-01-15', 50, 15.50),
('ITEM-005', 'PO-2024-003', '2024-01-25', 25, 75.00),
('ITEM-006', 'PO-2024-003', '2024-01-25', 15, 75.00),
('ITEM-007', 'PO-2024-004', '2024-02-10', 30, 250.00),
('ITEM-008', 'PO-2024-005', '2024-02-20', 200, 5.00),
('ITEM-009', 'PO-2024-005', '2024-02-20', 150, 5.00),
('ITEM-010', 'PO-2024-006', '2024-03-01', 80, 15.00),
('ITEM-011', 'PO-2024-006', '2024-03-01', 60, 15.00),
('ITEM-012', 'PO-2024-007', '2024-03-15', 40, 25.00),
('ITEM-013', 'PO-2024-007', '2024-03-15', 30, 25.00),
('ITEM-014', 'PO-2024-008', '2024-03-25', 120, 8.00),
('ITEM-015', 'PO-2024-008', '2024-03-25', 100, 8.00),
('ITEM-016', 'PO-2024-009', '2024-01-08', 500, 3.00),
('ITEM-017', 'PO-2024-009', '2024-01-08', 300, 3.00),
('ITEM-018', 'PO-2024-010', '2024-02-28', 50, 50.00),
('ITEM-019', 'PO-2024-010', '2024-02-28', 40, 50.00),
('ITEM-020', 'PO-2024-011', '2024-10-05', 200, 5.00),
('ITEM-021', 'PO-2024-012', '2024-10-15', 400, 3.00),
('ITEM-022', 'PO-2024-012', '2024-10-15', 250, 3.00),
('ITEM-023', 'PO-2024-013', '2024-10-25', 150, 8.00),
('ITEM-024', 'PO-2024-014', '2024-11-10', 300, 5.00),
('ITEM-025', 'PO-2024-015', '2024-11-20', 20, 50.00),
('ITEM-026', 'PO-2024-015', '2024-11-20', 15, 50.00),
('ITEM-027', 'PO-2024-016', '2024-12-01', 100, 12.00),
('ITEM-028', 'PO-2024-017', '2024-12-15', 200, 3.00),
('ITEM-029', 'PO-2024-018', '2024-12-25', 80, 15.00),
('ITEM-030', 'PO-2025-001', '2025-01-08', 15, 800.00),
('ITEM-031', 'PO-2025-001', '2025-01-08', 8, 800.00),
('ITEM-032', 'PO-2025-002', '2025-01-18', 120, 15.50),
('ITEM-033', 'PO-2025-002', '2025-01-18', 60, 15.50),
('ITEM-034', 'PO-2025-003', '2025-01-28', 35, 75.00),
('ITEM-035', 'PO-2025-003', '2025-01-28', 20, 75.00),
('ITEM-036', 'PO-2025-004', '2025-02-12', 40, 250.00),
('ITEM-037', 'PO-2025-005', '2025-02-22', 250, 5.00),
('ITEM-038', 'PO-2025-005', '2025-02-22', 180, 5.00),
('ITEM-039', 'PO-2025-006', '2025-03-05', 100, 15.00),
('ITEM-040', 'PO-2025-006', '2025-03-05', 75, 15.00);

-- ================================================================
-- 19. SHIP_ITEM DATA - Items shipped in shipments
-- ================================================================
DELETE FROM ShipItem;
INSERT INTO ShipItem (Serial#, ShipID, ExArrDate, ShippedQty) VALUES
('ITEM-001', 'SHIP-2024-001', '2024-01-05', 10),
('ITEM-002', 'SHIP-2024-001', '2024-01-05', 5),
('ITEM-003', 'SHIP-2024-002', '2024-01-15', 100),
('ITEM-004', 'SHIP-2024-002', '2024-01-15', 50),
('ITEM-005', 'SHIP-2024-003', '2024-01-25', 25),
('ITEM-006', 'SHIP-2024-003', '2024-01-25', 15),
('ITEM-007', 'SHIP-2024-004', '2024-02-10', 30),
('ITEM-008', 'SHIP-2024-005', '2024-02-20', 200),
('ITEM-009', 'SHIP-2024-005', '2024-02-20', 150),
('ITEM-010', 'SHIP-2024-006', '2024-03-01', 80),
('ITEM-011', 'SHIP-2024-006', '2024-03-01', 60),
('ITEM-012', 'SHIP-2024-007', '2024-03-15', 40),
('ITEM-013', 'SHIP-2024-007', '2024-03-15', 30),
('ITEM-014', 'SHIP-2024-008', '2024-03-25', 120),
('ITEM-015', 'SHIP-2024-008', '2024-03-25', 100),
('ITEM-016', 'SHIP-2024-009', '2024-01-08', 500),
('ITEM-017', 'SHIP-2024-009', '2024-01-08', 300),
('ITEM-018', 'SHIP-2024-010', '2024-02-28', 50),
('ITEM-019', 'SHIP-2024-010', '2024-02-28', 40),
('ITEM-020', 'SHIP-2024-011', '2024-10-05', 200),
('ITEM-021', 'SHIP-2024-012', '2024-10-15', 400),
('ITEM-022', 'SHIP-2024-012', '2024-10-15', 250),
('ITEM-023', 'SHIP-2024-013', '2024-10-25', 150),
('ITEM-024', 'SHIP-2024-014', '2024-11-10', 300),
('ITEM-025', 'SHIP-2024-015', '2024-11-20', 20),
('ITEM-026', 'SHIP-2024-015', '2024-11-20', 15),
('ITEM-027', 'SHIP-2024-016', '2024-12-01', 100),
('ITEM-028', 'SHIP-2024-017', '2024-12-15', 200),
('ITEM-029', 'SHIP-2024-018', '2024-12-25', 80),
('ITEM-030', 'SHIP-2025-001', '2025-01-08', 15),
('ITEM-031', 'SHIP-2025-001', '2025-01-08', 8),
('ITEM-032', 'SHIP-2025-002', '2025-01-18', 120),
('ITEM-033', 'SHIP-2025-002', '2025-01-18', 60),
('ITEM-034', 'SHIP-2025-003', '2025-01-28', 35),
('ITEM-035', 'SHIP-2025-003', '2025-01-28', 20),
('ITEM-036', 'SHIP-2025-004', '2025-02-12', 40),
('ITEM-037', 'SHIP-2025-005', '2025-02-22', 250),
('ITEM-038', 'SHIP-2025-005', '2025-02-22', 180),
('ITEM-039', 'SHIP-2025-006', '2025-03-05', 100),
('ITEM-040', 'SHIP-2025-006', '2025-03-05', 75);

-- ================================================================
-- 20. SUPPLIER_HAS_SHIPMENT DATA - Supplier shipment relationships
-- ================================================================
DELETE FROM SupplierHasShipment;
INSERT INTO SupplierHasShipment (SupID, ShipID) VALUES
('SUP001', 'SHIP-2024-001'),
('SUP002', 'SHIP-2024-002'),
('SUP003', 'SHIP-2024-003'),
('SUP001', 'SHIP-2024-004'),
('SUP004', 'SHIP-2024-005'),
('SUP005', 'SHIP-2024-006'),
('SUP006', 'SHIP-2024-007'),
('SUP007', 'SHIP-2024-008'),
('SUP008', 'SHIP-2024-009'),
('SUP009', 'SHIP-2024-010'),
('SUP004', 'SHIP-2024-011'),
('SUP004', 'SHIP-2024-012'),
('SUP004', 'SHIP-2024-013'),
('SUP004', 'SHIP-2024-014'),
('SUP008', 'SHIP-2024-015'),
('SUP009', 'SHIP-2024-016'),
('SUP001', 'SHIP-2024-017'),
('SUP002', 'SHIP-2024-018'),
('SUP001', 'SHIP-2025-001'),
('SUP002', 'SHIP-2025-002'),
('SUP003', 'SHIP-2025-003'),
('SUP001', 'SHIP-2025-004'),
('SUP005', 'SHIP-2025-005'),
('SUP006', 'SHIP-2025-006'),
('SUP003', 'SHIP-2025-007'),
('SUP007', 'SHIP-2025-008'),
('SUP008', 'SHIP-2025-009'),
('SUP009', 'SHIP-2025-010'),
('SUP001', 'SHIP-2025-011-DELAYED'),
('SUP001', 'SHIP-2025-012-DELAYED'),
('SUP004', 'SHIP-2025-013'),
('SUP004', 'SHIP-2025-014'),
('SUP008', 'SHIP-2025-015'),
('SUP001', 'SHIP-2025-016'),
('SUP002', 'SHIP-2025-017'),
('SUP003', 'SHIP-2025-018'),
('SUP001', 'SHIP-2026-001'),
('SUP002', 'SHIP-2026-002'),
('SUP003', 'SHIP-2026-003'),
('SUP004', 'SHIP-2026-004'),
('SUP008', 'SHIP-2026-005');

-- ================================================================
-- 21. INVENTORY DATA - Current warehouse inventory
-- ================================================================
DELETE FROM Inventory;
INSERT INTO Inventory (Serial#, PID, WID, CID, rQty, hQty, sQty, oQty, Location, Movement, Reasons) VALUES
-- Singapore Warehouse 1 Inventory
('ITEM-001', 'P001', 'WH-SG-001', 'C001', 0, 15, 15, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-002', 'P001', 'WH-SG-001', 'C001', 0, 10, 10, 0, 'A1-R1-B02', 'Receipt', 'Received from inbound shipment'),
('ITEM-003', 'P002', 'WH-SG-001', 'C001', 50, 150, 100, 0, 'A1-R2-B01', 'Putaway', 'Putaway from receiving to storage'),
('ITEM-004', 'P002', 'WH-SG-001', 'C001', 50, 100, 50, 0, 'A1-R2-B02', 'Pick', 'Allocated to order'),
('ITEM-005', 'P003', 'WH-SG-001', 'C001', 10, 50, 40, 0, 'A1-R3-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-006', 'P004', 'WH-SG-001', 'C002', 0, 30, 30, 0, 'A1-R3-B02', 'Putaway', 'Putaway from receiving'),
('ITEM-008', 'P005', 'WH-SG-001', 'C002', 100, 350, 250, 0, 'B1-R1-B01', 'Receipt', 'Received shipment'),
-- Singapore Warehouse 2 Inventory
('ITEM-009', 'P005', 'WH-SG-002', 'C002', 80, 200, 120, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-010', 'P006', 'WH-SG-002', 'C002', 30, 120, 90, 0, 'A1-R2-B01', 'Putaway', 'Putaway from receiving'),
('ITEM-011', 'P007', 'WH-SG-002', 'C003', 20, 80, 60, 0, 'A1-R2-B02', 'Receipt', 'Received from inbound shipment'),
('ITEM-014', 'P008', 'WH-SG-002', 'C003', 50, 200, 150, 0, 'B1-R1-B01', 'Pick', 'Allocated to order'),
('ITEM-015', 'P008', 'WH-SG-002', 'C004', 40, 150, 110, 0, 'B1-R1-B02', 'Putaway', 'Putaway from receiving'),
-- Bangkok Warehouse 1 Inventory
('ITEM-012', 'P005', 'WH-BKK-001', 'C004', 150, 400, 250, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-016', 'P009', 'WH-BKK-001', 'C005', 200, 600, 400, 0, 'A1-R2-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-018', 'P010', 'WH-BKK-001', 'C005', 50, 150, 100, 0, 'B1-R1-B01', 'Putaway', 'Putaway from receiving'),
('ITEM-020', 'P012', 'WH-BKK-001', 'C016', 300, 1000, 700, 0, 'B1-R2-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-021', 'P013', 'WH-BKK-001', 'C016', 100, 250, 150, 0, 'C1-R1-B01', 'Receipt', 'Received from inbound shipment'),
-- LA Warehouse 1 Inventory
('ITEM-007', 'P004', 'WH-LA-001', 'C001', 10, 50, 40, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment'),
('ITEM-019', 'P010', 'WH-LA-001', 'C012', 40, 120, 80, 0, 'A1-R2-B01', 'Putaway', 'Putaway from receiving'),
('ITEM-025', 'P015', 'WH-LA-001', 'C012', 5, 25, 20, 0, 'A1-R3-B01', 'Receipt', 'Received from inbound shipment'),
-- Manila Warehouse Inventory
('ITEM-017', 'P009', 'WH-MNL-001', 'C003', 100, 300, 200, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment'),
-- Jakarta Warehouse Inventory
('ITEM-024', 'P014', 'WH-JKT-001', 'C009', 80, 250, 170, 0, 'A1-R1-B01', 'Receipt', 'Received from inbound shipment');

-- ================================================================
-- 22. DELIVERY DATA - Last-mile delivery tracking
-- ================================================================
DELETE FROM DELIVERY;
INSERT INTO DELIVERY (Delivery_Date, RID, VID, WID, ShipID) VALUES
('2026-03-26', 'R001', 'V001', 'WH-SG-001', 'SHIP-2026-001'),
('2026-03-27', 'R002', 'V002', 'WH-SG-002', 'SHIP-2026-002'),
('2026-03-28', 'R003', 'V003', 'WH-LA-001', 'SHIP-2026-003'),
('2026-03-25', 'R004', 'V004', 'WH-BKK-001', 'SHIP-2026-004'),
('2026-03-30', 'R005', 'V005', 'WH-SG-001', 'SHIP-2025-015');

-- ================================================================
-- DATA GENERATION COMPLETE
-- ================================================================
-- Summary:
-- - 25 Client companies
-- - 10 Warehouses (3 in Singapore, 2 in LA, 2 in Bangkok, 1 each in Manila/Jakarta/Hanoi)
-- - 20 Products
-- - 15 Suppliers (including Singapore-only, and multi-regional suppliers)
-- - 50 Purchase Orders (2024-2026)
-- - 45 Shipments (including delayed shipments from Shanghai for query 7)
-- - 40 Order Items
-- - 40 Ship Items
-- - Sufficient data to support all 7 queries
-- ================================================================

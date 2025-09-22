-- DML syntax to simulate the transactions process for sales and purchase

USE JigiBoxZ

-- Purchase transaction (Table : Staff, Vendor, Purchase, PurchaseDetail, Product, ProductCategory)
BEGIN TRANSACTION

INSERT INTO Staff (StaffID, StaffName, StaffEmail, StaffGender, StaffDOB, StaffAddress) 
VALUES ('ST192', 'Slamet Suharjo', 'slamet@example.com', 'Male', '1994-02-05', 'Jl. Banteng No. 5'); 

INSERT INTO Vendor (VendorID, VendorName, VendorGender, VendorEmail, VendorDOB, VendorAddress) 
VALUES
('VR114', 'Jody Austus', 'Male', 'jody.austus@example.com', '1989-01-01', 'Jl. Kemang No. 23');

INSERT INTO Purchase (PurchaseID, StaffID, VendorID, PurchaseDate) VALUES
('PH304', 'ST192', 'VR114', '2023-09-12');

INSERT INTO PurchaseDetail (PurchaseID, ProductID, Quantity) VALUES
('PH304', 'PT002', 3),
('PH304', 'PT004', 1),
('PH304', 'PT009', 5);

INSERT INTO Product (ProductID, CategoryID, ProductName, ProductPrice, ProductWeight) VALUES
('PT001','CT001','Samsung Galaxy A12', 1000, 160),
('PT002','CT002','iPhone 12 Pro', 1500, 200),
('PT003','CT003','OnePlus Nord', 1500, 140),
('PT004','CT004','iPhone SE (2020)', 1700, 200),
('PT005','CT005','Xiaomi Redmi 9A', 1500, 200),
('PT006','CT006','Samsung Galaxy S21 Ultra', 2200, 200),
('PT007','CT007','Anker PowerCore Portable Charger', 1400, 200),
('PT008','CT008','Spigen Tough Armor Case', 2200, 80),
('PT009','CT009','Apple AirPods Pro', 2200, 50),
('PT010','CT010','Belkin BoostCharge USB-C Charger',1100, 70);

INSERT INTO ProductCategory (CategoryID,CategoryName) VALUES 
('CT001','Mobile Phones'),
('CT002','Smartphones'),
('CT003','Android Phones'),
('CT004','IOS Devices'),
('CT005','Budget Smartphones'),
('CT006','Flagship Phones'),
('CT007','Phone Accessories'),
('CT008','Phone Cases'),
('CT009','Wireless Earbuds'),
('CT010','Mobile Phone Chargers');

COMMIT


-- Sales Transaction (Table : Customer, Staff, Sale, SaleDetail, Product, ProductCategory)
BEGIN TRANSACTION

INSERT INTO Customer (CustomerID, CustomerName, CustomerGender, CustomerEmail, CustomerDOB, CustomerAddress) VALUES
('CU329','Mr. Abe Tiga', 'Male', 'abe.tiga@example.com', '1999-09-19', 'Jl. Melati No. 10');

INSERT INTO Staff (StaffID, StaffName, StaffEmail, StaffGender, StaffDOB, StaffAddress) 
VALUES ('ST195', 'Adi Rohmawan', 'adi@example.com', 'Male', '1994-02-05', 'Jl. Ular No. 2');

INSERT INTO Sale (SaleID, StaffID, CustomerID, TransactionDate) VALUES
('SH321', 'ST195', 'CU329', '2023-04-04');

INSERT INTO SaleDetail (SaleID, ProductID, Quantity) VALUES
('SH321', 'PT001', 2),
('SH321', 'PT006', 3),
('SH321', 'PT0013', 8);

INSERT INTO Product (ProductID, CategoryID, ProductName, ProductPrice, ProductWeight) VALUES
('PT001','CT001','Samsung Galaxy A12', 1000, 160),
('PT002','CT002','iPhone 12 Pro', 1500, 200),
('PT003','CT003','OnePlus Nord', 1500, 140),
('PT004','CT004','iPhone SE (2020)', 1700, 200),
('PT005','CT005','Xiaomi Redmi 9A', 1500, 200),
('PT006','CT006','Samsung Galaxy S21 Ultra', 2200, 200),
('PT007','CT007','Anker PowerCore Portable Charger', 1400, 200),
('PT008','CT008','Spigen Tough Armor Case', 2200, 80),
('PT009','CT009','Apple AirPods Pro', 2200, 50),
('PT010','CT010','Belkin BoostCharge USB-C Charger',1100, 70);

INSERT INTO ProductCategory (CategoryID,CategoryName) VALUES 
('CT001','Mobile Phones'),
('CT002','Smartphones'),
('CT003','Android Phones'),
('CT004','IOS Devices'),
('CT005','Budget Smartphones'),
('CT006','Flagship Phones'),
('CT007','Phone Accessories'),
('CT008','Phone Cases'),
('CT009','Wireless Earbuds'),
('CT010','Mobile Phone Chargers');

COMMIT
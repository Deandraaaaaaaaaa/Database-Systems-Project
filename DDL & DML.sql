-- Create a database system using DDL syntax that relevant with sales and purchase.

CREATE DATABASE JigiBoxZ

USE JigiBoxZ

-- DDL syntax

-- table Customer
CREATE TABLE Customer (
    CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
    CustomerName VARCHAR (100) NOT NULL,
    CustomerGender VARCHAR (10) NOT NULL CHECK (CustomerGender IN ('Male', 'Female')),
    CustomerEmail VARCHAR(100) NOT NULL,
    CustomerDOB DATE NOT NULL CHECK (YEAR(CustomerDOB) < 2000),
    CustomerAddress VARCHAR (255) NOT NULL
)

-- table Staff
CREATE TABLE Staff (
    StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
    StaffName VARCHAR(100) NOT NULL,
    StaffEmail VARCHAR(100) NOT NULL,
    StaffGender VARCHAR(10) NOT NULL CHECK (StaffGender IN ('Male', 'Female')),
    StaffDOB DATE NOT NULL CHECK (YEAR(StaffDOB) < 2000),
    StaffAddress VARCHAR(255) NOT NULL
)

-- table Vendor
CREATE TABLE Vendor (
    VendorID CHAR(5) PRIMARY KEY CHECK (VendorID LIKE 'VR[0-9][0-9][0-9]'),
    VendorName VARCHAR(100) NOT NULL,
    VendorGender VARCHAR(10) NOT NULL CHECK (VendorGender IN ('Male', 'Female')),
    VendorEmail VARCHAR(100) NOT NULL,
    VendorDOB DATE NOT NULL,
    VendorAddress VARCHAR(255) NOT NULL
)

-- table ProductCategory
CREATE TABLE ProductCategory (
    CategoryID CHAR(5) PRIMARY KEY CHECK (CategoryID LIKE 'CT[0-9][0-9][0-9]'),
    CategoryName VARCHAR(50) NOT NULL CHECK (CategoryName IN (
	'Mobile Phones',
	'Smartphones',
	'Android Phones',
	'IOS Devices',
	'Budget Smartphones',
	'Flagship Phones',
	'Phone Accessories',
	'Phone Cases',
	'Wireless Earbuds',
	'Mobile Phone Chargers'
	))
)

-- table Product
CREATE TABLE Product (
    ProductID CHAR(5) PRIMARY KEY CHECK (ProductID LIKE 'PT[0-9][0-9][0-9]'),
    CategoryID CHAR(5) FOREIGN KEY REFERENCES ProductCategory(CategoryID),
    ProductName VARCHAR(100) NOT NULL CHECK (LEN(ProductName) > 10),
    ProductPrice INT NOT NULL CHECK (ProductPrice BETWEEN 1000 AND 2200),
    ProductWeight INT NOT NULL
)

-- table Sale
CREATE TABLE Sale (
    SaleID CHAR(5) PRIMARY KEY CHECK (SaleID LIKE 'SH[0-9][0-9][0-9]'),
    StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
    CustomerID CHAR(5) FOREIGN KEY REFERENCES Customer(CustomerID),
    TransactionDate DATE NOT NULL
)

-- table SaleDetail
CREATE TABLE SaleDetail (
    SaleID CHAR(5),
    ProductID CHAR(5),
    Quantity INT NOT NULL,
	PRIMARY KEY (SaleID, ProductID),
	FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

-- table Purchase
CREATE TABLE Purchase (
    PurchaseID CHAR(5) PRIMARY KEY CHECK (PurchaseID LIKE 'PH[0-9][0-9][0-9]'),
    StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
    VendorID CHAR(5) FOREIGN KEY REFERENCES Vendor(VendorID),
    PurchaseDate DATE NOT NULL
)

-- table PurchaseDetail
CREATE TABLE PurchaseDetail (
    PurchaseID CHAR(5),
    ProductID CHAR(5),
    Quantity INT NOT NULL,
	PRIMARY KEY (PurchaseID, ProductID),
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)



-- DML syntax

-- Customer
INSERT INTO Customer (CustomerID, CustomerName, CustomerGender, CustomerEmail, CustomerDOB, CustomerAddress) VALUES
('CU029','Mr. Budi Santoso', 'Male', 'budi.santoso@example.com', '1986-09-19', 'Jl. Merdeka No. 10'),
('CU030','Mrs. Siti Rahmawati', 'Female', 'siti.rahmawati@example.com', '1999-04-28', 'Jl. Sudirman No. 15'),
('CU031','Mrs. Kirana Dewi', 'Female', 'kirana.dewi@example.com', '1988-06-20', 'Jl. Gajah Mungkur No. 8'),
('CU032','Mrs. Felia Anggraini', 'Female', 'felia.anggraini@example.com', '1999-12-28', 'Jl. Pahlawan No. 3'),
('CU033','Mr. Oka Masidi', 'Male', 'oka.masidi@example.com', '1999-08-12', 'Jl. Manggis No. 5'),
('CU034','Mrs. Mita Permata', 'Female', 'mita.permata@example.com', '1993-02-18', 'Jl. Mawar No. 24'),
('CU035','Mrs. Indah Mulia ', 'Female', 'indah.Mulia@example.com', '1999-12-01', 'Jl. Flaminggo No. 7'),
('CU036','Mrs. Nina Melati', 'Female', 'nina.melati@example.com', '1986-07-07', 'Jl. Melati Raya No. 12'),
('CU037','Mr. Lukman Hakim', 'Male', 'lukman.hakim@example.com', '1984-10-05', 'Jl. Jati No. 62'),
('CU038','Mr. Risky Ridho', 'Male', 'risky.ridho@example.com', '1999-09-19', 'Jl. Boulevard No. 65');


-- Staff
INSERT INTO Staff (StaffID, StaffName, StaffEmail, StaffGender, StaffDOB, StaffAddress) 
VALUES
('ST001', 'Alice Grabriela', 'alice.Grabriela@example.com', 'Female', '1985-03-10', 'Jl. Cendana No. 11'),
('ST002', 'Mursid Putra', 'Mursid.Putra@example.com', 'Male', '1975-12-25', 'Jl. Flamboyan No. 7'),
('ST003', 'David gaget',  'David.gaget@example.com','Male', '1988-02-14', 'Jl. Teratai No. 4'),
('ST004', 'Muthia Putri',  'Muthia.Putri@example.com','Female', '1992-08-19', 'Jl. Bunga Raya No. 12'),
('ST005','Siti Aminah', 'siti.aminah@example.com', 'Female', '1980-01-15', 'Jl. Cendana No. 1'),
('ST006','Ahmad Faisal', 'ahmad.faisal@example.com', 'Male', '1978-05-20', 'Jl. Merpati No. 3'),
('ST007','Nurul Hidayah', 'nurul.hidayah@example.com', 'Female', '1992-06-25', 'Jl. Mawar No. 7'),
('ST008','Citra Dewi', 'citra.dewi@example.com', 'Female', '1983-12-20', 'Jl. Teratai No. 6'),
('ST009','Yudi Santoso', 'yudi.santoso@example.com', 'Male', '1989-08-14', 'Jl. Merdeka No. 12'),
('ST010','Rahmat Hidayat', 'rahmat.hidayat@example.com', 'Male', '1988-09-09', 'Jl. Melati No. 9');


-- Vendor
INSERT INTO Vendor (VendorID, VendorName, VendorGender, VendorEmail, VendorDOB, VendorAddress) 
VALUES
('VR001', 'Faisal Udin', 'Male', 'faisal.udin@example.com', '1970-01-01', 'Jl. Market Street'),
('VR002', 'Fajar Sidiq', 'Male', 'fajar.sidiq@example.com', '1982-08-15', 'Jl. Commerce Lane'),
('VR003', 'Gita Anjani', 'Female', 'gita.anjani@example.com', '1975-10-10', 'Jl. Business Park'),
('VR004', 'Lina Marlina', 'Male', 'lina.marlina@example.com', '1983-05-05', 'Jl. Home Street'),
('VR005','Hendra Purnama', 'Male', 'hendra.purnama@example.com', '1991-08-25', 'Jl. Flamboyan No. 6, Makassar'),
('VR006','Yudistira Putra', 'Female', 'yudistira.putra@example.com', '1989-09-30', 'Jl. Cendana No. 4, Bogor'),
('VR007', 'Indra Wijaya', 'Male', 'indra.wijaya@example.com', '1985-02-20', 'Jl. Kebon Jeruk No. 3, Jakarta'),
('VR008', 'Maya Sari', 'Female', 'maya.sari@example.com', '1978-06-12', 'Jl. Mawar No. 8, Surabaya'),
('VR009', 'Dian Permana', 'Male', 'dian.permana@example.com', '1992-12-05', 'Jl. Melati No. 5, Bandung'),
('VR010', 'Rina Kusuma', 'Female', 'rina.kusuma@example.com', '1980-03-25', 'Jl. Anggrek No. 2, Semarang');


-- ProductCategory
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


-- Product
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


-- Sale
INSERT INTO Sale (SaleID, StaffID, CustomerID, TransactionDate) VALUES
('SH016', 'ST002', 'CU030', '2023-02-04'),
('SH001', 'ST001', 'CU029', '2023-01-11'),
('SH002', 'ST002', 'CU030', '2023-02-02'),
('SH003', 'ST003', 'CU031', '2023-04-22'),
('SH004', 'ST004', 'CU032', '2023-04-24'),
('SH005', 'ST005', 'CU033', '2023-06-05'),
('SH006', 'ST006', 'CU034', '2023-08-06'),
('SH007', 'ST007', 'CU035', '2024-01-01'),
('SH008', 'ST008', 'CU036', '2024-01-02'),
('SH009', 'ST009', 'CU037', '2024-04-03'),
('SH010', 'ST010', 'CU038', '2024-05-04'),
('SH011', 'ST001', 'CU029', '2024-05-05'),
('SH012', 'ST002', 'CU030', '2024-06-06'),
('SH013', 'ST003', 'CU031', '2024-07-06'),
('SH014', 'ST004', 'CU032', '2024-07-07'),
('SH015', 'ST005', 'CU033', '2024-07-07');


-- SaleDetail
INSERT INTO SaleDetail (SaleID, ProductID, Quantity) VALUES
('SH001', 'PT001', 2),
('SH002', 'PT003', 10),
('SH003', 'PT002', 1),
('SH004', 'PT004', 5),
('SH005', 'PT005', 1),
('SH006', 'PT006', 2),
('SH007', 'PT007', 15),
('SH008', 'PT008', 3),
('SH009', 'PT009', 2),
('SH010', 'PT010', 1),
('SH011', 'PT005', 3),
('SH012', 'PT003', 4),
('SH013', 'PT010', 7),
('SH014', 'PT009', 2),
('SH015', 'PT005', 6),
('SH010', 'PT001', 5),
('SH009', 'PT007', 1),
('SH008', 'PT004', 2),
('SH009', 'PT010', 1),
('SH001', 'PT003', 9),
('SH002', 'PT002', 11),
('SH014', 'PT008', 2),
('SH009', 'PT005', 4),
('SH011', 'PT010', 1),
('SH013', 'PT003', 5),
('SH016', 'PT005', 2);



-- Purchase
INSERT INTO Purchase (PurchaseID, StaffID, VendorID, PurchaseDate) VALUES
('PH001', 'ST001', 'VR001', '2024-05-01'),
('PH002', 'ST002', 'VR002', '2024-06-02'),
('PH003', 'ST003', 'VR003', '2024-06-03'),
('PH004', 'ST004', 'VR004', '2024-07-04'),
('PH005', 'ST005', 'VR005', '2024-07-05'),
('PH006', 'ST006', 'VR006', '2024-08-06'),
('PH007', 'ST007', 'VR003', '2024-08-01'),
('PH008', 'ST008', 'VR006', '2024-09-02'),
('PH009', 'ST009', 'VR005', '2024-09-03'),
('PH010', 'ST010', 'VR007', '2024-10-04'),
('PH011', 'ST002', 'VR008', '2024-10-05'),
('PH012', 'ST004', 'VR009', '2024-11-06'),
('PH013', 'ST008', 'VR010', '2024-11-01'),
('PH014', 'ST010', 'VR002', '2024-11-21'),
('PH015', 'ST003', 'VR005', '2024-11-24');


-- PurchaseDetail
INSERT INTO PurchaseDetail (PurchaseID, ProductID, Quantity) VALUES
('PH001', 'PT001', 1),
('PH002', 'PT003', 3),
('PH003', 'PT002', 7),
('PH004', 'PT004', 5),
('PH005', 'PT003', 9),
('PH006', 'PT007', 3),
('PH007', 'PT004', 4),
('PH008', 'PT008', 7),
('PH009', 'PT010', 2),
('PH010', 'PT001', 4),
('PH011', 'PT009', 5),
('PH012', 'PT003', 4),
('PH013', 'PT004', 2),
('PH014', 'PT007', 7),
('PH015', 'PT001', 3),
('PH011', 'PT003', 1),
('PH003', 'PT003', 2),
('PH004', 'PT006', 6),
('PH006', 'PT004', 8),
('PH002', 'PT010', 1),
('PH012', 'PT004', 4),
('PH015', 'PT003', 9),
('PH005', 'PT008', 2),
('PH001', 'PT007', 2),
('PH009', 'PT002', 4);







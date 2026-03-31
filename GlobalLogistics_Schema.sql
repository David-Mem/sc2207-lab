SET NOCOUNT ON;
GO

IF OBJECT_ID(N'dbo.Delivery', N'U') IS NOT NULL DROP TABLE dbo.Delivery;
IF OBJECT_ID(N'dbo.Inventory', N'U') IS NOT NULL DROP TABLE dbo.Inventory;
IF OBJECT_ID(N'dbo.SupplierHasShipment', N'U') IS NOT NULL DROP TABLE dbo.SupplierHasShipment;
IF OBJECT_ID(N'dbo.ShipItem', N'U') IS NOT NULL DROP TABLE dbo.ShipItem;
IF OBJECT_ID(N'dbo.OrderItem', N'U') IS NOT NULL DROP TABLE dbo.OrderItem;
IF OBJECT_ID(N'dbo.ShipmentToWarehouse', N'U') IS NOT NULL DROP TABLE dbo.ShipmentToWarehouse;
IF OBJECT_ID(N'dbo.Shipment', N'U') IS NOT NULL DROP TABLE dbo.Shipment;
IF OBJECT_ID(N'dbo.SupplierHasPO', N'U') IS NOT NULL DROP TABLE dbo.SupplierHasPO;
IF OBJECT_ID(N'dbo.ClientHasPO', N'U') IS NOT NULL DROP TABLE dbo.ClientHasPO;
IF OBJECT_ID(N'dbo.PO', N'U') IS NOT NULL DROP TABLE dbo.PO;
IF OBJECT_ID(N'dbo.Item', N'U') IS NOT NULL DROP TABLE dbo.Item;
IF OBJECT_ID(N'dbo.Stop', N'U') IS NOT NULL DROP TABLE dbo.Stop;
IF OBJECT_ID(N'dbo.Route', N'U') IS NOT NULL DROP TABLE dbo.Route;
IF OBJECT_ID(N'dbo.Driver', N'U') IS NOT NULL DROP TABLE dbo.Driver;
IF OBJECT_ID(N'dbo.Employee', N'U') IS NOT NULL DROP TABLE dbo.Employee;
IF OBJECT_ID(N'dbo.Staff', N'U') IS NOT NULL DROP TABLE dbo.Staff;
IF OBJECT_ID(N'dbo.Supply', N'U') IS NOT NULL DROP TABLE dbo.Supply;
IF OBJECT_ID(N'dbo.Zone', N'U') IS NOT NULL DROP TABLE dbo.Zone;
IF OBJECT_ID(N'dbo.Vehicle', N'U') IS NOT NULL DROP TABLE dbo.Vehicle;
IF OBJECT_ID(N'dbo.Product', N'U') IS NOT NULL DROP TABLE dbo.Product;
IF OBJECT_ID(N'dbo.Supplier', N'U') IS NOT NULL DROP TABLE dbo.Supplier;
IF OBJECT_ID(N'dbo.Warehouse', N'U') IS NOT NULL DROP TABLE dbo.Warehouse;
IF OBJECT_ID(N'dbo.Client', N'U') IS NOT NULL DROP TABLE dbo.Client;
GO

CREATE TABLE dbo.Client (
    CID VARCHAR(30) NOT NULL,
    CompanyName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    ServiceTier VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Client PRIMARY KEY (CID)
);
GO

CREATE TABLE dbo.Supplier (
    SupID VARCHAR(30) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    PaymentTerms VARCHAR(255) NOT NULL,
    LeadTimeDays INT NOT NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (SupID)
);
GO

CREATE TABLE dbo.Warehouse (
    WID VARCHAR(30) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Size FLOAT NOT NULL,
    Temperature FLOAT NOT NULL,
    Security INT NOT NULL,
    CONSTRAINT PK_Warehouse PRIMARY KEY (WID)
);
GO

CREATE TABLE dbo.Product (
    PID VARCHAR(30) NOT NULL,
    ItemSerial VARCHAR(30) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Brand VARCHAR(255) NULL,
    Category VARCHAR(100) NULL,
    UnitCost DECIMAL(10, 2) NOT NULL,
    RetailPrice DECIMAL(10, 2) NOT NULL,
    Length DECIMAL(8, 2) NULL,
    Width DECIMAL(8, 2) NULL,
    Height DECIMAL(8, 2) NULL,
    HandlingRequirements VARCHAR(255) NULL,
    CONSTRAINT PK_Product PRIMARY KEY (PID),
    CONSTRAINT UQ_Product_ItemSerial UNIQUE (ItemSerial)
);
GO

CREATE TABLE dbo.Vehicle (
    VID VARCHAR(30) NOT NULL,
    Type VARCHAR(30) NULL,
    License VARCHAR(30) NULL,
    CapacityWgt DECIMAL(8, 2) NULL,
    CapacityVol DECIMAL(8, 2) NULL,
    CONSTRAINT PK_Vehicle PRIMARY KEY (VID),
    CONSTRAINT UQ_Vehicle_License UNIQUE (License)
);
GO

CREATE TABLE dbo.Zone (
    WID VARCHAR(30) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Code INT NULL,
    CONSTRAINT PK_Zone PRIMARY KEY (WID, Location),
    CONSTRAINT FK_Zone_Warehouse FOREIGN KEY (WID) REFERENCES dbo.Warehouse (WID)
);
GO

CREATE TABLE dbo.Supply (
    PID VARCHAR(30) NOT NULL,
    SupID VARCHAR(30) NOT NULL,
    CID VARCHAR(30) NOT NULL,
    ContractStartDate DATE NOT NULL,
    ContractEndDate DATE NOT NULL,
    CONSTRAINT PK_Supply PRIMARY KEY (PID, SupID, CID, ContractStartDate, ContractEndDate),
    CONSTRAINT FK_Supply_Product FOREIGN KEY (PID) REFERENCES dbo.Product (PID),
    CONSTRAINT FK_Supply_Supplier FOREIGN KEY (SupID) REFERENCES dbo.Supplier (SupID),
    CONSTRAINT FK_Supply_Client FOREIGN KEY (CID) REFERENCES dbo.Client (CID)
);
GO

CREATE TABLE dbo.Staff (
    SID VARCHAR(30) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    CONSTRAINT PK_Staff PRIMARY KEY (SID)
);
GO

CREATE TABLE dbo.Employee (
    SID VARCHAR(30) NOT NULL,
    Certification VARCHAR(255) NULL,
    WID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (SID),
    CONSTRAINT FK_Employee_Staff FOREIGN KEY (SID) REFERENCES dbo.Staff (SID),
    CONSTRAINT FK_Employee_Warehouse FOREIGN KEY (WID) REFERENCES dbo.Warehouse (WID)
);
GO

CREATE TABLE dbo.Driver (
    SID VARCHAR(30) NOT NULL,
    LicenseNo VARCHAR(30) NOT NULL,
    LicenseExpiration DATE NOT NULL,
    VID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Driver PRIMARY KEY (SID),
    CONSTRAINT FK_Driver_Staff FOREIGN KEY (SID) REFERENCES dbo.Staff (SID),
    CONSTRAINT FK_Driver_Vehicle FOREIGN KEY (VID) REFERENCES dbo.Vehicle (VID)
);
GO

CREATE TABLE dbo.Route (
    RID VARCHAR(30) NOT NULL,
    Distance DECIMAL(8, 2) NULL,
    TotalStops INT NULL,
    Status VARCHAR(100) NULL,
    CONSTRAINT PK_Route PRIMARY KEY (RID)
);
GO

CREATE TABLE dbo.Stop (
    RID VARCHAR(30) NOT NULL,
    Sequence INT NOT NULL,
    EstArrTime DATETIME NULL,
    ActualArrTime DATETIME NULL,
    CONSTRAINT PK_Stop PRIMARY KEY (RID, Sequence),
    CONSTRAINT FK_Stop_Route FOREIGN KEY (RID) REFERENCES dbo.Route (RID)
);
GO

CREATE TABLE dbo.Item (
    [Serial#] VARCHAR(30) NOT NULL,
    PID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Item PRIMARY KEY ([Serial#]),
    CONSTRAINT UQ_Item_Serial_PID UNIQUE ([Serial#], PID),
    CONSTRAINT FK_Item_Product FOREIGN KEY (PID) REFERENCES dbo.Product (PID)
);
GO

CREATE TABLE dbo.PO (
    OID VARCHAR(30) NOT NULL,
    OrderDate DATE NULL,
    Status VARCHAR(100) NULL,
    Value DECIMAL(20, 2) NULL,
    CONSTRAINT PK_PO PRIMARY KEY (OID)
);
GO

CREATE TABLE dbo.ClientHasPO (
    OID VARCHAR(30) NOT NULL,
    CID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_ClientHasPO PRIMARY KEY (OID, CID),
    CONSTRAINT FK_ClientHasPO_PO FOREIGN KEY (OID) REFERENCES dbo.PO (OID),
    CONSTRAINT FK_ClientHasPO_Client FOREIGN KEY (CID) REFERENCES dbo.Client (CID)
);
GO

CREATE TABLE dbo.SupplierHasPO (
    OID VARCHAR(30) NOT NULL,
    SupID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_SupplierHasPO PRIMARY KEY (OID, SupID),
    CONSTRAINT FK_SupplierHasPO_PO FOREIGN KEY (OID) REFERENCES dbo.PO (OID),
    CONSTRAINT FK_SupplierHasPO_Supplier FOREIGN KEY (SupID) REFERENCES dbo.Supplier (SupID)
);
GO

CREATE TABLE dbo.Shipment (
    ShipID VARCHAR(30) NOT NULL,
    OriLocation VARCHAR(255) NULL,
    [Tracking#] VARCHAR(30) NULL,
    ShipDate DATE NULL,
    ExArrDate DATE NULL,
    AcArrDate DATE NULL,
    OID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Shipment PRIMARY KEY (ShipID),
    CONSTRAINT UQ_Shipment_Tracking UNIQUE ([Tracking#]),
    CONSTRAINT FK_Shipment_PO FOREIGN KEY (OID) REFERENCES dbo.PO (OID)
);
GO

CREATE TABLE dbo.ShipmentToWarehouse (
    ShipID VARCHAR(30) NOT NULL,
    WID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_ShipmentToWarehouse PRIMARY KEY (ShipID, WID),
    CONSTRAINT FK_ShipmentToWarehouse_Shipment FOREIGN KEY (ShipID) REFERENCES dbo.Shipment (ShipID),
    CONSTRAINT FK_ShipmentToWarehouse_Warehouse FOREIGN KEY (WID) REFERENCES dbo.Warehouse (WID)
);
GO

CREATE TABLE dbo.OrderItem (
    [Serial#] VARCHAR(30) NOT NULL,
    OID VARCHAR(30) NOT NULL,
    ExDelDate DATE NULL,
    OrderedQty INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrderItem PRIMARY KEY ([Serial#], OID),
    CONSTRAINT FK_OrderItem_Item FOREIGN KEY ([Serial#]) REFERENCES dbo.Item ([Serial#]),
    CONSTRAINT FK_OrderItem_PO FOREIGN KEY (OID) REFERENCES dbo.PO (OID)
);
GO

CREATE TABLE dbo.ShipItem (
    [Serial#] VARCHAR(30) NOT NULL,
    ShipID VARCHAR(30) NOT NULL,
    ExArrDate DATE NULL,
    ShippedQty INT NOT NULL,
    CONSTRAINT PK_ShipItem PRIMARY KEY ([Serial#], ShipID),
    CONSTRAINT FK_ShipItem_Item FOREIGN KEY ([Serial#]) REFERENCES dbo.Item ([Serial#]),
    CONSTRAINT FK_ShipItem_Shipment FOREIGN KEY (ShipID) REFERENCES dbo.Shipment (ShipID)
);
GO

CREATE TABLE dbo.SupplierHasShipment (
    SupID VARCHAR(30) NOT NULL,
    ShipID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_SupplierHasShipment PRIMARY KEY (SupID, ShipID),
    CONSTRAINT FK_SupplierHasShipment_Supplier FOREIGN KEY (SupID) REFERENCES dbo.Supplier (SupID),
    CONSTRAINT FK_SupplierHasShipment_Shipment FOREIGN KEY (ShipID) REFERENCES dbo.Shipment (ShipID)
);
GO

CREATE TABLE dbo.Inventory (
    [Serial#] VARCHAR(30) NOT NULL,
    PID VARCHAR(30) NOT NULL,
    WID VARCHAR(30) NOT NULL,
    CID VARCHAR(30) NOT NULL,
    rQty INT NOT NULL,
    hQty INT NOT NULL,
    sQty INT NOT NULL,
    oQty INT NOT NULL,
    Location VARCHAR(255) NULL,
    Movement VARCHAR(255) NULL,
    Reasons VARCHAR(255) NULL,
    CONSTRAINT PK_Inventory PRIMARY KEY ([Serial#], PID, WID, CID),
    CONSTRAINT FK_Inventory_Item FOREIGN KEY ([Serial#], PID) REFERENCES dbo.Item ([Serial#], PID),
    CONSTRAINT FK_Inventory_Warehouse FOREIGN KEY (WID) REFERENCES dbo.Warehouse (WID),
    CONSTRAINT FK_Inventory_Client FOREIGN KEY (CID) REFERENCES dbo.Client (CID)
);
GO

CREATE TABLE dbo.Delivery (
    DeliveryDate DATE NOT NULL,
    RID VARCHAR(30) NOT NULL,
    VID VARCHAR(30) NOT NULL,
    WID VARCHAR(30) NOT NULL,
    ShipID VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Delivery PRIMARY KEY (DeliveryDate, RID, VID, WID, ShipID),
    CONSTRAINT FK_Delivery_Route FOREIGN KEY (RID) REFERENCES dbo.Route (RID),
    CONSTRAINT FK_Delivery_Vehicle FOREIGN KEY (VID) REFERENCES dbo.Vehicle (VID),
    CONSTRAINT FK_Delivery_Warehouse FOREIGN KEY (WID) REFERENCES dbo.Warehouse (WID),
    CONSTRAINT FK_Delivery_Shipment FOREIGN KEY (ShipID) REFERENCES dbo.Shipment (ShipID)
);
GO

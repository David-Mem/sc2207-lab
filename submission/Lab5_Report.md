# SC2207 Lab 5 Submission

## Group Information

- Group: `[Fill in group number]`
- Team members: `[Fill in names exactly as required]`
- Database name: `scsdg1`
- Project title: `GlobalLogistics`

## Overview

This submission contains the final SQL Server implementation for the GlobalLogistics database, including the schema definition, sample data, required Appendix B queries, the outputs produced from those queries, and the printout of all table records.

## Assumptions

- The final implementation uses SQL Server / T-SQL syntax.
- `OrderItem` uses `ExDelDate` to represent the expected delivery date for the purchase-order line item.
- Shipment delay analysis is based on `Shipment.ExArrDate` and `Shipment.AcArrDate`.
- For Query 3, `ROW_NUMBER()` is used so that each year returns a clean top three months even when counts are tied.

## Additional Effort

Additional effort was made to clean and standardize the project into a rerunnable SQL Server package. The final version consolidates the earlier draft files into a single schema script, a single seed-data script, a clean query set, and helper validation scripts. Foreign keys were added, orphaned staff relationships were fixed, naming was standardized, and the sample dataset was adjusted so that all required Appendix B queries return meaningful results for testing and demonstration.

## DDL Commands

Source file: [GlobalLogistics_Schema.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Schema.sql)

```sql
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
```

## Appendix B Queries

### Query 1

**SQL**

```sql
WITH WarehouseBusiness AS (
    SELECT
        stw.WID,
        chp.CID,
        SUM(si.ShippedQty * oi.UnitPrice) AS TotalBusinessValue
    FROM dbo.ShipmentToWarehouse stw
    JOIN dbo.Shipment s
        ON stw.ShipID = s.ShipID
    JOIN dbo.ShipItem si
        ON s.ShipID = si.ShipID
    JOIN dbo.OrderItem oi
        ON si.[Serial#] = oi.[Serial#]
       AND s.OID = oi.OID
    JOIN dbo.ClientHasPO chp
        ON s.OID = chp.OID
    GROUP BY stw.WID, chp.CID
),
RankedClients AS (
    SELECT
        WID,
        CID,
        TotalBusinessValue,
        ROW_NUMBER() OVER (
            PARTITION BY WID
            ORDER BY TotalBusinessValue DESC, CID ASC
        ) AS ClientRank
    FROM WarehouseBusiness
)
SELECT
    WID AS WarehouseID,
    CID AS ClientID,
    TotalBusinessValue
FROM RankedClients
WHERE ClientRank <= 3
ORDER BY WID, ClientRank;
```

**Output**

```text
WarehouseID  ClientID    TotalBusinessValue
-----------  ----------  ------------------
WH-BKK-001   C004        6900.00
WH-BKK-001   C005        2750.00
WH-BKK-001   C006        2625.00
WH-LA-001    C002        3410.00
WH-LA-001    C005        1500.00
WH-LA-001    C007        1200.00
WH-LA-002    C007        1875.00
WH-LA-002    C002        1200.00
WH-LA-002    C004        1000.00
WH-SG-001    C001        31500.00
WH-SG-001    C005        750.00
WH-SG-002    C001        1200.00
WH-SG-002    C002        1200.00
WH-SG-003    C001        10000.00
```

**Explanation**

This query calculates warehouse business value by joining warehouse-shipment links, shipped items, order items, and client-purchase-order relationships. The total value for each client in each warehouse is ranked, and the top three clients per warehouse are returned.

### Query 2

**SQL**

```sql
SELECT
    CASE
        WHEN w.Address LIKE '%Singapore%' THEN 'Singapore'
        WHEN w.Address LIKE '%Los Angeles, USA%' THEN 'Los Angeles'
    END AS Region,
    SUM(si.ShippedQty * oi.UnitPrice) AS TotalBusinessValue
FROM dbo.Warehouse w
JOIN dbo.ShipmentToWarehouse stw
    ON w.WID = stw.WID
JOIN dbo.Shipment s
    ON stw.ShipID = s.ShipID
JOIN dbo.ShipItem si
    ON s.ShipID = si.ShipID
JOIN dbo.OrderItem oi
    ON si.[Serial#] = oi.[Serial#]
   AND s.OID = oi.OID
WHERE w.Address LIKE '%Singapore%'
   OR w.Address LIKE '%Los Angeles, USA%'
GROUP BY CASE
    WHEN w.Address LIKE '%Singapore%' THEN 'Singapore'
    WHEN w.Address LIKE '%Los Angeles, USA%' THEN 'Los Angeles'
END
ORDER BY Region;
```

**Output**

```text
Region       TotalBusinessValue
-----------  ------------------
Los Angeles  10185.00
Singapore    44650.00
```

**Explanation**

This query groups business value by region, specifically Singapore and Los Angeles, by summing shipped quantity multiplied by unit price. It compares the total business value handled by warehouses located in those two regions.

### Query 3

**SQL**

```sql
WITH MonthlyPOCounts AS (
    SELECT
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        COUNT(*) AS POCount
    FROM dbo.PO
    WHERE OrderDate >= '2024-01-01'
      AND OrderDate < '2026-01-01'
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
),
RankedMonths AS (
    SELECT
        OrderYear,
        OrderMonth,
        POCount,
        ROW_NUMBER() OVER (
            PARTITION BY OrderYear
            ORDER BY POCount DESC, OrderMonth ASC
        ) AS MonthRank
    FROM MonthlyPOCounts
)
SELECT
    OrderYear,
    OrderMonth,
    POCount
FROM RankedMonths
WHERE MonthRank <= 3
ORDER BY OrderYear, MonthRank;
```

**Output**

```text
OrderYear   OrderMonth  POCount
----------  ----------  ----------
2024        1           3
2024        10          3
2024        2           2
2025        10          3
2025        1           2
2025        2           2
```

**Explanation**

This query counts purchase orders by month and year, then ranks the months separately for each year. `ROW_NUMBER()` is used so that each year returns a clean top three months based on purchase-order count.

### Query 4

**SQL**

```sql
SELECT
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2))) AS DECIMAL(10, 2)) AS AvgLeadTimeDays,
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2)) / 30.0) AS DECIMAL(10, 2)) AS AvgLeadTimeMonths
FROM dbo.PO p
JOIN dbo.Shipment s
    ON p.OID = s.OID
WHERE p.OrderDate IS NOT NULL
  AND s.AcArrDate IS NOT NULL;
```

**Output**

```text
AvgLeadTimeDays  AvgLeadTimeMonths
---------------  -----------------
14.93            0.50
```

**Explanation**

This query measures the lead time from purchase-order date to actual shipment arrival date. It uses `DATEDIFF` to compute the delay in days for each purchase order and then returns the average in both days and approximate months.

### Query 5

**SQL**

```sql
SELECT
    s.SupID,
    s.Name
FROM dbo.Supplier s
WHERE EXISTS (
    SELECT 1
    FROM dbo.SupplierHasShipment shs
    JOIN dbo.ShipmentToWarehouse stw
        ON shs.ShipID = stw.ShipID
    JOIN dbo.Warehouse w
        ON stw.WID = w.WID
    WHERE shs.SupID = s.SupID
      AND w.Address LIKE '%Singapore%'
)
AND NOT EXISTS (
    SELECT 1
    FROM dbo.SupplierHasShipment shs
    JOIN dbo.ShipmentToWarehouse stw
        ON shs.ShipID = stw.ShipID
    JOIN dbo.Warehouse w
        ON stw.WID = w.WID
    WHERE shs.SupID = s.SupID
      AND w.Address NOT LIKE '%Singapore%'
)
ORDER BY s.SupID;
```

**Output**

```text
SupID       Name
----------  -------------------------
SUP001      TechImports Ltd
SUP005      Singapore Suppliers Group
```

**Explanation**

This query finds suppliers that have shipped to at least one Singapore warehouse and have not shipped to any non-Singapore warehouse. The result identifies suppliers that only serve Singapore warehouses in the current dataset.

### Query 6

**SQL**

```sql
WITH SingaporeProducts AS (
    SELECT DISTINCT i.PID
    FROM dbo.Inventory i
    JOIN dbo.Warehouse w
        ON i.WID = w.WID
    WHERE w.Address LIKE '%Singapore%'
)
SELECT
    s.SupID,
    s.Name
FROM dbo.Supplier s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.SupplierHasShipment shs
    JOIN dbo.ShipmentToWarehouse stw
        ON shs.ShipID = stw.ShipID
    JOIN dbo.Warehouse w
        ON stw.WID = w.WID
    WHERE shs.SupID = s.SupID
      AND w.Address LIKE '%Thailand%'
)
AND NOT EXISTS (
    SELECT 1
    FROM SingaporeProducts sp
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.Supply sup
        WHERE sup.SupID = s.SupID
          AND sup.PID = sp.PID
    )
)
ORDER BY s.SupID;
```

**Output**

```text
SupID       Name
----------  -------------------------
SUP005      Singapore Suppliers Group
```

**Explanation**

This query first identifies all products currently stored in Singapore warehouses. It then returns suppliers that do not ship to Thailand and that cover every product appearing in Singapore inventory.

### Query 7

**SQL**

```sql
WITH DelayCounts AS (
    SELECT
        s.OriLocation,
        COUNT(*) AS MajorDelayCount
    FROM dbo.Shipment s
    WHERE s.ExArrDate IS NOT NULL
      AND s.AcArrDate IS NOT NULL
      AND s.AcArrDate > DATEADD(MONTH, 6, s.ExArrDate)
    GROUP BY s.OriLocation
)
SELECT
    OriLocation,
    MajorDelayCount
FROM DelayCounts
WHERE MajorDelayCount = (
    SELECT MAX(MajorDelayCount)
    FROM DelayCounts
);
```

**Output**

```text
OriLocation      MajorDelayCount
---------------  ---------------
Shanghai, China  2
```

**Explanation**

This query counts shipment origins where the actual arrival date is more than six months later than the expected arrival date. It then returns the origin location with the highest count of such major delays.

## Printout of All Table Records

Source file: [GlobalLogistics_Print_All_Tables.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Print_All_Tables.sql)

Use the table outputs produced from the final rerun. If you are converting this markdown to PDF, the cleanest approach is to paste the table result screenshots or exported result blocks under each heading below.

### Client

Paste the output from `Result Set Batch 2 - Query 1` here.

### Supplier

Paste the output from `Result Set Batch 2 - Query 2` here.

### Warehouse

Paste the output from `Result Set Batch 2 - Query 3` here.

### Product

Paste the output from `Result Set Batch 2 - Query 4` here.

### Vehicle

Paste the output from `Result Set Batch 2 - Query 5` here.

### Zone

Paste the output from `Result Set Batch 2 - Query 6` here.

### Supply

Paste the output from `Result Set Batch 2 - Query 7` here.

### Staff

Paste the output from `Result Set Batch 2 - Query 8` here.

### Employee

Paste the output from `Result Set Batch 2 - Query 9` here.

### Driver

Paste the output from `Result Set Batch 2 - Query 10` here.

### Route

Paste the output from `Result Set Batch 2 - Query 11` here.

### Stop

Paste the output from `Result Set Batch 2 - Query 12` here.

### Item

Paste the output from `Result Set Batch 2 - Query 13` here.

### PO

Paste the output from `Result Set Batch 2 - Query 14` here.

### ClientHasPO

Paste the output from `Result Set Batch 2 - Query 15` here.

### SupplierHasPO

Paste the output from `Result Set Batch 2 - Query 16` here.

### Shipment

Paste the output from `Result Set Batch 2 - Query 17` here.

### ShipmentToWarehouse

Paste the output from `Result Set Batch 2 - Query 18` here.

### OrderItem

Paste the output from `Result Set Batch 2 - Query 19` here.

### ShipItem

Paste the output from `Result Set Batch 2 - Query 20` here.

### SupplierHasShipment

Paste the output from `Result Set Batch 2 - Query 21` here.

### Inventory

Paste the output from `Result Set Batch 2 - Query 22` here.

### Delivery

Paste the output from `Result Set Batch 2 - Query 23` here.

## Appendix C

`[Fill in Appendix C exactly as required by the lab manual.]`

## Appendix D

`[Fill in Appendix D exactly as required by the lab manual.]`

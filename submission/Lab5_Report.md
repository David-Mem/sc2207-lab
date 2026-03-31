# SC2207 Lab 5 Submission

## Group Information

- Group: `1`
- Team members: `.`
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

Source file: GlobalLogistics_Schema.sql

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

Source file: GlobalLogistics_Print_All_Tables.sql

Use the table outputs produced from the final rerun. If you are converting this markdown to PDF, the cleanest approach is to paste the table result screenshots or exported result blocks under each heading below.

### Client

```text
CID         CompanyName            ContactPerson      StartDate   ServiceTier
----------  ---------------------  -----------------  ----------  -----------
C001        Amazon Singapore       John Smith         2020-01-15  Gold
C002        Lazada Southeast Asia  Sarah Johnson      2019-06-22  Gold
C003        Shopee Philippines     Michael Chen       2021-03-10  Silver
C004        TikTok Shop Thailand   Emily Rodriguez    2018-09-30  Platinum
C005        AEON Thailand          David Wilson       2018-11-14  Gold
C006        Zalora Vietnam         Lisa Anderson      2022-02-14  Silver
C007        DHL eCommerce          James Thompson     2019-04-08  Platinum
C008        Kerry Logistics        Jennifer Lee       2020-10-25  Gold
C009        Robinsons Singapore    Robert Martinez    2020-03-25  Silver
C010        Takashimaya Singapore  Amanda Clark       2019-08-14  Platinum
C011        SM Malls Philippines   Christopher White  2021-05-11  Gold
C012        Central World Bangkok  Michelle Garcia    2019-07-17  Gold
```

### Supplier

```text
SupID       Country      Name                       PaymentTerms  LeadTimeDays
----------  -----------  -------------------------  ------------  ------------
SUP001      China        TechImports Ltd            Net 30        30
SUP002      Taiwan       Electronics Factory        Net 45        25
SUP003      Vietnam      TextileCorp Vietnam        Net 30        20
SUP004      Thailand     Bangkok Garment Works      Net 30        15
SUP005      Singapore    Singapore Suppliers Group  Net 15        10
SUP006      South Korea  Seoul Electronics          Net 45        28
SUP007      Japan        Tokyo Manufacturing        Net 60        35
SUP008      China        Shanghai Imports Co        Net 30        32
```

### Warehouse

```text
WID         Address                                  Size        Temperature  Security
----------  ---------------------------------------  ----------  -----------  ----------
WH-BKK-001  123 Soi Sukhumvit 38, Bangkok, Thailand  28000       25           4
WH-LA-001   1234 Industrial Blvd, Los Angeles, USA   50000       22.5         5
WH-LA-002   5678 Freight Lane, Los Angeles, USA      35000       22           4
WH-SG-001   26 Nanyang Avenue, Singapore             40000.25    23.6         5
WH-SG-002   03 Shenton Way, Singapore                20000       24           4
WH-SG-003   25 Broadway, Singapore                   10492       24.1         3
```

### Product

```text
PID         ItemSerial    Name                  Brand         Category              UnitCost    RetailPrice  Length      Width       Height      HandlingRequirements
----------  ------------  --------------------  ------------  --------------------  ----------  -----------  ----------  ----------  ----------  --------------------------------
P001        SN-ELEC-001   Laptop Pro 15         TechBrand     Electronics           800.00      1200.00      35.79       24.59       1.62        Fragile, Handle with care
P002        SN-ELEC-002   Wireless Mouse        ClickMaster   Computer Accessories  15.50       29.99        10.00       6.00        4.00        NULL
P003        SN-ELEC-003   Mechanical Keyboard   TypeFast      Computer Accessories  75.00       130.00       44.00       13.00       3.50        Keep Dry
P004        SN-ELEC-004   4K Monitor 27 inch    ViewSharp     Electronics           250.00      399.99       61.00       36.00       5.00        Fragile, Screen side up
P005        SN-CLOTH-001  Cotton T-Shirt        FashionBrand  Apparel               5.00        15.00        30.00       25.00       1.00        NULL
P006        SN-CLOTH-002  Denim Jeans           StyleHub      Apparel               15.00       45.00        32.00       30.00       2.00        NULL
P007        SN-FOOD-001   Instant Noodles Pack  FoodBrand     Food & Beverages      0.50        1.50         20.00       15.00       5.00        Keep Dry
P008        SN-FOOD-002   Coffee Beans 500g     BeansCo       Food & Beverages      8.00        20.00        15.00       10.00       10.00       Temperature Controlled, Keep Dry
P009        SN-HOME-001   Bedding Set           HomeDecor     Home & Garden         20.00       60.00        40.00       30.00       10.00       NULL
P010        SN-WATCH-001  Smart Watch           TechTime      Electronics           50.00       150.00       8.00        8.00        8.00        Fragile, High-Value
```

### Vehicle

```text
VID         Type                License        CapacityWgt  CapacityVol
----------  ------------------  -------------  -----------  -----------
V001        Van                 SG-VAN-001     2000.00      12.00
V002        Truck               SG-TRUCK-001   5000.00      35.00
V003        Refrigerated Truck  SG-REFRIG-001  3500.00      20.00
V004        Van                 LA-VAN-001     2000.00      12.00
V005        Truck               LA-TRUCK-001   5500.00      40.00
V006        Truck               BKK-TRUCK-001  5000.00      35.00
```

### Zone

```text
WID         Location       Code
----------  -------------  ----------
WH-BKK-001  Receiving      1
WH-LA-001   Receiving      1
WH-LA-002   Receiving      1
WH-SG-001   Bulk Storage   2
WH-SG-001   Packing Area   4
WH-SG-001   Picking Area   3
WH-SG-001   Receiving      1
WH-SG-001   Shipping Dock  5
WH-SG-002   Bulk Storage   2
WH-SG-002   Receiving      1
WH-SG-003   Receiving      1
```

### Supply

```text
PID         SupID       CID         ContractStartDate  ContractEndDate
----------  ----------  ----------  -----------------  ---------------
P001        SUP001      C001        2020-01-15         2026-12-31
P002        SUP001      C001        2020-01-15         2026-12-31
P003        SUP001      C011        2021-05-11         2026-12-31
P004        SUP002      C001        2020-02-01         2026-12-31
P010        SUP002      C007        2019-05-01         2026-12-31
P005        SUP003      C006        2022-02-14         2026-12-31
P006        SUP003      C006        2022-02-14         2026-12-31
P005        SUP004      C004        2018-10-01         2026-12-31
P007        SUP004      C004        2018-09-30         2026-12-31
P008        SUP004      C005        2018-11-14         2026-12-31
P001        SUP005      C001        2020-01-15         2026-12-31
P001        SUP005      C009        2020-03-25         2026-12-31
P006        SUP005      C009        2020-03-25         2026-12-31
P008        SUP005      C010        2019-08-14         2026-12-31
P009        SUP005      C010        2019-08-14         2026-12-31
P002        SUP006      C002        2019-06-22         2026-12-31
P010        SUP006      C008        2020-10-25         2026-12-31
P001        SUP008      C002        2020-01-01         2026-12-31
P003        SUP008      C007        2020-02-01         2026-12-31
```

### Staff

```text
SID         Name         Type             HireDate
----------  -----------  ---------------  ----------
DRV001      Gavin Tan    Driver           2020-09-01
DRV002      Hannah Ong   Driver           2020-10-12
DRV003      Isaac Chua   Driver           2021-04-20
DRV004      Jasmine Ho   Driver           2021-08-18
DRV005      Kelvin Yeo   Driver           2022-03-03
DRV006      Lydia Ng     Driver           2022-11-11
EMP001      Alice Tan    Warehouse Staff  2021-01-15
EMP002      Brandon Lim  Warehouse Staff  2021-03-10
EMP003      Cheryl Goh   Warehouse Staff  2021-06-21
EMP004      Darren Lee   Warehouse Staff  2022-02-14
EMP005      Elaine Koh   Warehouse Staff  2022-07-05
EMP006      Farhan Noor  Warehouse Staff  2023-01-09
```

### Employee

```text
SID         Certification                       WID
----------  ----------------------------------  ----------
EMP001      Forklift Operator, Hazmat Handling  WH-SG-001
EMP002      Forklift Operator                   WH-SG-002
EMP003      Quality Inspector                   WH-SG-003
EMP004      Forklift Operator, High Reach       WH-LA-001
EMP005      Hazmat Handling                     WH-LA-002
EMP006      Forklift Operator                   WH-BKK-001
```

### Driver

```text
SID         LicenseNo         LicenseExpiration  VID
----------  ----------------  -----------------  ----------
DRV001      SG-DRV-2019-001   2027-06-30         V001
DRV002      SG-DRV-2020-002   2028-03-15         V002
DRV003      SG-DRV-2020-003   2028-01-10         V003
DRV004      LA-DRV-2019-001   2027-05-15         V004
DRV005      LA-DRV-2018-002   2026-11-20         V005
DRV006      BKK-DRV-2020-001  2028-08-30         V006
```

### Route

```text
RID         Distance    TotalStops  Status
----------  ----------  ----------  ----------
R001        15.50       5           Completed
R002        22.30       8           Completed
R003        18.90       6           Completed
R004        25.50       10          Completed
R005        14.20       4           Completed
```

### Stop

```text
RID         Sequence    EstArrTime               ActualArrTime
----------  ----------  -----------------------  -----------------------
R001        1           2026-03-26 08:00:00.000  2026-03-26 08:15:00.000
R001        2           2026-03-26 09:00:00.000  2026-03-26 09:10:00.000
R002        1           2026-03-27 08:30:00.000  2026-03-27 08:45:00.000
R002        2           2026-03-27 10:00:00.000  2026-03-27 10:10:00.000
R003        1           2026-03-28 09:00:00.000  2026-03-28 09:20:00.000
```

### Item

```text
Serial#     PID
----------  ----------
ITEM-001    P001
ITEM-002    P001
ITEM-003    P002
ITEM-004    P003
ITEM-005    P004
ITEM-006    P005
ITEM-007    P006
ITEM-008    P007
ITEM-009    P008
ITEM-010    P009
ITEM-011    P010
ITEM-012    P002
ITEM-013    P003
ITEM-014    P004
ITEM-015    P005
```

### PO

```text
OID          OrderDate   Status          Value
-----------  ----------  --------------  ----------
PO-2024-001  2024-01-05  Fully Received  25000.00
PO-2024-002  2024-01-15  Fully Received  18000.00
PO-2024-003  2024-01-25  Fully Received  22000.00
PO-2024-004  2024-02-10  Fully Received  15000.00
PO-2024-005  2024-02-20  Fully Received  20000.00
PO-2024-006  2024-03-01  Fully Received  19000.00
PO-2024-007  2024-03-15  Fully Received  23000.00
PO-2024-008  2024-10-05  Fully Received  21000.00
PO-2024-009  2024-10-15  Fully Received  24000.00
PO-2024-010  2024-10-25  Fully Received  19500.00
PO-2024-011  2024-11-10  Fully Received  26000.00
PO-2024-012  2024-11-20  Fully Received  20500.00
PO-2024-013  2024-12-01  Fully Received  23000.00
PO-2024-014  2024-12-15  Fully Received  17750.00
PO-2025-001  2025-01-08  Fully Received  20000.00
PO-2025-002  2025-01-18  Fully Received  24500.00
PO-2025-003  2025-02-12  Fully Received  27000.00
PO-2025-004  2025-02-22  Fully Received  18500.00
PO-2025-005  2025-03-05  Fully Received  25000.00
PO-2025-006  2025-03-18  Fully Received  21500.00
PO-2025-007  2025-10-08  Fully Received  22000.00
PO-2025-008  2025-10-18  Fully Received  25500.00
PO-2025-009  2025-10-28  Fully Received  21750.00
PO-2025-010  2025-11-12  Fully Received  28500.00
PO-2025-011  2025-11-22  Fully Received  23500.00
PO-2025-012  2025-12-05  Fully Received  26500.00
PO-2025-013  2025-12-18  Fully Received  20750.00
```

### ClientHasPO

```text
OID          CID
-----------  ----------
PO-2024-001  C001
PO-2024-002  C002
PO-2024-003  C007
PO-2024-004  C001
PO-2024-005  C003
PO-2024-006  C004
PO-2024-007  C005
PO-2024-008  C005
PO-2024-009  C004
PO-2024-010  C012
PO-2024-011  C004
PO-2024-012  C005
PO-2024-013  C007
PO-2024-014  C002
PO-2025-001  C001
PO-2025-002  C002
PO-2025-003  C001
PO-2025-004  C003
PO-2025-005  C004
PO-2025-006  C006
PO-2025-007  C004
PO-2025-008  C005
PO-2025-009  C012
PO-2025-010  C004
PO-2025-011  C005
PO-2025-012  C001
PO-2025-013  C002
```

### SupplierHasPO

```text
OID          SupID
-----------  ----------
PO-2024-001  SUP001
PO-2024-002  SUP002
PO-2024-003  SUP006
PO-2024-004  SUP001
PO-2024-005  SUP003
PO-2024-006  SUP004
PO-2024-007  SUP004
PO-2024-008  SUP004
PO-2024-009  SUP004
PO-2024-010  SUP004
PO-2024-011  SUP004
PO-2024-012  SUP004
PO-2024-013  SUP006
PO-2024-014  SUP002
PO-2025-001  SUP001
PO-2025-002  SUP002
PO-2025-003  SUP005
PO-2025-004  SUP003
PO-2025-005  SUP004
PO-2025-006  SUP003
PO-2025-007  SUP008
PO-2025-008  SUP008
PO-2025-009  SUP004
PO-2025-010  SUP004
PO-2025-011  SUP004
PO-2025-012  SUP001
PO-2025-013  SUP002
```

### Shipment

```text
ShipID                 OriLocation           Tracking#   ShipDate    ExArrDate   AcArrDate   OID
---------------------  --------------------  ----------  ----------  ----------  ----------  -----------
SHIP-2024-001          Shanghai, China       TRACK-001   2023-12-10  2024-01-05  2024-01-05  PO-2024-001
SHIP-2024-002          Taipei, Taiwan        TRACK-002   2024-01-02  2024-01-15  2024-01-15  PO-2024-002
SHIP-2024-003          Seoul, South Korea    TRACK-003   2024-01-10  2024-01-25  2024-01-25  PO-2024-003
SHIP-2024-004          Shanghai, China       TRACK-004   2024-02-01  2024-02-10  2024-02-10  PO-2024-004
SHIP-2024-005          Ho Chi Minh, Vietnam  TRACK-005   2024-02-05  2024-02-20  2024-02-20  PO-2024-005
SHIP-2024-006          Bangkok, Thailand     TRACK-006   2024-02-15  2024-03-01  2024-03-01  PO-2024-006
SHIP-2024-007          Bangkok, Thailand     TRACK-007   2024-02-28  2024-03-15  2024-03-15  PO-2024-007
SHIP-2024-008          Bangkok, Thailand     TRACK-008   2024-09-25  2024-10-05  2024-10-05  PO-2024-008
SHIP-2024-009          Bangkok, Thailand     TRACK-009   2024-10-05  2024-10-15  2024-10-15  PO-2024-009
SHIP-2024-010          Bangkok, Thailand     TRACK-010   2024-10-15  2024-10-25  2024-10-25  PO-2024-010
SHIP-2024-011          Bangkok, Thailand     TRACK-011   2024-10-25  2024-11-10  2024-11-10  PO-2024-011
SHIP-2024-012          Bangkok, Thailand     TRACK-012   2024-11-05  2024-11-20  2024-11-20  PO-2024-012
SHIP-2024-013          Seoul, South Korea    TRACK-013   2024-11-15  2024-12-01  2024-12-01  PO-2024-013
SHIP-2024-014          Taipei, Taiwan        TRACK-014   2024-12-01  2024-12-15  2024-12-15  PO-2024-014
SHIP-2025-001          Shanghai, China       TRACK-015   2024-12-20  2025-01-08  2025-01-08  PO-2025-001
SHIP-2025-002          Taipei, Taiwan        TRACK-016   2025-01-05  2025-01-18  2025-01-18  PO-2025-002
SHIP-2025-003          Singapore, Singapore  TRACK-017   2025-02-01  2025-02-12  2025-02-12  PO-2025-003
SHIP-2025-004          Ho Chi Minh, Vietnam  TRACK-018   2025-02-08  2025-02-22  2025-02-22  PO-2025-004
SHIP-2025-005          Bangkok, Thailand     TRACK-019   2025-02-20  2025-03-05  2025-03-05  PO-2025-005
SHIP-2025-006          Ho Chi Minh, Vietnam  TRACK-020   2025-03-05  2025-03-18  2025-03-18  PO-2025-006
SHIP-2025-007-DELAYED  Shanghai, China       TRACK-021   2024-09-01  2025-10-08  2026-04-15  PO-2025-007
SHIP-2025-008-DELAYED  Shanghai, China       TRACK-022   2024-09-15  2025-10-18  2026-05-20  PO-2025-008
SHIP-2025-009          Bangkok, Thailand     TRACK-023   2025-09-28  2025-10-28  2025-10-28  PO-2025-009
SHIP-2025-010          Bangkok, Thailand     TRACK-024   2025-10-15  2025-11-12  2025-11-12  PO-2025-010
SHIP-2025-011          Bangkok, Thailand     TRACK-025   2025-11-08  2025-11-22  2025-11-22  PO-2025-011
SHIP-2025-012          Shanghai, China       TRACK-026   2025-11-18  2025-12-05  2025-12-05  PO-2025-012
SHIP-2025-013          Taipei, Taiwan        TRACK-027   2025-12-05  2025-12-18  2025-12-18  PO-2025-013
```

### ShipmentToWarehouse

```text
ShipID                 WID
---------------------  ----------
SHIP-2024-001          WH-SG-001
SHIP-2024-002          WH-LA-001
SHIP-2024-003          WH-LA-002
SHIP-2024-004          WH-SG-001
SHIP-2024-005          WH-BKK-001
SHIP-2024-006          WH-BKK-001
SHIP-2024-007          WH-BKK-001
SHIP-2024-008          WH-BKK-001
SHIP-2024-009          WH-BKK-001
SHIP-2024-010          WH-BKK-001
SHIP-2024-011          WH-BKK-001
SHIP-2024-012          WH-BKK-001
SHIP-2024-013          WH-LA-001
SHIP-2024-014          WH-SG-002
SHIP-2025-001          WH-SG-001
SHIP-2025-002          WH-LA-001
SHIP-2025-003          WH-SG-003
SHIP-2025-004          WH-BKK-001
SHIP-2025-005          WH-BKK-001
SHIP-2025-006          WH-BKK-001
SHIP-2025-007-DELAYED  WH-LA-002
SHIP-2025-008-DELAYED  WH-LA-001
SHIP-2025-009          WH-BKK-001
SHIP-2025-010          WH-BKK-001
SHIP-2025-011          WH-SG-001
SHIP-2025-012          WH-SG-002
SHIP-2025-013          WH-LA-002
```

### OrderItem

```text
Serial#     OID          ExDelDate   OrderedQty  UnitPrice
----------  -----------  ----------  ----------  ----------
ITEM-001    PO-2024-001  2024-01-05  10          800.00
ITEM-002    PO-2024-001  2024-01-05  5           800.00
ITEM-003    PO-2024-002  2024-01-15  100         15.50
ITEM-004    PO-2024-003  2024-01-25  25          75.00
ITEM-005    PO-2024-004  2024-02-10  30          250.00
ITEM-006    PO-2024-005  2024-02-20  200         5.00
ITEM-007    PO-2024-006  2024-03-01  80          15.00
ITEM-008    PO-2024-007  2024-03-15  40          25.00
ITEM-009    PO-2024-008  2024-10-05  200         5.00
ITEM-010    PO-2024-009  2024-10-15  400         3.00
ITEM-011    PO-2024-010  2024-10-25  150         8.00
ITEM-012    PO-2024-011  2024-11-10  300         5.00
ITEM-013    PO-2024-012  2024-11-20  250         3.00
ITEM-014    PO-2024-013  2024-12-01  100         12.00
ITEM-015    PO-2024-014  2024-12-15  80          15.00
ITEM-001    PO-2025-001  2025-01-08  15          800.00
ITEM-003    PO-2025-002  2025-01-18  120         15.50
ITEM-005    PO-2025-003  2025-02-12  40          250.00
ITEM-007    PO-2025-004  2025-02-22  250         5.00
ITEM-008    PO-2025-005  2025-03-05  100         15.00
ITEM-006    PO-2025-006  2025-03-18  35          75.00
ITEM-009    PO-2025-007  2025-10-08  200         5.00
ITEM-010    PO-2025-008  2025-10-18  300         5.00
ITEM-012    PO-2025-009  2025-10-28  150         8.00
ITEM-014    PO-2025-010  2025-11-12  300         5.00
ITEM-015    PO-2025-011  2025-11-22  250         3.00
ITEM-001    PO-2025-012  2025-12-05  100         12.00
ITEM-003    PO-2025-013  2025-12-18  80          15.00
```

### ShipItem

```text
Serial#     ShipID                 ExArrDate   ShippedQty
----------  ---------------------  ----------  ----------
ITEM-001    SHIP-2024-001          2024-01-05  10
ITEM-002    SHIP-2024-001          2024-01-05  5
ITEM-003    SHIP-2024-002          2024-01-15  100
ITEM-004    SHIP-2024-003          2024-01-25  25
ITEM-005    SHIP-2024-004          2024-02-10  30
ITEM-006    SHIP-2024-005          2024-02-20  200
ITEM-007    SHIP-2024-006          2024-03-01  80
ITEM-008    SHIP-2024-007          2024-03-15  40
ITEM-009    SHIP-2024-008          2024-10-05  200
ITEM-010    SHIP-2024-009          2024-10-15  400
ITEM-011    SHIP-2024-010          2024-10-25  150
ITEM-012    SHIP-2024-011          2024-11-10  300
ITEM-013    SHIP-2024-012          2024-11-20  250
ITEM-014    SHIP-2024-013          2024-12-01  100
ITEM-015    SHIP-2024-014          2024-12-15  80
ITEM-001    SHIP-2025-001          2025-01-08  15
ITEM-003    SHIP-2025-002          2025-01-18  120
ITEM-005    SHIP-2025-003          2025-02-12  40
ITEM-007    SHIP-2025-004          2025-02-22  250
ITEM-008    SHIP-2025-005          2025-03-05  100
ITEM-006    SHIP-2025-006          2025-03-18  35
ITEM-009    SHIP-2025-007-DELAYED  2025-10-08  200
ITEM-010    SHIP-2025-008-DELAYED  2025-10-18  300
ITEM-012    SHIP-2025-009          2025-10-28  150
ITEM-014    SHIP-2025-010          2025-11-12  300
ITEM-015    SHIP-2025-011          2025-11-22  250
ITEM-001    SHIP-2025-012          2025-12-05  100
ITEM-003    SHIP-2025-013          2025-12-18  80
```

### SupplierHasShipment

```text
SupID       ShipID
----------  ---------------------
SUP001      SHIP-2024-001
SUP001      SHIP-2024-004
SUP001      SHIP-2025-001
SUP001      SHIP-2025-012
SUP002      SHIP-2024-002
SUP002      SHIP-2024-014
SUP002      SHIP-2025-002
SUP002      SHIP-2025-013
SUP003      SHIP-2024-005
SUP003      SHIP-2025-004
SUP003      SHIP-2025-006
SUP004      SHIP-2024-006
SUP004      SHIP-2024-007
SUP004      SHIP-2024-008
SUP004      SHIP-2024-009
SUP004      SHIP-2024-010
SUP004      SHIP-2024-011
SUP004      SHIP-2024-012
SUP004      SHIP-2025-005
SUP004      SHIP-2025-009
SUP004      SHIP-2025-010
SUP004      SHIP-2025-011
SUP005      SHIP-2025-003
SUP006      SHIP-2024-003
SUP006      SHIP-2024-013
SUP008      SHIP-2025-007-DELAYED
SUP008      SHIP-2025-008-DELAYED
```

### Inventory

```text
Serial#     PID         WID         CID         rQty        hQty        sQty        oQty        Location    Movement    Reasons
----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ------------------------------
ITEM-005    P004        WH-BKK-001  C004        20          80          60          0           A1-R3-B01   Receipt     Received from inbound shipment
ITEM-006    P005        WH-BKK-001  C005        150         400         250         0           B1-R1-B01   Receipt     Received from inbound shipment
ITEM-008    P007        WH-BKK-001  C005        200         600         400         0           B1-R2-B01   Receipt     Received from inbound shipment
ITEM-010    P009        WH-BKK-001  C004        40          120         80          0           C1-R1-B01   Pick        Allocated to order
ITEM-003    P002        WH-LA-001   C001        50          150         100         0           A1-R2-B01   Putaway     Putaway from receiving
ITEM-004    P003        WH-LA-002   C002        30          120         90          0           A1-R2-B02   Pick        Allocated to order
ITEM-001    P001        WH-SG-001   C001        0           15          15          0           A1-R1-B01   Receipt     Received from inbound shipment
ITEM-002    P001        WH-SG-001   C001        0           10          10          0           A1-R1-B02   Receipt     Received from inbound shipment
ITEM-009    P008        WH-SG-001   C010        50          150         100         0           A1-R3-B02   Putaway     Putaway from receiving
ITEM-007    P006        WH-SG-002   C009        100         300         200         0           A1-R1-B01   Receipt     Received from inbound shipment
```

### Delivery

```text
DeliveryDate  RID         VID         WID         ShipID
------------  ----------  ----------  ----------  -------------
2026-03-26    R001        V001        WH-SG-001   SHIP-2025-001
2026-03-27    R002        V002        WH-LA-001   SHIP-2025-002
2026-03-28    R003        V006        WH-BKK-001  SHIP-2025-005
```

## Appendix C



## Appendix D


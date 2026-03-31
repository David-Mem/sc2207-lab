SET NOCOUNT ON;
GO

PRINT 'Query 1: Top 3 clients by warehouse business value';
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
GO

PRINT 'Query 2: Business value in Singapore vs Los Angeles';
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
GO

PRINT 'Query 3: Top 3 PO months per year';
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
GO

PRINT 'Query 4: Average lead time';
SELECT
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2))) AS DECIMAL(10, 2)) AS AvgLeadTimeDays,
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2)) / 30.0) AS DECIMAL(10, 2)) AS AvgLeadTimeMonths
FROM dbo.PO p
JOIN dbo.Shipment s
    ON p.OID = s.OID
WHERE p.OrderDate IS NOT NULL
  AND s.AcArrDate IS NOT NULL;
GO

PRINT 'Query 5: Suppliers serving only Singapore warehouses';
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
GO

PRINT 'Query 6: Suppliers that avoid Thailand and cover all Singapore products';
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
GO

PRINT 'Query 7: Origins with the most major delays';
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
GO

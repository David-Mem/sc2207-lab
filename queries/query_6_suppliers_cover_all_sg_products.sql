SET NOCOUNT ON;
GO

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

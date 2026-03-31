SET NOCOUNT ON;
GO

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

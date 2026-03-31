SET NOCOUNT ON;
GO

SELECT 'Employee without Staff' AS Issue, e.SID AS OffendingKey
FROM dbo.Employee e
LEFT JOIN dbo.Staff s
    ON e.SID = s.SID
WHERE s.SID IS NULL

UNION ALL

SELECT 'Driver without Staff' AS Issue, d.SID AS OffendingKey
FROM dbo.Driver d
LEFT JOIN dbo.Staff s
    ON d.SID = s.SID
WHERE s.SID IS NULL

UNION ALL

SELECT 'Driver without Vehicle' AS Issue, d.VID AS OffendingKey
FROM dbo.Driver d
LEFT JOIN dbo.Vehicle v
    ON d.VID = v.VID
WHERE v.VID IS NULL

UNION ALL

SELECT 'Employee without Warehouse' AS Issue, e.WID AS OffendingKey
FROM dbo.Employee e
LEFT JOIN dbo.Warehouse w
    ON e.WID = w.WID
WHERE w.WID IS NULL

UNION ALL

SELECT 'OrderItem without PO' AS Issue, oi.OID AS OffendingKey
FROM dbo.OrderItem oi
LEFT JOIN dbo.PO p
    ON oi.OID = p.OID
WHERE p.OID IS NULL

UNION ALL

SELECT 'OrderItem without Item' AS Issue, oi.[Serial#] AS OffendingKey
FROM dbo.OrderItem oi
LEFT JOIN dbo.Item i
    ON oi.[Serial#] = i.[Serial#]
WHERE i.[Serial#] IS NULL

UNION ALL

SELECT 'ShipItem without Shipment' AS Issue, si.ShipID AS OffendingKey
FROM dbo.ShipItem si
LEFT JOIN dbo.Shipment s
    ON si.ShipID = s.ShipID
WHERE s.ShipID IS NULL

UNION ALL

SELECT 'ShipItem without Item' AS Issue, si.[Serial#] AS OffendingKey
FROM dbo.ShipItem si
LEFT JOIN dbo.Item i
    ON si.[Serial#] = i.[Serial#]
WHERE i.[Serial#] IS NULL

UNION ALL

SELECT 'Shipment without PO' AS Issue, sh.OID AS OffendingKey
FROM dbo.Shipment sh
LEFT JOIN dbo.PO p
    ON sh.OID = p.OID
WHERE p.OID IS NULL

UNION ALL

SELECT 'ShipmentToWarehouse without Shipment' AS Issue, stw.ShipID AS OffendingKey
FROM dbo.ShipmentToWarehouse stw
LEFT JOIN dbo.Shipment sh
    ON stw.ShipID = sh.ShipID
WHERE sh.ShipID IS NULL

UNION ALL

SELECT 'ShipmentToWarehouse without Warehouse' AS Issue, stw.WID AS OffendingKey
FROM dbo.ShipmentToWarehouse stw
LEFT JOIN dbo.Warehouse w
    ON stw.WID = w.WID
WHERE w.WID IS NULL

UNION ALL

SELECT 'SupplierHasShipment without Supplier' AS Issue, shs.SupID AS OffendingKey
FROM dbo.SupplierHasShipment shs
LEFT JOIN dbo.Supplier s
    ON shs.SupID = s.SupID
WHERE s.SupID IS NULL

UNION ALL

SELECT 'SupplierHasShipment without Shipment' AS Issue, shs.ShipID AS OffendingKey
FROM dbo.SupplierHasShipment shs
LEFT JOIN dbo.Shipment sh
    ON shs.ShipID = sh.ShipID
WHERE sh.ShipID IS NULL

UNION ALL

SELECT 'Supply without Product' AS Issue, sup.PID AS OffendingKey
FROM dbo.Supply sup
LEFT JOIN dbo.Product p
    ON sup.PID = p.PID
WHERE p.PID IS NULL

UNION ALL

SELECT 'Supply without Supplier' AS Issue, sup.SupID AS OffendingKey
FROM dbo.Supply sup
LEFT JOIN dbo.Supplier s
    ON sup.SupID = s.SupID
WHERE s.SupID IS NULL

UNION ALL

SELECT 'Supply without Client' AS Issue, sup.CID AS OffendingKey
FROM dbo.Supply sup
LEFT JOIN dbo.Client c
    ON sup.CID = c.CID
WHERE c.CID IS NULL

UNION ALL

SELECT 'Inventory without Item' AS Issue, i.[Serial#] AS OffendingKey
FROM dbo.Inventory i
LEFT JOIN dbo.Item it
    ON i.[Serial#] = it.[Serial#]
   AND i.PID = it.PID
WHERE it.[Serial#] IS NULL

UNION ALL

SELECT 'Inventory without Warehouse' AS Issue, i.WID AS OffendingKey
FROM dbo.Inventory i
LEFT JOIN dbo.Warehouse w
    ON i.WID = w.WID
WHERE w.WID IS NULL

UNION ALL

SELECT 'Inventory without Client' AS Issue, i.CID AS OffendingKey
FROM dbo.Inventory i
LEFT JOIN dbo.Client c
    ON i.CID = c.CID
WHERE c.CID IS NULL

UNION ALL

SELECT 'Delivery without Route' AS Issue, d.RID AS OffendingKey
FROM dbo.Delivery d
LEFT JOIN dbo.Route r
    ON d.RID = r.RID
WHERE r.RID IS NULL

UNION ALL

SELECT 'Delivery without Vehicle' AS Issue, d.VID AS OffendingKey
FROM dbo.Delivery d
LEFT JOIN dbo.Vehicle v
    ON d.VID = v.VID
WHERE v.VID IS NULL

UNION ALL

SELECT 'Delivery without Warehouse' AS Issue, d.WID AS OffendingKey
FROM dbo.Delivery d
LEFT JOIN dbo.Warehouse w
    ON d.WID = w.WID
WHERE w.WID IS NULL

UNION ALL

SELECT 'Delivery without Shipment' AS Issue, d.ShipID AS OffendingKey
FROM dbo.Delivery d
LEFT JOIN dbo.Shipment s
    ON d.ShipID = s.ShipID
WHERE s.ShipID IS NULL;
GO

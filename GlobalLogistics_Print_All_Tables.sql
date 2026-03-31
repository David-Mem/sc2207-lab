SET NOCOUNT ON;
GO

SELECT * FROM dbo.Client ORDER BY CID;
SELECT * FROM dbo.Supplier ORDER BY SupID;
SELECT * FROM dbo.Warehouse ORDER BY WID;
SELECT * FROM dbo.Product ORDER BY PID;
SELECT * FROM dbo.Vehicle ORDER BY VID;
SELECT * FROM dbo.Zone ORDER BY WID, Location;
SELECT * FROM dbo.Supply ORDER BY SupID, PID, CID, ContractStartDate;
SELECT * FROM dbo.Staff ORDER BY SID;
SELECT * FROM dbo.Employee ORDER BY SID;
SELECT * FROM dbo.Driver ORDER BY SID;
SELECT * FROM dbo.Route ORDER BY RID;
SELECT * FROM dbo.Stop ORDER BY RID, Sequence;
SELECT * FROM dbo.Item ORDER BY [Serial#];
SELECT * FROM dbo.PO ORDER BY OID;
SELECT * FROM dbo.ClientHasPO ORDER BY OID, CID;
SELECT * FROM dbo.SupplierHasPO ORDER BY OID, SupID;
SELECT * FROM dbo.Shipment ORDER BY ShipID;
SELECT * FROM dbo.ShipmentToWarehouse ORDER BY ShipID, WID;
SELECT * FROM dbo.OrderItem ORDER BY OID, [Serial#];
SELECT * FROM dbo.ShipItem ORDER BY ShipID, [Serial#];
SELECT * FROM dbo.SupplierHasShipment ORDER BY SupID, ShipID;
SELECT * FROM dbo.Inventory ORDER BY WID, [Serial#];
SELECT * FROM dbo.Delivery ORDER BY DeliveryDate, RID, VID, WID, ShipID;
GO

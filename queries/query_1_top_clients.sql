SET NOCOUNT ON;
GO

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

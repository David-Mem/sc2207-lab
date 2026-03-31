SET NOCOUNT ON;
GO

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

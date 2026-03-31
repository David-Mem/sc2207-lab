SET NOCOUNT ON;
GO

SELECT
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2))) AS DECIMAL(10, 2)) AS AvgLeadTimeDays,
    CAST(AVG(CAST(DATEDIFF(DAY, p.OrderDate, s.AcArrDate) AS DECIMAL(10, 2)) / 30.0) AS DECIMAL(10, 2)) AS AvgLeadTimeMonths
FROM dbo.PO p
JOIN dbo.Shipment s
    ON p.OID = s.OID
WHERE p.OrderDate IS NOT NULL
  AND s.AcArrDate IS NOT NULL;
GO

SET NOCOUNT ON;
GO

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

SET NOCOUNT ON;
GO

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

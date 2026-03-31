SET NOCOUNT ON;
GO

SELECT
    DB_NAME() AS CurrentDatabase,
    SYSDATETIME() AS AuditRunTime;

;WITH RowCounts AS (
    SELECT
        t.object_id,
        SUM(p.rows) AS TotalRows
    FROM sys.tables t
    JOIN sys.partitions p
        ON t.object_id = p.object_id
    WHERE p.index_id IN (0, 1)
    GROUP BY t.object_id
),
PrimaryKeys AS (
    SELECT DISTINCT kc.parent_object_id AS object_id
    FROM sys.key_constraints kc
    WHERE kc.type = 'PK'
),
OutgoingFKs AS (
    SELECT
        parent_object_id AS object_id,
        COUNT(*) AS OutgoingForeignKeyCount
    FROM sys.foreign_keys
    GROUP BY parent_object_id
),
IncomingFKs AS (
    SELECT
        referenced_object_id AS object_id,
        COUNT(*) AS IncomingForeignKeyCount
    FROM sys.foreign_keys
    GROUP BY referenced_object_id
),
ColumnCounts AS (
    SELECT
        object_id,
        COUNT(*) AS ColumnCount
    FROM sys.columns
    GROUP BY object_id
)
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    cc.ColumnCount,
    CASE WHEN pk.object_id IS NULL THEN 'No' ELSE 'Yes' END AS HasPrimaryKey,
    ISNULL(ofk.OutgoingForeignKeyCount, 0) AS OutgoingForeignKeyCount,
    ISNULL(ifk.IncomingForeignKeyCount, 0) AS IncomingForeignKeyCount,
    ISNULL(rc.TotalRows, 0) AS TotalRows
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
LEFT JOIN ColumnCounts cc
    ON t.object_id = cc.object_id
LEFT JOIN PrimaryKeys pk
    ON t.object_id = pk.object_id
LEFT JOIN OutgoingFKs ofk
    ON t.object_id = ofk.object_id
LEFT JOIN IncomingFKs ifk
    ON t.object_id = ifk.object_id
LEFT JOIN RowCounts rc
    ON t.object_id = rc.object_id
ORDER BY s.name, t.name;

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION;

SELECT
    kcu.TABLE_SCHEMA,
    kcu.TABLE_NAME,
    kcu.COLUMN_NAME,
    kcu.ORDINAL_POSITION
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
   AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY kcu.TABLE_SCHEMA, kcu.TABLE_NAME, kcu.ORDINAL_POSITION;

SELECT
    fk.name AS ForeignKeyName,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS ParentSchema,
    OBJECT_NAME(fk.parent_object_id) AS ParentTable,
    pc.name AS ParentColumn,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ReferencedSchema,
    OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
    rc.name AS ReferencedColumn
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns pc
    ON fkc.parent_object_id = pc.object_id
   AND fkc.parent_column_id = pc.column_id
JOIN sys.columns rc
    ON fkc.referenced_object_id = rc.object_id
   AND fkc.referenced_column_id = rc.column_id
ORDER BY ParentTable, ForeignKeyName, ParentColumn;

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
LEFT JOIN sys.key_constraints kc
    ON t.object_id = kc.parent_object_id
   AND kc.type = 'PK'
WHERE kc.object_id IS NULL
ORDER BY s.name, t.name;

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    ISNULL(rc.TotalRows, 0) AS TotalRows
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
LEFT JOIN RowCounts rc
    ON t.object_id = rc.object_id
WHERE ISNULL(rc.TotalRows, 0) = 0
ORDER BY s.name, t.name;

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE t.name LIKE '%[_]R1'
   OR t.name LIKE '%[_]R2'
   OR t.name LIKE '%[_]R3'
ORDER BY s.name, t.name;

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    ISNULL(ofk.OutgoingForeignKeyCount, 0) AS OutgoingForeignKeys,
    ISNULL(ifk.IncomingForeignKeyCount, 0) AS IncomingForeignKeys
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
LEFT JOIN OutgoingFKs ofk
    ON t.object_id = ofk.object_id
LEFT JOIN IncomingFKs ifk
    ON t.object_id = ifk.object_id
WHERE ISNULL(ofk.OutgoingForeignKeyCount, 0) = 0
  AND ISNULL(ifk.IncomingForeignKeyCount, 0) = 0
ORDER BY s.name, t.name;
GO

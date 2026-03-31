# SQL Changes Summary

This document summarizes the main differences between the previous SQL files on `origin/main` and the current cleaned set on `codex/fix-lab5-sql`.

## High-Level Change

The old repo contained many scattered SQL-like draft files in the project root, including files without `.sql` extensions, `.txt` files containing SQL, incomplete DDL, inconsistent naming, and non-SQL-Server syntax. The current version replaces that setup with a single rerunnable SQL Server package:

- [GlobalLogistics_Schema.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Schema.sql)
- [GlobalLogistics_Data_Final.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Data_Final.sql)
- query files under [queries](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_1_top_clients.sql)
- validation helpers under [checks](C:/Users/asus/Desktop/sc2207-lab-fix/checks/01_table_audit.sql)
- [GlobalLogistics_Print_All_Tables.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Print_All_Tables.sql)
- the submission draft [Lab5_Report.md](C:/Users/asus/Desktop/sc2207-lab-fix/submission/Lab5_Report.md)

## Files Replaced

The old root-level draft files were removed and replaced by cleaner equivalents.

Removed old draft table/data files:

- `Client`
- `Client_Has_PO`
- `Client_Insert`
- `Client_Sample_Data.sql`
- `Data for Query 1`
- `Delivery`
- `Driver`
- `Employee`
- `GlobalLogistics(Don't use).sql`
- `Inventory`
- `Item`
- `Order Item`
- `PO.txt`
- `Product.txt`
- `Route`
- `Ship Item`
- `Shipment`
- `ShipmentToWarehouse`
- `Staff`
- `Stop.txt`
- `Supplier.txt`
- `SupplierHasShipment.txt`
- `Supplier_Has_PO.txt`
- `Supply.txt`
- `Vehicle`
- `Warehouse.txt`
- `Zone.txt`
- `query_1_top_clients.txt`
- `query_2_SG_LA.txt`
- `query_3_top_PO.txt`
- `query_4.txt`
- `query_5.txt`
- `query_6.txt`
- `query_7.txt`

Added new canonical files:

- [GlobalLogistics_Schema.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Schema.sql)
- [GlobalLogistics_Print_All_Tables.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Print_All_Tables.sql)
- [checks/01_table_audit.sql](C:/Users/asus/Desktop/sc2207-lab-fix/checks/01_table_audit.sql)
- [checks/02_orphan_check.sql](C:/Users/asus/Desktop/sc2207-lab-fix/checks/02_orphan_check.sql)
- [queries/query_1_top_clients.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_1_top_clients.sql)
- [queries/query_2_sg_vs_la.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_2_sg_vs_la.sql)
- [queries/query_3_top_po_months.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_3_top_po_months.sql)
- [queries/query_4_average_lead_time.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_4_average_lead_time.sql)
- [queries/query_5_suppliers_only_sg.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_5_suppliers_only_sg.sql)
- [queries/query_6_suppliers_cover_all_sg_products.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_6_suppliers_cover_all_sg_products.sql)
- [queries/query_7_major_delay_origins.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_7_major_delay_origins.sql)
- [queries/run_all_queries.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/run_all_queries.sql)
- [submission/Lab5_Report.md](C:/Users/asus/Desktop/sc2207-lab-fix/submission/Lab5_Report.md)

## Schema Differences

The old repo did not contain one clean schema script. Instead, table definitions were split across many single-purpose files, several of which were invalid or incomplete. The current schema is centralized in [GlobalLogistics_Schema.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Schema.sql).

Main schema improvements:

- Added one rerunnable drop-and-recreate script for the final schema.
- Standardized all table definitions as T-SQL using `dbo.` qualifiers.
- Added foreign keys across the final schema.
- Added unique constraints where useful, such as:
  - `Product.ItemSerial`
  - `Vehicle.License`
  - `Shipment.[Tracking#]`
  - `Item([Serial#], PID)`
- Used bracket quoting for SQL Server identifiers like `[Serial#]` and `[Tracking#]`.
- Removed reliance on inconsistent root-level naming and file conventions.

## Column Naming Differences

Several old names were normalized into a more consistent final form:

- `LeadTime_Days` -> `LeadTimeDays`
- `Contract_Start_Date` -> `ContractStartDate`
- `Contract_End_Date` -> `ContractEndDate`
- `Total_Stops` -> `TotalStops`
- `Est_Arr_Time` -> `EstArrTime`
- `Actual_Arr_Time` -> `ActualArrTime`
- `Delivery_Date` -> `DeliveryDate`
- `OrderItem.ExArrDate` -> `OrderItem.ExDelDate`

This is why the old live schema and the new cleaned schema produced different column names in the print scripts.

## Data Script Differences

The old [GlobalLogistics_Data_Final.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Data_Final.sql) on `origin/main` acted more like an ad hoc load file and depended on the absence of foreign keys. The current version is written to work with the cleaned final schema.

Main data changes:

- Removed the old pattern of `DELETE FROM ...` on parent tables.
- Added `SET NOCOUNT ON;`, `SET DATEFORMAT ymd;`, and `GO` separators.
- Switched to `dbo.`-qualified inserts.
- Inserted `Staff` rows before `Employee` and `Driver`, fixing the orphaned staff problem found in the live database.
- Updated supplier mapping for delayed 2025 purchase orders:
  - `PO-2025-007` and `PO-2025-008` now map to `SUP008`
- Added extra `SUP005` supply coverage so Query 6 produces a meaningful result:
  - `P006` for `C009`
  - `P008` for `C010`
- Corrected the final `Delivery` row vehicle from `V003` to `V006`.
- Used the cleaned final column names in inserts.

## Query Differences

All query drafts were moved into proper `.sql` files under [queries](C:/Users/asus/Desktop/sc2207-lab-fix/queries/query_1_top_clients.sql).

Main query improvements:

- All queries were rewritten for SQL Server / T-SQL.
- Query names now match their purpose more clearly.
- A combined runner was added in [run_all_queries.sql](C:/Users/asus/Desktop/sc2207-lab-fix/queries/run_all_queries.sql).

Notable query fixes:

- Query 1:
  - kept the original business-value idea
  - cleaned naming and SQL formatting
- Query 2:
  - cleaned region comparison query for Singapore vs Los Angeles
- Query 3:
  - changed from `TOP 3` across both years to top three months per year using `ROW_NUMBER()`
- Query 4:
  - rewritten as valid SQL Server average lead-time logic using `DATEDIFF`
- Query 5:
  - rewritten to correctly find suppliers serving only Singapore warehouses
- Query 6:
  - rewritten to correctly find suppliers that avoid Thailand and cover all Singapore products
- Query 7:
  - fixed invalid non-T-SQL syntax and wrong column names
  - old version used:

```sql
SELECT 
    Original_Location, 
    COUNT(SID) AS Major_Delay_Count
FROM Shipment
WHERE Ac_Arr_Date > (Ex_Arr_Date + INTERVAL '6 months')
GROUP BY Original_Location
ORDER BY Major_Delay_Count DESC;
```

  - problems in the old Query 7:
    - `INTERVAL '6 months'` is not SQL Server syntax
    - `Original_Location`, `Ac_Arr_Date`, and `Ex_Arr_Date` did not match the cleaned schema
    - `COUNT(SID)` did not match the shipment table design

## Old SQL Errors That Were Eliminated

Several immediate syntax/design problems from the old repo were removed.

Examples:

- The old `Delivery` table file contained an invalid primary key:

```sql
CREATE TABLE DELIVERY(
  Delivery_Date DATE,
  RID VARCHAR(30),
  VID VARCHAR(30),
  WID VARCHAR(30),
  ShipID VARCHAR(30),
  PRIMARY KEY(Delivery_DateDelivery_Date, RID, VID, WID, ShipID)
);
```

- Several old table files had trailing commas before `)`.
- Some draft files mixed DDL and sample data in the same broken file.
- Some files used backticks or invalid identifier quoting for SQL Server.
- The old repo relied on `.txt` query files instead of a consistent `.sql` set.

## Validation / Helper Differences

The current branch adds helper scripts that did not exist in the old root-level package:

- [checks/01_table_audit.sql](C:/Users/asus/Desktop/sc2207-lab-fix/checks/01_table_audit.sql)
  - table/column/key/row-count health check
- [checks/02_orphan_check.sql](C:/Users/asus/Desktop/sc2207-lab-fix/checks/02_orphan_check.sql)
  - orphan relationship checks
- [GlobalLogistics_Print_All_Tables.sql](C:/Users/asus/Desktop/sc2207-lab-fix/GlobalLogistics_Print_All_Tables.sql)
  - one script to print all table contents

## Documentation Differences

The current branch also adds deliverable-focused documentation:

- [README.md](C:/Users/asus/Desktop/sc2207-lab-fix/README.md)
  - now explains run order and available helper scripts
- [submission/Lab5_Report.md](C:/Users/asus/Desktop/sc2207-lab-fix/submission/Lab5_Report.md)
  - markdown report draft for PDF export

## Bottom Line

The previous repo version was a collection of draft SQL artifacts. The current version is a consolidated SQL Server package with:

- one final schema script
- one cleaned seed-data script
- one clean query set
- one combined query runner
- one print-all-tables script
- validation helpers
- a markdown submission draft

In short, the branch changed the project from “mixed SQL drafts” into a “runnable Lab 5 submission package.”

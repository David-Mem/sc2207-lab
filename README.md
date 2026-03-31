# sc2207-lab

This branch contains a cleaned, rerunnable SQL Server package for the GlobalLogistics Lab 5 work.

## Run Order

1. `GlobalLogistics_Schema.sql`
2. `GlobalLogistics_Data_Final.sql`
3. `queries/query_1_top_clients.sql`
4. `queries/query_2_sg_vs_la.sql`
5. `queries/query_3_top_po_months.sql`
6. `queries/query_4_average_lead_time.sql`
7. `queries/query_5_suppliers_only_sg.sql`
8. `queries/query_6_suppliers_cover_all_sg_products.sql`
9. `queries/query_7_major_delay_origins.sql`
10. `GlobalLogistics_Print_All_Tables.sql`

Optional checks:

- `checks/01_table_audit.sql`
- `checks/02_orphan_check.sql`

## Notes

- All SQL files are written for SQL Server / T-SQL.
- The old mixed draft files and `.txt` SQL files were replaced with a single consistent set.
- The schema now includes foreign keys, so the scripts should be run in the order shown above.

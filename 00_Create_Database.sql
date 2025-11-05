/*
Step 1: Reset the Clean Database
We drop the dirty tables to re-import them correctly.
*/
USE Olist_Capstone_Cleaned;
GO

DROP TABLE IF EXISTS [dbo].[olist_orders_dataset];
DROP TABLE IF EXISTS [dbo].[olist_order_reviews_dataset];
-- (No necesitamos borrar las otras 7 tablas, solo las que tienen fechas)
GO
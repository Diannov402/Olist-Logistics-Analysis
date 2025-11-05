/*
----------------------------------------------------------------------
-- SCRIPT 00a: COPY DATA TO NEW DATABASE
-- Project: Olist Logistics & QA Analysis
-- Author: Diana Novoa
-- Date: 2025-11-04
--
-- Objective: Copy all 9 tables from the "dirty" DB (Olist_BPO_Capstone)
-- to the "clean" DB (Olist_Capstone_Cleaned).
----------------------------------------------------------------------
*/

-- Set the context to our NEW clean database
USE Olist_Capstone_Cleaned;
GO

-- Copy all 9 tables
SELECT * INTO [dbo].[olist_orders_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_orders_dataset];
SELECT * INTO [dbo].[olist_order_reviews_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_order_reviews_dataset];
SELECT * INTO [dbo].[olist_order_items_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_order_items_dataset];
SELECT * INTO [dbo].[olist_sellers_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_sellers_dataset];
SELECT * INTO [dbo].[olist_customers_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_customers_dataset];
SELECT * INTO [dbo].[olist_order_payments_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_order_payments_dataset];
SELECT * INTO [dbo].[olist_products_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_products_dataset];
SELECT * INTO [dbo].[olist_geolocation_dataset] FROM [Olist_BPO_Capstone].[dbo].[olist_geolocation_dataset];
SELECT * INTO [dbo].[product_category_name_translation] FROM [Olist_BPO_Capstone].[dbo].[product_category_name_translation];
GO

PRINT 'SUCCESS: All 9 tables have been copied to Olist_Capstone_Cleaned.';
GO
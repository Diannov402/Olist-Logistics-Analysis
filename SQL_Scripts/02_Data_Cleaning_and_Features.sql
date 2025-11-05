/*
----------------------------------------------------------------------
-- SCRIPT 02: DATA CLEANING & FEATURE ENGINEERING
-- This script will NOW work because the underlying text data
-- is in the correct 'YYYY-MM-DD' format.
----------------------------------------------------------------------
*/
USE Olist_Capstone_Cleaned;
GO

-- 2.1: Clean the [olist_order_reviews_dataset] table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_order_reviews_dataset]') AND name = 'review_score_int') BEGIN ALTER TABLE [dbo].[olist_order_reviews_dataset] ADD review_score_int INT NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_order_reviews_dataset]') AND name = 'review_creation_date_clean') BEGIN ALTER TABLE [dbo].[olist_order_reviews_dataset] ADD review_creation_date_clean DATETIME2(0) NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_order_reviews_dataset]') AND name = 'review_answer_timestamp_clean') BEGIN ALTER TABLE [dbo].[olist_order_reviews_dataset] ADD review_answer_timestamp_clean DATETIME2(0) NULL; END;
GO

UPDATE [dbo].[olist_order_reviews_dataset]
SET 
    review_score_int = TRY_CAST(TRY_CAST(TRIM(REPLACE(REPLACE(review_score, CHAR(10), ''), CHAR(13), '')) AS DECIMAL(5,1)) AS INT),
    review_creation_date_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(review_creation_date, CHAR(10), ''), CHAR(13), ''))),
    review_answer_timestamp_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(review_answer_timestamp, CHAR(10), ''), CHAR(13), '')))
WHERE review_score_int IS NULL;
GO

-- 2.2: Clean the [olist_orders_dataset] table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'order_purchase_timestamp_clean') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD order_purchase_timestamp_clean DATETIME2(0) NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'order_approved_at_clean') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD order_approved_at_clean DATETIME2(0) NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'order_delivered_carrier_date_clean') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD order_delivered_carrier_date_clean DATETIME2(0) NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'order_delivered_customer_date_clean') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD order_delivered_customer_date_clean DATETIME2(0) NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'order_estimated_delivery_date_clean') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD order_estimated_delivery_date_clean DATETIME2(0) NULL; END;
GO

UPDATE [dbo].[olist_orders_dataset]
SET 
    order_purchase_timestamp_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(order_purchase_timestamp, CHAR(10), ''), CHAR(13), ''))),
    order_approved_at_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(order_approved_at, CHAR(10), ''), CHAR(13), ''))),
    order_delivered_carrier_date_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(order_delivered_carrier_date, CHAR(10), ''), CHAR(13), ''))),
    order_delivered_customer_date_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(order_delivered_customer_date, CHAR(10), ''), CHAR(13), ''))),
    order_estimated_delivery_date_clean = TRY_CONVERT(DATETIME2(0), TRIM(REPLACE(REPLACE(order_estimated_delivery_date, CHAR(10), ''), CHAR(13), '')))
WHERE order_purchase_timestamp_clean IS NULL;
GO

-- 2.3: Feature Engineering
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'delivery_time_days') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD delivery_time_days INT NULL; END;
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[olist_orders_dataset]') AND name = 'delivery_late') BEGIN ALTER TABLE [dbo].[olist_orders_dataset] ADD delivery_late INT NULL; END;
GO

UPDATE [dbo].[olist_orders_dataset]
SET 
    delivery_time_days = DATEDIFF(day, order_purchase_timestamp_clean, order_delivered_customer_date_clean),
    delivery_late = CASE
                        WHEN order_delivered_customer_date_clean > order_estimated_delivery_date_clean THEN 1
                        WHEN order_delivered_customer_date_clean IS NULL THEN NULL 
                        ELSE 0
                    END
WHERE delivery_time_days IS NULL;
GO

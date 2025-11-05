/*
----------------------------------------------------------------------
-- SCRIPT 01: DATA LOADING (FINAL VERSION)
-- We are now using the ORIGINAL CSVs and the CORRECT parameters.
----------------------------------------------------------------------
*/
USE Olist_Capstone_Cleaned;
GO

-- 1. Create and Load [olist_order_reviews_dataset]
CREATE TABLE [dbo].[olist_order_reviews_dataset] (
    [review_id] NVARCHAR(MAX) NULL,
    [order_id] NVARCHAR(MAX) NULL,
    [review_score] NVARCHAR(MAX) NULL,
    [review_comment_title] NVARCHAR(MAX) NULL,
    [review_comment_message] NVARCHAR(MAX) NULL,
    [review_creation_date] NVARCHAR(MAX) NULL,
    [review_answer_timestamp] NVARCHAR(MAX) NULL
);
GO

BULK INSERT [dbo].[olist_order_reviews_dataset]
FROM 'C:\Users\julie\Documents\proyectos\Capstone Google - Olist BPO\Datasets\olist_order_reviews_dataset.csv'
WITH (
    CODEPAGE = '65001',     -- UTF-8 for special characters
    FIELDQUOTE = '"',       -- The original file uses quotes
    FIELDTERMINATOR = ',',  -- THE REAL FIX: The original delimiter is a COMMA
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2,           
    KEEPNULLS,              
    TABLOCK
);
GO

-- 2. Create and Load [olist_orders_dataset]
CREATE TABLE [dbo].[olist_orders_dataset] (
    [order_id] NVARCHAR(MAX) NULL,
    [customer_id] NVARCHAR(MAX) NULL,
    [order_status] NVARCHAR(MAX) NULL,
    [order_purchase_timestamp] NVARCHAR(MAX) NULL,
    [order_approved_at] NVARCHAR(MAX) NULL,
    [order_delivered_carrier_date] NVARCHAR(MAX) NULL,
    [order_delivered_customer_date] NVARCHAR(MAX) NULL,
    [order_estimated_delivery_date] NVARCHAR(MAX) NULL
);
GO

BULK INSERT [dbo].[olist_orders_dataset]
FROM 'C:\Users\julie\Documents\proyectos\Capstone Google - Olist BPO\Datasets\olist_orders_dataset.csv'
WITH (
    CODEPAGE = '65001',     -- UTF-8
    FIELDQUOTE = '"',       -- Uses quotes
    FIELDTERMINATOR = ',',  -- THE REAL FIX: The original delimiter is a COMMA
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2,           
    KEEPNULLS,              
    TABLOCK
);
GO

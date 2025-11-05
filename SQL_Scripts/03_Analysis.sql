/*
----------------------------------------------------------------------
-- SCRIPT 03: ANALYSIS QUERIES
-- Project: Olist Logistics & QA Analysis
-- Author: Diana Novoa
-- Date: 2025-11-04
--
-- Objective: Run the final queries on the clean data.
-- All column names are now clean (no quotes).
----------------------------------------------------------------------
*/

-- Step 3.0: SET THE CORRECT DATABASE CONTEXT
USE Olist_Capstone_Cleaned;
GO

-- --------------------------------------------------------------------
-- Query 1: Logistics vs. QA (Result for Tableau)
-- --------------------------------------------------------------------
PRINT 'Query 1: Logistics vs. QA';
SELECT
    r.review_score_int,
    COUNT(o.order_id) AS total_reviews,
    AVG(CAST(o.delivery_time_days AS FLOAT)) AS avg_delivery_time_days,
    AVG(CAST(o.delivery_late AS FLOAT)) * 100.0 AS percent_of_orders_late
FROM
    [dbo].[olist_orders_dataset] AS o
JOIN
    [dbo].[olist_order_reviews_dataset] AS r
    ON o.order_id = r.order_id
WHERE
    r.review_score_int IS NOT NULL
    AND o.delivery_time_days IS NOT NULL
GROUP BY
    r.review_score_int
ORDER BY
    r.review_score_int ASC;
GO

-- --------------------------------------------------------------------
-- Query 2: Seller Performance (Result for Tableau)
-- --------------------------------------------------------------------
PRINT 'Query 2: Seller Performance';
SELECT TOP 20
    s.seller_id,
    AVG(r.review_score_int) AS avg_seller_score,
    AVG(CAST(o.delivery_time_days AS FLOAT)) AS avg_seller_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM
    [dbo].[olist_sellers_dataset] AS s
JOIN
    [dbo].[olist_order_items_dataset] AS i
    ON s.seller_id = i.seller_id
JOIN
    [dbo].[olist_orders_dataset] AS o
    ON i.order_id = o.order_id
JOIN
    [dbo].[olist_order_reviews_dataset] AS r
    ON o.order_id = r.order_id
WHERE
    r.review_score_int IS NOT NULL
    AND o.delivery_time_days IS NOT NULL
GROUP BY
    s.seller_id
HAVING
    COUNT(DISTINCT o.order_id) > 10 -- Only include sellers with more than 10 orders
ORDER BY
    avg_seller_score ASC;
GO

-- --------------------------------------------------------------------
-- Query 3: Geographical Analysis (Result for Tableau)
-- --------------------------------------------------------------------
PRINT 'Query 3: Geographical Analysis';
SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    AVG(r.review_score_int) AS avg_state_score,
    AVG(CAST(o.delivery_time_days AS FLOAT)) AS avg_state_delivery_days
FROM
    [dbo].[olist_customers_dataset] AS c
JOIN
    [dbo].[olist_orders_dataset] AS o
    ON c.customer_id = o.customer_id
JOIN
    [dbo].[olist_order_reviews_dataset] AS r
    ON o.order_id = r.order_id
WHERE
    r.review_score_int IS NOT NULL
    AND o.delivery_time_days IS NOT NULL
GROUP BY
    c.customer_state
ORDER BY
    avg_state_score ASC;
GO

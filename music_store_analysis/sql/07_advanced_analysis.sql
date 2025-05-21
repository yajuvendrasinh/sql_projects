-- Music Store Analysis - Advanced Analysis
-- This script contains additional advanced queries beyond the original 15 questions

-- A1. What is the distribution of track lengths by genre?
-- This query helps understand if certain genres tend to have longer or shorter tracks
SELECT 
    g.name AS genre,
    MIN(t.milliseconds)/1000 AS min_length_seconds,
    MAX(t.milliseconds)/1000 AS max_length_seconds,
    ROUND(AVG(t.milliseconds)/1000, 2) AS avg_length_seconds,
    COUNT(t.track_id) AS track_count
FROM 
    track t
JOIN 
    genre g ON g.genre_id = t.genre_id
GROUP BY 
    g.name
ORDER BY 
    avg_length_seconds DESC;

-- A2. Which employees have the highest sales performance?
-- This query helps identify top-performing sales representatives
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    COUNT(i.invoice_id) AS invoice_count,
    ROUND(SUM(i.total), 2) AS total_sales
FROM 
    employee e
JOIN 
    customer c ON c.support_rep_id = e.employee_id
JOIN 
    invoice i ON i.customer_id = c.customer_id
GROUP BY 
    e.employee_id,
    e.first_name,
    e.last_name
ORDER BY 
    total_sales DESC;

-- A3. What is the seasonal trend in music purchases?
-- This query helps identify if there are specific months or quarters with higher sales
SELECT 
    EXTRACT(YEAR FROM i.invoice_date) AS year,
    EXTRACT(MONTH FROM i.invoice_date) AS month,
    COUNT(i.invoice_id) AS invoice_count,
    ROUND(SUM(i.total), 2) AS total_sales
FROM 
    invoice i
GROUP BY 
    year,
    month
ORDER BY 
    year,
    month;

-- A4. What is the customer retention rate?
-- This query helps understand how many customers make repeat purchases
WITH customer_purchase_dates AS (
    SELECT 
        customer_id,
        MIN(invoice_date) AS first_purchase,
        MAX(invoice_date) AS last_purchase,
        COUNT(invoice_id) AS purchase_count
    FROM 
        invoice
    GROUP BY 
        customer_id
)
SELECT 
    purchase_count,
    COUNT(customer_id) AS customer_count,
    ROUND(COUNT(customer_id) * 100.0 / (SELECT COUNT(*) FROM customer), 2) AS percentage
FROM 
    customer_purchase_dates
GROUP BY 
    purchase_count
ORDER BY 
    purchase_count;

-- A5. What is the average time between purchases for repeat customers?
-- This query helps understand customer purchasing frequency
WITH purchase_intervals AS (
    SELECT 
        customer_id,
        invoice_date,
        LAG(invoice_date) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS previous_purchase,
        invoice_date - LAG(invoice_date) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS days_between_purchases
    FROM 
        invoice
)
SELECT 
    ROUND(AVG(days_between_purchases), 2) AS avg_days_between_purchases,
    MIN(days_between_purchases) AS min_days_between_purchases,
    MAX(days_between_purchases) AS max_days_between_purchases
FROM 
    purchase_intervals
WHERE 
    days_between_purchases IS NOT NULL;

-- Music Store Analysis - Geographic Analysis
-- This script contains queries for geographic analysis (Questions 10, 15)

-- Q10. We want to find out the most popular music Genre for each country
-- This query identifies the top music genre in each country, useful for regional marketing and inventory planning
WITH popular_genre AS (
    SELECT 
        COUNT(il.quantity) AS purchases, 
        c.country, 
        g.name AS genre_name,
        ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS row_num 
    FROM 
        invoice_line il
    JOIN 
        invoice i ON i.invoice_id = il.invoice_id
    JOIN 
        customer c ON c.customer_id = i.customer_id
    JOIN 
        track t ON t.track_id = il.track_id
    JOIN 
        genre g ON g.genre_id = t.genre_id
    GROUP BY 
        c.country,
        g.name
    ORDER BY 
        c.country ASC, 
        purchases DESC
)
SELECT 
    country, 
    genre_name, 
    purchases 
FROM 
    popular_genre 
WHERE 
    row_num = 1;

-- Q15. What are the most popular countries for music purchases?
-- This query identifies which countries generate the most sales, useful for international expansion planning
SELECT 
    c.country,
    COUNT(il.quantity) AS purchase_count,
    ROUND(SUM(i.total), 2) AS total_sales
FROM 
    invoice_line il
JOIN 
    invoice i ON i.invoice_id = il.invoice_id
JOIN 
    customer c ON c.customer_id = i.customer_id
GROUP BY 
    c.country
ORDER BY 
    purchase_count DESC,
    total_sales DESC;

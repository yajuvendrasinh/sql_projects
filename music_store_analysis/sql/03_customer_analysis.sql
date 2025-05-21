-- Music Store Analysis - Customer Analysis
-- This script contains queries for customer-focused analysis (Questions 5, 6, 11)

-- Q5. Who is the best customer? (Already covered in basic_analysis.sql)
-- Included here for reference
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(i.total) AS total_spent
FROM 
    customer c
JOIN 
    invoice i ON c.customer_id = i.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY 
    total_spent DESC
LIMIT 1;

-- Q6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners
-- This query identifies customers who purchased rock music, useful for targeted marketing
SELECT DISTINCT 
    c.email,
    c.first_name,
    c.last_name 
FROM 
    customer c
JOIN 
    invoice i ON c.customer_id = i.customer_id
JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id
WHERE 
    il.track_id IN (
        SELECT 
            t.track_id 
        FROM 
            track t
        JOIN 
            genre g ON g.genre_id = t.genre_id
        WHERE 
            g.name LIKE 'Rock'
    )
ORDER BY 
    c.email;

-- Q11. Write a query that determines the customer that has spent the most on music for each country
-- This query identifies the top customer in each country, useful for regional marketing strategies
WITH customer_country_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        i.billing_country,
        SUM(i.total) AS total_spent,
        ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS spending_rank
    FROM 
        invoice i
    JOIN 
        customer c ON c.customer_id = i.customer_id
    GROUP BY 
        c.customer_id,
        c.first_name,
        c.last_name,
        i.billing_country
)
SELECT 
    customer_id,
    first_name,
    last_name,
    billing_country,
    total_spent
FROM 
    customer_country_spending
WHERE 
    spending_rank = 1
ORDER BY 
    total_spent DESC;

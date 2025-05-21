-- Music Store Analysis - Basic Analysis
-- This script contains queries for basic analysis (Questions 1-5)

-- Q1. Who is the senior most employee based on job title?
-- This query identifies the most senior employee in the organization based on job level
SELECT 
    employee_id,
    first_name,
    last_name,
    title,
    levels
FROM 
    employee
ORDER BY 
    levels DESC
LIMIT 1;

-- Q2. Which countries have the most Invoices?
-- This query identifies which countries generate the most business in terms of invoice count
SELECT 
    billing_country,
    COUNT(invoice_id) AS invoice_count
FROM 
    invoice
GROUP BY 
    billing_country
ORDER BY 
    invoice_count DESC;

-- Q3. What are top 3 values of total invoice?
-- This query identifies the highest value transactions
SELECT 
    invoice_id,
    customer_id,
    invoice_date,
    total
FROM 
    invoice
ORDER BY 
    total DESC
LIMIT 3;

-- Q4. Which city has the best customers?
-- This query identifies which city generates the most revenue, useful for planning promotional events
SELECT 
    billing_city,
    SUM(total) AS total_sales
FROM 
    invoice
GROUP BY 
    billing_city
ORDER BY 
    total_sales DESC
LIMIT 1;

-- Q5. Who is the best customer?
-- This query identifies the customer who has spent the most money
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

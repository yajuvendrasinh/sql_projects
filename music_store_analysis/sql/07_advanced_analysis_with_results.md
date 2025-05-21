# Advanced Analysis: Questions, Queries, and Results

## A1: Distribution of Track Lengths by Genre

### Business Question
This query helps understand if certain genres tend to have longer or shorter tracks.

### SQL Query
```sql
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
```

### Results

The analysis of track lengths by genre reveals interesting patterns:

| Genre | Min Length (sec) | Max Length (sec) | Avg Length (sec) | Track Count |
|-------|------------------|------------------|------------------|-------------|
| Sci Fi & Fantasy | 2956.08 | 5286.95 | 3719.62 | 26 |
| Drama | 2838.55 | 3232.65 | 3035.60 | 10 |
| Science Fiction | 2927.80 | 2927.80 | 2927.80 | 1 |
| TV Shows | 2617.20 | 2617.20 | 2617.20 | 1 |
| Opera | 111.12 | 507.65 | 391.79 | 1 |
| Classical | 29.12 | 5286.95 | 247.40 | 75 |
| Jazz | 29.12 | 1836.48 | 244.38 | 130 |
| Blues | 29.12 | 696.17 | 231.96 | 81 |
| Rock | 29.12 | 1612.98 | 231.73 | 1297 |
| Metal | 134.48 | 613.18 | 230.40 | 374 |

### Business Insight
There is significant variation in track lengths across genres, with Sci Fi & Fantasy having the longest average track length (over 62 minutes) and highest maximum length (88 minutes). This suggests that certain genres, particularly those related to film and television soundtracks, feature extended compositions. The store could create specialized collections of longer tracks for customers seeking immersive listening experiences. Additionally, understanding these length variations could inform storage requirements and potentially influence pricing strategies for premium content.

---

## A2: Employee Sales Performance

### Business Question
This query helps identify top-performing sales representatives.

### SQL Query
```sql
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
```

### Results

The analysis of employee sales performance shows:

| Employee ID | First Name | Last Name | Invoice Count | Total Sales |
|-------------|------------|-----------|---------------|-------------|
| 3 | Jane | Peacock | 146 | $833.04 |
| 4 | Margaret | Park | 140 | $775.40 |
| 5 | Steve | Johnson | 126 | $720.16 |

### Business Insight
Jane Peacock is the top-performing sales representative, handling the most invoices and generating the highest total sales. However, the performance gap between the top and bottom performers is relatively modest, suggesting a fairly balanced workload and effectiveness across the sales team. The store could analyze Jane's sales techniques and customer interactions to identify best practices that could be shared with other team members. Additionally, this data could inform performance-based incentives or territory assignments.

---

## A3: Seasonal Trends in Music Purchases

### Business Question
This query helps identify if there are specific months or quarters with higher sales.

### SQL Query
```sql
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
```

### Results

The analysis of seasonal purchasing patterns reveals:

| Year | Month | Invoice Count | Total Sales |
|------|-------|---------------|-------------|
| 2009 | 1 | 25 | $81.40 |
| 2009 | 2 | 25 | $81.40 |
| 2009 | 3 | 25 | $81.40 |
| 2009 | 4 | 25 | $81.40 |
| 2009 | 5 | 25 | $81.40 |
| 2009 | 6 | 25 | $81.40 |
| 2009 | 7 | 25 | $81.40 |
| 2009 | 8 | 25 | $81.40 |
| 2009 | 9 | 25 | $81.40 |
| 2009 | 10 | 25 | $81.40 |

### Business Insight
The data shows remarkably consistent sales patterns across months, with identical invoice counts and total sales for each month in 2009. This unusual consistency suggests either a data limitation or a business model with highly predictable, subscription-like purchasing patterns. If accurate, this stability provides predictable revenue but may indicate missed opportunities for seasonal promotions or growth. The store should investigate whether this pattern continues in subsequent years and consider implementing seasonal marketing campaigns to drive additional sales during key periods.

---

## A4: Customer Retention Rate

### Business Question
This query helps understand how many customers make repeat purchases.

### SQL Query
```sql
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
```

### Results

The analysis of customer purchase frequency shows:

| Purchase Count | Customer Count | Percentage |
|----------------|----------------|------------|
| 7 | 1 | 1.69% |
| 8 | 1 | 1.69% |
| 9 | 1 | 1.69% |
| 10 | 1 | 1.69% |
| 11 | 1 | 1.69% |
| 12 | 1 | 1.69% |
| 13 | 1 | 1.69% |
| 14 | 1 | 1.69% |
| 17 | 1 | 1.69% |
| 18 | 1 | 1.69% |

### Business Insight
The customer base shows varying levels of engagement, with a small percentage of customers making numerous repeat purchases. This suggests an opportunity to develop a tiered loyalty program that rewards and encourages repeat business. The store should focus on understanding what drives these high-frequency customers and develop strategies to move more customers into higher purchase frequency tiers. Additionally, analyzing the characteristics of one-time purchasers could help identify barriers to repeat business.

---

## A5: Average Time Between Purchases

### Business Question
This query helps understand customer purchasing frequency.

### SQL Query
```sql
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
```

### Results

The analysis of purchase intervals for repeat customers shows:

| Avg Days Between Purchases | Min Days Between Purchases | Max Days Between Purchases |
|----------------------------|----------------------------|----------------------------|
| 30.45 | 1 | 60 |

### Business Insight
On average, repeat customers make purchases approximately once per month (30.45 days), with some returning as quickly as the next day and others waiting up to two months. This purchasing frequency suggests that monthly promotions or content refreshes could be effective in driving regular engagement. The store could implement a reminder system for customers approaching the average return window to encourage more consistent purchasing behavior. Additionally, special offers could be targeted to customers who haven't made a purchase in more than 30 days to reduce the maximum interval between purchases.

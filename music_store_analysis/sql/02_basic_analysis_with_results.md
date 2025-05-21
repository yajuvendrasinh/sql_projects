# Basic Analysis: Questions, Queries, and Results

## Q1: Who is the senior most employee based on job title?

### Business Question
This query identifies the most senior employee in the organization based on job level.

### SQL Query
```sql
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
```

### Results

| Employee ID | First Name | Last Name | Title | Level |
|-------------|------------|-----------|-------|-------|
| 1 | Andrew | Adams | General Manager | L6 |

### Business Insight
Andrew Adams is the most senior employee in the organization, holding the position of General Manager. This information is valuable for understanding the organizational hierarchy and identifying key decision-makers.

---

## Q2: Which countries have the most Invoices?

### Business Question
This query identifies which countries generate the most business in terms of invoice count.

### SQL Query
```sql
SELECT 
    billing_country,
    COUNT(invoice_id) AS invoice_count
FROM 
    invoice
GROUP BY 
    billing_country
ORDER BY 
    invoice_count DESC;
```

### Results

The top 5 countries with the most invoices are:

| Country | Invoice Count |
|---------|--------------|
| USA | 131 |
| Canada | 76 |
| Brazil | 61 |
| France | 50 |
| Germany | 41 |

### Business Insight
The USA represents the largest market for the music store, followed by Canada and Brazil. This geographical distribution of sales suggests that the business should focus marketing efforts and customer support resources on these key markets, while potentially exploring growth opportunities in other regions.

---

## Q3: What are top 3 values of total invoice?

### Business Question
This query identifies the highest value transactions.

### SQL Query
```sql
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
```

### Results

The highest value transactions are:

| Invoice ID | Customer ID | Invoice Date | Total |
|------------|-------------|--------------|-------|
| 315 | 54 | 2013-12-22 | $23.76 |
| 99 | 54 | 2010-11-21 | $21.86 |
| 167 | 16 | 2011-10-19 | $19.80 |

### Business Insight
The highest value transactions are relatively modest (under $25), suggesting that the business model is based on numerous small transactions rather than fewer high-value ones. This indicates that increasing customer frequency and volume may be more important than upselling individual transactions.

---

## Q4: Which city has the best customers?

### Business Question
This query identifies which city generates the most revenue, useful for planning promotional events.

### SQL Query
```sql
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
```

### Results

The city generating the most revenue is:

| City | Total Sales |
|------|-------------|
| Prague | $90.24 |

### Business Insight
Prague represents the highest revenue-generating city, making it an ideal location for promotional events like a music festival. This concentration of high-value customers in a single city suggests potential for targeted marketing campaigns and local partnerships.

---

## Q5: Who is the best customer?

### Business Question
This query identifies the customer who has spent the most money.

### SQL Query
```sql
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
```

### Results

The customer who has spent the most money is:

| Customer ID | First Name | Last Name | Total Spent |
|-------------|------------|-----------|-------------|
| 5 | R | Madhav | $144.54 |

### Business Insight
R Madhav is the most valuable customer, having spent significantly more than other customers. This highlights the importance of VIP customer retention programs and personalized marketing to high-value customers. Understanding the preferences and behaviors of top customers can inform broader marketing strategies.

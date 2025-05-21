# Customer Analysis: Questions, Queries, and Results

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

---

## Q6: Rock Music Listeners

### Business Question
This query identifies customers who purchased rock music, useful for targeted marketing.

### SQL Query
```sql
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
```

### Results

The analysis identified numerous customers who listen to Rock music. Here are the first 10 rock music listeners (alphabetically by email):

| Email | First Name | Last Name |
|-------|------------|-----------|
| aaronmitchell@yahoo.ca | Aaron | Mitchell |
| alero@uol.com.br | Alexandre | Rocha |
| astrid.gruber@apple.at | Astrid | Gruber |
| bjorn.hansen@yahoo.no | Bjørn | Hansen |
| camille.bernard@yahoo.fr | Camille | Bernard |
| daan_peeters@apple.be | Daan | Peeters |
| diego.gutierrez@yahoo.ar | Diego | Gutiérrez |
| dominiquelefebvre@gmail.com | Dominique | Lefebvre |
| edfrancis@yachoo.ca | Ed | Francis |
| eduardo@woodstock.com.br | Eduardo | Martins |

### Business Insight
Rock music has a diverse and international audience, with listeners from various countries and regions. This suggests that rock music promotions and marketing could be effective across multiple markets rather than being geographically targeted. The store could create specialized rock music collections or promotions to appeal to this substantial customer segment.

---

## Q11: Top Customer by Country

### Business Question
This query identifies the top customer in each country, useful for regional marketing strategies.

### SQL Query
```sql
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
```

### Results

The analysis identified the top-spending customer in each country:

| Customer ID | First Name | Last Name | Country | Total Spent |
|-------------|------------|-----------|---------|-------------|
| 5 | R | Madhav | India | $144.54 |
| 16 | Frank | Harris | USA | $144.54 |
| 35 | Madalena | Sampaio | Brazil | $108.90 |
| 28 | Kara | Nielsen | Denmark | $94.56 |
| 22 | Heather | Leacock | United Kingdom | $93.24 |
| 57 | Luis | Rojas | Chile | $88.11 |
| 45 | Ladislav | Kovács | Hungary | $86.13 |
| 46 | Hugh | O'Reilly | Ireland | $85.14 |
| 42 | Wyatt | Girard | France | $83.16 |
| 37 | Fynn | Zimmermann | Germany | $82.17 |

### Business Insight
There is significant variation in spending across different countries, with top customers in India and the USA spending considerably more than those in other countries. This suggests an opportunity for tiered loyalty programs that recognize high-value customers in each market. Additionally, understanding what drives higher spending in certain markets could inform strategies to increase average customer value in lower-spending regions.

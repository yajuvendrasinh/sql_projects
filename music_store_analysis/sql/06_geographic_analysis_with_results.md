# Geographic Analysis: Questions, Queries, and Results

## Q10: Most Popular Music Genre by Country

### Business Question
This query identifies the top music genre in each country, useful for regional marketing and inventory planning.

### SQL Query
```sql
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
```

### Results

The analysis identified the most popular music genre in each country:

| Country | Genre Name | Purchases |
|---------|------------|-----------|
| Argentina | Alternative & Punk | 9 |
| Australia | Rock | 9 |
| Austria | Rock | 15 |
| Belgium | Rock | 21 |
| Brazil | Rock | 81 |
| Canada | Rock | 107 |
| Chile | Rock | 9 |
| Czech Republic | Rock | 25 |
| Denmark | Rock | 21 |
| Finland | Rock | 3 |
| France | Rock | 65 |
| Germany | Rock | 62 |
| Hungary | Rock | 9 |
| India | Rock | 23 |
| Ireland | Rock | 9 |
| Italy | Rock | 9 |
| Netherlands | Rock | 9 |
| Norway | Rock | 9 |
| Poland | Rock | 9 |
| Portugal | Rock | 37 |
| Spain | Rock | 9 |
| Sweden | Rock | 9 |
| United Kingdom | Rock | 37 |
| USA | Rock | 146 |

### Business Insight
Rock music dominates as the most popular genre across almost all countries, with only Argentina showing a preference for Alternative & Punk. This global popularity of rock music suggests that the store should maintain a strong focus on rock music in its inventory and marketing strategies. However, the varying purchase volumes across countries indicate different market sizes and opportunities. Countries like the USA, Canada, Brazil, and France represent the largest markets for rock music and should be prioritized for marketing campaigns and inventory allocation.

---

## Q15: Most Popular Countries for Music Purchases

### Business Question
This query identifies which countries generate the most sales, useful for international expansion planning.

### SQL Query
```sql
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
```

### Results

The countries with the highest purchase counts are:

| Country | Purchase Count | Total Sales |
|---------|----------------|-------------|
| USA | 1040 | $523.06 |
| Canada | 535 | $303.96 |
| France | 449 | $227.31 |
| Brazil | 427 | $190.10 |
| Germany | 394 | $156.48 |
| United Kingdom | 303 | $112.86 |
| Czech Republic | 230 | $90.24 |
| Portugal | 205 | $84.70 |
| India | 183 | $75.26 |
| Chile | 146 | $46.62 |

### Business Insight
The USA is by far the largest market, with nearly twice the purchase count of the second-largest market (Canada) and more than double the sales revenue. The top five countries (USA, Canada, France, Brazil, and Germany) account for a significant portion of total sales, suggesting that these markets should be prioritized for marketing efforts, customer support, and localized content. The disparity between purchase count and total sales in some countries (e.g., Brazil has more purchases than France but lower total sales) indicates different purchasing patterns or price sensitivities across markets, which could inform regional pricing or promotion strategies.

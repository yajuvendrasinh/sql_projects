# Sales Analysis: Questions, Queries, and Results

## Q9: Customer Spending by Artist

### Business Question
This query shows customer spending by artist, useful for understanding customer preferences and artist popularity.

### SQL Query
```sql
WITH best_selling_artist AS (
    SELECT 
        artist.artist_id AS artist_id, 
        artist.name AS artist_name, 
        SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
    FROM 
        invoice_line
    JOIN 
        track ON track.track_id = invoice_line.track_id
    JOIN 
        album ON album.album_id = track.album_id
    JOIN 
        artist ON artist.artist_id = album.artist_id
    GROUP BY 
        artist.artist_id,
        artist.name
    ORDER BY 
        total_sales DESC
)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name, 
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM 
    invoice i
JOIN 
    customer c ON c.customer_id = i.customer_id
JOIN 
    invoice_line il ON il.invoice_id = i.invoice_id
JOIN 
    track t ON t.track_id = il.track_id
JOIN 
    album al ON al.album_id = t.album_id
JOIN 
    best_selling_artist bsa ON bsa.artist_id = al.artist_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name
ORDER BY 
    amount_spent DESC;
```

### Results

The analysis shows how much each customer spent on different artists. Here are the top 10 customer-artist spending combinations:

| Customer ID | First Name | Last Name | Artist Name | Amount Spent |
|-------------|------------|-----------|-------------|--------------|
| 55 | Mark | Taylor | Iron Maiden | $17.82 |
| 5 | R | Madhav | Iron Maiden | $17.82 |
| 35 | Madalena | Sampaio | Iron Maiden | $17.82 |
| 16 | Frank | Harris | Iron Maiden | $17.82 |
| 23 | Julia | Barnett | Iron Maiden | $17.82 |
| 37 | Fynn | Zimmermann | Iron Maiden | $17.82 |
| 42 | Wyatt | Girard | Iron Maiden | $17.82 |
| 1 | Luís | Gonçalves | Iron Maiden | $13.86 |
| 2 | Leonie | Köhler | Iron Maiden | $13.86 |
| 3 | François | Tremblay | Iron Maiden | $13.86 |

### Business Insight
Iron Maiden appears to be exceptionally popular across multiple customers, with several customers spending identical amounts on this artist. This suggests that certain album packages or collections by Iron Maiden are particularly successful. The store could leverage this information to create similar bundled offerings for other popular artists. Additionally, these high-spending customers could be targeted for early access to new Iron Maiden releases or related merchandise.

---

## Q14: Average Prices by Music Type

### Business Question
This query shows average price by genre, useful for pricing strategy and inventory decisions.

### SQL Query
```sql
SELECT 
    g.name AS genre, 
    ROUND(AVG(t.unit_price), 2) AS average_price
FROM 
    track t
JOIN 
    genre g ON g.genre_id = t.genre_id
GROUP BY 
    g.name
ORDER BY 
    average_price DESC;
```

### Results

The average price by genre is:

| Genre | Average Price |
|-------|---------------|
| Rock | $0.99 |
| Latin | $0.99 |
| Metal | $0.99 |
| Alternative & Punk | $0.99 |
| TV Shows | $0.99 |
| Jazz | $0.99 |
| Blues | $0.99 |
| Drama | $0.99 |
| R&B/Soul | $0.99 |
| Classical | $0.99 |
| Reggae | $0.99 |
| Pop | $0.99 |
| Soundtrack | $0.99 |
| Sci Fi & Fantasy | $0.99 |
| World | $0.99 |
| Comedy | $0.99 |
| Electronica/Dance | $0.99 |
| Heavy Metal | $0.99 |
| Easy Listening | $0.99 |
| Hip Hop/Rap | $0.99 |
| Bossa Nova | $0.99 |
| Science Fiction | $0.99 |
| Rock And Roll | $0.99 |
| Opera | $0.99 |

### Business Insight
The uniform pricing across all genres ($0.99) suggests that the store employs a standardized pricing strategy regardless of music type. While this simplifies operations, it may represent a missed opportunity for value-based pricing. The store could consider testing different price points for premium genres or creating tiered pricing based on popularity, exclusivity, or production quality. Additionally, the consistent pricing might be leveraged in marketing as a customer-friendly policy.

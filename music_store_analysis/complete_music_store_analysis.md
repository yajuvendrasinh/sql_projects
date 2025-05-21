# Complete Music Store Analysis

This document combines all analysis sections into a single comprehensive file, including business questions, SQL queries, results, and business insights.

## Table of Contents

1. [Basic Analysis](#basic-analysis-questions-queries-and-results)
2. [Customer Analysis](#customer-analysis-questions-queries-and-results)
3. [Music Analysis](#music-analysis-questions-queries-and-results)
4. [Sales Analysis](#sales-analysis-questions-queries-and-results)
5. [Geographic Analysis](#geographic-analysis-questions-queries-and-results)
6. [Advanced Analysis](#advanced-analysis-questions-queries-and-results)

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

# Music Analysis: Questions, Queries, and Results

## Q7: Top 10 Rock Bands by Track Count

### Business Question
This query identifies the top 10 rock bands by track count, useful for event planning.

### SQL Query
```sql
SELECT 
    a.artist_id,
    a.name AS artist_name,
    COUNT(t.track_id) AS track_count
FROM 
    artist a
JOIN 
    album al ON al.artist_id = a.artist_id
JOIN 
    track t ON t.album_id = al.album_id
WHERE 
    t.genre_id IN (
        SELECT 
            genre_id 
        FROM 
            genre
        WHERE 
            name LIKE 'Rock'
    )
GROUP BY 
    a.artist_id,
    a.name
ORDER BY 
    track_count DESC
LIMIT 10;
```

### Results

The artists who have written the most rock music in our dataset are:

| Artist ID | Artist Name | Track Count |
|-----------|-------------|-------------|
| 22 | Led Zeppelin | 114 |
| 150 | U2 | 112 |
| 58 | Deep Purple | 92 |
| 90 | Iron Maiden | 81 |
| 118 | Pearl Jam | 54 |
| 152 | Van Halen | 52 |
| 51 | Queen | 45 |
| 142 | The Rolling Stones | 41 |
| 76 | Creedence Clearwater Revival | 40 |
| 52 | Kiss | 35 |

### Business Insight
Led Zeppelin and U2 dominate the rock music catalog, suggesting they should be featured prominently in rock music promotions. The strong presence of classic rock bands indicates an opportunity for themed collections or promotions targeting classic rock enthusiasts. This data could inform inventory decisions, ensuring sufficient stock of popular rock artists' music.

---

## Q8: Tracks Longer Than Average Length

### Business Question
This query identifies longer-than-average tracks, useful for playlist curation.

### SQL Query
```sql
SELECT 
    name AS track_name,
    milliseconds AS track_length_ms
FROM 
    track
WHERE 
    milliseconds > (
        SELECT 
            AVG(milliseconds) AS avg_track_length
        FROM 
            track
    )
ORDER BY 
    milliseconds DESC;
```

### Results

The analysis identified numerous tracks with lengths exceeding the average. Here are the top 10 longest tracks:

| Track Name | Length (ms) |
|------------|-------------|
| Occupation / Precipice | 5286953 |
| Through a Looking Glass | 5088838 |
| Greetings from Earth, Pt. 1 | 2960293 |
| The Man With Nine Lives | 2956998 |
| Battlestar Galactica, Pt. 2 | 2956081 |
| Battlestar Galactica, Pt. 1 | 2952702 |
| Murder On the Rising Star | 2935894 |
| Take the Celestra | 2927802 |
| Fire In Space | 2926593 |
| War of the Gods, Pt. 2 | 2924716 |

### Business Insight
The store has a significant number of tracks that exceed the average length, with some tracks being exceptionally long (over 5 million milliseconds or 88 minutes). These extended tracks could be marketed as special editions or featured in dedicated playlists for customers seeking immersive listening experiences. This data could also inform pricing strategies for premium content.

---

## Q12: Most Popular Artists by Purchase Count

### Business Question
This query identifies the most purchased artists, useful for inventory and promotion decisions.

### SQL Query
```sql
SELECT 
    a.name AS artist_name,
    COUNT(il.quantity) AS purchase_count
FROM 
    invoice_line il
JOIN 
    track t ON t.track_id = il.track_id
JOIN 
    album al ON al.album_id = t.album_id
JOIN 
    artist a ON a.artist_id = al.artist_id
GROUP BY 
    a.name
ORDER BY 
    purchase_count DESC
LIMIT 10;
```

### Results

The most purchased artists are:

| Artist Name | Purchase Count |
|-------------|----------------|
| Iron Maiden | 140 |
| U2 | 107 |
| Metallica | 91 |
| Led Zeppelin | 87 |
| Lost | 71 |
| Deep Purple | 58 |
| Faith No More | 49 |
| Pearl Jam | 46 |
| Various Artists | 42 |
| Ozzy Osbourne | 39 |

### Business Insight
Iron Maiden significantly outperforms other artists in terms of sales, followed by U2 and Metallica. This suggests that heavy metal and rock genres are particularly popular among customers. The store should ensure adequate inventory of these top-selling artists and consider creating featured collections or promotions around them. The presence of "Various Artists" in the top 10 also indicates that compilation albums perform well.

---

## Q13: Most Popular Songs by Purchase Count

### Business Question
This query identifies the most purchased tracks, useful for promotion and playlist curation.

### SQL Query
```sql
SELECT 
    t.name AS track_name,
    COUNT(il.quantity) AS purchase_count
FROM 
    invoice_line il
JOIN 
    track t ON t.track_id = il.track_id
GROUP BY 
    t.name
ORDER BY 
    purchase_count DESC
LIMIT 10;
```

### Results

The most purchased tracks are:

| Track Name | Purchase Count |
|------------|----------------|
| The Trooper | 5 |
| Hallowed Be Thy Name | 5 |
| Woman | 5 |
| Cry For Eternity | 5 |
| Princess of the Dawn | 5 |
| Restless and Wild | 5 |
| Balls to the Wall | 5 |
| Fast As a Shark | 5 |
| Thriller | 5 |
| The Number of the Beast | 5 |

### Business Insight
There appears to be a tie among several tracks for the most purchased, with each having 5 purchases. Many of these top tracks are from heavy metal bands like Iron Maiden and Accept, aligning with the finding that Iron Maiden is the most popular artist. This data suggests that featuring these tracks in playlists or promotions could drive additional sales. The diversity of popular tracks also indicates an opportunity for genre-specific marketing strategies.

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

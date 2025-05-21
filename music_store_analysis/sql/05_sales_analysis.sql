-- Music Store Analysis - Sales Analysis
-- This script contains queries for sales and financial analysis (Questions 9, 14)

-- Q9. Find how much amount spent by each customer on artists
-- This query shows customer spending by artist, useful for understanding customer preferences and artist popularity
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

-- Q14. What are the average prices of different types of music?
-- This query shows average price by genre, useful for pricing strategy and inventory decisions
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

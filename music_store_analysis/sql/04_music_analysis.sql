-- Music Store Analysis - Music Analysis
-- This script contains queries for music-focused analysis (Questions 7, 8, 12, 13)

-- Q7. Let's invite the artists who have written the most rock music in our dataset
-- This query identifies the top 10 rock bands by track count, useful for event planning
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

-- Q8. Return all the track names that have a song length longer than the average song length
-- This query identifies longer-than-average tracks, useful for playlist curation
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

-- Q12. Who are the most popular artists?
-- This query identifies the most purchased artists, useful for inventory and promotion decisions
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

-- Q13. Which is the most popular song?
-- This query identifies the most purchased track, useful for promotion and playlist curation
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

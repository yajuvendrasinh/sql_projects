# Data Dictionary

This document provides detailed descriptions of all fields in the music store database.

## Artist Table

| Field | Type | Description |
|-------|------|-------------|
| artist_id | INTEGER | Primary key, unique identifier for each artist |
| name | VARCHAR(120) | Name of the artist |

## Album Table

| Field | Type | Description |
|-------|------|-------------|
| album_id | INTEGER | Primary key, unique identifier for each album |
| title | VARCHAR(160) | Title of the album |
| artist_id | INTEGER | Foreign key referencing the artist who created the album |

## Track Table

| Field | Type | Description |
|-------|------|-------------|
| track_id | INTEGER | Primary key, unique identifier for each track |
| name | VARCHAR(200) | Name of the track |
| album_id | INTEGER | Foreign key referencing the album containing the track |
| media_type_id | INTEGER | Foreign key referencing the media type of the track |
| genre_id | INTEGER | Foreign key referencing the genre of the track |
| composer | VARCHAR(220) | Name of the composer (may be null) |
| milliseconds | INTEGER | Duration of the track in milliseconds |
| bytes | INTEGER | Size of the track in bytes (may be null) |
| unit_price | NUMERIC(10,2) | Price of the track |

## MediaType Table

| Field | Type | Description |
|-------|------|-------------|
| media_type_id | INTEGER | Primary key, unique identifier for each media type |
| name | VARCHAR(120) | Name of the media type (e.g., MPEG audio, AAC audio) |

## Genre Table

| Field | Type | Description |
|-------|------|-------------|
| genre_id | INTEGER | Primary key, unique identifier for each genre |
| name | VARCHAR(120) | Name of the genre (e.g., Rock, Jazz, Metal) |

## Employee Table

| Field | Type | Description |
|-------|------|-------------|
| employee_id | INTEGER | Primary key, unique identifier for each employee |
| last_name | VARCHAR(20) | Last name of the employee |
| first_name | VARCHAR(20) | First name of the employee |
| title | VARCHAR(30) | Job title of the employee |
| reports_to | INTEGER | Foreign key referencing the employee's manager (may be null) |
| levels | VARCHAR(10) | Seniority level of the employee (e.g., L1, L2, L6) |
| birthdate | TIMESTAMP | Birth date of the employee |
| hire_date | TIMESTAMP | Date the employee was hired |
| address | VARCHAR(70) | Street address of the employee |
| city | VARCHAR(40) | City where the employee lives |
| state | VARCHAR(40) | State where the employee lives (may be null) |
| country | VARCHAR(40) | Country where the employee lives |
| postal_code | VARCHAR(10) | Postal code of the employee's address |
| phone | VARCHAR(24) | Phone number of the employee |
| fax | VARCHAR(24) | Fax number of the employee (may be null) |
| email | VARCHAR(60) | Email address of the employee |

## Customer Table

| Field | Type | Description |
|-------|------|-------------|
| customer_id | INTEGER | Primary key, unique identifier for each customer |
| first_name | VARCHAR(40) | First name of the customer |
| last_name | VARCHAR(20) | Last name of the customer |
| company | VARCHAR(80) | Company name of the customer (may be null) |
| address | VARCHAR(70) | Street address of the customer |
| city | VARCHAR(40) | City where the customer lives |
| state | VARCHAR(40) | State where the customer lives (may be null) |
| country | VARCHAR(40) | Country where the customer lives |
| postal_code | VARCHAR(10) | Postal code of the customer's address (may be null) |
| phone | VARCHAR(24) | Phone number of the customer (may be null) |
| fax | VARCHAR(24) | Fax number of the customer (may be null) |
| email | VARCHAR(60) | Email address of the customer |
| support_rep_id | INTEGER | Foreign key referencing the employee who supports the customer |

## Invoice Table

| Field | Type | Description |
|-------|------|-------------|
| invoice_id | INTEGER | Primary key, unique identifier for each invoice |
| customer_id | INTEGER | Foreign key referencing the customer who made the purchase |
| invoice_date | TIMESTAMP | Date and time of the invoice |
| billing_address | VARCHAR(70) | Billing address for the invoice (may be null) |
| billing_city | VARCHAR(40) | Billing city for the invoice |
| billing_state | VARCHAR(40) | Billing state for the invoice (may be null) |
| billing_country | VARCHAR(40) | Billing country for the invoice |
| billing_postal_code | VARCHAR(10) | Billing postal code for the invoice (may be null) |
| total | NUMERIC(10,2) | Total amount of the invoice |

## InvoiceLine Table

| Field | Type | Description |
|-------|------|-------------|
| invoice_line_id | INTEGER | Primary key, unique identifier for each invoice line |
| invoice_id | INTEGER | Foreign key referencing the invoice |
| track_id | INTEGER | Foreign key referencing the track purchased |
| unit_price | NUMERIC(10,2) | Price of the track at the time of purchase |
| quantity | INTEGER | Quantity of the track purchased |

## Playlist Table

| Field | Type | Description |
|-------|------|-------------|
| playlist_id | INTEGER | Primary key, unique identifier for each playlist |
| name | VARCHAR(120) | Name of the playlist |

## PlaylistTrack Table

| Field | Type | Description |
|-------|------|-------------|
| playlist_id | INTEGER | Part of composite primary key, foreign key referencing the playlist |
| track_id | INTEGER | Part of composite primary key, foreign key referencing the track |

## Data Quality Notes

- Several fields contain null values, particularly optional fields like company, fax, state, etc.
- The primary key and foreign key relationships are intact, allowing for meaningful analysis despite missing values.
- The track table has the most missing values (978), primarily in the composer field.
- The customer table has 130 missing values across various optional fields.
- The invoice table has 359 missing values, primarily in the billing_state and billing_postal_code fields.

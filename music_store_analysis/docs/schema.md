# Database Schema Documentation

## Overview

The music store database consists of 11 interconnected tables that store information about customers, employees, music tracks, albums, artists, invoices, and playlists. The schema follows a normalized design to minimize data redundancy while maintaining data integrity through primary and foreign key relationships.

## Tables and Relationships

### Artist
- **Primary Key**: artist_id
- **Description**: Contains information about music artists
- **Fields**:
  - artist_id: Unique identifier for each artist
  - name: Name of the artist

### Album
- **Primary Key**: album_id
- **Foreign Keys**: artist_id (references Artist)
- **Description**: Contains information about music albums
- **Fields**:
  - album_id: Unique identifier for each album
  - title: Title of the album
  - artist_id: Reference to the artist who created the album

### Track
- **Primary Key**: track_id
- **Foreign Keys**: 
  - album_id (references Album)
  - media_type_id (references MediaType)
  - genre_id (references Genre)
- **Description**: Contains information about individual music tracks
- **Fields**:
  - track_id: Unique identifier for each track
  - name: Name of the track
  - album_id: Reference to the album containing the track
  - media_type_id: Reference to the media type of the track
  - genre_id: Reference to the genre of the track
  - composer: Name of the composer
  - milliseconds: Duration of the track in milliseconds
  - bytes: Size of the track in bytes
  - unit_price: Price of the track

### MediaType
- **Primary Key**: media_type_id
- **Description**: Contains information about different media types
- **Fields**:
  - media_type_id: Unique identifier for each media type
  - name: Name of the media type

### Genre
- **Primary Key**: genre_id
- **Description**: Contains information about music genres
- **Fields**:
  - genre_id: Unique identifier for each genre
  - name: Name of the genre

### Employee
- **Primary Key**: employee_id
- **Foreign Keys**: reports_to (self-referencing to Employee)
- **Description**: Contains information about store employees
- **Fields**:
  - employee_id: Unique identifier for each employee
  - last_name: Last name of the employee
  - first_name: First name of the employee
  - title: Job title of the employee
  - reports_to: Reference to the employee's manager
  - levels: Seniority level of the employee
  - birthdate: Birth date of the employee
  - hire_date: Date the employee was hired
  - address: Street address of the employee
  - city: City where the employee lives
  - state: State where the employee lives
  - country: Country where the employee lives
  - postal_code: Postal code of the employee's address
  - phone: Phone number of the employee
  - fax: Fax number of the employee
  - email: Email address of the employee

### Customer
- **Primary Key**: customer_id
- **Foreign Keys**: support_rep_id (references Employee)
- **Description**: Contains information about store customers
- **Fields**:
  - customer_id: Unique identifier for each customer
  - first_name: First name of the customer
  - last_name: Last name of the customer
  - company: Company name of the customer
  - address: Street address of the customer
  - city: City where the customer lives
  - state: State where the customer lives
  - country: Country where the customer lives
  - postal_code: Postal code of the customer's address
  - phone: Phone number of the customer
  - fax: Fax number of the customer
  - email: Email address of the customer
  - support_rep_id: Reference to the employee who supports the customer

### Invoice
- **Primary Key**: invoice_id
- **Foreign Keys**: customer_id (references Customer)
- **Description**: Contains information about customer invoices
- **Fields**:
  - invoice_id: Unique identifier for each invoice
  - customer_id: Reference to the customer who made the purchase
  - invoice_date: Date of the invoice
  - billing_address: Billing address for the invoice
  - billing_city: Billing city for the invoice
  - billing_state: Billing state for the invoice
  - billing_country: Billing country for the invoice
  - billing_postal_code: Billing postal code for the invoice
  - total: Total amount of the invoice

### InvoiceLine
- **Primary Key**: invoice_line_id
- **Foreign Keys**: 
  - invoice_id (references Invoice)
  - track_id (references Track)
- **Description**: Contains information about individual line items on invoices
- **Fields**:
  - invoice_line_id: Unique identifier for each invoice line
  - invoice_id: Reference to the invoice
  - track_id: Reference to the track purchased
  - unit_price: Price of the track at the time of purchase
  - quantity: Quantity of the track purchased

### Playlist
- **Primary Key**: playlist_id
- **Description**: Contains information about playlists
- **Fields**:
  - playlist_id: Unique identifier for each playlist
  - name: Name of the playlist

### PlaylistTrack
- **Primary Key**: Composite (playlist_id, track_id)
- **Foreign Keys**: 
  - playlist_id (references Playlist)
  - track_id (references Track)
- **Description**: Junction table linking playlists and tracks (many-to-many relationship)
- **Fields**:
  - playlist_id: Reference to the playlist
  - track_id: Reference to the track

## Relationship Diagram

The database schema diagram visually represents these relationships:

![Music Database Schema](../MusicDatabaseSchema.png)

## Data Integrity Constraints

- **Primary Keys**: Each table has a unique identifier to ensure row uniqueness
- **Foreign Keys**: Maintain referential integrity between related tables
- **Not Null Constraints**: Critical fields like names, dates, and prices are required
- **Default Values**: Some fields have default values to ensure data consistency

## Data Quality Notes

Based on the data quality assessment, the following issues were identified:

- **Missing Values**: 
  - Customer table: 130 missing values (primarily in optional fields)
  - Employee table: 1 missing value
  - Invoice table: 359 missing values (primarily in optional fields)
  - Track table: 978 missing values (primarily in composer field)

These missing values are primarily in optional fields and do not affect the primary key and foreign key relationships, allowing for meaningful analysis despite these gaps.

-- Music Store Analysis - Database Setup Script
-- This script creates the necessary tables for the music store database

-- Create tables based on the schema diagram

-- Create Artist table
CREATE TABLE IF NOT EXISTS artist (
    artist_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

-- Create Album table
CREATE TABLE IF NOT EXISTS album (
    album_id INTEGER PRIMARY KEY,
    title VARCHAR(160) NOT NULL,
    artist_id INTEGER REFERENCES artist(artist_id)
);

-- Create MediaType table
CREATE TABLE IF NOT EXISTS media_type (
    media_type_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

-- Create Genre table
CREATE TABLE IF NOT EXISTS genre (
    genre_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

-- Create Track table
CREATE TABLE IF NOT EXISTS track (
    track_id INTEGER PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    album_id INTEGER REFERENCES album(album_id),
    media_type_id INTEGER REFERENCES media_type(media_type_id),
    genre_id INTEGER REFERENCES genre(genre_id),
    composer VARCHAR(220),
    milliseconds INTEGER NOT NULL,
    bytes INTEGER,
    unit_price NUMERIC(10,2) NOT NULL
);

-- Create Employee table
CREATE TABLE IF NOT EXISTS employee (
    employee_id INTEGER PRIMARY KEY,
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    title VARCHAR(30),
    reports_to INTEGER REFERENCES employee(employee_id),
    levels VARCHAR(10),
    birthdate TIMESTAMP,
    hire_date TIMESTAMP,
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60)
);

-- Create Customer table
CREATE TABLE IF NOT EXISTS customer (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    company VARCHAR(80),
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60) NOT NULL,
    support_rep_id INTEGER REFERENCES employee(employee_id)
);

-- Create Invoice table
CREATE TABLE IF NOT EXISTS invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(customer_id),
    invoice_date TIMESTAMP NOT NULL,
    billing_address VARCHAR(70),
    billing_city VARCHAR(40),
    billing_state VARCHAR(40),
    billing_country VARCHAR(40),
    billing_postal_code VARCHAR(10),
    total NUMERIC(10,2) NOT NULL
);

-- Create InvoiceLine table
CREATE TABLE IF NOT EXISTS invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER REFERENCES invoice(invoice_id),
    track_id INTEGER REFERENCES track(track_id),
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INTEGER NOT NULL
);

-- Create Playlist table
CREATE TABLE IF NOT EXISTS playlist (
    playlist_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

-- Create PlaylistTrack table
CREATE TABLE IF NOT EXISTS playlist_track (
    playlist_id INTEGER REFERENCES playlist(playlist_id),
    track_id INTEGER REFERENCES track(track_id),
    PRIMARY KEY (playlist_id, track_id)
);

-- Note on data quality issues:
-- The data quality report identified missing values in the following tables:
-- - customer: 130 missing values
-- - employee: 1 missing value
-- - invoice: 359 missing values
-- - track: 978 missing values
-- These missing values are primarily in optional fields like company, fax, state, etc.
-- The primary key and foreign key relationships are intact, allowing for meaningful analysis.

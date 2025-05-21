-- Artist Table
CREATE TABLE Artist (
    ArtistId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

-- Album Table
CREATE TABLE Album (
    AlbumId INTEGER PRIMARY KEY,
    Title VARCHAR(160),
    ArtistId INTEGER,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
);

-- MediaType Table
CREATE TABLE MediaType (
    MediaTypeId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

-- Genre Table
CREATE TABLE Genre (
    GenreId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

-- Track Table
CREATE TABLE Track (
    TrackId INTEGER PRIMARY KEY,
    Name VARCHAR(200),
    AlbumId INTEGER,
    MediaTypeId INTEGER,
    GenreId INTEGER,
    Composer VARCHAR(220),
    Milliseconds INTEGER,
    Bytes INTEGER,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId),
    FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId),
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

-- Playlist Table
CREATE TABLE Playlist (
    PlaylistId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

-- PlaylistTrack Table
CREATE TABLE PlaylistTrack (
    PlaylistId INTEGER,
    TrackId INTEGER,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES Playlist(PlaylistId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

-- Employee Table
CREATE TABLE Employee (
    EmployeeId INTEGER PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Title VARCHAR(100),
    ReportsTo INTEGER,
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(220),
    City VARCHAR(120),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Phone VARCHAR(40),
    Fax VARCHAR(40),
    Email VARCHAR(80),
    FOREIGN KEY (ReportsTo) REFERENCES Employee(EmployeeId)
);

-- Customer Table
CREATE TABLE Customer (
    CustomerId INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Company VARCHAR(150),
    Address VARCHAR(220),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Phone VARCHAR(40),
    Fax VARCHAR(40),
    Email VARCHAR(80),
    SupportRepId INTEGER,
    FOREIGN KEY (SupportRepId) REFERENCES Employee(EmployeeId)
);

-- Invoice Table
CREATE TABLE Invoice (
    InvoiceId INTEGER PRIMARY KEY,
    CustomerId INTEGER,
    InvoiceDate DATE,
    BillingAddress VARCHAR(220),
    BillingCity VARCHAR(100),
    BillingState VARCHAR(50),
    BillingCountry VARCHAR(50),
    BillingPostalCode VARCHAR(20),
    Total DECIMAL(10, 2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- InvoiceLine Table
CREATE TABLE InvoiceLine (
    InvoiceLineId INTEGER PRIMARY KEY,
    InvoiceId INTEGER,
    TrackId INTEGER,
    UnitPrice DECIMAL(10, 2),
    Quantity INTEGER,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

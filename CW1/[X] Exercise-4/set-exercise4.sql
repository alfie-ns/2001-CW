-- Creates the CW1 schema if it doesn't already exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'CW1') -- if the schema doesn't already exist in the systems catalogue; select everything from sys.schemas where the name is CW1
BEGIN -- begin the following block of code
    EXEC('CREATE SCHEMA CW1') -- Execute schema creation CW1
END -- end if statement
---------------------------------------------------------------------------------------------------------------------------------------
-- Create Trail table in CW1 schema
/*
    This table state TrailID as the primary key with auto-increment; TrailName, Length, ElevationGain, RouteType, 
    Difficulty, and UserEmail as NOT null constraints, and their respective data types and lengths. Description
    is also included as a column with a maximum length. LocationID and UserEmail are foreign keys that reference
    the Location and User table, respectively.
*/
CREATE TABLE CW1.Trail (
    TrailID INT PRIMARY KEY IDENTITY(1,1),
    TrailName VARCHAR(75) NOT NULL, -- can't find any names above 50 characters; 75 == safe bet
    Length FLOAT NOT NULL,
    ElevationGain INT NOT NULL,
    RouteType VARCHAR(15) NOT NULL, -- Out & Back || Loop || Point to Point
    Description VARCHAR(500), -- Average character-length of a description is around 400; thus 500 == safe bet
    Difficulty VARCHAR(10) NOT NULL, -- Easy || Moderate || Hard
    LocationID INT NOT NULL,
    UserEmail NVARCHAR(254) NOT NULL, -- 254 is legal maximum length for an email address
    FOREIGN KEY (LocationID) REFERENCES CW1.Location(LocationID),
    FOREIGN KEY (UserEmail) REFERENCES CW1.[User](Email)
);
---------------------------------------------------------------------------------------------------------------------------------------
-- Create Location table in CW1 schema
/*
    This table state LocationID as the primary key with auto-increment, City, County, and Country as not null constraints,
    and their respective data types and lengths. 
*/
CREATE TABLE CW1.Location ( -- 100 == safe bet for all location columns
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    City VARCHAR(100) NOT NULL,
    County VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);
---------------------------------------------------------------------------------------------------------------------------------------
-- Create User table in CW1 schema
/*
    This table sets Email as the primary key, with UserName and Password as not null constraints,
    along with their respective data types and lengths. Although NVARCHAR allocates twice the
    storage space compared to VARCHAR, it is used for the Email column to support 
    international characters emails.
*/
CREATE TABLE CW1.[User] ( -- 254 == legal email maximum length; 100 == safe bet for username; 255 == safe bet for hashed password
    Email NVARCHAR(254) PRIMARY KEY, 
    UserName VARCHAR(100) NOT NULL, 
    Password VARCHAR(255) NOT NULL 
);
---------------------------------------------------------------------------------------------------------------------------------------
-- Insert sample data into Location table
INSERT INTO CW1.Location (City, County, Country) VALUES
('London', 'Greater London', 'United Kingdom'),
('Plymouth', 'Devon', 'United Kingdom'),
('Manchester', 'Greater Manchester', 'United Kingdom'),
('Edinburgh', 'Midlothian', 'United Kingdom'),
('Cardiff', 'South Glamorgan', 'United Kingdom');

-- Insert sample data into User table
INSERT INTO CW1.[User] (Email, UserName, Password) VALUES
('john@example.com', 'JohnDoe', 'hashedpassword1'),
('jane@example.com', 'JaneSmith', 'hashedpassword2'),
('mike@example.com', 'MikeJohnson', 'hashedpassword3'),
('sarah@example.com', 'SarahBrown', 'hashedpassword4'),
('alex@example.com', 'AlexWilson', 'hashedpassword5');

-- Insert sample data into Trail table
INSERT INTO CW1.Trail (TrailName, Length, ElevationGain, RouteType, Description, Difficulty, LocationID, UserEmail) VALUES
('Thames Path', 8.5, 50, 'Out & Back', 'Scenic walk along the River Thames in London', 'Easy', 1, 'john@example.com'),
('Dartmoor Way', 15.0, 500, 'Loop', 'Circular route showcasing Dartmoor National Park near Plymouth', 'Moderate', 2, 'jane@example.com'),
('Pennine Way', 20.0, 800, 'Point to Point', 'Part of the famous trail near Manchester', 'Difficult', 3, 'mike@example.com'),
('Arthurs Seat', 4.5, 250, 'Loop', 'Iconic hill walk in Edinburgh with panoramic views', 'Moderate', 4, 'sarah@example.com'),
('Taff Trail', 12.0, 150, 'Out & Back', 'Popular cycling and walking route in Cardiff', 'Easy', 5, 'alex@example.com');

-- SELECT statements to demonstrate data in tables
SELECT * FROM CW1.Location;
SELECT * FROM CW1.[User];
SELECT * FROM CW1.Trail;
-- '*' = all columns

-- Analysis queries ----------------------------------------------------------------------------------------------------------------------

-- query to show the number of trails per user -
SELECT 
    u.Email,
    u.UserName,
    COUNT(t.TrailID) AS NumberOfTrails
FROM 
    CW1.[User] u
    LEFT JOIN CW1.Trail t ON u.Email = t.UserEmail
GROUP BY 
    u.Email, u.UserName
ORDER BY 
    NumberOfTrails DESC;

-- query to show the number of trails per location -
SELECT 
    l.LocationID,
    l.City,
    l.County,
    l.Country,
    COUNT(t.TrailID) AS NumberOfTrails
FROM 
    CW1.Location l
    LEFT JOIN CW1.Trail t ON l.LocationID = t.LocationID
GROUP BY 
    l.LocationID, l.City, l.County, l.Country
ORDER BY 
    NumberOfTrails DESC;

-- query to show trails with their difficulty levels and creators -
SELECT 
    t.TrailName,
    t.Difficulty,
    t.Length,
    u.UserName AS Creator,
    l.City,
    l.Country
FROM 
    CW1.Trail t
    JOIN CW1.[User] u ON t.UserEmail = u.Email
    JOIN CW1.Location l ON t.LocationID = l.LocationID
ORDER BY 
    t.Difficulty, t.Length DESC; -- DESC = descending order

-- Testing queries -----------------------------------------------------------------------------------------------------------------------

-- Check current data in Trail table
SELECT * FROM CW1.Trail;

-- Verify row counts individually
SELECT COUNT(*) AS LocationCount FROM CW1.Location;
SELECT COUNT(*) AS UserCount FROM CW1.[User];
SELECT COUNT(*) AS TrailCount FROM CW1.Trail;

-- Check for NULL values
SELECT * FROM CW1.Trail WHERE TrailName IS NULL OR Length IS NULL OR Difficulty IS NULL;

-- This should fail
INSERT INTO CW1.Trail (TrailName, Length, ElevationGain, RouteType, Difficulty, LocationID, UserEmail)
VALUES ('Test Trail', 10, 100, 'Loop', 'Easy', 999, 'nonexistent@example.com');

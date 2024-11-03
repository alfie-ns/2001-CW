-- Create view to display trail information
CREATE VIEW CW1.TrailView AS
SELECT 
    t.TrailName AS Trail_Name,
    t.Length AS Trail_Length,
    t.ElevationGain AS Elevation_Gain,
    t.RouteType AS Route_Type,
    t.Description AS Trail_Description,
    t.Difficulty AS Difficulty_Level,
    l.City AS Location_City,
    l.County AS Location_County,
    l.Country AS Location_Country,
    u.UserName AS Creator_Name
FROM 
    CW1.Trail t
    JOIN CW1.Location l ON t.LocationID = l.LocationID
    JOIN CW1.[User] u ON t.UserEmail = u.Email;

-- Enable IDENTITY_INSERT for Location
SET IDENTITY_INSERT CW1.Location ON;

-- Insert demo data into the Location table
INSERT INTO CW1.Location (LocationID, City, County, Country)
VALUES
    (6, 'Plymouth', 'Devon', 'United Kingdom'),
    (7, 'Bristol', 'Bristol', 'United Kingdom'),
    (8, 'Bath', 'Somerset', 'United Kingdom');

-- Disable IDENTITY_INSERT for Location
SET IDENTITY_INSERT CW1.Location OFF;

-- Insert demo data into the User table with Passwords
INSERT INTO CW1.[User] (Email, UserName, Password)
VALUES
    ('john.doe@example.com', 'John Doe', 'hashedpassword'),
    ('jane.smith@example.com', 'Jane Smith', 'hashedpassword'),
    ('mark.jones@example.com', 'Mark Jones', 'hashedpassword');

-- Enable IDENTITY_INSERT for Trail
SET IDENTITY_INSERT CW1.Trail ON;

-- Insert demo data into the Trail table
INSERT INTO CW1.Trail (TrailID, TrailName, Length, ElevationGain, RouteType, Description, Difficulty, LocationID, UserEmail)
VALUES
    (6, 'Coastal Path', 10.5, 300, 'Out & Back', 'A scenic coastal walk with beautiful views.', 'Moderate', 1, 'john.doe@example.com'),
    (7, 'Forest Loop', 8.2, 150, 'Loop', 'A peaceful walk through dense forest areas.', 'Easy', 2, 'jane.smith@example.com'),
    (8, 'Mountain Ridge', 15.0, 800, 'Point to Point', 'A challenging hike with steep elevation gains.', 'Hard', 3, 'mark.jones@example.com');

-- Disable IDENTITY_INSERT for Trail
SET IDENTITY_INSERT CW1.Trail OFF;

-- Display the contents of the tables
SELECT * FROM CW1.Location;
SELECT * FROM CW1.[User];
SELECT * FROM CW1.Trail;

-- Display the view data
SELECT * FROM CW1.TrailView;
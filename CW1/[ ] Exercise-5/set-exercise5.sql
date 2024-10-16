-- Create view to display trail information, including location and creator details
-- This view combines data from the Trail, Location, and User tables to be displayed on a trails webpage or app.
CREATE VIEW CW1.TrailView AS
SELECT 
    t.TrailName AS Trail_Name,
    t.Length AS Trail_Length,
    t.ElevationGain AS Elevation_Gain,
    t.RouteType AS Route_Type,
    t.Description AS Trail_Description,
    t.Difficulty AS Difficulty_Level,
    l.City AS Location_City,
    l.Country AS Location_Country,
    u.UserName AS Creator_Name
FROM 
    CW1.Trail t
    JOIN CW1.Location l ON t.LocationID = l.LocationID
    JOIN CW1.[User] u ON t.UserEmail = u.Email;
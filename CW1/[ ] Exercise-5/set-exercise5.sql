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

    /*
        This .sql file creates a view called TrailView that combines data from the Trail table with
        the Location and User tables, from the CW1 schema, with the respective foreign keys; LocationID
        and UserEmail. The non-capitalised letters (t, l, and u) are aliases for the Trail, Location, and
        User tables, respectively.
    */
-- Set-exercise 6: Procedures --

-- Create procedure --
CREATE PROCEDURE CW1.CreateTrail
    @TrailName NVARCHAR(75),
    @Length FLOAT,
    @ElevationGain INT,
    @RouteType NVARCHAR(15),
    @Description NVARCHAR(500),
    @Difficulty NVARCHAR(10),
    @LocationID INT,
    @UserEmail NVARCHAR(254)
AS
BEGIN
    INSERT INTO CW1.Trail (TrailName, Length, ElevationGain, RouteType, Description, Difficulty, LocationID, UserEmail)
    VALUES (@TrailName, @Length, @ElevationGain, @RouteType, @Description, @Difficulty, @LocationID, @UserEmail)
END
GO

-- Read procedure --
CREATE PROCEDURE CW1.ReadTrail
    @TrailID INT
AS
BEGIN
    SELECT * FROM CW1.Trail WHERE TrailID = @TrailID
END
GO

-- Update procedure --
CREATE PROCEDURE CW1.UpdateTrail
    @TrailID INT,
    @TrailName NVARCHAR(75),
    @Length FLOAT,
    @ElevationGain INT,
    @RouteType NVARCHAR(15),
    @Description NVARCHAR(500),
    @Difficulty NVARCHAR(10),
    @LocationID INT,
    @UserEmail NVARCHAR(254)
AS
BEGIN
    UPDATE CW1.Trail
    SET TrailName = @TrailName,
        Length = @Length,
        ElevationGain = @ElevationGain,
        RouteType = @RouteType,
        Description = @Description,
        Difficulty = @Difficulty,
        LocationID = @LocationID,
        UserEmail = @UserEmail
    WHERE TrailID = @TrailID
END
GO

-- Delete procedure --
CREATE PROCEDURE CW1.DeleteTrail
    @TrailID INT
AS
BEGIN
    DELETE FROM CW1.Trail WHERE TrailID = @TrailID
END
GO
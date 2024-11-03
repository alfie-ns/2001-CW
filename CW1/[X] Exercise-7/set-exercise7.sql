-- Set-exercise 7: Triggers

-- Create log table to store trail addition details
CREATE TABLE CW1.TrailLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TrailID INT,
    UserEmail NVARCHAR(254),
    AddedOn DATETIME,
    FOREIGN KEY (TrailID) REFERENCES CW1.Trail(TrailID),
    FOREIGN KEY (UserEmail) REFERENCES CW1.[User](Email)
);

-- Create trigger to log trail additions
CREATE TRIGGER CW1.LogNewTrail
ON CW1.Trail
AFTER INSERT
AS
BEGIN
    INSERT INTO CW1.TrailLog (TrailID, UserEmail, AddedOn)
    SELECT inserted.TrailID, inserted.UserEmail, GETDATE()
    FROM inserted;
END
GO
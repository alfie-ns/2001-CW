-- First delete from the child tables that depend on foreign keys
DELETE FROM CW1.TrailLog;
DELETE FROM CW1.Trail;

-- Then delete from the parent tables
DELETE FROM CW1.Location;
DELETE FROM CW1.[User];

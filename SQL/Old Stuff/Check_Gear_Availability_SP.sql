DELIMITER $$;
CREATE PROCEDURE Check_Gear_Availability(IN GearID INT, IN Quantity INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN
	SET @startdate1 = CONVERT('2016-01-01', date);
    SET @enddate1 = CONVERT('2016-02-02', date);
    
    DROP TEMPORARY TABLE IF EXISTS Availability;
    
    CREATE TEMPORARY Table Availability (
		ID INT NOT NULL,
        Name varchar(255) NULL,
        Size varchar(255) NULL,
        QuantityAvailable INT NOT NULL,
        Quantity INT NOT NULL
    )
    
    INSERT into Availability CALL GetAvailability('2016-01-01', '2016-02-02');
    
	SET @availability := CALL GetAvailability('2016-01-01', '2016-02-02');
	SELECT IFNULL(a.Quantity - Quantity), a.Quantity) as QuantityAvailable,
    FROM @availability as a
    WHERE GearID = a.id


END$$
DELIMITER ;

SET @StartDate = '2016-01-01';
SET @EndDate = '2016-02-02';

DROP TEMPORARY TABLE IF EXISTS Gears_available;
	CREATE TEMPORARY Table Gears_available (
		ID INT NOT NULL,
        QuantityAvailable INT NOT NULL
    );
    
		INSERT INTO Gears_available			
		SELECT Inventory.id,
		IFNULL(Inventory.total_quantity - SUM(ReservedGears.quantity), Inventory.total_quantity) as QuantityAvailable	 
		FROM ( 
			SELECT a.id as GearID, SUM(b.quantity) as quantity
			FROM gear_item as a
			JOIN reserved_item as b
				ON a.id = b.gear_item_id
			JOIN request as c
				ON b.request_id = c.id
			JOIN status as d
				ON c.status_id = d.id
			WHERE (c.start_date between @StartDate and @EndDate || c.end_date between @StartDate and @EndDate) AND
				  (d.request_status LIKE '%created%' OR d.request_status LIKE '%approved%')
			GROUP BY GearID) 
			as ReservedGears
		right JOIN gear_item as Inventory
			ON Inventory.id = ReservedGears.GearID
		JOIN size
			ON size.id = Inventory.size_id
		GROUP BY Inventory.id, Inventory.name, size.name_of_size;
        
        
        
        SELECT * from Gears_available;
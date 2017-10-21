DELIMITER $$
CREATE PROCEDURE `AvailableItems`(IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN
SELECT  Inventory.id,
		Inventory.name,
		size.name_of_size as Size,
		IFNULL(Inventory.total_quantity - SUM(ReservedGears.quantity), Inventory.total_quantity) as QuantityAvailable, 
        SUM(Inventory.total_quantity) as Quantity	 
FROM (
	SELECT a.id as GearID, SUM(b.quantity) as quantity
	FROM gear_item as a
		JOIN reserved_item as b
			ON a.id = b.gear_item_id
		JOIN request as c
			ON b.request_id = c.id
		JOIN status as d
			ON c.status_id = d.id
	WHERE (c.start_date between StartDate and EndDate || c.end_date between StartDate and EndDate) AND
		  (d.request_status NOT LIKE 'Completed' and d.request_status NOT LIKE 'Rejected')
	GROUP BY GearID
    ) as ReservedGears
  
right JOIN gear_item as Inventory
		ON Inventory.id = ReservedGears.GearID
	JOIN size
		ON size.id = Inventory.size_id
GROUP BY Inventory.id, Inventory.name, size.name_of_size;
END$$
DELIMITER ;

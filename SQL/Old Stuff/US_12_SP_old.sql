USE WTA;
DELIMITER ;
DROP PROCEDURE IF EXISTS gear_availability;
DELIMITER $$
CREATE PROCEDURE gear_availability(IN StartDate DATE, IN EndDate DATE)
BEGIN
		SELECT Inventory.id, Inventory.name, 
			size.size,
			CASE WHEN (IFNULL(Inventory.total_quantity - SUM(ReservedGears.quantity), Inventory.total_quantity) < 0) THEN 0 ELSE
				(IFNULL(Inventory.total_quantity - SUM(ReservedGears.quantity), Inventory.total_quantity))END as QuantityAvailable	 
		FROM ( 
			SELECT a.id as GearID, SUM(b.quantity) as quantity
            FROM gear_item as a
			JOIN reserved_item as b
				ON a.id = b.item_id
			JOIN request as c
				ON b.request_id = c.id
			JOIN status as d
				ON c.status_id = d.id
            WHERE (c.start_date between StartDate and EndDate || c.end_date between StartDate and EndDate) AND
				  (d.status LIKE '%requested%' OR d.status LIKE '%approved%' OR d.status like '%picked_up%')
			GROUP BY GearID) 
			as ReservedGears
		RIGHT JOIN gear_item as Inventory
			ON Inventory.id = ReservedGears.GearID
		JOIN size
			ON size.id = Inventory.size_id
		GROUP BY Inventory.id, Inventory.name, size.size;
 END$$
 DELIMITER ;
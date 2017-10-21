USE WTA;
DELIMITER ;
DROP PROCEDURE IF EXISTS get_gear_inventory;
DELIMITER $$
CREATE PROCEDURE `get_gear_inventory`()
BEGIN
		SELECT  Inventory.id, Inventory.name, 
			size.size,
			Inventory.total_quantity as TotalQuantity	 
		FROM gear_item as Inventory
		JOIN size
			ON size.id = Inventory.size_id
		GROUP BY Inventory.id, Inventory.name, size.size;
 END$$
DELIMITER ;

 CALL get_gear_inventory()
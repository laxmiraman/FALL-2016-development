USE WTA;
DELIMITER ;
DROP PROCEDURE IF EXISTS update_gear_inventory;
DELIMITER $$
CREATE PROCEDURE `update_gear_inventory`(IN `GearID` INT, IN `NewQuantity` INT)
BEGIN

UPDATE gear_item g 
SET g.total_quantity = NewQuantity 
WHERE g.id = GearID;

END$$
DELIMITER ;


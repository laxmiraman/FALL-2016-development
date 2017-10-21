use `wta`;

DELIMITER ;
DROP PROCEDURE IF EXISTS GetMoreGearDetails;
DELIMITER $$
CREATE PROCEDURE GetMoreGearDetails(IN `GearId` INT)
BEGIN
	SELECT id, `name`, image_url, care_maintenance, sizing_table, description FROM gear_item WHERE gear_item.id = GearId;    
	/*SELECT image_url.gi, care_maintenance.gi, sizing_table.gi, description.gi FROM gear_item gi WHERE id = '20';*/
END $$

/*CALL GetMoreGearDetails(300);*/
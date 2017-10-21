USE WTA;
DELIMITER $$

DROP PROCEDURE IF EXISTS gear_availability$$
DROP TABLE IF EXISTS output$$
DROP TABLE IF EXISTS temp$$
SET SQL_SAFE_UPDATES=0$$

CREATE PROCEDURE gear_availability(IN StartDate DATE, IN EndDate DATE)
BEGIN

	DECLARE item_id INT;
	DECLARE item_name VARCHAR(45);
	DECLARE size VARCHAR(45);
    DECLARE total_quantity INT;
	DECLARE reserved_quantity INT;
    DECLARE temp_date DATE;
    DECLARE done INT DEFAULT 0;
    
    DECLARE item_cur CURSOR FOR
		SELECT i.id, i.name, s.size, i.total_quantity FROM gear_item i JOIN size s ON i.size_id=s.id;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	CREATE TEMPORARY TABLE output
			(id INT, name VARCHAR(45), size VARCHAR(45), availability INT);

	CREATE TEMPORARY TABLE temp
			(requested_date DATE, availability INT);
	
    OPEN item_cur;
    item_loop:
    LOOP FETCH item_cur INTO item_id, item_name, size, total_quantity;

			IF done = 1 THEN
				LEAVE item_loop;
			END IF;
            
            SET temp_date = StartDate;
            DELETE FROM temp;
            
            /*Loops through each date of given date range*/
			WHILE(temp_date <= EndDate) DO
                
                /*Calcuates approved quantity for each date*/
				SELECT SUM(ri.quantity) INTO reserved_quantity FROM REQUEST r, RESERVED_ITEM ri 
				WHERE r.id = ri.request_id AND r.status_id IN (1, 2, 3)
				AND temp_date BETWEEN r.start_date AND r.end_date
				AND ri.item_id=item_id;
                
				INSERT INTO temp VALUES(temp_date, total_quantity-reserved_quantity);
                SET temp_date = DATE_ADD(temp_date, INTERVAL 1 DAY);
                
                
                
			END WHILE;
            INSERT INTO output VALUES
				(item_id, item_name, size,IFNULL((SELECT MIN(availability) FROM temp), total_quantity));

	END LOOP item_loop;
    CLOSE item_cur;
	
	/*Item Name and their available quantity for the given date range*/
    SELECT output.id, output.name, size.size, gender.gender, output.availability AS QuantityAvailable FROM output
    JOIN gear_item on gear_item.id = output.id
    JOIN size on size.id = gear_item.size_id 
    JOIN gender on gear_item.size_id = gender.id WHERE availability <> 0;

	DROP TABLE output;
    DROP TABLE temp;
    SET SQL_SAFE_UPDATES=0;

END$$

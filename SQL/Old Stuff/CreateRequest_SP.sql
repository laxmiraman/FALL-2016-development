DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateRequest`(IN StartDate DATE, IN EndDate DATE, IN JSON_data JSON, IN UserID INT)
BEGIN
-- TODO: Need to create function that checks if quantity is available

-- Create request in request table
select id into @status_id from status 
where request_status like '%Pending%';
INSERT INTO request(start_date, end_date, personnel_information_id,status_id) values(StartDate, EndDate, UserID, @status_id);
SET @request_id := (SELECT last_insert_id()); -- into RequestID;

-- Reserve the gear for the request
SET @gears := (SELECT JSON_EXTRACT(JSON_data, '$.gears'));
CALL reserve_gear(@gears, @request_id);
/*SELECT * FROM reserved_item as b
JOIN request as a ON
b.request_id = a.id;*/
END$$
DELIMITER ;

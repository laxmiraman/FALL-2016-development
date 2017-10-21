USE WTA;
DELIMITER ;
DROP PROCEDURE IF EXISTS get_admin_emails;
DELIMITER $$
CREATE PROCEDURE get_admin_emails()
BEGIN
		SELECT email
	        FROM personnel_info
            JOIN role
            ON personnel_info.role_id = role.id
	        WHERE role.role_name LIKE '%Administrator%';
END$$
DELIMITER ;

DROP procedure IF EXISTS get_upcoming_pickups;

DELIMITER $$
CREATE PROCEDURE get_upcoming_pickups(IN DAYS_FROM_PICK_UP INT)
BEGIN
    SELECT personnel_info.name, email
	    FROM personnel_info
        JOIN request
        ON personnel_info.id = request.customer_id
        JOIN status
        ON request.status_id = status.id
        /* find email when request start date - DAYS_FROM_PICK_UP equals today and the request
           status is approved */
	    WHERE SUBDATE(request.start_date, INTERVAL DAYS_FROM_PICK_UP DAY) = CURDATE() 
		    AND
		    status.status LIKE '%approved%';
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS get_upcoming_returns;
DELIMITER $$
CREATE PROCEDURE get_upcoming_returns(IN DAYS_FROM_RETURN INT)
BEGIN
		SELECT personnel_info.name, email
	        FROM personnel_info
            JOIN request
            ON personnel_info.id = request.customer_id
            JOIN status
            ON request.status_id = status.id
            /* find requests when request end date - DAYS_FROM_RETURN equals today and the request
               status is 'picked up' or 'approved' */
	        WHERE SUBDATE(request.end_date, INTERVAL DAYS_FROM_RETURN DAY) = CURDATE() 
		        AND
                (status.status LIKE '%approved%' OR status.status LIKE '%picked_up%');
END$$
DELIMITER ;
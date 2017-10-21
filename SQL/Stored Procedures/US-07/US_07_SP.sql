USE WTA;

DELIMITER ;
DROP PROCEDURE IF EXISTS approve_request;
DELIMITER $$
CREATE PROCEDURE approve_request(IN `RequestId` INT)
BEGIN
-- This procedure approves given request

UPDATE request set status_id=2 WHERE request.id = RequestId;

END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS get_new_requests;
DELIMITER $$
CREATE PROCEDURE get_requests() READS SQL DATA
BEGIN
	-- This procedure returns list of gear requests which is in 'Requested' and 'Approved' status
	SELECT rq.id request_id, rq.start_date, rq.end_date , cr.`name` requester, st.`status`
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        WHERE st.id IN (1,2);
        
END$$
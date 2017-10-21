use wta;

DROP PROCEDURE IF EXISTS RequestHistoryByTripLeader;
CREATE PROCEDURE RequestHistoryByTripLeader(IN `TripLeader` VARCHAR(50)) READS SQL DATA
	SELECT DISTINCT pi.name, gi.name, r.start_date, r.end_date, gi.total_quantity, s.status, gi.care_maintenance
	FROM personnel_info pi
	JOIN role c ON c.id = 1
	JOIN request r ON r.customer_id = pi.id
	JOIN reserved_item ri ON ri.request_id = r.id
	JOIN gear_item gi ON gi.id = ri.item_id
	JOIN status s ON r.status_id = s.id
	WHERE (pi.name = TripLeader AND r.end_date < CURDATE())
    GROUP BY (r.end_date);

DROP PROCEDURE IF EXISTS RequestHistoryDate;
CREATE PROCEDURE RequestHistoryByDate(IN `start_date` DATE, IN `end_date` DATE) READS SQL DATA
	SELECT DISTINCT pi.name, gi.name, r.start_date, r.end_date, gi.total_quantity, s.status, gi.care_maintenance
	FROM personnel_info pi
	JOIN role c ON c.id = 1
	JOIN request r ON r.customer_id = pi.id
	JOIN reserved_item ri ON ri.request_id = r.id
	JOIN gear_item gi ON gi.id = ri.item_id
	JOIN status s ON r.status_id = s.id
	WHERE (r.start_date >= start_date AND r.end_date <= end_date)
    GROUP BY (r.end_date);
    
/*
CALL RequestHistoryByTripLeader('Joe Gearborrower');
CALL RequestHistoryByTripLeader('Scott Shipp');
CALL RequestHistoryByDate('2016-11-05', '2016-11-12');

*/
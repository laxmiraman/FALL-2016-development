USE WTA;

DELIMITER ;
DROP PROCEDURE IF EXISTS get_gear_request_details;
DELIMITER $$
CREATE PROCEDURE get_gear_request_details(IN RequestID INT)
BEGIN
-- This procedure gets the details of a gear request

SELECT req.start_date, req.end_date, quantity, st.status, gi.name, gi.image_url, gi.care_maintenance, gi.sizing_table, gi.description, gi.total_quantity, g.gender, si.size FROM wta.request req
join reserved_item itm on req.id = itm.request_id
join status st on req.status_id = st.id
join gear_item gi on itm.item_id = gi.id
join gender g on gi.gender_id = g.id
join size si on gi.size_id = si.id
where req.id = RequestID;

END$$
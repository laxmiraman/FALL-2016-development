use `wta`;
   
DROP PROCEDURE IF EXISTS RequestsDueForReturn;
CREATE PROCEDURE RequestsDueForReturn() READS SQL DATA
	SELECT rq.id request_id, rq.end_date due_date, st.`status`, cr.`name` borrower, cr.email, 
			gr.gender, sz.size, gi.`name`, ri.quantity
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        JOIN reserved_item ri ON rq.id = ri.request_id
        JOIN gear_item gi ON ri.item_id = gi.id
        JOIN size sz ON gi.size_id = sz.id JOIN gender gr on gi.gender_id = gr.id
        WHERE st.id = 3;
        
DROP PROCEDURE IF EXISTS SetRequestStatus;
CREATE PROCEDURE SetRequestStatus(IN `RequestId` INT, IN `Status` INT)
	UPDATE request set status_id=`Status` WHERE request.id = RequestId;
    
DROP PROCEDURE IF EXISTS MarkRequestReturned;
CREATE PROCEDURE MarkRequestReturned(IN `RequestId` INT)
	UPDATE request set status_id=4 WHERE request.id = RequestId;
    
DROP PROCEDURE IF EXISTS ViewRequestDetail;
CREATE PROCEDURE ViewRequestDetail(IN `RequestId` INT) READS SQL DATA
	SELECT rq.id request_id, rq.end_date due_date, st.`status`, cr.`name` borrower, cr.email, 
			gr.gender, sz.size, gi.`name`, ri.quantity
		FROM request rq
        JOIN `status` st ON rq.status_id = st.id
        JOIN personnel_info cr ON rq.customer_id = cr.id
        JOIN reserved_item ri ON rq.id = ri.request_id
        JOIN gear_item gi ON ri.item_id = gi.id
        JOIN size sz ON gi.size_id = sz.id JOIN gender gr on gi.gender_id = gr.id
        WHERE rq.id = RequestId;
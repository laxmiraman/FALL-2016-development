USE WTA;

DELIMITER ;
DROP PROCEDURE IF EXISTS gear_request_trend;
DELIMITER $$
CREATE PROCEDURE gear_request_trend(IN ReportYear INT)
BEGIN
-- This procedure gets report of gear request trend across given year

SELECT
    trend.name,  
    SUM(CASE WHEN (trend.month='January') THEN trend.quantity ELSE 0 END) AS January,
    SUM(CASE WHEN (trend.month='February') THEN trend.quantity ELSE 0 END) AS February,
    SUM(CASE WHEN (trend.month='March') THEN trend.quantity ELSE 0 END) AS March,
    SUM(CASE WHEN (trend.month='April') THEN trend.quantity ELSE 0 END) AS April,
    SUM(CASE WHEN (trend.month='May') THEN trend.quantity ELSE 0 END) AS May,
    SUM(CASE WHEN (trend.month='June') THEN trend.quantity ELSE 0 END) AS June,
    SUM(CASE WHEN (trend.month='July') THEN trend.quantity ELSE 0 END) AS July,
    SUM(CASE WHEN (trend.month='August') THEN trend.quantity ELSE 0 END) AS August,
    SUM(CASE WHEN (trend.month='September') THEN trend.quantity ELSE 0 END) AS September,
    SUM(CASE WHEN (trend.month='October') THEN trend.quantity ELSE 0 END) AS October,
    SUM(CASE WHEN (trend.month='November') THEN trend.quantity ELSE 0 END) AS November,
    SUM(CASE WHEN (trend.month='December') THEN trend.quantity ELSE 0 END) AS December
FROM 
    (SELECT gear_item.name AS name,
	MONTHNAME(request.start_date) AS month,
	sum(reserved_item.quantity) AS quantity
	FROM reserved_item 
    LEFT JOIN gear_item ON reserved_item.item_id=gear_item.id
	INNER JOIN request
	ON reserved_item.request_id=request.id
	WHERE YEAR(request.start_date) = ReportYear OR YEAR(request.end_date) = ReportYear 
	GROUP BY gear_item.name, MONTHNAME(request.start_date)) 
AS trend
GROUP BY trend.name;

END$$
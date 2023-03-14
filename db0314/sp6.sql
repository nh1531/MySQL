drop procedure if exists pro6;
delimiter //
CREATE PROCEDURE pro6()
BEGIN
	select custid, count(*) as 구매권수, sum(saleprice)
	from orders 
	group by custid;
END;
//
delimiter ;
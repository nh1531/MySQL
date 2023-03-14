drop procedure if exists pro5;
delimiter //
CREATE PROCEDURE pro5()
BEGIN
	select b1.bookname
	from book b1
	where b1.price > (select avg(b2.price)
								from book b2
								where b2.publisher = b1.publisher);
END;
//
delimiter ;
drop procedure if exists pro4;
delimiter //
CREATE PROCEDURE pro4()
BEGIN
	select publisher, sum(saleprice)
	from book, orders
	where book.bookid = orders.bookid
	group by publisher;
END;
//
delimiter ;
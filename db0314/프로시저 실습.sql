use db0220;

#drop procedure if exists procedur_name;

# 1) InsertBook() 프로시저를 수정하여 고객을 새로 등록하는 InsertCustomer() 프로시저 작성하시오.
drop procedure if exists InsertCustomer;
delimiter //
CREATE PROCEDURE InsertCustomer(
 IN mycustid INTEGER,
 IN myname VARCHAR(40),
 IN myaddress VARCHAR(40),
 IN myphone INTEGER)
 # 매개변수는 컬럼명과 다른게 좋음
BEGIN
 INSERT INTO Customer(custid, name, address, phone)
 VALUES(mycustid, myname, myaddress, myphone);
END;
//
delimiter ;

/* 프로시저 InsertBook을 테스트하는 부분 */
CALL InsertCustomer(6, '이소희', '대한민국 부산', 000-4560-0001);
SELECT * FROM Customer;

# 2) BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오. 
# 삽입하려는 도서와 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다.
drop procedure if exists BookInsertOrUpdate;
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
 myBookID INTEGER,
 myBookName VARCHAR(40),
 myPublisher VARCHAR(40),
 myPrice INT)
BEGIN
 DECLARE mycount INTEGER;
 SELECT count(*) INTO mycount FROM Book
 WHERE bookname LIKE myBookName;
 IF mycount!=0 THEN
 SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */
 UPDATE Book SET price = myPrice
	WHERE price<myPrice;
 ELSE
 INSERT INTO Book(bookid, bookname, publisher, price)
 VALUES(myBookID, myBookName, myPublisher, myPrice);
 END IF;
END;
//
delimiter ; 

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
-- 없는값, 높은값, 낮은값 -> call 해서 보기
-- 없는 값
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
-- 있는 값인데 price 높음 -> update
-- 이 값만 남아있음
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 30000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
-- 있는 값인데 price 낮음 -> update
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인

-- 3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오. + cursor 사용
drop procedure if exists db0220.cursor_pro3;
delimiter //
CREATE PROCEDURE cursor_pro3()
BEGIN
	declare myname varchar(40);
    declare myprice int;
    declare endOfRow boolean default false; # 행의 끝인지 판단하는 플래그
    declare bookCursor cursor for select bookname, price from book where publisher = "이상미디어"; #커서 선언
    declare continue handler for not found set endOfRow=true; # 행의 끝일 때 handler 정의
    open bookCursor; # 커서 열기
    cursor_loop : Loop
		fetch bookCursor into myname, myprice; # fetch
        if endOfRow then leave cursor_loop;
        end if;
        select myname, myprice; # 화면에 뿌려줌
	end loop cursor_loop; # 루프 닫기
    close bookCursor; # 커서 닫기
END;
//
delimiter ;

call cursor_pro3(); -- 쿼리 한 행마다 각자 출력됨

-- 4) 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다)
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

call pro4();

-- 5) 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오
-- (예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다).
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

call pro5();

-- 6) 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오.
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

call pro6;

-- 7) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.
drop procedure if exists pro7;
delimiter $$
CREATE PROCEDURE pro7()
BEGIN
	-- 변수 선언
    declare done boolean default false;
    declare v_sum int;
    declare v_id int;
    declare v_name varchar(20);
    -- select한 결과를 cursor1로 정의
    declare cursor1 cursor for select custid, name from customer;
    declare continue handler for not found set done = true;
    open cursor1;
		my_loop : LOOP
        -- loop 하며 cursor1의 데이터를 불러와 변수에 넣는다
        fetch cursor1 into v_id, v_name;
			select sum(saleprice) into v_sum from Orders where custid=v_id;
			if done then
				leave my_loop;
            end if;
            select v_name, v_sum;
            end loop my_loop;
	close cursor1;
END;
$$
delimiter ;

call pro7;

# 예제 5-6 판매된 도서에 대한 이익을 계산하는 함수  fnc_Interest.sql
delimiter //
CREATE FUNCTION fnc_Interest(
Price INTEGER) RETURNS INT
BEGIN
DECLARE myInterest INTEGER;
-- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5%
IF Price >= 30000 THEN SET myInterest = Price * 0.1;
ELSE SET myInterest := Price * 0.05;
END IF;
RETURN myInterest;
END; //
delimiter ;

/* Orders 테이블에서 각 주문에 대한 이익을 출력 */
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest
FROM Orders;

show global variables like 'log_bin_trust_function_creators'; 
SET GLOBAL log_bin_trust_function_creators = 1;

#--------
-- 8) 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오. Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL 문도 작성하시오.
delimiter //
CREATE FUNCTION Grade(cid INTEGER) -- 매개변수
RETURNS varchar(10) -- retrun 자료형
BEGIN
	DECLARE total int; -- 변수선언
    select sum(saleprice) into total from Orders where custid=cid;
	IF total >= 20000 then 
		RETURN '우수';
	ELSE 
		RETURN '보통';
	END IF;
END; //
delimiter ;

-- 쿼리 안에 결과 넣기 -> into
-- into 안에 들어간 값을 if 사용해서 우수, 보통 판단하기

-- userFunc 함수 실행
SELECT name, Grade(custid) as Total from customer;

-- 9) 고객의 주소를 이용하여 국내에 거주하면 '국내거주', 해외에 거주하면 '국외거주'를 반환하는 함수 Domestic()을 작성하시오. 
-- Domestic()을 호출하여 고객의 이름과 국내/국외 거주 여부를 출력하는 SQL 문도 작성하시오
-- 10) (9)번에서 작성한 Domestic()을 호출하여 국내거주 고객의 판매 총액과 국외거주 고객의 판매총액을 출력하는 SQL 문을 작성하시오
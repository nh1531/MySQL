# 예제 5-4 Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저 
-- db0220
-- continue / exit 중 continue 
delimiter //
CREATE PROCEDURE Interest()
BEGIN
DECLARE myInterest INTEGER DEFAULT 0.0;
DECLARE Price INTEGER;
DECLARE endOfRow BOOLEAN DEFAULT FALSE;
DECLARE InterestCursor CURSOR FOR
SELECT saleprice FROM Orders;
DECLARE CONTINUE handler
FOR NOT FOUND SET endOfRow=TRUE;
OPEN InterestCursor;
cursor_loop: LOOP
FETCH InterestCursor INTO Price;
IF endOfRow THEN LEAVE cursor_loop;
END IF;
IF Price >= 30000 THEN
SET myInterest = myInterest + Price * 0.1;
ELSE
SET myInterest = myInterest + Price * 0.05;
END IF;
END LOOP cursor_loop;
CLOSE InterestCursor;
SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */
CALL Interest();

-- 예제 5-5 새로운 도서를 삽입한 후 자동으로 Book_log 테이블에 삽입한 내용을 기록하는 트리거
CREATE TABLE Book_log(
bookid_l INTEGER,
bookname_l VARCHAR(40),
publisher_l VARCHAR(40),
price_l INTEGER);

delimiter //
CREATE TRIGGER AfterInsertBook
AFTER INSERT ON Book FOR EACH ROW
BEGIN
DECLARE average INTEGER;
INSERT INTO Book_log
VALUES(new.bookid, new.bookname, new.publisher, new.price);
END;
//
delimiter ;

INSERT INTO Book VALUES(16, '스포츠 과학 1', '이상미디어', 25000);
SELECT * FROM Book WHERE BOOKID=16;
SELECT * FROM Book_log WHERE BOOKID_L='16' ; -- 결과 확인



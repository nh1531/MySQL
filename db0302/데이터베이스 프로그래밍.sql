-- 예제 5-1
-- Book 테이블에 한 개의 투플을 삽입하는 프로시저
use db0220;

delimiter //
CREATE PROCEDURE InsertBook(
IN myBookID INTEGER,
IN myBookName VARCHAR(40),
IN myPublisher VARCHAR(40),
IN myPrice INTEGER)
BEGIN
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES(myBookID, myBookName, myPublisher, myPrice);
END;
//
delimiter ;

/* 프로시저 InsertBook을 테스트하는 부분 */
CALL InsertBook(13, '스포츠과학', '마당과학서적', 25000);
CALL InsertBook(14, '야구과학', '마당과학서적', 3000);
SELECT * FROM Book;

-- 예제 5-2
-- 동일한 도서가 있는지 점검한 후 삽입하는 프로시저
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
WHERE bookname LIKE myBookName;
ELSE
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES(myBookID, myBookName, myPublisher, myPrice);
END IF;
END;
//
delimiter ;

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인
-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인

-- 프로젝트 시 직접 insert 하려 하지 말고 프로시저로 만들어서 쓰기

-- 예제 5-3 Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저 
delimiter //
CREATE PROCEDURE AveragePrice(OUT AverageVal INTEGER)
BEGIN
SELECT AVG(price) INTO AverageVal
FROM Book WHERE price IS NOT NULL;
END;
//
delimiter ;

/* 프로시저 AveragePrice를 테스트하는 부분 */
CALL AveragePrice(@myValue);
SELECT @myValue;
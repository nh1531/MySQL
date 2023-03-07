-- 상품 테이블 작성
CREATE TABLE 상품 (
  상품코드        VARCHAR(6) NOT NULL PRIMARY KEY,
  상품명           VARCHAR(30)  NOT NULL,
  제조사        VARCHAR(30)  NOT NULL,
  소비자가격  INT,
  재고수량     INT DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
   입고번호      INT PRIMARY KEY,
  상품코드      VARCHAR(6) NOT NULL,
  -- CONSTRAINT FK_ibgo_no REFERENCES 상품(상품코드),
  입고일자     DATE,
  입고수량      INT,
  입고단가      INT
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      int PRIMARY KEY,
  상품코드      VARCHAR(6) NOT NULL,
  -- CONSTRAINT FK_pan_no REFERENCES 상품(상품코드),
  판매일자      DATE,
  판매수량      int,
  판매단가      int
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;

-- 입출고 수량에 따라 재고수량 변동 
-- 입고 - 판매 - 재고 : 연동

use db0306;
-- 입고
delimiter //
CREATE TRIGGER afterin
AFTER INSERT ON 상품 FOR EACH ROW
BEGIN
DECLARE average INTEGER;
INSERT INTO 입고
VALUES(new.입고번호, new.상품코드, new.입고일자, new.입고수량, new.입고단가);
END;
//
delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */
INSERT INTO 입고 VALUES(1, 'FFF', 'curdate()', 11, 11500);
select * from 입고;
select * from 상품; 

-- 판매
DELIMITER //
CREATE TRIGGER afterout
AFTER DELETE
    ON 상품
    FOR EACH ROW
BEGIN
	delete to 판매
    values(old.판매번호, old.상품코드, old.판매일자, old.판매수량, old.판매단가);
END;
DELIMITER ;

delete from 판매 values(10, 

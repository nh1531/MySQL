use db0307;
-- 상품 테이블 작성
CREATE TABLE 상품 (상품코드 VARCHAR(6) NOT NULL PRIMARY KEY, 상품명 VARCHAR(30)  NOT NULL, 제조사 VARCHAR(30) NOT NULL, 소비자가격  INT, 재고수량  INT DEFAULT 0);

-- 입고 테이블 작성
CREATE TABLE 입고 (입고번호 INT PRIMARY KEY, 상품코드 VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 입고일자 DATE,입고수량 INT,입고단가 INT);

-- 판매 테이블 작성
CREATE TABLE 판매 (판매번호 INT  PRIMARY KEY,상품코드  VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 판매일자 DATE,판매수량 INT,판매단가 INT);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('EEEEEE', '프린터', '삼싱', 200000);

-- 입고 테이블에 자료 추가 테스트
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);


-- 트리거 종류 2가지 : before , after
-- insert -> new 값만 있음
-- update -> new, old
-- delete -> old 값만 있음

-- 1. [입고] 테이블에 상품이 입고되면 [상품] 테이블에 상품의 재고수량이 수정되는 트리거
-- 입고 테이블에 트리거 등록
delimiter //
CREATE TRIGGER afterInsert입고
AFTER INSERT ON 입고 FOR EACH ROW
BEGIN
	UPDATE 상품
    SET 재고수량 = 재고수량 + NEW.입고수량
	WHERE 상품코드 = NEW.상품코드;
END;
//
delimiter ;

-- 삭제 시
drop trigger afterInsert입고;

-- 2. [입고] 테이블에 수량이 수정되면 [상품] 테이블에 상품의 재고수량이 수정되는 트리거
delimiter //
CREATE TRIGGER afterUpdate입고
AFTER UPDATE ON 입고 FOR EACH ROW
BEGIN
	UPDATE 상품
    SET 재고수량 = 재고수량 -OLD.입고수량 + NEW.입고수량
	WHERE 상품코드 = NEW.상품코드;
END;
//
delimiter ;

-- 테스트
update 입고 set 입고수량 = 30 where 입고번호 = 1;

###
-- 3. [입고] 테이블에서 삭제(취소)하면 [상품]테이블에서 재고수량을 수정하는 트리거
delimiter //
CREATE TRIGGER afterDelete입고
AFTER DELETE ON 입고 FOR EACH ROW
BEGIN
	UPDATE 상품
    SET 재고수량 = 재고수량 -OLD.입고수량 
	WHERE 상품코드 = OLD.상품코드;
END;
//
delimiter ;

-- 테스트
delete 입고 

-- 4. [판매] 테이블에 자료가 추가되면 [상품]테이블에 상품의 재고수량이 변경되는 트리거
delimiter //
CREATE TRIGGER beforeInsert판매
AFTER INSERT ON 판매 FOR EACH ROW
BEGIN
	if(재고수량-판매수량>0) then
		SET 재고수량 = 재고수량 - old.판매수량;
    end if;
END;
//
delimiter ;

-- 5. [판매] 테이블에 자료가 변경되면 [상품] 테이블에 상품의 재고수량이 변경되는 트리거
delimiter //
CREATE TRIGGER beforeUpdate판매
AFTER UPDATE ON 판매 FOR EACH ROW
BEGIN
	
END;
//
delimiter ;

delimiter // 
CREATE TRIGGER StockOut
AFTER INSERT ON 판매 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	UPDATE 상품
    SET 재고수량 = 재고수량 - NEW.판매수량
	WHERE 상품코드 = NEW.상품코드;
END; 
// 
delimiter ;
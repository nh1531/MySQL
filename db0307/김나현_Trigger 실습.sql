-- 4. [판매] 테이블에 자료가 추가되면 [상품]테이블에 상품의 재고수량이 변경되는 트리거
delimiter //
CREATE TRIGGER beforeInsert판매
AFTER INSERT ON 판매 FOR EACH ROW
BEGIN
	UPDATE 상품
	if 재고수량-판매수량>0
		SET 재고수량 = 재고수량 - old.판매수량
    else
		
	WHERE 상품코드 = OLD.상품코드;
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
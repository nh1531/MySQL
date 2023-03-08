use db0308;

DROP TABLE IF EXISTS Summer; /* 기존 테이블이 있으면 삭제 */
CREATE TABLE Summer
( sid INTEGER,
class VARCHAR(20),
price INTEGER
);
INSERT INTO Summer VALUES (100, 'FORTRAN', 20000);
INSERT INTO Summer VALUES (150, 'PASCAL', 15000);
INSERT INTO Summer VALUES (200, 'C', 10000);
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);
/* 생성된 Summer 테이블 확인 */
SELECT * FROM Summer;

# 삭제이상
-- 200번 학생의 계절학기 수강신청을 취소하시오.

/* C 강좌 수강료 조회 */
SELECT price "C 수강료"
FROM Summer
WHERE class='C';

/* 200번 학생의 수강신청 취소 */
DELETE FROM Summer
WHERE sid=200;

/* C 강좌 수강료 다시 조회 */ -- => C 수강료 조회 불가능!!
SELECT price "C 수강료"
FROM Summer
WHERE class='C';

/* 다음 실습을 위해 200번 학생 자료 다시 입력 */
INSERT INTO Summer VALUES (200, 'C', 10000);

# 삽입이상
-- 계절학기에 새로운 자바 강좌를 개설하시오.

/* 자바 강좌 삽입 */ -- => NULL을 삽입해야 한다. NULL 값은 문제가 있을 수 있다.
INSERT INTO Summer VALUES (NULL, 'JAVA', 25000);

/* Summer 테이블 조회 */
SELECT * FROM Summer;

/* NULL 값이 있는 경우 주의할 질의 : 투플은 다섯 개지만 수강학생은 총 네 명임 */
SELECT COUNT(*) "수강인원"
FROM Summer;

SELECT COUNT(sid) "수강인원"
FROM Summer;

SELECT count(*) "수강인원"
FROM Summer
WHERE sid IS NOT NULL;

#수정이상
-- FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.


-- 1.모든 개체는 릴레이션으로 변환
-- 2.다대다(m:n) 관계는 릴레이션으로 변환
-- 3.일대일(1:1) , 일대다 관계는 외래키로 표현
-- 1:n에서 1쪽 기본키를 가져와서 n쪽에 집어넣기. 외래키인데 이름 다르게 넣을 수 있음 
-- 4.다중값 속성은 릴레이션으로 변환

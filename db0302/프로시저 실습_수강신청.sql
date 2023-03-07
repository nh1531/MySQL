-- 실습
-- db0221
# 새학과 stored procedure
delimiter //
CREATE PROCEDURE `새학과` (
	p학과번호 VARCHAR(2),
    p학과명 VARCHAR(20),
    p전화번호 VARCHAR(20) )

BEGIN
INSERT INTO 학과(학과번호, 학과명, 전화번호)
VALUES(p학과번호, p학과명, p전화번호);
END
// delimiter ;

CALL 새학과('04', '보안학과’, ‘022-200-7777'); -- 학과번호가 겹침
CALL 새학과('08', '컴퓨터보안학과’, ‘022-200-7000');

# 수강신청 통계 
delimiter //
CREATE PROCEDURE `통계` (
	out 학생수 int,
	out 과목수 int
)
BEGIN
	select count(학번) into 학생수 from 수강신청; 
    select count(distinct(과목번호)) into 과목수 from 수강신청내역; 
END
// delimiter 

-- CALL 통계(@a, @b, @c);
-- SELECT @a AS 학생수, @b AS 교수수, @c AS 과목수;
call 통계 (@a,@b);
select  @a AS 학생수, @b AS 과목수;

# 학과
delimiter //
CREATE PROCEDURE `학과_입력_수정` (
	p학과번호 VARCHAR(2),
    p학과명 VARCHAR(20),
    p전화번호 VARCHAR(20) )
BEGIN
	-- 입력 시 학과가 있는 경우는 업데이트, 없는 경우 입력이 되는 프로시저
    -- select 쿼리문 조회 결과를 into 절을 사용하여 변수에 대입
    -- count -> 변수의 유무
    DECLARE cnt int;
    select count(*) into cnt from 학과 where 학과번호 = p학과번호;
    
	IF (cnt=0) THEN 
		-- 학과가 없는 경우, insert
        INSERT INTO 학과 values (p학과번호, p학과명, p전화번호);
    ELSE
		-- update
        UPDATE 학과 set 학과명 = p학과명, 전화번호 = p전화번호 where 학과번호 = p학과번호;
    END IF;
END
// delimiter ;

call 학과_입력_수정('08','빅데이터보안학과','022-111-1111');

# 과목수강자수
#####
use db0221;
delimiter //
CREATE PROCEDURE `과목수강자수` (
	IN my과목번호 char(6),
    OUT 수강자수 INTEGER
)
BEGIN
	-- 검색 결과 변수에 저장
    SELECT count(*) INTO 수강자수 FROM 수강신청내역 WHERE 과목번호=my과목번호;
END
// 
delimiter ;

call 과목수강자수('K20002',@Count); -- 값 : 3
select @Count;

# 새수강신청
-- 수강신청 테이블에서 수강신청번호를 반환하는 저장 프로시저. 수강신청번호는 현재 이전 데이터의 다음 값 (이전 번호+1) , 날짜는 시스템상 
delimiter //
CREATE PROCEDURE `새수강신청` (
	in p학번 char(7),
    out p수강신청번호 int
)
BEGIN
	select max(수강신청번호) into p수강신청번호 from 수강신청;
	set p수강신청번호 = p수강신청번호 + 1;
	INSERT INTO 수강신청(수강신청번호,학번,날짜,연도,학기) VALUES(p수강신청번호, p학번, curdate(), '2023', '1');
END
// delimiter ;

-- 수강신청 테이블은 자식테이블. 부모 테이블에 없는 데이터를 넣을 수 없음. 참조무결성 위배
call 새수강신청('1804003', @수강신청번호);
select @수강신청번호;


alter table book drop primary key;
alter table book add primary key(bookid);

show index from orders;

-- SQL 내장 함수
-- db0220 order
-- 고객별 평균 주문 금액을 백 원 단위로 반올림한 값
select custid '고객번호', ROUND(SUM(saleprice)/COUNT(*),-2)'평균금액'
from orders
group by custid;

-- 문자함수 
-- replace : 문자열을 치환
-- 도서제목에 야구가 포함된 책을 농구로 변환
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price
from book;

-- length : 대상 문자열의 byte 변환, 알파벳 1byte, 한글 2byte 혹은 3byte (utf8)
-- char_length : 글자의 수를 세어주는 함수 ex.알파벳->3
-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자수

-- substr : 지정한 길이만큼 문자열을 반환하는 함수
 -- 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되늕니 성별 인원수를 구하시오
select substr(name, 1, 1) '성', count(*) '인원'
from customer
group by substr(name,1,1);

-- 날짜 . 시간 함수
-- 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
-- adddate(date,interval) : date형 날짜에서 interval 시간을 더한 날짜 반환
select orderid '주문번호' , orderdate '주문일' , adddate(orderdate,  interval 10 day) ' 확정일자'
from orders;

-- str_to_date : 문자형으로 저장된 날짜를 날짜형을 변환하는 함수
-- date_format : 날짜형을 문자형으로 변환하는 함수
-- 2014년 7월 7일에 주문받은 도서의 정보를 보이시오. 단, 주문일은 '%Y-%m-%d' 형태로 표시한다
select orderid'주문번호',str_to_date(orderdate, '%Y-%m-%d')'주문일',custid'고객번호',bookid'도서번호'
from orders
where orderdate=date_format('20140707','%Y-%m-%d');

-- sysdate : mysql의 현재 날짜와 시간을 반환하는 함수
select sysdate(),
		date_format(sysdate() ,'%Y/%m/%d %M %h:%s' ) 'sysdate_1';

-- 집계 함수 사용 시 주의
-- 'null + 숫자' 연산 결과는 null
-- ifnull : null 값을 다른 값으로 대치하여 연산하거나 다른 값으로 출력 . ifnull(속성, 값)
-- 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처 없음'으르 표시한다.
select name'이름' , ifnull(phone, '연락처없음') '전화번호'
from customer;

-- 내장 함수는 아니지만 자주 사용되는 문법 , 자료를 일부분만 확인하여 처리할 때 유용
-- mysql에서 변수는 이름 앞에 @ 기호를 붙이며 치환문에는 set과 := 기호를 사용함
-- 고객목록에서 앞의 2명만 보이시오
set @seq:=0;
select (@seq:=@seq+1) '순번', custid, name, phone
from customer
where @seq<2;

-- 부속질의 subquery : 하나의 sql문 안에 다른 sql문이 중첩된 질의
-- 스칼라 부속질의 - select 부속질의
select custid , (select name
				from customer cs
                where cs.custid = od.custid), sum(saleprice)
from orders od
group by custid;

-- join 
-- 부속쿼리를 쓸건지 join쿼리를 쓸건지는 편한대로. 결과는 똑같으니
select name, sum(saleprice) 'total'
from orders, customer
where orders.custid = customer.custid
group by orders.custid;

-- 인라인 뷰 - from 부속질의
-- 가상 테이블 뷰
-- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이르모가 고객별 판매액 출력)
select cs.name, sum(od.saleprice)'total'
from (select custid, name
		from customer
		where custid <= 2) cs,
        orders od
where cs.custid = od.custid
group by cs.name;

-- 중첩질의 - where 부속질의
-- 비교 연산자 : 부속질의가 반드시 단일 행, 단일 열을 반환해야 함벼, 아닐 경우 질의를 처리할 수 없음
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
					from orders);
                    
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오
-- 같은 릴레이션이지만 별칭을 다르게 씀
select orderid, custid, saleprice
from orders od
where saleprice > (select avg(saleprice)
					from orders so
                    where od.custid=so.custid);
-- 비교 >, <, <> ...
-- 집합 in, not in 
-- 한정 all, any
-- 존재 exists, not exists : 데이터의 존재 유무. 참, 거짓


-- VIEW 생성
-- CREATE VIEW 뷰이름 [(열이름 [ ,...n ])]
-- AS SELECT 문
-- Book 테이블에서 ‘축구’라는 문구가 포함된 자료만 보여주는 뷰
CREATE VIEW vw_Book
AS SELECT *
FROM Book
WHERE bookname LIKE '%축구%';

-- vw_Customer
CREATE VIEW vw_Customer
AS SELECT *
FROM Customer
WHERE address LIKE '%대한민국%';

-- VIEW 수정
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address
FROM Customer
WHERE address LIKE '%영국%';




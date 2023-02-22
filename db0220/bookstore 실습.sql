-- 출판사가 '굿스포츠', '대한미디어'가 아닌 책
select *
from book
where not (publisher='굿스포츠' or publisher='대한미디어');

-- '축구의 역사' 를 출간한 출판사 like, =
select bookname, publisher
from book
where bookname = '축구의 역사';
-- where bookname like '축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사 like %, _
select bookname, publisher
from book
where bookname like '%축구%';

-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서  패턴검색, like
select *
from book
where bookname like '_구%';

-- 복합조건
-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서
select *
from book
where bookname like '%축구%' and price >= 20000;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서 in or
select * 
from book
where publisher in ('굿스포츠', '대한미디어');

-- 도서를 이름순으로 
select * 
from book
order by bookname;

-- 도서를 가격순으로 검색, 가격이 같으면 이름순
select *
from book
order by price, bookname;

-- 도서를 가격 내림차순으로 검색. 가격이 같아면 출판사의 오름차순
select * 
from book
order by price desc, publisher asc;

-- 집계 함수(sum, avg, count, min, max)와 group by
-- 고객이 주문한 도서의 총 판매액
select sum(saleprice) as 총매출
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액
select sum(saleprice)
from orders
where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가
select sum(saleprice) as Total, avg(saleprice) as Average, min(saleprice) Minimun, max(saleprice) Maximum
from orders;

-- 마당서점의 도서 판매 건수
-- count [ all | distinct ] 속성
select count(*)
from orders;

-- group by (~별로)
-- 고객별로 주문한 도서의 총 수량과 총 판매액
-- group by 부분 소계 rollup (2개 컬럼 이상)
select custid, count(*) aS 도서수량, sum(saleprice) as 총액
from orders
group by custid with rollup;

-- 가격이 8,000원 이상(전체 조건) 도서를 구매한 고객에 대해 고객별 주문 도서의 총 수량. 단, 두 권 이상 구매한 고객만(group by 조건)
-- where -> 전체 조건, having -> gorup by의 조건
select custid, count(*) as 도서수량
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

-- customer 테이블을 order 테이블과 조건 없이 연결
-- 카디전 프로젝트 (기호 X) : 두 릴레이션에 속한 모든 투플의 집합
select * 
from customer, orders;

-- JOIN ->  select 자리에 "테이블명.필드명" , from절에 테이블이 2개 이상 올 때
-- 고객과 고객의 주문에 관한 데이터를 모두 보이시오
select *
from customer, orders
where customer.custid = orders.custid;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오
select name, sum(saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 고객의 이름과 고객이 주문한 도서이름
-- informal
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid
and book.bookid= orders.bookid;

-- 가격이 20,000원인 (조건) 도서를 주문한 고객의 이름과 도서의 이름
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid
and book.bookid= orders.bookid
and book.price = 20000;

-- 외부조인
-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격
-- R1 LEFT OUTER JOIN R2 ON 조인조건
-- formal
select customer.name, saleprice
from customer LEFT OUTER JOIN orders ON customer.custid = orders.custid;

-- 도서를 구매하지 않은 고객의 이름
select customer.name
from customer LEFT OUTER JOIN orders ON customer.custid = orders.custid
where saleprice is null;

-- 부속질의(subquery, SQL문 내에 또 다른 SQL문)
-- 가장 비싼 도서의 이름
select bookname
from book
where price = (SELECT max(price)
				FROM book);
                
-- 도서를 구매한 적이 있는 고객의 이름
-- subquery 밑에서 부터 올라오는 구조
select name 
from customer
where custid IN (SELECT custid FROM orders);

-- join ?? 중복제거?
select name
from customer join orders ON customer.custid = orders.custid
where orderid is not null;

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름
SELECT name
FROM customer
WHERE custid IN (SELECT custid
				FROM orders
                WHERE bookid IN (SELECT bookid
								FROM book
                                WHERE publisher = '대한미디어' ));
                                
-- join 
SELECT customer.name
FROM customer, orders, book
where customer.custid = orders.custid AND book.bookid= orders.bookid
AND book.publisher = '대한미디어'; 

-- 집합연산
-- 합집합 union, 차집합 minus, 교집합 intersect
-- 대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름
SELECT name
FROM customer
WHERE address like '대한민국%'
UNION 
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

-- 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 빼고 보이시오
SELECT name
FROM customer
WHERE address LIKE '대한민국%' AND 
	name NOT IN (SELECT name 
				FROM customer 
                WHERE custid IN (SELECT custid FROM orders));

-- 대한민국에서 거주하는 고객 중 도서를 주문한 고객의 이름
SELECT name
FROM customer
WHERE address LIKE '대한민국%' AND 
	name IN (SELECT name 
				FROM customer 
                WHERE custid IN (SELECT custid FROM orders));
                
                





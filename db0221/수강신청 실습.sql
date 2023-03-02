-- 1
select 이름 
from 학생;

-- 2
select 이름, 전화번호
from 교수;

-- 3
select *
from 수강신청;

-- 4 ??
select *
from 학생 join 수강신청
on 학생.학번 = 수강신청.학번
where 수강신청.연도 in "2018";

select 이름
from 학생
where 이름 not in (
					select 학생.이름
					from 학생
					inner join 수강신청 on 학생.학번 = 수강신청.학번
					where 연도 = '2018' and 학기 = '1' );

-- 5 
select 과목.과목명
from 학생, 수강신청, 수강신청내역,  과목
where 학생.학번 = 수강신청.학번 and
수강신청.수강신청번호 = 수강신청내역.수강신청번호 and
수강신청내역.과목번호 = 과목.과목번호
and 학생.이름 = '김민준' and 수강신청.연도 = '2018' and 수강신청.학기 ='1'; 

-- 6
select 이름
from 학생
order by 이름 asc;

-- 7
select 시도, 이름
from 학생
order by 시도, 이름 asc;

-- 8
select 시도, 이름
from 학생
order by 시도 desc, 이름 asc;

-- 9
select 시도, 이름
from 학생
order by 시도, 이름 desc;
-- order by 1 desc, 2 desc;

-- 10
select 수강신청번호, 학번, 날짜
from 수강신청
where 학번 = 1801001;

-- 11
select 수강신청번호, 학번, 날짜
from 수강신청
where 날짜 < '2018-01-01';

-- 12
select 과목번호, 과목명, 시수
from 과목
where 시수 in ('1','2','3');

-- 13
select 이름, 학과
from 교수
where 전화번호 is null;

-- 14
-- 사이에 (날짜 포함x)
select 학번, 날짜
from 수강신청
where 날짜 > '2018-01-01' and 날짜 < '2018-07-31';

-- 15
select 이름, 전자우편, 전화번호
from 교수
where 전화번호 is not null;

-- 16
select *
from 수강신청
where 학번 = 1601001 and 연도 = 2016;

-- 17
select *
from 수강신청
where 학번 in (1601002, 1801002);
-- where 학번 = '1601002' or 학번 = '1801002';

-- 18
select *
from 수강신청
where 학번 in (1601001, 1601002) and
연도 = 2016;

-- 19
select *
from 수강신청
where 학번 in (1601001, 1601002)
order by 학번;

-- 20
select *
from 수강신청
where 학번 != '1601001';
-- where 학번 <> '1601001';

-- 21
select *
from 교수
where 이름 like '김%';

-- 22
select *
from 학과
where 학과명 like '%공학%';

-- 23
select 과목번호, 과목명, 영문명
from 과목
where 영문명 like 'C%e';

-- 24
select *
from 학생
where 이름 like '%준';

-- 25 ??
select 수강신청번호, 과목번호, 평점
from 수강신청내역
where 과목번호 = 'K20045' or 과목번호 = 'K20056' and
평점 = 3;

select 수강신청번호, 과목번호, 평점
from 수강신청내역
where (과목번호 = 'K20045' or 과목번호 = 'K20056') and 평점 = 3;

-- 26 
select 수강신청번호, 과목번호, 평점
from 수강신청내역
where 과목번호 in ('K20045’, ‘K20056’, ‘Y00132')
order by 2;

-- 27
select *
from 수강신청내역
where 평점 != -1;

-- 28
select 학번, 이름, 시도
from 학생
where 학번 like '18%'; 

-- 29
select 학번, 이름, 시도, 시군구
from 학생
where 시군구 like '%구';

-- 30
select 과목번호, 과목명, 영문명
from 과목
where 영문명 like 'I%' and 영문명 like '%n';

-- 31 
select 과목번호, 과목명, 영문명
from 과목
where 과목명 like '컴퓨터__';

-- 32 
select 학번, 학과, 이름, 시도
from 학생
where 이름 like '%서%';

-- 33 
select concat(이름,'(', 주소, ' ', 시군구, 시도, 우편번호, ')') as '학생정보'
from 학생
order by 이름;

-- 34
select 과목명, 담당교수 as '담당교수사번'
from 과목;

-- 35
select 수강신청번호, concat(연도,'학년도-',학기,'학기') as 신청학년도
from 수강신청
where 학번 = 1801001;

-- 36
-- substring( ... , position, length)
select 학번, 이름, substring(이름, 1, 1) as 성
from 학생;

select 학번, 이름, left(이름, 1) as 성
from 학생;

-- 37
select 학번, 이름, 학년
from 학생
where left(학번,2) like '16';

-- 38
select 수.수강신청번호, 수.학번, 수.날짜
from 수강신청 수, 학생 학, 학과 과
where 과.학과번호 not in ('01') and
수.학번 = 학.학번 and 학.학과 = 과.학과번호;

select 수.수강신청번호, 수.학번, 수.날짜
from 수강신청 수, 학생 학, 학과 과
where 과.학과명 <> '컴퓨터정보학과' and
수.학번 = 학.학번 and 학.학과 = 과.학과번호;

-- 39 
select 수강신청번호, 학번, 날짜
from 수강신청
where year(날짜)=2018 and month(날짜)=03;

-- 40 
-- 제어문
select 수강신청번호, 학번, 날짜,
IF(평점>0, 취득, 미취득) AS 취득여부
from 수강신청내역
where 평점 not in ('-1');

-- if(조건, 조건이 참일 때 출력, 조건이 거짓일 때 출력)
select 수강신청번호, 과목번호, 평점, if (평점=0, '미취득', '취득') as 취득여부
from 수강신청내역
where 평점 <> -1;

-- 41 
select concat(이름,'(',시도,')') as 이름
from 학생;

-- 42
select 담당교수, concat(과목명, '(', 영문명, ')') as 과목명 
from 과목;

-- 43
select 과목명, 학점, (시수*15) 총시간수
from 과목;

-- 44
select 학번, substr(이름,2) 이름
from 학생;

select 학번, right(이름,2) 이름
from 학생;

-- 45 
select 학번, 날짜
from 수강신청
where month(날짜)=3 and day(날짜)=1;

-- 46 
-- if(조건, 조건이 참이면, 조건이 거짓이면)
select 생.학번, 생.이름, 생.학과, if(과.학과명='컴퓨터정보학과','컴퓨터정보학과','타과')as 비고
from 학생 생, 학과 과
where 생.학과 = 과.학과번호;

-- 47
select count(*) as 신청수 from 수강신청내역;

-- 48
select count(*) as 과목수
from 수강신청내역
where 수강신청번호 = '1810002';

-- 49
select count(*) as '교수 수'
from 교수
where 전화번호 is not null;

-- 50
select count(DISTINCT 담당교수) as '강의 교수 수'
from 과목;

-- 51
select avg(학점) '평균학점', sum(학점) '총학점'
from 과목;

-- 52
select min(학점) '최소학점', max(학점) '최대학점'
from 과목;

-- 53 
-- ~별 -> group by
select 담당교수, count(과목명) as 과목수, sum(학점) as 학점수
from 과목
group by 담당교수;

-- 54
select count(DISTINCT 과목번호) as '과목 수'
from 수강신청내역;

-- 55
select count(DISTINCT 학번) as '학생 수'
from 수강신청;

-- 56
select count(과목번호) as '과목수', avg(평점) '평균평점'
from 수강신청내역
where 수강신청번호 = '1810001';

-- 57 
select 과목번호, count(수강신청번호) as '수강자 수'
from 수강신청내역
group by 과목번호;

-- 58
select 과목번호, count(수강신청번호) as '수강자 수'
from 수강신청내역
where 평점 not in(-1)
-- where 평점 <> -1
group by 과목번호;

-- 59
select 과목번호, count(수강신청번호) as '수강자 수', avg(평점) '평균평점'
from 수강신청내역
where 평점 not in(-1)
group by 과목번호;

-- 60
select 과목번호, count(수강신청번호) as '수강자 수', avg(평점) '평균평점'
from 수강신청내역
where 평점 not in(-1) 
group by 과목번호
having count(수강신청번호)>3;

-- 61
select 과목번호, count(수강신청번호) as '수강자 수', avg(평점) '평균평점'
from 수강신청내역
where 평점 not in(-1) 
group by 과목번호
having count(*)>3
order by avg(평점);

-- 62 
select 수강신청번호, count(*) as '수강과목 수', avg(평점) '평균평점'
from 수강신청내역
where 평점 <> -1
group by 수강신청번호
having count(*) >= 3
order by 평균평점 desc;

-- 63
-- 유일한 항목이면 학과.학과명 이렇게 안써도 됌
select 학번, 학과, 이름, 학과명
from 학생, 학과
where 학생.학과 = 학과.학과번호;

-- 64
-- 71과 동일
select 
from
where

-- 65 
select 수강신청번호, 학생.학번, 이름
from 수강신청, 학생
where 수강신청.학번 = 학생.학번 
and year(날짜)=2018;

-- 66
-- 67과 중복
select 수강신청.수강신청번호, 수강신청내역.과목번호, 과목명
from 수강신청, 수강신청내역, 과목
where 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 수강신청내역.과목번호=과목.과목번호
and 학번 = '1801001';

-- 68
select count(*) as 과목수, sum(평점) as 평점합계
from 수강신청, 수강신청내역, 과목
where 수강신청.수강신청번호 = 수강신청내역.수강신청번호 and 수강신청내역.과목번호=과목.과목번호
and 학번 = '1801001';

-- 69
-- ~별로 -> group by
select 수강신청.수강신청번호, 수강신청.학번, 이름, sum(평점)/count(수강신청내역.과목번호) as 평균평점
from 학생, 수강신청, 수강신청내역, 과목
where 학생.학번= 수강신청.학번 and 수강신청.수강신청번호 = 수강신청내역.수강신청번호 
and 수강신청내역.과목번호 = 과목.과목번호 and 평점<>-1
group by 수강신청.수강신청번호;

-- 70. 72. 73 중복
-- 71
select 수강신청번호, 과목.과목번호, 과목.과목명
from 수강신청내역, 과목
where 수강신청내역.과목번호 = 과목.과목번호 and 수강신청번호 in ('1810001', '1610001');

-- 74
-- 서브쿼리
-- 사번이 1000004인 학과를 먼저 찾고나서 다시 질의
select 사번, 학과, 이름
from 교수
where 학과 = (select 학과
from 교수
where 사번='1000004');

-- 76
-- ~별로 -> group by
select 과목.과목번호, 과목명, count(*)as 수강인원, avg(평점) as 평균평점
from 과목, 수강신청내역
where 과목.과목번호 = 수강신청내역.과목번호 and 학기 = '1'
group by 과목.과목번호;
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

-- 33 ??
select (이름, 주소, 시군구, 시도, 우편번호) as '학생정보'
from 학생
order by 이름;

-- 34
select 과목명, 담당교수 as '담당교수사번'
from 과목;

-- 35
select 수강신청번호, concat(연도,'학년도-',학기,'학기')
from 수강신청
where 학번 = 1801001;

-- 36
-- substring( ... , position, length)
select 학번, 이름, substring(이름, 1, 1) as 이
from 학생;

-- 37
select 학번, 이름, 학년
from 학생
where 학번 like '16%';

-- 38
select 수강신청번호, 학번, 날짜
from 수강신청
where 
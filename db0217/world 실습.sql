-- 국가 코드가 "KOR"인 도시를 찾아 인구수를 역순으로 표시하시오. order by
select Name as 도시명, Population as 인구수
from city
where CountryCode = 'KOR'
order by Population desc;

-- city 테이블에서 국가코드와 인구수를 출력하라. 정렬은 국가코드별로 오름차순으로, 동일한 코드(국가) 안에서는 인구 수의 역순으로 표시하라 order by
select CountryCode, Population
from city
order by CountryCode, Population desc;

-- city 테이블에서 국가 코드가 'KOR', 'CHN', 'JPN'인 도시를 찾으시오. in
select Name
from city
where CountryCode in ('KOR', 'CHN', 'JPN');

-- 국가코드가 'KOR'이면서 인구가 100만 이상인 도시를 찾으시오. and
select Name
from city
where CountryCode='KOR' and Population>=1000000;

-- 국가 코드가 'KOR'인 도시 중 인구수가 많은 순서로 상위 10개만 표시하시오 order by limit
select Name
from city
where CountryCode='KOR' 
order by Population desc limit 10;

-- city 테이블에서 국가코드가 'KOR'이고, 인구가 100만 이상 500만 이하인 도시를 찾으시오. and, between
select name, Population
from city
where Population
between 1000000 and 5000000
and CountryCode = 'KOR';

-- <함수>
-- city 테이블에서 국가코드가 'KOR'인 도시의 수를 표시하시오.
-- Hint) count
select count(CountryCode) as 도시수
from city
where CountryCode = 'KOR' ;

-- city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 총합을 구하시오.
-- Hint) sum
select sum(Population)
from city
where CountryCode = 'KOR';

-- city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최소값을 구하시오. 단 결과를 나타내는 테이블의 필드는 "최소값"으로 표시하시오
-- Hint) min
select min(Population) as 최소값
from city
where CountryCode = 'KOR';

-- city 테이블에서 국가코드가 'KOR'인 도시들의 평균을 구하시오.
-- Hint) avg
select avg(Population) as 평균값
from city
where CountryCode = 'KOR';

-- city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최대값을 구하시오. 단 결과를 나타내는 테이블의 필드는 "최대값"으로 표시하시오.
-- Hint) max
select max(Population) as 최대값
from city
where CountryCode = 'KOR';

-- country 테이블 각 레코드의 Name 칼럼의 글자수를 표시하시오.
-- Hint) length()
select length(Name)
from country;

-- country테이블의 나라명(Name 칼럼)을 앞 세글자만 대문자로 표시하시오.
-- Hint) upper, mid 함수
select upper ( mid(Name, 1,3) )
from country;

-- country테이블의 기대수명(LifeExpectancy)을 소수점 첫째자리에서 반올림해서 표시하시오.
-- Hint) round()
select round(LifeExpectancy , 1)
from country;
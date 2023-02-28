-- 1 영어를 사용하는 나라의 수
select count(cl.Language)
from country c, countrylanguage cl
where c.Code = cl.CountryCode
and cl.Language = 'English';

-- 2 대한민국이 사용하는 언어
select cl.Language
from country c, countrylanguage cl
where c.Code = cl.CountryCode
and c.Code = 'KOR';

-- 3 영어를 공식언어로 사용하는 나라의 대륙과 이름
select c.Name, c.Continent
from country c, countrylanguage cl
where cl.Language = 'English' and cl.IsOfficial = 'T'
and c.Code = cl.CountryCode;

-- 4 영어를 사용하는 나라의 수를 대륙별로 출력
select c.Continent, count(c.Name) as count 
from country c, countrylanguage cl
where c.Code = cl.CountryCode
and cl.Language = 'English'
group by c.Continent;


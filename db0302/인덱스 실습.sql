-- 테이블의 색인 정보를 확인
show index from dept_emp;

-- 테이블과 관련된 정보를 조회
show table status like 'dept_emp';
-- 'Index_length' 열은 기본키를 제외한 색인을 저장하는 페이지 수에 페이지 크기를 곱한 결과로 바이트 수이다

-- dept_emp 테이블에 설정된 색인을 삭제
-- 외래키 설정과 dept_emp 열에 설정된 색인만 삭제
alter table dept_emp drop foreign key dept_emp_ibfk_1;
alter table dept_emp drop foreign key dept_emp_ibfk_2;
drop index dept_no on dept_emp;

-- 테이블을 다시 분석해서 관련 정보를 업데이트하고 테이블의 색인 정보를 확인
analyze table `dept_emp`;
show index from dept_emp;

-- 테이블의 기본키 정보까지 삭제
alter table `dept_emp` drop primary key;

-- 실행 계획을 확인하는 방법으로 'explain', ...

-- 테이블에서 첫 번째 행의 데이터를 조회
select * from dept_emp order by emp_no asc limit 1;

-- 테이블에서 마지막 행의 데이터를 조회
select * from dept_emp order by emp_no desc limit 1;

-- 첫 번째 행과 마지막 행의 실행 계획 결과? Full scan
select count(*) from dept_emp;
explain select * from dept_emp where emp_no = 10001;
explain select * from dept_emp where emp_no = 499999;

-- 모두 삭제한 색인 중 기본키 다시 설정
-- rows 값 1로 변함. 효율성 좋아짐
alter table dept_emp add primary key (emp_no, dept_no);
explain select * from dept_emp where emp_no = 10001;
explain select * from dept_emp where emp_no = 499999;

-- index (색인) 사용 목적 : 데이터 조회하는 시간이 최소화 된다. 

-- 색인이 설정되지 않은 'dept_no' 열을 사용하여 데이터를 조회하는 쿼리
select count(*) from dept_emp where dept_no = 'd006';
explain select * from dept_emp where dept_no = 'd006';

-- on 테이블명(필드명)
create index dept_emp on dept_emp(dept_no); 
explain select * from dept_emp where dept_no = 'd006';

-- 색인을 설정한 dept_no 열과 색인을 설정하지 않은 from_date 열을 사용하여 복합조건을 설정한 select
select * from dept_emp where dept_no = 'd006' and from_date = '1996-11-24';
explain select * from dept_emp where dept_no = 'd006' and from_date='1996-11-24';

create index from_date on dept_emp(from_date);
select * from dept_emp where dept_no= 'd006' and from_date = '1996-11-24';
explain select * from dept_emp where dept_no = 'd006' and from_date='1996-11-24';

-- 'dept_emp' 테이블과 'employess' 테이블을 join 하는 경우
-- 색인 설정 여부에 따라 실행 계획의 차이를 확인하기 위해 다음의 쿼리문을 실행하여 두 개의 테이블에 설정된 모든 색인 삭제
alter table `dept_emp` drop primary key;
alter table `dept_emp` drop index `dept_emp`;
alter table `dept_emp` drop index `from_date`;
analyze table dept_emp;

-- employees
alter table dept_manager drop foreign key dept_manager_ibfk_1;
alter table titles drop foreign key titles_ibfk_1;
alter table employees drop primary key;
analyze table employees, dept_emp;

explain select a.emp_no, b.first_name, b.last_name
from dept_emp a inner join employees b
on a.emp_no = b.emp_no;

-- 조건이 있던 없든 검색 횟수는 똑같다
explain select a.emp_no, b.first_name, b.last_name
from dept_emp a inner join employees b
on a.emp_no = b.emp_no
where a.emp_no = 10001;

alter table employees add primary key(`emp_no`);
alter table dept_no add primary key(`emp_no`,`dept_no`);

-- where, join 많이 하면 index 넣으면 효율적
-- insert, delete 등 데이터 변경이 많으면 색인 넣지 않는 것이 좋음

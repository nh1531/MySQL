use db0220;
-- 트랜잭션
commit;
rollback;

-- mysql은 기본적으로 자동커밋 상태
select @@autocommit;

-- 수동으로 사용하고 싶다면
SET autocommit = 0;

-- 테이블 복사
create table book1 (select * from book);
create table book2 (select * from book);

delete from book1;
rollback;

-- rollback or commit을 하면 트랜잭션 한 단위가 끝남
-- 자동커밋 상태(autocommit= 1)에서 start transaction
-- 원래 자동커밋 상태이면 delete시 복구가 되지 않지만 rollback하면 살아남
start transaction;
delete from book1;
delete from book2;
rollback;

start transaction;
savepoint A;
delete from book1;
savepoint B;
delete from book2;
-- rollback 범위 지정
rollback to savepoint B;
commit; 


use db0307;
create table account(
accNum char(10) primary key,
amount int not null default 0
);

insert into account values('A', 45000);
insert into account values('B', 98000);
-- A 계좌에서 4만원을 출금해서 B 계좌로 송금한다 (쿼리문)
start transaction;
update account 
set amount = amount - 40000
where accNum = 'A';

update account
set amount = amount + 40000
where accNum = 'B';
rollback;

-- 계좌 금액이 부족할 경우 인출이 되지 않는 trigger
-- 예외처리 해야 함
delimiter //
CREATE TRIGGER `after_BEFORE_UPDATE`
BEFORE UPDATE ON account FOR EACH ROW
BEGIN
	if(new.amount<0) then
		signal sqlstate '45000'; -- *
	end if;
END;
//
delimiter ;

-- procedure
delimiter //
CREATE PROCEDURE `account_transaction`(
in sender char(15),
in recip char(15),
in _amount int
)
BEGIN
	declare exit handler for sqlexception rollback; -- *
    start transaction;
	update account 
	set amount = amount - _amount
	where accNum = sender;

	update account
	set amount = amount + _amount
	where accNum = recip;
    commit;
END
//
delimiter ;

-- 돈이 모자라서 실행되지 않는 경우에는 rollback 됨
call account_transaction ('A','B', 1000);

-- 프로시저 + 트리거 + 트랜잭션 연결하는 예제
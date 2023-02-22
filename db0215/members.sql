create table members (
memid varchar(10) not null,
memname varchar(20) not null,
passwd varchar(128),
passwdmdt datetime,
jumin varchar(64),
addr varchar(100),
birthday date,
jobcd char(1),
-- ( 총 숫자길이, 소수점 이하 자릿수 ) --
-- unsigned 부호 없음 --
-- default : 값을 넣지 않아도 자동으로 0이 들어가있음. null이 안됨 --
mileage decimal(7,0) unsigned default 0,
-- enum : list 중에서 선택 가능
stat enum('Y','N') default 'Y',
-- 시스템의 날짜 가지고 와서 넣어줌 DEFAULT CURRENT_TIMESTAMP() -> 함수니까 () --
enterdtm datetime DEFAULT CURRENT_TIMESTAMP(),
leavedtm datetime,
primary key(memid)
);

INSERT  INTO members (memid, memname, addr, birthday, jobcd, mileage, enterdtm) VALUES ('hong1', '홍길동', '인천 동구 송림동', '2000-05-08', '2', 500, '2022-03-01 14:10:27');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, mileage, enterdtm) VALUES	('hong2', '홍길동', '서울 강남구 신사동', '1990-01-05', '9', 1000,  '2022-03-01 14:11:50');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('kim1', '김갑수', '인천 연수구 연수동', '2003-07-01', '1', '2022-03-01 14:12:39');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('park', '박기자', '경기 부천시', '2002-09-30', '3', '2022-03-01 14:13:16');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES ('seo', '서갑돌',  '인천 동구', '1998-03-10', '1', '2022-03-01 14:08:41');
INSERT  INTO members (memid, memname, addr, birthday, jobcd, enterdtm) VALUES	('Taeh', '태현', '경기 수원시', '2002-10-15', '4', '2022-03-01 14:15:10');


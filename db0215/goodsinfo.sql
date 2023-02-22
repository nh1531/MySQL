create table goodsinfo(
goodscd char(5) not null,
goodsname varchar(20) not null,
unitcd char(2),
unitprice decimal(5,0) unsigned default 0,
stat enum('Y','N'),
insdtm datetime,
moddtm datetime,
primary key(goodscd)
);

INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS01', '노트', '01', '2000', '2022-03-01 14:42:44');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS02', '연필', '02', '100', '2022-03-01 14:43:17');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS03', '복사지', '03', '5000', '2022-03-01 14:43:47');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS04', '볼펜', '02', '500', '2022-03-01 14:44:13');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS05', '네임펜', '02', '1000', '2022-03-01 14:44:30');
INSERT INTO goodsinfo (goodscd, goodsname, unitcd, unitprice, insdtm) VALUES ('GDS06', '크레파스', '02', '1500', '2022-03-01 14:45:30');

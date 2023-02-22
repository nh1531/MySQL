create table order_h(
orderno char(9) not null,
orddt date not null,
memid varchar(10) not null,
ordamt decimal(7,0) unsigned default 0,
cancelyn char(1) default 'N',
canceldtm datetime,
insdtm datetime,
moddtm datetime,
primary key(orderno)
);

INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES  ('202201001', '2022-01-24', 'seo', '10000', '2022-03-01 14:49:07');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201002', '2022-01-24', 'hong2', '15000', '2022-03-01 14:50:35');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201003', '2022-01-25', 'hong1', '20000', '2022-03-01 14:51:19');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202201004', '2022-01-25', 'kim1', '10000', '2022-03-01 14:51:58');
INSERT INTO order_h (orderno, orddt, memid, ordamt, cancelyn, canceldtm, insdtm) VALUES ('202201005', '2022-01-25', 'park', '5000', 'Y', '2022-01-25 00:00:00', '2022-03-01 14:53:12');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202001', '2022-02-01', 'hong1', '30000', '2022-03-01 14:54:09');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202002', '2022-02-01', 'hong1', '1000', '2022-03-01 14:54:40');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202003', '2022-02-02', 'park', '10000', '2022-03-01 14:55:28');
INSERT INTO order_h (orderno, orddt, memid, ordamt, insdtm) VALUES ('202202004', '2022-02-02', 'abcd', '500', '2022-03-01 14:56:03');
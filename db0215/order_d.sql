create table order_d(
orderno char(9) not null,
goodscd char(5) not null,
unitcd char(2),
unitprice decimal(5,0) unsigned default 0,
qty decimal(3,0) unsigned default 0,
amt decimal(7,0) unsigned default 0,
insdtm datetime DEFAULT CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(orderno, goodscd)
);

INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:10:39');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS02', '02', '100', '50', '5000', '2022-03-01 15:11:39');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201001', 'GDS03', '03', '5000', '1', '5000', '2022-03-01 15:12:23');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201002', 'GDS01', '01', '1000', '5', '5000', '2022-03-01 15:13:28');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201002', 'GDS03', '03', '5000', '10', '50000', '2022-03-01 15:14:26');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201003', 'GDS04', '02', '500', '50', '25000', '2022-03-01 15:15:12');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201004', 'GDS05', '02', '1000', '10', '10000', '2022-03-01 15:15:59');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201005', 'GDS02', '02', '100', '50', '5000', '2022-03-01 15:16:45');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201005', 'GDS03', '03', '5000', '4', '20000', '2022-03-01 15:17:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202201006', 'GDS01', '01', '2000', '1', '2000', '2022-03-01 15:18:08');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:18:59');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS03', '03', '5000', '1', '5000', '2022-03-01 15:19:10');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202001', 'GDS05', '02', '1000', '20', '20000', '2022-03-01 15:19:20');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202003', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:19:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202003', 'GDS07', '03', '2000', '20', '40000', '2022-03-01 15:20:30');
INSERT INTO order_d (orderno, goodscd, unitcd, unitprice, qty, amt, insdtm) VALUES ('202202004', 'GDS01', '01', '2000', '10', '20000', '2022-03-01 15:21:18');
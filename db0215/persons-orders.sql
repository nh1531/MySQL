create table Persons(
id int not null,
lastname varchar(255) not null,
firstname varchar(255),
age int,
primary key(id)
);

insert into persons values(1, 'Hansen', 'ola', 30);
insert into persons values(2, 'Svendson', 'tove', 23);
insert into persons values(3, 'Pettersen', 'kan', 20);

create table orders(
orderid int not null,
ordernumber int not null,
personid int,
primary key(orderid),
foreign key(personid) references persons(id)
);

insert into orders values(1, 77895, 3);
insert into orders values(2, 44678, 3);
insert into orders values(3, 22456, 2);
insert into orders values(4, 24562, 1);
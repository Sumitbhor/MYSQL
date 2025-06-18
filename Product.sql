create database Product ;
use Product;
create table product(id int, name varchar(8), unit_price int, quantity int,description varchar (4) );
insert into product values(1,"table", 5000,100,'good');
insert into product values(2,"sofa", 2500,200,'good');
insert into product values(3,"chair", 700,300,'good');
insert into product values(4,"bed", 15000,400,'good');
insert into product values(5,"cupboard", 10500,500,'good');
select * from product;
drop table product ;
 update product set description ="bad" where id = 1 ;
 delete from product where description= "bad" and quantity=500;
 select id , name from product ; 
 ALTER TABLE product MODIFY COLUMN description varchar(82);
describe product
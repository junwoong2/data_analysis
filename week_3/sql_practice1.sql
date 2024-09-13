## 데이터 베이스 생성하기
use shop;

-- create table tb_user(
-- 	user_id int,
--     user_name varchar(10),
--     phone char(13)
-- );

-- desc tb_user;

create table tb_product(
	product_id int primary key auto_increment,
    product_name varchar(20) unique not null,
	product_price int
);
desc tb_product;

alter table tb_user add user_addr varchar(255);
desc tb_user;

-- 컬럼명 수정하기
alter table tb_user change phone user_phone varchar(50);
desc tb_user;

-- 컬럼 타입 수정하기
alter table tb_user modify column user_phone varchar(13);
desc tb_user;

-- 컬럼에 제약조건과 속성 추가
alter table tb_user modify column user_id int primary key auto_increment;
desc tb_user;

-- 컬럼 삭제하기
alter table tb_user add user_age int;
alter table tb_user drop user_age;
desc tb_user;

-- not null 제약조건 추가
alter table tb_user modify column user_name varchar(10) not null;
alter table tb_user modify column user_phone varchar(13) not null;
alter table tb_user modify column user_addr varchar(255) not null;

create table tb_order(
	order_id int primary key auto_increment,
    user_id int,
    product_id int,
    order_dt datetime default current_timestamp,
    foreign key(user_id) references tb_user(user_id),
    foreign key(product_id) references tb_product(product_id)
);
desc tb_order

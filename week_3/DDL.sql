# MySQL 주석
-- 한줄 주석
 #한줄주석
 /*
 여러줄 주석!!!!
 ...
 */

# DDL
-- 데이터베이스와 테이블을 정의하는 언어
-- 학습내용: database 와 table 생성, 수정, 삭제 

## 데이터 베이스 생성하기
create database shop;

## 데이터 베이스 삭제하기
drop database if exists shop;

create database shop;

## 데이터 베이스 목록 확인하기
show databases;

## 선택된 데이터 베이스 확인해보기
select database();

## 데이터 베이스 선택하기
use shop;

## 테이블 생성하기
create table tb_user(
	user_id int,
	user_name varchar(10),
    phone char(13) 
);

## 테이블 구조확인하기
desc tb_user;

## 테이블 삭제하기
-- drop table if exists tb_user;  

## 제약 조건이란?
-- 데이터를 삽입할 때 무조건 삽입되는 게 아니라 어떠한 조건이 만족했을 경우만 삽입 가능하게 하는 제약
-- primary key(기본키): 테이블의 각 행을 고유하게 식별하는 역할을 하는 컬럼
-- auto_increments 는 해당 컬럼에 값을 넣어주지 않아도 자동으로 1씩 증가하면서 들어간다.
-- unique 는 중복을 허용하지 않음.
-- not null 은 null 값을 허용하지 않는다.
create table tb_product(
	product_id int primary key auto_increment, 
    product_name varchar(20) unique not null,
    product_price int
);
desc tb_product;

## 테이블 수정하기
-- 컬럼 추가하기
alter table tb_user add user_addr varchar(255);
desc tb_user;

-- 컬럼명 수정하기
alter table tb_user change phone user_phone varchar(50);
desc tb_user;

-- 컬럼타입 수정하기
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
desc tb_user;
alter table tb_user modify column user_phone varchar(13) not null;
alter table tb_user modify column user_addr varchar(255) not null;

## 주문 테이블 만들기
-- 주문id, 고객id, 상품id, 주문시간
-- 외부키(foreign key)
	-- 한 테이블의 컬럼이 다른 테이블의 기본 키와 연결되어 있음을 나타내는 제약조건
    -- 다른 테이블의 기본키를 참조하는 컬럼 데이터
    -- 기본키를 보유한 테이블 부모, 외부키를 보유한 테이블을 자식 
create table tb_order(
	order_id int primary key auto_increment,
    user_id int,
    product_id int,
    order_dt datetime default current_timestamp,
    foreign key(user_id) references tb_user(user_id),
    foreign key(product_id) references tb_product(product_id)
);

desc tb_order;

  













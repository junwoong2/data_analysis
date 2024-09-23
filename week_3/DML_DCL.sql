# DML
-- 테이블 안의 데이터를 조작하는 
	-- insert: 테이블 안의 데이터를 삽입하는 구문
	-- update: 테이블 안의 데이터를 수정하는 구문
	-- delete: 테이블 안의 데이터를 삭제하는 구문
	-- select: 테이블 안의 데이터를 조회하는 구문

use shop;
select database();
## insert
-- 데이터 삽입하기
desc tb_user;
insert into tb_user(user_name, user_phone, user_addr)
values("이관수", "010-0000-0000", "서울시 중랑구");
select * from tb_user;

-- 허용하는 길이를 초과할 경우 에러발생
-- insert into tb_user(user_name, user_phone, user_addr)
-- values("철수", "00000000000000", "서울시 강남구");

-- not null 로 제약조건이 설정된 컬럼에 데이터를 삽입하지 않는 경우 에러발생
-- insert into tb_user(user_name, user_phone)
-- values("길동", "010-0000-0000");

-- 여러개 삽입하기
desc tb_product;
insert into tb_product(product_name, product_price)
values ('에어컨', 1200000),
	   ('스마트TV', 2000000),
	   ('컴퓨터', 1000000),
	   ('모니터', 200000);

-- 민수, 철수, 만수, 훈수 tb_user 테이블에 삽입해주세요.
insert into tb_user(user_name, user_phone, user_addr)
values
("민수", "010-1111-1111", "경기도"),
("철수", "010-2222-2222", "경상도"),
("만수", "010-3333-3333", "전라도"),
("훈수", "010-4444-4444", "충청도");
select * from tb_user;

-- unique 제약 조건이 있는 컬럼에 중복 데이터를 삽입할 경우 에러 발생
-- insert into tb_product(product_name, product_price)
-- values("에어컨", 200);

desc tb_order;
select * from tb_user;
select * from tb_product;

insert into tb_order(user_id, product_id)
values(1,3);
select * from tb_order;

-- tb_user 테이블에없는 user_id 를 tb_order 테이블에 삽입해보기(에러 발생)
-- insert into tb_order(user_id, product_id)
-- values(10,3);
-- tb_product 테이블에없는 product_id 를 tb_order 테이블에 삽입해보기(에러 발생)
-- insert into tb_order(user_id, product_id)
-- values(1,300);

## update
-- 데이터 수정하기
select * from tb_product;

update tb_product
set product_name = '삼성 에어컨'
where product_id = 1;

select * from tb_product;

## delete
-- 데이터 삭제하기
select * from tb_user;

delete from tb_user
where user_name = "만수";

select * from tb_order;

-- 자식 테이블에서 참조하고 있는 데이터가 있을 경우 해당 데이터는 삭제가 되지 않는다.(에러 발생)
-- delete from tb_user
-- where user_id = 1;

-- 자식 테이블에서 참조하고 있는 행을 먼저 제거한 후에 부모테이블에 해당 행을 제거할 수 있다.
delete from tb_order
where user_id = 1;
delete from tb_user
where user_id = 1;

# DCL
-- grant: 사용자한테 권한을 주는 명령어
-- revoke: 사용자의 권한을 회수하는 명령어
-- commit: insert, update, delete 문에 대한 데이터베이스에 실제 반영
-- rollback: insert, update, delete 문에 대한 복구

-- 접속 계정 만들기
use mysql;
create user 'karns'@'%' identified by '1234';
select * from user;

-- 권한 주기
grant select, insert , delete, update on *.* to 'karns'@'%';
select * from user;
flush privileges;

grant all privileges on *.* to 'karns'@'%'; # with grant option
flush privileges;

select * from user;

-- 권한 회수
revoke select, insert , delete, update on *.* from 'karns'@'%';
flush privileges;
select * from user;

-- 계정 삭제
drop user 'karns'@'%';
select * from user;


use shop;
select @@autocommit; # auto commit 상태 확인
set @@autocommit = 0; # auto commit 해제

select * from tb_product;

delete from tb_product
where product_name='모니터';

select * from tb_product;
rollback; # 복구 하기

select * from tb_product;

delete from tb_product
where product_name='모니터';
commit; # 실제 반영

select * from tb_product;

set @@autocommit = 1; # auto commit 모드 적용






































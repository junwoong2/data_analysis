use mydata;
select database();

show tables;

select * from tb_titanic;

/*
passengerid : 승객 id
survived : 생존여부
pclass : 객실등급
gender : 성별
age : 나이
sibsp : 동반한 형제 또는 자매 또는 배우자 수
parch : 동반한 부모 또는 자식 수
ticket : 티켓번호
cabin : 객실번호
embarked : 탑승항구 ( c : 프랑스 항구, s : 영국 항구, q : 아일랜드 항)
*/

-- 컬럼을 선택해서 조회 가능
select name, age from tb_titanic;

select name as 이름,age as 나이 from tb_titanic;
select name 이름,age 나이 from tb_titanic;

# where 이용하여 조건 줘서 조회하기
select * from tb_titanic
where survived = 1;

select * from tb_titanic
where survived != 1;

select * from tb_titanic
where survived > 0;

select * from tb_titanic
where name like '%mrs.%' or name like '%miss.*';

-- in, not in
select * from tb_titanic
where embarked in ("c", "s");

select * from tb_titanic
where embarked not in ("c", "s");

-- 구간 조회
select * from tb_titanic
where age between 20 and 40;

-- 조회 결과 정렬하기
select *
from tb_titanic
where survived = 1
order by fare desc;

# 함수 사용하기
select distinct(cabin)
from tb_titanic;

-- pclass가 1등급에 운임료 표준편차와 3등급의 운임료의 표준 편차를 확인해보세요.

select std(fare)
from tb_titanic
where pclass = 1;

-- 분산
select variance(fare)
from tb_titanic;

-- 거듭제곱
select pow( std(fare), 2 )
from tb_titanic;

-- 최대값
select max(fare) 최댓값
from tb_titanic;

-- 최소값
select min(fare)
from tb_titanic;

-- 생존자의 나이에 대한 평균과 표준편차를 구해보시오
select avg(age) as 나이평균, std(age) as 표준편차
from tb_titanic
where survived = 1;

-- 사망자의 나이에 대한 평균과 표준편차를 구해보시오
select avg(age) as 나이평균, std(age) as 표준편차
from tb_titanic
where survived = 0;

-- 3등급(pclass)에 대한 생존률을 구해보세요
select avg(survived)
from tb_titanic
where pclass = 3;

# select 절 조건 주기
-- ifnull
select ifnull(cabin, "알 수 없음")
from tb_titanic;

-- if
select if(gender='male', '남자', '여자')
from tb_titanic;

select pclass, avg(age)
from tb_titanic
group by pclass
order by pclass;

select pclass, avg(gender='female') as 여자비율, avg(age) 평균나이
from tb_titanic
where embarked = 'Q'
group by pclass
order by pclass;

select embarked as 항구, pclass as 등급, avg(survived = 1) 비율
from tb_titanic
where gender = 'male'
group by embarked, pclass
order by pclass;


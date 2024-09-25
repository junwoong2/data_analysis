use mydata;
select database();

show tables;

select * from tb_titanic;

/*
passengerid: 승객 id
survived : 생존 여부(0: 사망, 1: 생존)
pclass: 객실 등급(1,2,3)
gender: 성별
age: 나이
sibsp: 동반한 형제 또는 자매 또는 배우자 수
parch: 동반한 부모 또는 자식 수 
ticket: 티켓번호
fare: 운임료
cabin: 객실번호
embarked: 탑승항구(C: 프랑스 항구, S: 영국 항구, Q: 아일랜드 항구)
*/

-- 컬럼을 선택해서 조회 가능
select name, age from tb_titanic;

-- 조회한 컬럼명에 대해 별칭을 부여할 수 있다.
select name as 이름, age as 나이 from tb_titanic; 
select name "이 름", age 나이 from tb_titanic; 

# where 이용하여 조건 줘서 조회하기
select * from tb_titanic
where survived = 1;

-- 비교 연산자의 `같다` 만 파이썬과 다르고 나머지는 똑같다!!
select * from tb_titanic
where survived != 1;

select * from tb_titanic
where age > 59;

-- is null
select * from tb_titanic
where age is null;

-- is not null
select * from tb_titanic
where age is not null;

-- 특정 문자열이 포함 되어 있는지 조회
select * from tb_titanic
where name like '%Miss.%'; -- 대소문자 구분 안함

-- 대소문자 구분하려면 binary 키워드를 사용
select * from tb_titanic
where binary name like '%miss.%'; -- Miss. , Mrs. Mr., Ms.

-- and 
select * from tb_titanic
where survived = 1 and gender = "female";

-- or
-- 기혼 여성이거나 미혼 여성인 승객 조회하기
select * from tb_titanic
where name like '%mrs.%' or name like '%miss.%';

-- in , not in 
select * from tb_titanic
where embarked in("c", "s");
select * from tb_titanic
where embarked not in("c", "s");

-- 구간 조회
select * from tb_titanic
where age between 20 and 40; -- age >= 20 and age <=40

# 조회 결과 정렬하기
select * 
from tb_titanic
where survived = 1
order by fare asc; # 오름차순

select * 
from tb_titanic
where survived = 1
order by fare desc; # 내림차순

# 산술 연산
select name, sibsp + parch as add_sibsp_parch
from tb_titanic;

select name, sibsp - parch as sub_sibsp_parch
from tb_titanic;

select name, sibsp * parch as mul_sibsp_parch
from tb_titanic;

select name, sibsp / parch as div_sibsp_parch
from tb_titanic;

select name, sibsp % parch as div_sibsp_parch
from tb_titanic;

-- 정규표현식 도 가능 , Miss. , Mrs. Mr., Ms.
select * from tb_titanic
where name regexp "M[rsi]{1,3}[.]";

# 함수 사용하기
-- 중복 제거하기
select distinct(cabin)
from tb_titanic;

-- 조회된 결과의 총 개수 확인하기
select count(passengerid) -- null 제외하고 counting
from tb_titanic;

-- 합계 함수(null 무시)
select sum(fare) 
from tb_titanic;

-- 평균 함수(null 무시)
select avg(fare) 
from tb_titanic;

-- 표준편차(null 무시)
select std(fare) 
from tb_titanic;

-- pclass가 1등급에 운임료 표준편차와 3등급의 운임료의 표준편차를 확인해보세요..
select std(fare) 
from tb_titanic
where pclass = 1;

select std(fare) 
from tb_titanic
where pclass = 3;

-- 분산
select variance(fare)
from tb_titanic;

-- 거듭제곱
select pow( std(fare) , 2) 
from tb_titanic;

-- 최대값
select max(fare)
from tb_titanic;

-- 최소값
select min(fare)
from tb_titanic;

-- 생존자의 나이에 대한 평균과 표준편차를 구해보세요.
select avg(age), std(age)
from tb_titanic
where survived = 1;

-- 사망자의 나이에 대한 평균과 표준편차를 구해보세요.
select avg(age), std(age)
from tb_titanic
where survived = 0;

-- 3등급(pclass)에 대한 생존률을 구해보세요.
select avg(survived)
from tb_titanic
where pclass = 3;

-- 1등급 생존률, 2등급 생존률, 전체 생존률, 여자 생존률을 각각 조회해서 저한테 의견을 주세요. 
select avg(survived) from tb_titanic where pclass = 1;
select avg(survived) from tb_titanic where pclass = 2;
select avg(survived) from tb_titanic;
select avg(survived) from tb_titanic where gender = "female";

select avg(survived) from tb_titanic where pclass = 1 and gender = "female";

-- 10세 미만의 생존률 확인해보기
select avg(survived) from tb_titanic where age between 0 and 9;

-- 생존자에 대한 sibsp 와 parch 의 평균
select avg(sibsp) , avg(parch)
from tb_titanic
where survived = 1;

-- 사망자에 대한 sibsp 와 parch 의 평균
select avg(sibsp) , avg(parch)
from tb_titanic
where survived = 0;

# select 절 조건 주기
-- ifnull
select ifnull(cabin, "알수 없음")
from tb_titanic;

-- if
select if(gender='male' , '남자', '여자')
from tb_titanic;

-- Mr. 생존률, Mrs. 생존률, Miss. 생존률, Ms. 생존률,
select 
avg( if(name like '%mr.%', survived, null) ) mr_rate, -- Mr. 에 대한 생존률
avg( if(name like '%mrs.%', survived, null) ) mrs_rate, -- Mrs. 에 대한 생존률
avg( if(name like '%miss.%', survived, null) ) miss_rate, -- Miss. 에 대한 생존률
avg( if(name like '%ms.%', survived, null) ) ms_rate-- Ms. 에 대한 생존률
from tb_titanic;

-- one hot encoding 
-- embarked: C , Q, S
-- C | Q | S
-- 1 | 0 | 0 -- c항구일 경우
-- 0 | 1 | 0 -- q항구일 경우
-- 0 | 0 | 1 -- s항구일 경우
-- ...

select 
if(embarked="c", 1, 0) C,
if(embarked="q", 1, 0) Q, 
if(embarked="s", 1, 0) S  
from tb_titanic;


-- case 문
select 
case 
	when embarked = 'c' then '프랑스 항구'
    when embarked = 'q' then '아일랜드 항구'
    else '영국 항구'
end as em
from tb_titanic;


-- count encoding(범주의 빈도수로 인코딩해주는 기법)
set @embarked_c = (select count(embarked) from tb_titanic where embarked="c");
set @embarked_q = (select count(embarked) from tb_titanic where embarked="q");
set @embarked_s = (select count(embarked) from tb_titanic where embarked="s");
select 
case
	when embarked = "c" then @embarked_c
    when embarked = "q" then @embarked_q
    else @embarked_s
end emb_count
from tb_titanic;

# group by 
-- 데이터 그룹화
-- 데이터의 특정 컬럼을 기준으로 동일한 값끼리 그룹화하여 집계할 때 사용
-- 동일한 값을 가진 행들을 하나의 그룹으로 묶어주는 역할
-- pclass 별 평균 나이를 알고 싶다면???
select avg(age) from tb_titanic where pclass = 1;
select avg(age) from tb_titanic where pclass = 2;
select avg(age) from tb_titanic where pclass = 3;

select pclass, avg(age)
from tb_titanic
group by pclass;

-- pclass 별 생존률이 알고 싶다면??
select pclass, avg(survived)
from tb_titanic
group by pclass;

-- embarked 별 생존률을 확인해보기
select embarked, avg(survived)
from tb_titanic
where embarked is not null
group by embarked;

-- gender 별 생존률 알아보세요..
select gender, avg(survived)
from tb_titanic
group by gender;

-- survived 별 나이와 운임료의 평균과 표준편차를 알아보세요..
select 
survived,
avg(age) age_avg,
std(age) age_std,
avg(fare) fare_avg,
std(fare) fare_std
from tb_titanic
group by survived;

-- 각 pclass 대하여 gender 별 생존률을 알고 싶다면?
select pclass, gender, avg(survived) result
from tb_titanic
group by pclass, gender
order by pclass, gender;

-- 각 embarked 대하여 pclass 별 생존률을 구해서 저한테 의견을 DM 주세요.!!!
select embarked, pclass , avg(survived) result
from tb_titanic
group by embarked, pclass
order by embarked, pclass;

-- Q항구에 대하여 pclass별 여자의 비율과, 나이의 평균을 구해주세요.
select 
pclass,
avg( if(gender="female", 1, 0) ) female_rate,
avg(age) age_avg
from tb_titanic
where embarked = 'q'
group by pclass;
-- q 항구에 경우 3등급에 여자 비율이 높은 편이고, 평균연령도 낮아서.. 다른 항구의 3등급에 비해
-- 생존률이 높아진 것으로 추측인된다.

-- 남성 승객들 중에서 각 항구에 대하여 객실 등급별 생존률 확인하기
select embarked, pclass, avg(survived) survived_rate, count(passengerid)
from tb_titanic
where gender = "male"
group by embarked, pclass
order by embarked, pclass;

-- 각 탑승항구(embarked) 에 대하여 생존여부(survived)별 특징을 알아보자
-- 가족수(sibsp+parch)에 평균, 운임료의 평균, 티켓번호(ticket)에 고유값의 개수, cabin 고유값의 개수 
-- 가족이 없는 승객의 비율
select embarked, survived,
avg(sibsp + parch) avg_family,
avg(fare) fare_avg,
count(distinct(ticket)) nunique_ticket,
count(distinct(cabin)) nunique_cabin,
avg(if(sibsp+parch = 0, 1, 0)) alone_rate
from tb_titanic
group by embarked, survived
order by embarked, survived;

# having 절
-- group by 집계 결과에 대한 조건 걸기

-- 객실번호(cabin)별 생존률이 0.6 이상의 객실만 보고 싶다면???
select cabin, avg(survived) survived_rate, avg(fare)
from tb_titanic
group by cabin
having survived_rate >= 0.6
order by survived_rate desc;

-- 객실번호(cabin)별로 티켓번호의 고유값 개수가 1개인 객실들만 조회해보기
select cabin, count(distinct(ticket)) nunique_ticket
from tb_titanic
where cabin is not null
group by cabin
having nunique_ticket=1;

# limit 절
-- 조회결과 대한 행 범위를 지정
-- 행번호는 0번부터 시작!!
-- limit 시작 행번호, 조회할 개수
select * from tb_titanic limit 10, 5;
select * from tb_titanic limit 5; # 시작행번호가 자동으로 0으로 세팅

# SQL 실행 순서
-- from -> where -> group by -> having -> select -> order by -> limit
select cabin, count(distinct(ticket)) nunique_ticket
from tb_titanic
where cabin is not null
group by cabin
having nunique_ticket=1
order by cabin
limit 0, 5;

show tables;
/*
부서 정보 테이블(dept)
-- deptno : 부서 번호
-- dname : 부서 이름
-- loc : 지역
*/

select * from dept;

/*
empno : 사원번호
ename : 사원이름
job : 직무
mgr : 상사의 사원번호
hiredate : 입사일
sal : 급여
comm : 커미션
depno : 부서번호
*/
select * from emp;

## inner join
-- 테이블 사이에서 on 조건에 맞는 데이터만 join
select *
from dept
inner join emp
on dept.deptno = emp.deptno;

select *
from dept
join emp
on dept.deptno = emp.deptno;

select *
from dept, emp
where dept.deptno = emp.deptno;

-- table에 별칭 줄 수 있다.
select *
from emp e, dept d
where e.deptno = d.deptno;

-- scott 사원에 이름과 부서 이름, 지역 조회하기
select ename, dname, loc
from emp
inner join dept
on emp.deptno = dept.deptno and emp.ename='scott';

-- research 부서에서 근무하는 사원의 이름, 급여, 입사일 조회
select ename, sal, hiredate
from dept d, emp e
where d.deptno = e.deptno and d.dname = 'research';

-- 직무가 manager 인 사원의 이름, 부서명, 급여, 커미션 조회
select ename, dname, sal, comm
from dept d, emp e
where d.deptno = e.deptno and e.job = 'manager';

## self join
-- 동일한 테이블끼리 조인

-- 각 사원의 이름을 알고 싶다면?
select e2.ename "상사이름", e1.ename "사원이름"
from emp e1, emp e2
where e1.mgr = e2.empno;

select e2.ename "상사이름", e1.ename "사원이름"
from emp e1, emp e2
where e1.mgr = e2.empno and e2.ename = 'king';

-- allen의 동료 이름 조회
select e2.ename
from emp e1, emp e2
where e1.deptno = e2.deptno and e1.ename = 'allen';

## left join
select e.ename "사원이름", m.ename "상사이름"
from emp e
left join emp m
on e.mgr = m.empno;

select * from dept;
select * from emp;

select dept.deptno, sum(sal) 연봉, avg(sal) 평균, std(sal) 표준편차, count(ename)
from dept
left join emp
 on dept.deptno = emp.deptno
 group by dept.deptno;
 
 select e1.mgr 상사번호, count(e1.ename) 부하직원수, avg(e1.sal) 평균연봉
 from emp e1
 left join emp e2
 on e1.mgr = e2.ename
 group by e1.mgr
 order by e1.mgr;
 
 select m.empno, m.ename, count(e.empno) as cnt, avg(e.sal) as avg_sal
 from emp e
 inner join emp m
 on e.mgr = m.empno
 group by m.empno;
 
 ## sub-query
select *, (select dname from dept where deptno = e.deptno);

-- scott 사원과 같은 부서에 있는 직원 이름을 검색하기 

select  *
from emp e
where deptno = (select deptno from emp where ename = 'scott') and ename != 'scott';

select job
from emp
where ename = 'smith';

-- smith의 급여 이상을 받는 직원들의 사원명과 급여를 검색해주세요.
select *
from emp
where sal >= (select sal from emp where ename = 'smith') and ename != 'smith';

-- from 절에서 서브쿼리 작성
-- 사원 테이블에서 급여가 2000이 넘는 사람들의 이름과  부서번호, 부서이름, 지역 조회
select e.ename, d.deptno, d.dname, d.loc
from (select * from emp where sal>2000) e
inner join dept d
on e.deptno = d.deptno;

-- join 절에서 서브쿼리 작성

-- 모든 부서의 부서 이름과 지역, 부서 내의 평균 급여 조회하기
select avg(sal)
from emp
group by deptno;

select *
from dept d
left join(select deptno, avg(sal) avg_sal from emp group by deptno) e
on d.deptno = e.deptno;

-- 서브쿼리를 활용해서 테이블 복제하기
create table emp01 as select * from emp;
select * from emp01;

-- 데이터를 제외하고 테이블 복제하기
create table emp02 as select * from emp where 1=0;
select * from emp02;

-- 서브쿼리를 활용해서 insert 해보기
insert into emp02 select * from emp;
select * from emp02;

select * from emp where 1=0;
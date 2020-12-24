/*
*** DDL 테이블 관리 ***
create alter drop rename
*/

--테이블 생성 기본형태 : 컬럼명 자료형(자릿수), 
create table book(
    book_id number(5), 
    title varchar2(50),
    author varchar2(10),
    pub_date date
    );
    
--컬럼 추가    
 alter table book add(pubs varchar2(50));
 
 --컬럼 수정 : modify(자료형 변경), rename(컬럼명 변경)
 alter table book modify(title varchar(100)); 
 alter table book rename COLUMN title to subject;
 
 --컬럼 삭제
 alter table book drop (author);
 
 --테이블명 수정
 rename book to article;
 
 --테이블 삭제
 drop table article;
 
 --테이블 데이터(로우) 삭제
 TRUNCATE table article;
 
 /*
 제약조건
 not null : null값 입력 불가
 unique : 중복값 불가 (null 허용)
 pk : not null + unique
 fk : pk 참조
 */
 create table author(
    author_id   NUMBER(10),
    author_name varchar(100)    not null,
    author_desc varchar(500),
    PRIMARY KEY (author_id)
    );
    
    
/*
*** DML ***
insert update delete
*/
--묵시적 방법 : 컬럼 이름, 순서 지정 안 하고 테이블 생성시 정의한 순서 따라감.
insert into author
values(1, '박경리', '토지 작가');

insert into author
values(3, '이문열', ''); --값 다 채워야 됨

--명시적 방법 : 지정되지 않은 컬럼에 null 자동 입력됨
--컬럼명 명시적으로 사용해서(괄호 안에 컬럼명 순서 정해서) 데이터입력 순서 지정+원하는 컬럼 데이터만 받기 가능. 
insert into author(author_id, author_name)
values(2, '이문열'); 



--수정하기 update
--조건을 만족하는 레코드 변경 (*주의* : where절 없으면 전체를 다 변경함)
update author
set author_name = '세윤',
    author_desc = '겟백'
where author_id = 3;

--삭제
DELETE FROM author --where없으면 데이터 다 날아가서 복구 안 됨
where author_id = 1;


--새 데이터 입력하기
delete from author;

insert into author
values(SEQ_AUTHOR_ID.nextval, '이문열', '경북 영양'); 
/*일련번호 일일이 붙이는 대신 내가 만든 시퀀스로 번호 매김. 
만약에 테이블과 상관없이 시퀀스를 실행시켰으면 +1된 값으로 계속 저장돼서 이걸로 매겨짐.*/

insert into author
values(SEQ_AUTHOR_ID.nextval, '박경리', '경남 통영');

insert into author
values(SEQ_AUTHOR_ID.nextval, '유시민', '국회의원');

insert into author
values(SEQ_AUTHOR_ID.nextval, '세윤', '겟백');


/*
*** sequence ***
연속적인 일련번호 생성 (pk에 주로 사용)
*/
--번호표 기계 : 시퀀스 카테고리에 생성됨
create sequence seq_author_id --sequence에 번호표가 들어갈 컬럼명을 주로 씀
INCREMENT by 1 --버튼 누를 때마다 n씩 올라간 값이 나옴
START with 1; --시작번호

--쓰려는 곳에 seq_author_id.nextval 넣으면 되는데 1부터 시작됨. 실행해서 오류나도 실행하면 무조건 +n됨.

--시퀀스 조회
SELECT
    *
FROM user_sequences;

--현재 시퀀스 조회
SELECT  seq_author_id.currval
FROM dual;

--다음 시퀀스 조회 --> 번호 1증가(전으로 돌아갈 수 없음)
SELECT  seq_author_id.nextval
FROM dual;

--시퀀스 삭제
drop SEQUENCE seq_author_id; --이름 모르겠으면 조회해보면 됨

--만약에 중간에 로우 삭제해서 시퀀스 번호가 안 맞게 되면 이 번호 굳이 수정할 필요없음. 어차피 알아서 작동됨. 
--시퀀스 번호는 실제 데이터도 아니고 연속된 번호보다는 중복+빈값이 아닌 게 중요한 거.
--DML(insert, update, delete)은 commit; 커밋해야 변경값이 적용되고 시퀀스는 롤백해도 계속 쌓여있음.
--실수로 delete해도 commit 안 하면 완전히 적용 안 됨. rollback; 하면 돌아감. 대신 테이블 자체를 바꾸거나 삭제하는 건 못 되돌림.
commit;
rollback;

--------------------------------
--테이블 연결하기
create table book (
    book_id NUMBER(10),
    title VARCHAR2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id NUMBER(10), --이 컬럼은 author테이블의 값으로만 쓸 거라고 연결해서 다른 데이터 못들어가게 방지
    PRIMARY KEY (book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id) --book_fk는 연결하는 거 작명해준 거
    REFERENCES author(author_id) --위 컬럼을 author테이블의 author_id에서 갖다 쓰겠다는 의미 
);

insert into book
values(1, '삼국지', '삼양출판사', '20-01-01', 1); --숫자 써놓은 거(작가아이디)로 나중에 작가테이블로 찾아감

SELECT
    *
FROM author;

SELECT
    *
FROM book;
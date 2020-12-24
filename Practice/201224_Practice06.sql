--webdb계정 삭제하고 다시 만듦

--author 테이블 생성
create table author(
    author_id NUMBER(10),
    author_name varchar2(100) not null,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);

drop table author;
ROLLBACK;

--author 시퀀스(*먼저 실행하기*)
create SEQUENCE seq_author_id
  INCREMENT BY 1
  start with 1;
  
--author 테이블 데이터 입력
insert into author
values(seq_author_id.nextval, '이문열', '경북 영양');

insert into author
values(seq_author_id.nextval, '박경리', '경남 통영');

insert into author
values(seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval, '기안84', '기안동 84년생');

insert into author
values(seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval, '김영하', '알쓸신잡');

--////////////////////////////////////////////////

--book 시퀀스
create SEQUENCE seq_book_author_id
  INCREMENT BY 1
  start with 1;

--book 테이블
create table book(
    book_id NUMBER(10),
    title varchar2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id NUMBER(10),
    PRIMARY KEY (book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

--book 테이블 데이터 입력
insert into book
values(seq_book_author_id.nextval, '우리들의 일그러진 영웅', '다림','98/02/22', 1);

insert into book
values(seq_book_author_id.nextval, '삼국지', '민음사', '02/03/01', 1);

insert into book
values(seq_book_author_id.nextval, '토지', '마로니에북스', '12/08/15', 2);

insert into book
values(seq_book_author_id.nextval, '유시민의 글쓰기 특강', '생각의길', '15/04/01', 3);

insert into book
values(seq_book_author_id.nextval, '패션왕', '중앙북스(books)', '12/02/22', 4);

insert into book
values(seq_book_author_id.nextval, '순정만화', '재미주의', '11/08/03', 5);

insert into book
values(seq_book_author_id.nextval, '오직두사람', '문학동네', '17/05/04', 6);

insert into book
values(seq_book_author_id.nextval, '26년', '재미주의', '12/02/04', 5);


--select 출력
SELECT * FROM author;

SELECT * FROM book;

SELECT  b.book_id "책번호",
        b.title "제목",
        b.pubs "출판사",
        to_char(b.pub_date, 'YYYY-MM-DD') "출판일",
        b.author_id "작가번호",
        a.author_name "작가명",
        a.author_desc "작가정보"
FROM author a, book b
where a.author_id = b.author_id;

--commit
commit;

--데이터 변경 : 강풀 작가정보를 '서울특별시'로
update author
set author_desc = '서울특별시'
where author_id = 5;

--author테이블에서 기안84 데이터 삭제
DELETE FROM author
where author_id = 4; --이러면 오류남. book테이블과 연결돼 있기 때문에 삭제하고 싶으면 book테이블에서 먼저 삭제하면 됨.

DELETE FROM book
where author_id = 4; --이거 하고 다시 위 삭제 쿼리 실행하면 삭제됨.



--////////////////////////////////////////////////



--연습 : 웹툰, 플랫폼, 작가 테이블 3개 연결해보기 (not null 깜빡함...)

drop table platform;
drop table w_author;

--플랫폼 시퀀스
create sequence seq_pl_platform_id
  INCREMENT BY 1
  start with 1;
  
--플랫폼 테이블 생성 및 입력
create table platform(
    platform_id NUMBER(10),
    platform_name VARCHAR2(50),
    PRIMARY KEY (platform_id)
);

insert into platform
values(seq_pl_platform_id.nextval, '네이버 시리즈');

insert into platform
values(seq_pl_platform_id.nextval, '다음');

insert into platform
values(seq_pl_platform_id.nextval, '딜리헙');

insert into platform
values(seq_pl_platform_id.nextval, '카카오페이지');

insert into platform
values(seq_pl_platform_id.nextval, '리디북스');

--카카페 삭제
delete from platform
where platform_id = 4;

--카카페 삭제하고 나서 왜인지 author_id 4번에서 오류 나서 데이터 지우고 다시 입력하려고 했는데
--테이블 다 연관돼 있어서 삭제도 안 됨. 알고 보니까 이거랑 관련 없고 작가번호를 w_author로 안 써서 오류난 거였음.
DELETE FROM platform;

--/////

--작가 시퀀스
create sequence seq_wau_author_id
  INCREMENT BY 1
  start with 1;
  
--작가 테이블 생성 및 입력
create table w_author(
    w_author_id NUMBER(10),
    w_author_name VARCHAR2(100),
    w_author_desc VARCHAR2(500),
    PRIMARY KEY (w_author_id)
);

--이것도 컬럼명 잘못 정해서 삭제 후 재생성
drop table w_author;

insert into w_author
values(seq_wau_author_id.nextval, '고사리박사', '독립출판');

insert into w_author
values(seq_wau_author_id.nextval, '세윤', '네이버최강전20??');

insert into w_author
values(seq_wau_author_id.nextval, '뼈와피와살', '베스트도전');

insert into w_author
values(seq_wau_author_id.nextval, '와난', '00년대후반웹툰');

insert into w_author
values(seq_wau_author_id.nextval, '자룡/골왕', '다음리그');

insert into w_author
values(seq_wau_author_id.nextval, '김민희', '00년대출판만화');

--/////

--웹툰 시퀀스
create SEQUENCE seq_webtoon
  INCREMENT BY 1
  start with 1;
  
--웹툰 테이블 생성 및 입력
create table webtoon(
    webtoon_id NUMBER(10),
    title VARCHAR2(100),
    platform_id NUMBER(10),
    w_author_id NUMBER(10),
    PRIMARY KEY (webtoon_id),
    CONSTRAINT webtoon_fk_pl FOREIGN KEY (platform_id)
    REFERENCES platform(platform_id),
    CONSTRAINT webtoon_fk_au FOREIGN KEY (w_author_id)
    REFERENCES w_author(w_author_id)
);

--작가fk 잘못연결해서 웹툰테이블 지우고 다시 생성
drop table webtoon;

insert into webtoon
values(seq_webtoon.nextval, '극락왕생', 3, 7);

insert into webtoon
values(seq_webtoon.nextval, '미드나잇 파트너', 5, 12);

insert into webtoon
values(seq_webtoon.nextval, '붉고 푸른 눈', 2, 12);

insert into webtoon
values(seq_webtoon.nextval, '이대로 멈출 순 없다', 2, 11);

insert into webtoon
values(seq_webtoon.nextval, '집이 없어', 1, 10);

insert into webtoon
values(seq_webtoon.nextval, '합법해적 파르페', 1, 9);

insert into webtoon
values(seq_webtoon.nextval, '겟백', 1, 8);

insert into webtoon
values(seq_webtoon.nextval, '하나(HANA)', 1, 10);

--commit
commit;

--출력
SELECT * FROM platform;

SELECT * FROM w_author;

SELECT  w.webtoon_id "웹툰번호",
        w.title "제목",
        p.platform_name "연재플랫폼",
        a.w_author_name "작가명",
        a.w_author_desc "작가정보"
FROM webtoon w, platform p, w_author a
where w.platform_id = p.platform_id
and w.w_author_id = a.w_author_id;

/*
오류
1. webtoon테이블에 w_author가 아닌 author테이블 연결해서 webtoon테이블에 '와난'만 데이터입력이 안 됨
2. webtoon, w_author 테이블 삭제 후 제대로 연결하고 최종 출력했는데 오류남 --> w_author와 webtoon 내 w_author_id 컬럼명이 달라서 
3. w_author 내 w_author_id 컬럼명 고치고 최종 출력했는데 오류남 
--> w_author데이터 insert를 너무 많이 해서 시퀀스 번호 늘어났고 이에 따라 w_author_id값도 바뀜
4. 바뀐 시퀀스 번호에 맞는 w_author_id를 webtoon테이블 insert에 넣고 출력 --> 정상 작동
5. 근데 webtoon데이터도 insert를 너무 많이 해서 20대까지 올라감...
*/
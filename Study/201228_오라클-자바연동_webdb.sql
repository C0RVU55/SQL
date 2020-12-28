
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

drop table book;
drop SEQUENCE seq_book_author_id;

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

SELECT  book_id,
        title,
        pubs,
        to_char(pub_date, 'YY/MM/DD') pub_date,
        author_id
FROM book;

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
rollback;

--데이터 변경 
update book
set title = '토지 (수정 테스트)'
where book_id = 7;

--201228 자바 연동 수업 (update)
update author
set author_desc = '우리집'
where author_id = 21;

DELETE FROM author
where author_id = 21;

SELECT  author_id,
        author_name,
        author_desc
FROM author;

--삭제
DELETE FROM author
where author_id = 4; 

DELETE FROM book
where author_id = 2;


create table members(
    id varchar(20) primary key,
    pw varchar(128) not null,
    name varchar(20) not null,
    nickname varchar(50) not null,
    phone varchar(11) ,
    email varchar(100) not null,
    gender varchar(1) not null,
    birth varchar(8),
    grade number default 1,
    avatar varchar(500) default null,
    join_date timestamp default sysdate
);

create table grade(
    seq number primary key,
    name varchar(20) not null
);

create table board(
    seq number primary key,
    title varchar(100) not null,
    contents varchar(4000) not null,
    count number default 0,
    member_id varchar(20) not null,
    board_code number not null, 
    write_date timestamp default sysdate,
    secret varchar(1) default 'N'
);

create table board_list(
    seq number primary key,
    name varchar(20) not null
);

create table reply(
    seq number primary key,
    member_id varchar(20) not null,
    contents varchar(4000) not null,
    board_seq number not null,
    write_date timestamp default sysdate
);

create table reply_child(
    seq number primary key,
    member_id varchar(20) not null,
    contents varchar(4000) not null,
    reply_seq number not null,
    write_date timestamp default sysdate
);

create table game(
    seq number primary key,
    title varchar(50) not null,
    discription varchar(1000) not NULL,
    contents varchar(4000) not null,
    thumbnail varchar(500) not null,
    service_code number not null
);

create table game_score(
    score number default 0,
    member_id varchar(20) not null,
    game_seq number not null
);

create table files(
    seq number primary key,
    oriname varchar(1000) not null,
    sysname varchar(1000) not null,
    board_seq number not null
);

create table service(
    service_code number primary key,
    service_state varchar(20) not null
);

create table images(
    seq number primary key,
    oriname varchar(1000) not null,
    sysname varchar(1000) not null,
    image_code number not null,
    parent_seq number,
    member_id varchar(20)
);

create table image_code(
    image_code number primary key,
    sortaion varchar(30) 
);

CREATE TABLE qna(
	seq NUMBER PRIMARY KEY,
	board_seq NUMBER NOT NULL,
	res_ok varchar(1) DEFAULT 'N'
);

create sequence board_seq
start with 1
increment by 1
nomaxvalue
nocache
;

create sequence reply_seq
start with 1
increment by 1
nomaxvalue
nocache
;

create sequence reply_child_seq
start with 1
increment by 1
nomaxvalue
nocache;
commit;

create sequence game_seq
start with 1
increment by 1
nomaxvalue
nocache
;

create sequence files_seq
start with 1
increment by 1
nomaxvalue
nocache;

create sequence images_seq
start with 1
increment by 1
nomaxvalue
nocache;

CREATE SEQUENCE qna_seq
start with 1
increment by 1
nomaxvalue
nocache
;

-- grade table data
INSERT INTO grade (seq, name) VALUES (1, '일반회원');
INSERT INTO grade (seq, name) VALUES (2, '휴면계정');
INSERT INTO grade (seq, name) VALUES (3, '블랙리스트');
INSERT INTO grade (seq, name) VALUES (98, '서브관리자');
INSERT INTO grade (seq, name) VALUES (99, '메인관리자');

-- board_list table dummy data
INSERT INTO board_list VALUES (1, '자유게시판');
INSERT INTO board_list VALUES (2, '공지게시판');
INSERT INTO board_list VALUES (3, '문의게시판');
INSERT INTO board_list VALUES (4, 'FAQ');

-- service table dummy data
INSERT INTO service VALUES (0, '서비스 중지');
INSERT INTO service VALUES (1, '서비스 진행 중');

-- image_code table dummy data
insert into image_code values(1,'board');
insert into image_code values(2,'members');
insert into image_code values(3,'thumbnails');

COMMIT;
Create Table freeboard (
    id number constraint PK_freeboard_id Primary Key,  -- 자동증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,  -- 글제목
    content varchar2(100) not null,  -- 글내용
    inputdate varchar2(100) not null,  --글쓴날짜
    masterid number default 0,  -- 질문 답변형 게시판에서 답변의 글을 그룹핑 할때 사용 
    readcount number default 0, -- 글 조회수
    replaynum number default 0, -- 
    step number default 0
);

delete freeboard;
commit;

select * from freeboard;

INSERT INTO freeboard (id, name, password, email, subject, 
content, inputdate, masterid, readcount, replaynum, step) 
values (2,'홍길동','1234','ccc@bbb.com',
'첫번째 글입니다.','첫번째 내용입니다. 글 내용입니다. 글 내용2 입니다.',
'22-05-131 12:36 오후',2,0,0,0);

select * from freeboard where id = 3;
desc freeboard;




-- 답변글이 존재하는 테이블을 출력 할때 정렬을 잘 해서 가져와야 한다.
select * from freeboard 
order by masterid desc, replaynum, step, id;
    -- masterid 컬럼에 중복된 값이 있을 경우, replaynum컬럼을 asc
    -- replaynum이 중복된 값이 존재 할때 step을 asc
    -- step 이 중복된 값이 존재할때 id asc





-- id 컬럼 : 새로운 글이 등록될때 기존의 id컬럼의 최대값을 가져와서 +1 <= 새로운 글번호에 대한 넘버링
-- 답변글을 처리하는 컬럼이 3개 필요하다. (masterid, replaynum, step)
-- masterid : 
    -- 글의 답변에 대한 그룹핑, 
    -- id 컬럼의 값이 그대로 들어간 경우, 답변글이 아니다. 처음글
-- replaynum : 답변글에대한 넘버링. (1,2,3...)
-- step : 답변글에대한 깊이
    -- 0 : 처음글 (자신의 글, 답변x)
    -- 1 : 답변글
    -- 2 : 답변의 답변글
    -- 3 : 답변의 답변의 답변글
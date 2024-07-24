-- Add/modify columns staff
alter table STAFF modify saddress null;
alter table STAFF modify smobile null;
alter table STAFF modify smail null;

--check tables:
select * from staff;
select * from teacher;

--insert the data from teacher to staff
insert into staff (sid, sname)
select teacher_id as sid, tfirst_name || ' ' || tlast_name
from teacher 
where teacher.teacher_id not in (select sid from staff);


--drop unnecessary columns from teacher
alter table teacher
drop column tfirst_name;
alter table teacher
drop column tlast_name;


-- Add/modify columns teacher
alter table TEACHER rename column teacher_id to sid;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TEACHER
  drop constraint SYS_C007482 cascade;
alter table TEACHER
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  -- Add/modify columns 
alter table TEACHER modify sid NUMBER(5);

--change foreign key for teacher
alter table teacher
add constraint fk_t_s foreign key (sid) references staff(sid);

-- Add/modify columns 
alter table PATIENT modify caddress null;
alter table PATIENT modify cgender null;
alter table PATIENT modify cmail null;


--check tables:
select count(*) from patient;
select count(*) from student;

--insert the data from teacher to staff
insert into patient(cbirthyear, cname,cid,cmobile)
 select EXTRACT(YEAR FROM birth_date) AS cbirthyear,first_name || ' ' || last_name, student_id as cid,  to_char(phone) as cmobile
from student
where student.student_id not in (select cid from patient);


--convert phone froem INTEGER to VARCHAR2(10)
 
--alter table STUDENT add Newphone varchar2(10);
--update STUDENT set newphone = to_char(STUDENT.PHONE);
--ALTER TABLE STUDENT
 --DROP COLUMN PHONE;
--alter table STUDENT rename INTEGER Newphone to STUDENT.PHO


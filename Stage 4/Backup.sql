prompt PL/SQL Developer import file
prompt Created on יום רביעי 24 יולי 2024 by maria
set feedback off
set define off
prompt Creating STAFF...
create table STAFF
(
  saddress VARCHAR2(55),
  smobile  CHAR(10),
  sname    VARCHAR2(30) not null,
  smail    VARCHAR2(35),
  sid      NUMBER(5) not null
)
;
alter table STAFF
  add primary key (SID);

prompt Creating DOCTOR...
create table DOCTOR
(
  license     VARCHAR2(15) not null,
  specialties VARCHAR2(15) not null,
  sid         NUMBER(5) not null
)
;
alter table DOCTOR
  add primary key (SID);
alter table DOCTOR
  add foreign key (SID)
  references STAFF (SID)
  disable;

prompt Creating PATIENT...
create table PATIENT
(
  cbirthyear NUMBER(4) not null,
  caddress   VARCHAR2(55),
  cname      VARCHAR2(30) not null,
  cgender    VARCHAR2(5),
  cid        NUMBER(5) not null,
  cmail      VARCHAR2(35),
  cmobile    INTEGER not null
)
;
alter table PATIENT
  add primary key (CID);

prompt Creating APPOINTMENT...
create table APPOINTMENT
(
  adate         DATE default TRUNC(SYSDATE) not null,
  appointmentid NUMBER(7) not null,
  sid           NUMBER(5) not null,
  cid           NUMBER(5) not null
)
;
alter table APPOINTMENT
  add primary key (APPOINTMENTID);
alter table APPOINTMENT
  add foreign key (SID)
  references DOCTOR (SID)
  disable;
alter table APPOINTMENT
  add foreign key (CID)
  references PATIENT (CID);

prompt Creating ROOM...
create table ROOM
(
  room_id                NUMBER(3) not null,
  max_capacity           INTEGER not null,
  is_lab                 NUMBER(1),
  last_maintenance_check DATE
)
;
alter table ROOM
  add primary key (ROOM_ID);
alter table ROOM
  add check (is_lab = 1 OR is_lab = 0);

prompt Creating TEACHER...
create table TEACHER
(
  sid           NUMBER(5) not null,
  hourly_salary NUMBER,
  bonus         NUMBER
)
;
alter table TEACHER
  add primary key (SID);
alter table TEACHER
  add constraint FK_T_S foreign key (SID)
  references STAFF (SID);

prompt Creating CLASS_...
create table CLASS_
(
  class_id   NUMBER(3) not null,
  grade      NUMBER(2) not null,
  teacher_id NUMBER(3) not null,
  room_id    NUMBER(3) not null
)
;
alter table CLASS_
  add primary key (CLASS_ID);
alter table CLASS_
  add constraint CHECK_CLASSROOM unique (ROOM_ID);
alter table CLASS_
  add foreign key (TEACHER_ID)
  references TEACHER (SID);
alter table CLASS_
  add foreign key (ROOM_ID)
  references ROOM (ROOM_ID);

prompt Creating SUBJECT...
create table SUBJECT
(
  subject_id   NUMBER(3) not null,
  subject_name VARCHAR2(30) not null,
  mandatory    NUMBER(1) not null
)
;
alter table SUBJECT
  add primary key (SUBJECT_ID);
alter table SUBJECT
  add check (mandatory = 1 OR mandatory = 0);

prompt Creating LESSON...
create table LESSON
(
  lesson_id   NUMBER(3) not null,
  lesson_day  INTEGER not null,
  lesson_hour INTEGER not null,
  class_id    NUMBER(3),
  teacher_id  NUMBER(3),
  subject_id  NUMBER(3)
)
;
alter table LESSON
  add primary key (LESSON_ID);
alter table LESSON
  add unique (CLASS_ID, LESSON_DAY, LESSON_HOUR);
alter table LESSON
  add unique (TEACHER_ID, LESSON_DAY, LESSON_HOUR);
alter table LESSON
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);
alter table LESSON
  add foreign key (TEACHER_ID)
  references TEACHER (SID);
alter table LESSON
  add foreign key (SUBJECT_ID)
  references SUBJECT (SUBJECT_ID);
alter table LESSON
  add check (Lesson_Day BETWEEN 1 AND 6);

prompt Creating MATERIAL...
create table MATERIAL
(
  mid    NUMBER(5) not null,
  mname  VARCHAR2(15) not null,
  amount NUMBER(5) not null
)
;
alter table MATERIAL
  add primary key (MID);

prompt Creating TREATMENT...
create table TREATMENT
(
  ttype       VARCHAR2(15) not null,
  description VARCHAR2(200) not null,
  price       NUMBER(5) not null,
  tid         NUMBER(5) not null,
  time        NUMBER not null
)
;
alter table TREATMENT
  add primary key (TID);
alter table TREATMENT
  add constraint CHECK_P
  check (PRICE > 0);
alter table TREATMENT
  add constraint CHECK_PRICE
  check (PRICE > 0);

prompt Creating MUSEDINT...
create table MUSEDINT
(
  tid NUMBER(5) not null,
  mid NUMBER(5) not null
)
;
alter table MUSEDINT
  add primary key (TID, MID);
alter table MUSEDINT
  add foreign key (TID)
  references TREATMENT (TID)
  disable;
alter table MUSEDINT
  add foreign key (MID)
  references MATERIAL (MID)
  disable;

prompt Creating OFFICE...
create table OFFICE
(
  otype VARCHAR2(15) not null,
  sid   NUMBER(5) not null
)
;
alter table OFFICE
  add primary key (SID);
alter table OFFICE
  add foreign key (SID)
  references STAFF (SID)
  disable;

prompt Creating OMAKEA...
create table OMAKEA
(
  appointmentid NUMBER(5) not null,
  sid           NUMBER(5) not null
)
;
alter table OMAKEA
  add primary key (APPOINTMENTID, SID);
alter table OMAKEA
  add foreign key (APPOINTMENTID)
  references APPOINTMENT (APPOINTMENTID)
  disable;
alter table OMAKEA
  add foreign key (SID)
  references OFFICE (SID)
  disable;

prompt Creating STUDENT...
create table STUDENT
(
  cid        NUMBER(5) not null,
  fathername VARCHAR2(15) not null,
  mothername VARCHAR2(15) not null,
  class_id   NUMBER(3)
)
;
alter table STUDENT
  add primary key (CID);
alter table STUDENT
  add constraint FK_STUDENT_PATIENT foreign key (CID)
  references PATIENT (CID);
alter table STUDENT
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);

prompt Creating PAYMENT...
create table PAYMENT
(
  id            NUMBER(5) not null,
  totalprice    NUMBER(10) not null,
  pdate         DATE not null,
  appointmentid NUMBER(5),
  paymenttype   VARCHAR2(20),
  student_id    NUMBER(5)
)
;
alter table PAYMENT
  add primary key (ID);
alter table PAYMENT
  add constraint FK_PAYMENT_STUDENT foreign key (STUDENT_ID)
  references STUDENT (CID);
alter table PAYMENT
  add foreign key (APPOINTMENTID)
  references APPOINTMENT (APPOINTMENTID);
alter table PAYMENT
  add constraint CK_PAYMENT_TYPE
  check (
  (PaymentType = 'School' AND Student_ID IS NOT NULL AND AppointmentID IS NULL) OR
  (PaymentType = 'Appointment' AND AppointmentID IS NOT NULL)
);
alter table PAYMENT
  add constraint CK_PAYMENTTYPE
  check (PaymentType IN ('School', 'Appointment'));

prompt Creating TPREFORMEDINA...
create table TPREFORMEDINA
(
  tid           NUMBER(5) not null,
  appointmentid NUMBER(5) not null
)
;
alter table TPREFORMEDINA
  add primary key (TID, APPOINTMENTID);
alter table TPREFORMEDINA
  add foreign key (TID)
  references TREATMENT (TID)
  disable;
alter table TPREFORMEDINA
  add foreign key (APPOINTMENTID)
  references APPOINTMENT (APPOINTMENTID)
  disable;

prompt Disabling triggers for STAFF...
alter table STAFF disable all triggers;
prompt Disabling triggers for DOCTOR...
alter table DOCTOR disable all triggers;
prompt Disabling triggers for PATIENT...
alter table PATIENT disable all triggers;
prompt Disabling triggers for APPOINTMENT...
alter table APPOINTMENT disable all triggers;
prompt Disabling triggers for ROOM...
alter table ROOM disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling triggers for CLASS_...
alter table CLASS_ disable all triggers;
prompt Disabling triggers for SUBJECT...
alter table SUBJECT disable all triggers;
prompt Disabling triggers for LESSON...
alter table LESSON disable all triggers;
prompt Disabling triggers for MATERIAL...
alter table MATERIAL disable all triggers;
prompt Disabling triggers for TREATMENT...
alter table TREATMENT disable all triggers;
prompt Disabling triggers for MUSEDINT...
alter table MUSEDINT disable all triggers;
prompt Disabling triggers for OFFICE...
alter table OFFICE disable all triggers;
prompt Disabling triggers for OMAKEA...
alter table OMAKEA disable all triggers;
prompt Disabling triggers for STUDENT...
alter table STUDENT disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA disable all triggers;
prompt Disabling foreign key constraints for APPOINTMENT...
alter table APPOINTMENT disable constraint SYS_C007566;
prompt Disabling foreign key constraints for TEACHER...
alter table TEACHER disable constraint FK_T_S;
prompt Disabling foreign key constraints for CLASS_...
alter table CLASS_ disable constraint SYS_C007472;
alter table CLASS_ disable constraint SYS_C007473;
prompt Disabling foreign key constraints for LESSON...
alter table LESSON disable constraint SYS_C007485;
alter table LESSON disable constraint SYS_C007486;
alter table LESSON disable constraint SYS_C007487;
prompt Disabling foreign key constraints for STUDENT...
alter table STUDENT disable constraint FK_STUDENT_PATIENT;
alter table STUDENT disable constraint SYS_C007497;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint FK_PAYMENT_STUDENT;
alter table PAYMENT disable constraint SYS_C007344;
prompt Deleting TPREFORMEDINA...
delete from TPREFORMEDINA;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
commit;
prompt Deleting STUDENT...
delete from STUDENT;
commit;
prompt Deleting OMAKEA...
delete from OMAKEA;
commit;
prompt Deleting OFFICE...
delete from OFFICE;
commit;
prompt Deleting MUSEDINT...
delete from MUSEDINT;
commit;
prompt Deleting TREATMENT...
delete from TREATMENT;
commit;
prompt Deleting MATERIAL...
delete from MATERIAL;
commit;
prompt Deleting LESSON...
delete from LESSON;
commit;
prompt Deleting SUBJECT...
delete from SUBJECT;
commit;
prompt Deleting CLASS_...
delete from CLASS_;
commit;
prompt Deleting TEACHER...
delete from TEACHER;
commit;
prompt Deleting ROOM...
delete from ROOM;
commit;
prompt Deleting APPOINTMENT...
delete from APPOINTMENT;
commit;
prompt Deleting PATIENT...
delete from PATIENT;
commit;
prompt Deleting DOCTOR...
delete from DOCTOR;
commit;
prompt Deleting STAFF...
delete from STAFF;
commit;
prompt Loading STAFF...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('777-555 Fringilla. Av.', '557839415 ', 'Eaton Lott', 'eatonlott5980@yahoo.net', 70250);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #656-7023 Est. St.', '574921141 ', 'Clark Sampson', 'clarksampson4602@gmail.edu', 35553);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('833-8832 Aliquam St.', '580411781 ', 'Garrett Harrison', 'garrettharrison@icloud.ca', 43931);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 969, 908 Cum St.', '562542622 ', 'Madaline Mack', 'madalinemack@aol.net', 27637);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('496-2155 Orci Street', '541521610 ', 'Ali Black', 'aliblack@gmail.org', 50219);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #601-1348 Et Road', '535112874 ', 'Marshall Shannon', 'marshallshannon5759@google.net', 22440);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('309-8129 Feugiat Rd.', '564257271 ', 'Oscar Benjamin', 'oscarbenjamin@aol.edu', 66029);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('786-3330 Nisi Av.', '513778782 ', 'Emerson Cardenas', 'emersoncardenas@icloud.couk', 68854);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7968 Eu Road', '548711235 ', 'Brennan Reid', 'brennanreid@yahoo.edu', 99681);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7783 Phasellus Avenue', '552114866 ', 'Kiara Ayers', 'kiaraayers7858@aol.org', 30610);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #418-6767 Semper. Avenue', '593645385 ', 'Sacha Webster', 'sachawebster6532@yahoo.com', 24608);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #833-5380 Mauris Road', '512145373 ', 'Oscar Mays', 'oscarmays9991@gmail.couk', 47411);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1014 Aliquet Rd.', '573652779 ', 'Vance Bradley', 'vancebradley@icloud.ca', 13416);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #453-5652 Mollis. Rd.', '564797052 ', 'Karyn Price', 'karynprice@gmail.edu', 18802);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('480-3066 Nunc Rd.', '537150742 ', 'Macon King', 'maconking3176@gmail.net', 16012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 467, 5418 Duis Road', '564174504 ', 'Connor Mcmillan', 'connormcmillan@google.net', 15963);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #719-4855 Ante St.', '535721837 ', 'Abra Clemons', 'abraclemons2857@aol.org', 84940);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('809 Urna Street', '575013566 ', 'Harrison Stewart', 'harrisonstewart@gmail.net', 19098);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #901-2030 Vel Street', '542991526 ', 'Jeremy Santana', 'jeremysantana@gmail.couk', 69373);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('827-8375 Aliquam Rd.', '527581368 ', 'Constance Navarro', 'constancenavarro@icloud.edu', 31845);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('383-3411 Nam Rd.', '566718812 ', 'Colby Shaffer', 'colbyshaffer7949@icloud.couk', 25922);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('279-4046 A, St.', '594524576 ', 'Stacey Mcleod', 'staceymcleod@aol.com', 26135);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4212 Odio Av.', '521145828 ', 'Gannon Vance', 'gannonvance@google.org', 77934);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 408, 8813 Volutpat. Avenue', '517871957 ', 'Alan Sullivan', 'alansullivan@aol.com', 83782);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8129 Facilisis Av.', '598355463 ', 'Joelle Hoover', 'joellehoover4378@yahoo.couk', 90376);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #331-8940 Ut Road', '521151267 ', 'Kane Velazquez', 'kanevelazquez5579@icloud.com', 90152);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7215 Vestibulum Road', '556769693 ', 'Halee Boyer', 'haleeboyer8640@yahoo.couk', 61039);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 933, 8375 Enim Rd.', '582388653 ', 'Jordan Stanton', 'jordanstanton@gmail.net', 72497);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('112-260 Varius Av.', '576107777 ', 'Jescie Reynolds', 'jesciereynolds4525@icloud.couk', 44135);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #299-1591 Dictum Street', '505456764 ', 'Harding Ballard', 'hardingballard7768@icloud.ca', 41470);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('442-2426 Ut Street', '526678882 ', 'Gavin Foley', 'gavinfoley@yahoo.ca', 16017);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #878-4716 Magna Rd.', '554512612 ', 'Kennedy Atkins', 'kennedyatkins5511@yahoo.net', 68062);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('369-2220 Proin Av.', '556043206 ', 'Keely Lambert', 'keelylambert@aol.couk', 87909);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #778-3523 Nunc Street', '521473627 ', 'Kerry Cantrell', 'kerrycantrell3347@google.couk', 37037);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('214-5228 Turpis St.', '540508616 ', 'Nehru Kane', 'nehrukane@gmail.edu', 13854);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('861-3422 Et, Rd.', '548580479 ', 'Evan Norman', 'evannorman3424@yahoo.net', 20080);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 302, 6246 Risus. St.', '538180461 ', 'Flynn Fulton', 'flynnfulton@google.edu', 48224);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #727-177 Pede Rd.', '545651455 ', 'Indigo Rios', 'indigorios2663@aol.net', 74972);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('242-6132 Laoreet Ave', '535495636 ', 'Dexter Brock', 'dexterbrock@google.edu', 90220);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 452, 4243 Mi Street', '564133153 ', 'Finn Dalton', 'finndalton8241@google.net', 15962);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 745, 426 Sed Avenue', '578738721 ', 'Ryan Farley', 'ryanfarley@aol.couk', 62317);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('431-364 Nulla. Street', '533622703 ', 'Devin Dejesus', 'devindejesus6975@yahoo.com', 19618);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('787-2727 Curabitur St.', '583807736 ', 'Lance Mooney', 'lancemooney@google.com', 65613);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #238-8440 Dapibus Av.', '597121814 ', 'Chadwick May', 'chadwickmay@aol.edu', 96640);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9496 Nulla Ave', '557505223 ', 'Slade Frank', 'sladefrank9577@google.edu', 61696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7256 Lorem St.', '555586696 ', 'Raymond Warner', 'raymondwarner@icloud.com', 38187);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 334, 4736 Eleifend St.', '580677323 ', 'Gil Morse', 'gilmorse@google.ca', 29872);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #556-2620 Lectus Street', '541851873 ', 'Lesley Clements', 'lesleyclements@gmail.org', 87171);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('551-7034 Semper St.', '532543299 ', 'Berk Brooks', 'berkbrooks5135@gmail.com', 85179);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #189-6621 Gravida. Rd.', '513542253 ', 'Axel Simpson', 'axelsimpson4740@google.com', 72073);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('820-4056 Cras Avenue', '521786146 ', 'Brynne Winters', 'brynnewinters7074@yahoo.com', 98900);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 503, 1178 Metus Ave', '559616521 ', 'Rahim Rodriquez', 'rahimrodriquez@yahoo.edu', 35556);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5718 Vulputate St.', '594666137 ', 'Phoebe Mckinney', 'phoebemckinney@google.ca', 33532);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('560-2948 Non, Rd.', '523156678 ', 'Tanner Peters', 'tannerpeters@icloud.couk', 68549);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('509-4772 Vestibulum Rd.', '524626646 ', 'Flynn Villarreal', 'flynnvillarreal9983@aol.couk', 68614);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('564-5771 Eu Street', '592450737 ', 'Tanisha Morgan', 'tanishamorgan838@google.couk', 11083);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8968 Suspendisse Road', '504006741 ', 'Lunea Emerson', 'luneaemerson@google.net', 38296);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('396-1488 Erat Street', '538383559 ', 'Naida Wade', 'naidawade@icloud.edu', 54635);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('881-5828 Integer St.', '551732000 ', 'Flavia Mcintosh', 'flaviamcintosh@gmail.com', 43915);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #403-2787 Egestas. Street', '573237112 ', 'Karyn Marsh', 'karynmarsh@yahoo.edu', 63761);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('319-2818 Nisl St.', '515333265 ', 'Galvin Ashley', 'galvinashley@gmail.net', 90668);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #522-2184 Amet Av.', '522733464 ', 'Tamara Park', 'tamarapark1701@gmail.com', 71473);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246-5855 Amet Av.', '515274520 ', 'Griffith Keller', 'griffithkeller7065@icloud.couk', 18863);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3056 Turpis Rd.', '536953528 ', 'Colleen Drake', 'colleendrake4856@icloud.couk', 84301);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3407 Parturient Road', '569438994 ', 'Jamalia Nelson', 'jamalianelson1349@gmail.couk', 50906);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 227, 6260 Ac St.', '588621867 ', 'Axel Brewer', 'axelbrewer1930@aol.com', 24626);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('870-4178 Ut St.', '566568338 ', 'Hoyt Burgess', 'hoytburgess@icloud.org', 21996);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #841-223 Donec Avenue', '502347836 ', 'Ezra Petty', 'ezrapetty@gmail.org', 50112);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #949-2228 Taciti Ave', '546448857 ', 'Stephanie Walters', 'stephaniewalters6553@google.org', 59791);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('988-8976 Phasellus Rd.', '512641152 ', 'Justin Perkins', 'justinperkins@google.couk', 60642);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('960-1858 Vivamus Av.', '516540543 ', 'Charles Russell', 'charlesrussell1550@gmail.org', 88541);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7486 Mollis Avenue', '550467486 ', 'Timon Kirk', 'timonkirk@yahoo.net', 70482);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('172-5884 Orci. Rd.', '525639826 ', 'Yen Boyer', 'yenboyer391@aol.edu', 61721);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('655-8823 Quam Street', '565424647 ', 'Leah Olson', 'leaholson@gmail.ca', 84092);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('727-1258 Et, Rd.', '564758401 ', 'Warren Bradley', 'warrenbradley8891@yahoo.net', 73373);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('187-6770 Ipsum. Avenue', '524397393 ', 'Hanae Salas', 'hanaesalas5714@yahoo.net', 55295);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #704-1734 Urna Road', '554277315 ', 'Hilel Leonard', 'hilelleonard6037@google.net', 12245);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #148-4189 Magna. Av.', '520381736 ', 'Natalie Bishop', 'nataliebishop@aol.net', 43702);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 533, 173 Aliquet Avenue', '573723328 ', 'Nerea Atkins', 'nereaatkins3078@gmail.couk', 52769);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #315-4061 Pellentesque Ave', '512018656 ', 'Keiko Greene', 'keikogreene9814@aol.couk', 74841);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4830 Nec Ave', '561202638 ', 'August Mayer', 'augustmayer@aol.edu', 92960);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('921-5607 Molestie Rd.', '577522811 ', 'Macey Leonard', 'maceyleonard@google.com', 69582);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #136-7353 Sed Ave', '568035678 ', 'Shannon Leon', 'shannonleon5982@gmail.couk', 68890);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 300, 1799 Gravida. Rd.', '555590456 ', 'Hammett Gill', 'hammettgill3998@yahoo.net', 18791);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-9305 Vivamus St.', '573718435 ', 'Shelley Moody', 'shelleymoody@google.net', 89796);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 522, 8963 Ante. Av.', '587582511 ', 'Quynn Holloway', 'quynnholloway@gmail.ca', 95354);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #666-8698 Purus Rd.', '522758221 ', 'Salvador Ashley', 'salvadorashley9273@gmail.com', 57569);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('948-8845 Vel St.', '517414144 ', 'Dahlia Owens', 'dahliaowens@aol.com', 54038);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('489-8703 Arcu. St.', '572652786 ', 'Morgan Hardin', 'morganhardin@yahoo.com', 69221);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 547, 4627 Molestie Road', '563603836 ', 'Wyatt Lara', 'wyattlara@icloud.com', 51251);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #700-8942 Nunc Street', '516175362 ', 'Rowan Savage', 'rowansavage1753@aol.couk', 82187);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('509 Non Rd.', '546198853 ', 'Zena Howard', 'zenahoward@icloud.couk', 44156);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 445, 7101 Quisque Rd.', '574447573 ', 'Eve Holland', 'eveholland@icloud.couk', 58745);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('700-1021 Elit, Av.', '522656074 ', 'Robert Sims', 'robertsims4427@gmail.com', 18525);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('111-6793 Magna. Av.', '546229625 ', 'Ivory Dunn', 'ivorydunn@google.couk', 99939);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 873, 6303 Nec St.', '576201253 ', 'Uriel Neal', 'urielneal@aol.org', 81284);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('585-1795 Metus Av.', '555092215 ', 'Fritz Weeks', 'fritzweeks5168@yahoo.com', 17105);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #641-3387 Phasellus Avenue', '531410563 ', 'Cheryl Rojas', 'cherylrojas@yahoo.org', 11630);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('950-338 Nascetur Ave', '513777066 ', 'Ferris Gallagher', 'ferrisgallagher1685@icloud.couk', 86538);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #760-5710 Vulputate, Ave', '564394841 ', 'Len Baldwin', 'lenbaldwin@google.com', 64760);
commit;
prompt 100 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #269-7789 Molestie. Avenue', '585648527 ', 'Jennifer Durham', 'jenniferdurham@aol.net', 32568);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 775, 1674 Odio Avenue', '569446768 ', 'Dominique Travis', 'dominiquetravis@google.edu', 82258);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 714, 4508 Mollis St.', '522208561 ', 'Molly Perry', 'mollyperry@gmail.couk', 63530);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 382, 7049 Non St.', '513075078 ', 'Cara Rosario', 'cararosario5324@google.com', 56476);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #757-1273 Et, St.', '576548447 ', 'Darryl Schmidt', 'darrylschmidt@yahoo.com', 64185);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('555-8195 Augue Rd.', '543118427 ', 'Samson Waller', 'samsonwaller@aol.couk', 88762);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('841 Aliquam St.', '568408287 ', 'Sebastian Brown', 'sebastianbrown@icloud.org', 99769);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #872-7778 Ullamcorper Rd.', '555239556 ', 'Jena Gamble', 'jenagamble9266@gmail.couk', 83831);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #550-8456 Nunc. Road', '513447169 ', 'Emmanuel Burks', 'emmanuelburks@gmail.com', 27991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #515-9910 Ac Av.', '517415802 ', 'Preston Golden', 'prestongolden@yahoo.ca', 82172);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #492-5770 Nunc Ave', '588137371 ', 'Guy Macdonald', 'guymacdonald@google.net', 35877);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5998 Dolor. Rd.', '578693863 ', 'Eric Wade', 'ericwade@google.com', 61546);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('352-1005 Mauris St.', '562747017 ', 'Sybil Garner', 'sybilgarner@gmail.org', 52116);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('520-5294 Habitant St.', '517443492 ', 'Lillian Parrish', 'lillianparrish@google.org', 80830);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('101-2980 Auctor St.', '523740535 ', 'Beverly Clements', 'beverlyclements881@yahoo.org', 71959);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 485, 6211 Non, Street', '566737527 ', 'Alana Sweet', 'alanasweet@gmail.edu', 37345);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('890-9570 Faucibus Rd.', '516973121 ', 'Ray Waters', 'raywaters@gmail.org', 34214);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('765-6368 Sed Av.', '557582683 ', 'Erin Franks', 'erinfranks6566@aol.ca', 86842);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('366-1556 Phasellus Rd.', '577777975 ', 'Venus Nolan', 'venusnolan2990@aol.com', 91865);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('822-8554 Pellentesque Road', '516661385 ', 'Jaquelyn Meyers', 'jaquelynmeyers5406@icloud.ca', 79825);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('455-9109 Odio Street', '533682586 ', 'Elton Wells', 'eltonwells@yahoo.edu', 14599);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('336-8376 Pede, Rd.', '575701763 ', 'Graham O''brien', 'grahamobrien6608@gmail.org', 12053);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 127, 6219 Eu St.', '546418581 ', 'Joy Jacobson', 'joyjacobson@icloud.ca', 83250);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('868-9853 Vitae, Road', '526222973 ', 'Vance Butler', 'vancebutler2321@aol.org', 57384);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 632, 4151 Turpis St.', '542322210 ', 'Lucy Moses', 'lucymoses@aol.couk', 55244);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9869 Magna Av.', '587828575 ', 'Keaton Mcknight', 'keatonmcknight@yahoo.edu', 12082);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('146-1365 Congue, St.', '527349116 ', 'Valentine Kaufman', 'valentinekaufman@gmail.net', 41120);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('230-6929 Suscipit Road', '596814562 ', 'Chiquita Hines', 'chiquitahines@google.com', 31151);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #513-8280 Enim. Ave', '566358768 ', 'Lars Baird', 'larsbaird94@google.ca', 99596);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 300, 1701 Donec Street', '542121155 ', 'Risa Torres', 'risatorres3860@gmail.org', 31448);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('491-894 Mauris Avenue', '502523876 ', 'Laith Austin', 'laithaustin326@yahoo.couk', 55149);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789-2466 Eu Rd.', '583569262 ', 'Carissa Baird', 'carissabaird@gmail.org', 83211);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 107, 1303 Donec Road', '565625124 ', 'Helen Rocha', 'helenrocha@yahoo.com', 70610);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('803-6157 Cras Road', '502526397 ', 'Vielka Lopez', 'vielkalopez578@aol.ca', 88875);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 999, 980 Sollicitudin St.', '534253376 ', 'Barrett Beasley', 'barrettbeasley@google.couk', 99342);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #707-9661 Tempus St.', '596105288 ', 'Lee Gould', 'leegould3190@aol.com', 42679);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1962 Dui. Ave', '582623882 ', 'Sheila Mooney', 'sheilamooney@gmail.couk', 83526);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #851-5065 Fusce Avenue', '596768416 ', 'Tanisha Ruiz', 'tanisharuiz3940@aol.com', 19936);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('989-4140 Aliquet Rd.', '535472519 ', 'Reagan Ashley', 'reaganashley3225@google.com', 81877);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9362 Suspendisse Street', '564069268 ', 'Kenyon Greene', 'kenyongreene@icloud.edu', 50598);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('736-6478 Velit. Rd.', '573703504 ', 'Sheila Banks', 'sheilabanks@aol.org', 89061);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('582-8851 Iaculis St.', '541634727 ', 'Keelie Waters', 'keeliewaters7555@gmail.edu', 76589);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('924-4488 Torquent Avenue', '544831649 ', 'Judah Kerr', 'judahkerr5@google.edu', 25190);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('841-5414 Orci, Rd.', '521844931 ', 'Ryan Castaneda', 'ryancastaneda@aol.couk', 32593);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 879, 8486 Congue, Av.', '594677637 ', 'Hilel Baird', 'hilelbaird7340@gmail.edu', 72720);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #322-8694 Vel, Avenue', '551835552 ', 'Melinda Rosario', 'melindarosario@google.ca', 35130);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #237-505 Ullamcorper, St.', '554657269 ', 'Carly Mosley', 'carlymosley5311@icloud.edu', 91368);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('679-9125 Ut Av.', '514407551 ', 'Jenna Graves', 'jennagraves@yahoo.org', 28571);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #804-1927 Vitae St.', '524243801 ', 'Justine Baldwin', 'justinebaldwin8485@google.ca', 87332);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #265-8459 Curabitur Rd.', '539591012 ', 'Alfonso Morales', 'alfonsomorales737@gmail.com', 86483);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('325-1754 Vestibulum Av.', '562876878 ', 'Melissa Schroeder', 'melissaschroeder@google.net', 51740);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 110, 8945 In Avenue', '574646715 ', 'Timon Fleming', 'timonfleming@gmail.net', 79591);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #680-7541 Lorem, Rd.', '577325511 ', 'Abel Byers', 'abelbyers@google.com', 74331);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 746, 6204 Nunc Ave', '564741374 ', 'Henry Sweet', 'henrysweet6041@aol.couk', 74548);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('555-2029 Cursus Rd.', '524579329 ', 'Brady Strickland', 'bradystrickland@yahoo.couk', 52359);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('887-6001 Duis St.', '554222075 ', 'Abel Alvarez', 'abelalvarez@google.ca', 19671);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('898-8406 Nulla. Rd.', '523461780 ', 'Graiden Hutchinson', 'graidenhutchinson@google.org', 28053);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #244-9663 Faucibus Rd.', '586539667 ', 'Melvin Knapp', 'melvinknapp4769@aol.couk', 16712);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('122-8062 Erat. Av.', '580046806 ', 'Kenneth Ashley', 'kennethashley@gmail.org', 59839);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 200, 7870 Laoreet, Avenue', '553212214 ', 'Garrison Lambert', 'garrisonlambert818@gmail.net', 89337);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('727-1250 Scelerisque Ave', '583463722 ', 'Rosalyn Valencia', 'rosalynvalencia@aol.com', 97343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('105-5667 A, Ave', '574118242 ', 'Grady Maddox', 'gradymaddox@aol.couk', 45839);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #741-1070 Suspendisse Rd.', '510726324 ', 'Flynn Madden', 'flynnmadden1077@aol.com', 10652);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4121 Dolor. Av.', '592391108 ', 'Jason Wilcox', 'jasonwilcox6386@icloud.edu', 47507);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('135-6253 Nisl Road', '519384725 ', 'Angelica Randall', 'angelicarandall@aol.couk', 57567);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #982-4907 Pede, St.', '541679324 ', 'Germane Newton', 'germanenewton@google.org', 28651);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8085 Est. Rd.', '548734071 ', 'Cedric Fulton', 'cedricfulton@aol.net', 10334);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6720 Sit Avenue', '523468637 ', 'Kerry Petty', 'kerrypetty3896@gmail.ca', 27192);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9508 Amet, Road', '501773154 ', 'Jemima Little', 'jemimalittle166@icloud.couk', 91660);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('737-6687 Mi. Avenue', '515384361 ', 'Cathleen Winters', 'cathleenwinters2733@yahoo.ca', 95896);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('540-5910 Fringilla St.', '594767325 ', 'Uta Lynch', 'utalynch@google.net', 49666);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('656-6402 Ac Rd.', '579426362 ', 'Erica Ramos', 'ericaramos@gmail.org', 95320);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('960-9429 Vitae Av.', '557048406 ', 'Walter Rodriguez', 'walterrodriguez8240@icloud.edu', 47027);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('411-6658 Natoque Road', '525646654 ', 'Camden Acevedo', 'camdenacevedo1142@aol.net', 15383);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('164-6098 Tincidunt, St.', '558642378 ', 'Brett Vinson', 'brettvinson3881@aol.com', 13261);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('352-9568 Lacus. Rd.', '564658502 ', 'Minerva Knowles', 'minervaknowles@aol.net', 74091);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('781-1796 Mauris St.', '525587831 ', 'Jacqueline Fleming', 'jacquelinefleming4206@google.com', 47970);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('774-6657 Adipiscing, Avenue', '542627439 ', 'Montana Bullock', 'montanabullock6038@google.org', 42023);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 427, 7833 Eget Street', '508652224 ', 'Abel Dillard', 'abeldillard@gmail.edu', 34428);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #115-2097 Purus Av.', '528857826 ', 'Chancellor Bates', 'chancellorbates@aol.org', 15991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('157-6601 Pellentesque Rd.', '530105577 ', 'Tanisha Kim', 'tanishakim@google.couk', 73025);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('367-5340 Vestibulum, Rd.', '557955774 ', 'Zelenia Robles', 'zeleniarobles5833@aol.couk', 53998);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 208, 7355 Bibendum Street', '514448660 ', 'Jada Gibson', 'jadagibson5119@yahoo.couk', 34404);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('908-6570 Vitae Rd.', '553888816 ', 'Hasad Madden', 'hasadmadden3719@aol.couk', 79255);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('778-828 Tempor St.', '513625224 ', 'Barclay Donovan', 'barclaydonovan@icloud.org', 21312);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7423 Vel Ave', '589795952 ', 'Amena Bowers', 'amenabowers6899@google.edu', 63284);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #715-8187 Vulputate Street', '502841488 ', 'Ignacia Haley', 'ignaciahaley@google.edu', 54246);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #242-1826 Ante Road', '581931122 ', 'Medge Matthews', 'medgematthews@gmail.edu', 17595);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8685 Erat Av.', '542787462 ', 'Hasad Frye', 'hasadfrye7650@yahoo.couk', 29561);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #211-5804 Adipiscing, Street', '554814788 ', 'Bree Blackburn', 'breeblackburn@google.edu', 46150);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('165-9181 Dictum Av.', '558713989 ', 'Pascale Mclean', 'pascalemclean@yahoo.ca', 48255);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 519, 8551 Interdum Av.', '585153685 ', 'Fritz Robles', 'fritzrobles2842@icloud.ca', 98375);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('838-4367 Sem Rd.', '514486364 ', 'Garrison Sims', 'garrisonsims5648@google.couk', 65741);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('430-2424 Aliquet, Avenue', '509955854 ', 'Desiree Drake', 'desireedrake6194@icloud.org', 79859);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('840-8083 Cras Road', '560688853 ', 'Shaine Garcia', 'shainegarcia@gmail.org', 92935);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #881-2381 Luctus Rd.', '531546613 ', 'Carla Park', 'carlapark@yahoo.ca', 24656);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #150-6481 Lorem Avenue', '504367217 ', 'Gregory Hull', 'gregoryhull9722@google.org', 70748);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8110 Nunc Ave', '552884893 ', 'Tucker Holcomb', 'tuckerholcomb@gmail.com', 55269);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('540-7773 Nullam St.', '532912738 ', 'Ferdinand Hunter', 'ferdinandhunter9004@gmail.edu', 47962);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #603-6530 Auctor St.', '535493434 ', 'Seth Mcdonald', 'sethmcdonald2053@icloud.edu', 89885);
commit;
prompt 200 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('427-2751 Facilisis, St.', '513666362 ', 'Josiah Pacheco', 'josiahpacheco@google.org', 33360);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 571, 7230 In Rd.', '541637088 ', 'Francesca Mendoza', 'francescamendoza8935@yahoo.couk', 88571);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('952-4250 Nulla Av.', '558444542 ', 'Gay Glover', 'gayglover5321@google.org', 49355);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #777-9659 Blandit Avenue', '583816826 ', 'Vincent Wilkinson', 'vincentwilkinson@google.couk', 81875);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #260-5768 Lorem Street', '526494402 ', 'Nerea Flowers', 'nereaflowers2160@yahoo.com', 10709);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 478, 2984 Et Av.', '529168672 ', 'Ulla Richardson', 'ullarichardson@aol.ca', 99447);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 370, 365 Elementum, Av.', '506867633 ', 'Giselle Miranda', 'gisellemiranda4065@aol.net', 80248);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 542, 520 Etiam Rd.', '563614205 ', 'Kato Fowler', 'katofowler7238@google.net', 55385);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8206 Suspendisse Street', '528153403 ', 'Jonah Davis', 'jonahdavis@google.ca', 58938);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #475-7167 Aliquet St.', '576794236 ', 'Ali Mccarty', 'alimccarty@gmail.org', 99778);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('760-4732 Ante Road', '529684949 ', 'Hoyt Terry', 'hoytterry9662@gmail.net', 35535);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('167-396 Sem Rd.', '532851328 ', 'Basil Sawyer', 'basilsawyer@aol.net', 50188);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8461 Eu St.', '504368535 ', 'Steel French', 'steelfrench7565@aol.net', 64636);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5527 Eget, Av.', '525465726 ', 'Silas Berger', 'silasberger@icloud.com', 59041);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #901-8937 Magna. St.', '571664224 ', 'Rana Hughes', 'ranahughes@icloud.net', 92716);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #404-2686 Habitant Rd.', '555403678 ', 'Nissim Carter', 'nissimcarter2938@gmail.couk', 39314);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('247-1748 Gravida. Av.', '554380376 ', 'Colleen Kelley', 'colleenkelley8163@aol.org', 64076);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('878-8837 Ornare, Avenue', '560948551 ', 'Madison Clarke', 'madisonclarke@yahoo.net', 66915);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #718-1453 Vel, Ave', '515126338 ', 'Mason Roberts', 'masonroberts5198@google.couk', 39306);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #488-9356 Nisl St.', '538404014 ', 'Slade Bowers', 'sladebowers@gmail.net', 57210);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3750 Ligula. Ave', '524166350 ', 'Troy Hayden', 'troyhayden@gmail.ca', 81184);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('985-1322 Lacus Rd.', '593164728 ', 'Seth Tanner', 'sethtanner@gmail.net', 93908);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('504-7454 Rutrum Street', '530850760 ', 'Erich Mayer', 'erichmayer2714@icloud.edu', 27277);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #625-8527 Ligula. Av.', '535458431 ', 'Allegra Harper', 'allegraharper@gmail.ca', 15746);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('680-804 Sociis St.', '524168384 ', 'Fulton Sanders', 'fultonsanders@gmail.com', 49449);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #706-799 Phasellus St.', '501794513 ', 'Helen Walters', 'helenwalters4808@aol.com', 33794);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('134-4456 Mi Road', '549835824 ', 'Deanna Taylor', 'deannataylor@google.edu', 68229);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-261 Luctus Road', '537254793 ', 'Hanae Mercado', 'hanaemercado1791@icloud.ca', 83271);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 592, 2502 Nulla Avenue', '547128513 ', 'Wilma Mcintyre', 'wilmamcintyre@gmail.ca', 30379);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('382-2358 Sapien. Rd.', '536552445 ', 'Shay Wilkerson', 'shaywilkerson@gmail.couk', 72662);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #953-2828 Semper St.', '532443538 ', 'Reagan Reed', 'reaganreed@yahoo.org', 48384);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #665-9867 Ipsum Rd.', '510334421 ', 'Melyssa Gould', 'melyssagould4067@gmail.com', 34941);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('678-7913 Dolor. Rd.', '583862347 ', 'Haviva Roth', 'havivaroth3316@gmail.net', 15357);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #228-5304 Lectus Av.', '552686566 ', 'Dara Mcclure', 'daramcclure5281@yahoo.couk', 66193);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3715 Commodo St.', '529985889 ', 'Jameson Sears', 'jamesonsears7830@icloud.net', 60957);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #384-9731 Eget Rd.', '585903313 ', 'Mikayla Ramos', 'mikaylaramos7868@icloud.edu', 72820);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('821 Accumsan Street', '559015656 ', 'Rebecca Glover', 'rebeccaglover5668@aol.net', 45109);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 725, 719 Odio. St.', '536348805 ', 'Vance Mcleod', 'vancemcleod3763@icloud.com', 26921);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('388-6577 Sodales Street', '560653462 ', 'Pamela Wheeler', 'pamelawheeler8490@yahoo.couk', 94830);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6097 Sed St.', '541163753 ', 'Kalia Martinez', 'kaliamartinez@gmail.couk', 82443);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 393, 1086 Justo. Rd.', '514477505 ', 'Benedict Neal', 'benedictneal@gmail.couk', 98750);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #560-4351 Tincidunt, Av.', '510113661 ', 'Eugenia Harmon', 'eugeniaharmon@yahoo.com', 31947);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('747-1905 Sodales Street', '500871371 ', 'Cadman Knapp', 'cadmanknapp9312@aol.net', 57527);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 192, 7628 Mi St.', '531600723 ', 'Jasmine Holcomb', 'jasmineholcomb4015@icloud.edu', 13794);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 827, 1820 Nec, Avenue', '534165364 ', 'Timon Cameron', 'timoncameron1858@google.ca', 42991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #590-3472 A, Street', '545885159 ', 'Lavinia Gordon', 'laviniagordon3328@icloud.ca', 30696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('887-8056 Ornare, Av.', '557618769 ', 'Ignacia Sanders', 'ignaciasanders5602@yahoo.com', 51125);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6358 Eu Rd.', '573183387 ', 'Keefe Cardenas', 'keefecardenas6920@yahoo.net', 76380);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('105-5302 In Rd.', '522421773 ', 'Imelda Pittman', 'imeldapittman6879@yahoo.net', 91455);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #306-3942 Eget Avenue', '522015243 ', 'Quyn Hamilton', 'quynhamilton1081@google.org', 56263);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 760, 9733 Egestas Street', '553737682 ', 'Alden Murphy', 'aldenmurphy@yahoo.net', 51861);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('120-7097 Egestas. Av.', '545561089 ', 'Zeus Villarreal', 'zeusvillarreal9608@google.net', 62741);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #753-5386 Nunc Ave', '544171861 ', 'Jacob Arnold', 'jacobarnold6727@icloud.edu', 55546);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #675-9070 Dolor. Ave', '534303341 ', 'Chandler Rios', 'chandlerrios@gmail.net', 95541);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('107-4502 Aenean St.', '583194321 ', 'Nicole Pollard', 'nicolepollard7474@yahoo.com', 55777);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('335-5389 Eu, Ave', '565872686 ', 'Xyla Rutledge', 'xylarutledge@google.com', 54662);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #649-8422 Nullam Av.', '517796724 ', 'Maggy Meyer', 'maggymeyer@icloud.edu', 93859);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('635-2003 Sit Av.', '508975168 ', 'Joel Pratt', 'joelpratt@gmail.com', 63762);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 426, 3188 Nunc. Rd.', '583770774 ', 'Christen Rocha', 'christenrocha@aol.org', 25578);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #328-7014 Consequat Av.', '511215426 ', 'Noel French', 'noelfrench@icloud.net', 86430);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #777-4122 Facilisis Rd.', '583231436 ', 'Brian Mcgowan', 'brianmcgowan593@gmail.couk', 63961);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7351 A Rd.', '516758953 ', 'Harding Ortiz', 'hardingortiz@icloud.net', 90716);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #136-7681 Aliquet Rd.', '531158076 ', 'Idona York', 'idonayork4706@gmail.com', 68393);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5850 Sed Road', '545186956 ', 'MacKenzie Rivera', 'mackenzierivera4426@google.couk', 36074);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #873-3777 Vitae St.', '533242190 ', 'Dawn Mack', 'dawnmack9547@yahoo.edu', 13243);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 209, 6098 Lacinia Ave', '533672181 ', 'Zane Mason', 'zanemason3835@gmail.edu', 15343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 718, 2810 Malesuada Ave', '576014371 ', 'Aaron West', 'aaronwest@aol.edu', 22236);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('923-8870 Malesuada Ave', '562428602 ', 'Ria Blair', 'riablair@gmail.net', 33143);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('444-4229 Ipsum. Ave', '585821533 ', 'Tyler Kirk', 'tylerkirk5592@yahoo.net', 89219);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 699, 710 Aliquet Avenue', '560063248 ', 'Vernon Terrell', 'vernonterrell@icloud.ca', 34355);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 423, 6657 Luctus. Ave', '517220662 ', 'Haley Floyd', 'haleyfloyd@gmail.couk', 76479);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8230 Luctus, St.', '533187031 ', 'Amal George', 'amalgeorge2591@aol.org', 99553);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #379-8022 Cras Street', '581654097 ', 'Louis Coffey', 'louiscoffey@yahoo.edu', 92365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #623-9447 Tincidunt, Rd.', '526281113 ', 'Rashad Morse', 'rashadmorse8467@google.com', 21395);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #836-672 Non, Rd.', '568198026 ', 'Kylie Washington', 'kyliewashington@icloud.couk', 26952);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #186-8377 Magna St.', '580346633 ', 'Lesley Mitchell', 'lesleymitchell@google.net', 78475);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('350-1665 In Ave', '558401857 ', 'Dominique Barron', 'dominiquebarron@aol.net', 46197);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8630 Dictum Rd.', '585728104 ', 'Lillith Juarez', 'lillithjuarez@yahoo.couk', 42122);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #860-3713 Nec Rd.', '583491354 ', 'Amanda Schneider', 'amandaschneider5626@google.net', 77955);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #571-8518 Aliquam Road', '553751328 ', 'Cruz Thomas', 'cruzthomas@icloud.edu', 25991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 447, 6647 Arcu Avenue', '516365335 ', 'Leslie Sawyer', 'lesliesawyer249@gmail.net', 65725);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('607-8242 Euismod St.', '531186934 ', 'Steven Roberts', 'stevenroberts1344@google.couk', 45148);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('708-2955 Hendrerit Av.', '567582562 ', 'Basia Cabrera', 'basiacabrera@google.com', 36102);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #770-1714 Ipsum Road', '559516128 ', 'Kelsie Anderson', 'kelsieanderson@icloud.edu', 69880);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('427-6416 Eros. Av.', '560467565 ', 'Nola Hunt', 'nolahunt1361@aol.com', 11410);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('349-5844 Porttitor St.', '576740394 ', 'Kyle Castillo', 'kylecastillo7518@aol.edu', 60751);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('125-1770 Aenean Ave', '584744473 ', 'Ahmed Carey', 'ahmedcarey5002@yahoo.org', 37415);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4585 Mollis St.', '511582703 ', 'Edward Black', 'edwardblack9041@google.net', 28516);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('938-6874 Nullam Rd.', '568671458 ', 'Jolene Grant', 'jolenegrant3628@gmail.com', 81157);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 923, 8101 Non, Road', '530214135 ', 'Hayden Green', 'haydengreen1666@google.com', 41224);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #794-303 Sit Rd.', '508515499 ', 'Janna Hayden', 'jannahayden1610@icloud.ca', 54266);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 111, 6097 Nullam Avenue', '568540267 ', 'Giacomo Day', 'giacomoday@gmail.com', 80537);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-8555 Quis Street', '565725845 ', 'Todd Jimenez', 'toddjimenez@aol.couk', 81894);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #713-1789 Sodales. Rd.', '578771307 ', 'Garrett Freeman', 'garrettfreeman@gmail.net', 17853);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('154-9857 Dolor Av.', '533222477 ', 'Caesar French', 'caesarfrench9172@google.com', 29543);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('664-7202 Elit Ave', '560853734 ', 'Beau Horne', 'beauhorne2911@icloud.couk', 30526);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 191, 6074 Mi St.', '585874316 ', 'Jackson Parsons', 'jacksonparsons@aol.com', 83689);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('794-1599 Consectetuer Rd.', '582511229 ', 'Camille Ratliff', 'camilleratliff@yahoo.edu', 19331);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6953 Sollicitudin St.', '537311487 ', 'Ivor Gonzales', 'ivorgonzales9752@google.edu', 51672);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('257-185 Quis, St.', '575363961 ', 'Slade Rivas', 'sladerivas7347@yahoo.com', 34609);
commit;
prompt 300 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #154-5061 Vel Ave', '512177462 ', 'Olivia Church', 'oliviachurch@google.com', 73659);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('299-3992 Etiam Av.', '565532609 ', 'Jaquelyn Delgado', 'jaquelyndelgado59@google.net', 23953);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 743, 8952 Eu St.', '547847816 ', 'Astra Baker', 'astrabaker1642@google.org', 37004);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #996-3197 Tempor Rd.', '551560128 ', 'Rhoda Waller', 'rhodawaller@aol.couk', 40705);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #834-7751 Rutrum, Avenue', '527856737 ', 'Kevin Guerra', 'kevinguerra3289@google.org', 39365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('576-1754 Fusce St.', '513537248 ', 'Magee Mccarthy', 'mageemccarthy823@aol.org', 69296);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #570-3303 Mus. Street', '542823752 ', 'Otto Sharpe', 'ottosharpe@yahoo.org', 18773);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #309-2092 Vitae, Rd.', '571389174 ', 'Shad Stein', 'shadstein1487@google.couk', 33749);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('381-262 Mauris Avenue', '545334213 ', 'Nigel Waters', 'nigelwaters5879@aol.ca', 16063);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6305 Cras Rd.', '534811785 ', 'Cruz Neal', 'cruzneal@google.net', 62435);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('134-2600 Sit Av.', '536862815 ', 'Sara Sandoval', 'sarasandoval4151@aol.net', 58235);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #815-5751 Egestas. Ave', '587603023 ', 'Herrod Rowe', 'herrodrowe@aol.net', 78572);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 465, 8105 At Rd.', '555958867 ', 'Jena Barron', 'jenabarron@google.com', 31696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #434-8747 Fringilla Rd.', '512638817 ', 'Neil Potts', 'neilpotts1191@yahoo.ca', 96641);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #896-8687 Justo Avenue', '588367610 ', 'Maite Delacruz', 'maitedelacruz@gmail.ca', 48188);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('461-8594 A Ave', '584395811 ', 'Nero Riley', 'neroriley@icloud.couk', 45377);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('120-6708 Cursus Av.', '539472154 ', 'Richard Bates', 'richardbates@icloud.com', 91156);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #407-2591 Fusce St.', '599544334 ', 'Griffin Cummings', 'griffincummings1057@yahoo.org', 11311);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8086 Ac Road', '568812899 ', 'Patrick Norton', 'patricknorton6880@gmail.couk', 27600);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('108-7510 Non, Rd.', '537715789 ', 'Whitney Atkinson', 'whitneyatkinson@google.couk', 18401);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #572-4245 Ut Rd.', '564037863 ', 'Imelda Harrington', 'imeldaharrington4459@gmail.com', 53805);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #214-699 Eros. Rd.', '506917833 ', 'Jasper Mercado', 'jaspermercado2111@google.edu', 43573);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('752-1645 Proin St.', '563111331 ', 'Xavier Murphy', 'xaviermurphy@yahoo.com', 68429);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('820-8046 Ligula. Street', '586147840 ', 'Ayanna Underwood', 'ayannaunderwood9150@google.edu', 40492);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #973-6569 Aenean Rd.', '513540692 ', 'Quail Hester', 'quailhester@icloud.edu', 40041);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9808 Auctor St.', '556167576 ', 'Jessica Thornton', 'jessicathornton@icloud.org', 20672);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #788-7084 Mollis St.', '514975733 ', 'Gavin Walker', 'gavinwalker@google.net', 77008);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 712, 8640 Odio. Rd.', '530216427 ', 'Ava Nolan', 'avanolan@gmail.org', 22376);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('560-8645 Risus. Av.', '536481753 ', 'Kato Merrill', 'katomerrill8189@aol.couk', 67810);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('732-9174 Sed Rd.', '574827138 ', 'Gregory Welch', 'gregorywelch1282@google.couk', 27715);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #169-5910 Tincidunt Av.', '518248266 ', 'Heidi Rogers', 'heidirogers@gmail.net', 53235);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8432 Pede. Rd.', '594678748 ', 'Keelie Shannon', 'keelieshannon@aol.net', 89350);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #509-7935 Tempus Ave', '545145090 ', 'Kaye Stephenson', 'kayestephenson@google.com', 44433);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('850-1622 Pretium Road', '538844066 ', 'Imani Cantu', 'imanicantu@gmail.couk', 72479);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 355, 4457 Ut Rd.', '590725614 ', 'Len Harmon', 'lenharmon7633@google.couk', 40849);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9170 Elit Rd.', '571814691 ', 'Randall Reeves', 'randallreeves8335@gmail.com', 30063);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5909 Cras Avenue', '568485264 ', 'Jerome Walters', 'jeromewalters8398@icloud.com', 98364);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 437, 6016 Dolor. Rd.', '558569531 ', 'Sydnee Mclaughlin', 'sydneemclaughlin3424@gmail.com', 61435);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #339-3448 Mollis Street', '568966378 ', 'Valentine Forbes', 'valentineforbes2516@yahoo.ca', 63036);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('489-892 Id Rd.', '506169440 ', 'Lisandra Carson', 'lisandracarson@icloud.org', 12474);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246-4726 Tellus. Av.', '577187944 ', 'Florence Herrera', 'florenceherrera1097@google.edu', 44023);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('329-5721 Orci, Rd.', '511121883 ', 'Zephania Golden', 'zephaniagolden@aol.net', 91539);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7883 Condimentum. Rd.', '511177873 ', 'Abdul Erickson', 'abdulerickson7535@icloud.org', 60334);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #671-4417 Facilisi. Rd.', '524139451 ', 'Gannon Hudson', 'gannonhudson@yahoo.couk', 25253);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 337, 4911 Laoreet Rd.', '586035372 ', 'Echo Ashley', 'echoashley@google.com', 97879);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('538-8525 Elementum Street', '584845961 ', 'Elmo Richmond', 'elmorichmond92@aol.ca', 10770);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #241-1911 Facilisis Av.', '568971842 ', 'Nichole Hurst', 'nicholehurst3419@gmail.org', 44105);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('662-3825 Lorem St.', '526148534 ', 'Elaine Larson', 'elainelarson@icloud.couk', 75431);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('673-7508 Vivamus Rd.', '520253330 ', 'Devin Briggs', 'devinbriggs4745@gmail.com', 34002);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('447-2896 Neque Av.', '560813114 ', 'Bell Mckay', 'bellmckay@google.couk', 28310);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('926-7645 Velit. Rd.', '572252698 ', 'Liberty Daugherty', 'libertydaugherty5880@yahoo.com', 30893);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 390, 2107 Enim Avenue', '573568453 ', 'Gareth Espinoza', 'garethespinoza7921@icloud.com', 36012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('109-4906 Amet, Av.', '578145026 ', 'Bevis Mccormick', 'bevismccormick7662@icloud.com', 92442);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('262-5272 Egestas Road', '504178564 ', 'Murphy Jimenez', 'murphyjimenez@icloud.org', 96456);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('556-4976 A, Rd.', '543378125 ', 'Nayda Olson', 'naydaolson7006@gmail.ca', 12979);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789-1741 Sagittis Rd.', '522758463 ', 'Mia Lindsey', 'mialindsey@google.edu', 66715);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3001 Sit Avenue', '523982489 ', 'Caleb Battle', 'calebbattle@gmail.ca', 29127);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #753-1712 Amet Avenue', '597366970 ', 'Dennis Walton', 'denniswalton@gmail.ca', 67343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #634-6226 Nec, Ave', '515070766 ', 'Ferris Hodges', 'ferrishodges1682@yahoo.net', 90477);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 165, 8628 Quis Av.', '589553513 ', 'Wing Ford', 'wingford@icloud.org', 15536);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #664-419 Eu Road', '531261261 ', 'Angelica Cotton', 'angelicacotton@gmail.com', 73586);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('150-9963 Cras Ave', '515535173 ', 'Xena Bennett', 'xenabennett@aol.ca', 48212);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #709-2871 Sodales Rd.', '571174738 ', 'James Bailey', 'jamesbailey@yahoo.net', 79819);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('2225 Dolor Street', '575352376 ', 'Hector Melton', 'hectormelton@gmail.org', 78125);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('728-5482 Dolor. Road', '511784241 ', 'Todd Bentley', 'toddbentley8304@gmail.couk', 21570);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #381-170 Nisi. St.', '568018728 ', 'Grant Montgomery', 'grantmontgomery@yahoo.ca', 74606);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #615-7538 Dolor St.', '563242550 ', 'Jocelyn Beasley', 'jocelynbeasley@google.edu', 96750);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('299-7059 Cras Avenue', '523058955 ', 'Keiko Hale', 'keikohale@aol.ca', 32397);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #224-9961 Odio Ave', '514728513 ', 'Rashad Elliott', 'rashadelliott@aol.net', 56697);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 285, 1153 Habitant Street', '511632402 ', 'Miriam Brennan', 'miriambrennan8719@aol.couk', 23821);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #245-8882 Nec Rd.', '530082758 ', 'Martha Wilder', 'marthawilder6889@gmail.net', 26912);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('362-2266 Aliquam Avenue', '560694231 ', 'Emerald Sullivan', 'emeraldsullivan@google.org', 79051);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #914-6465 Non St.', '575503317 ', 'Jada Hatfield', 'jadahatfield@icloud.com', 79374);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6678 Mollis Ave', '545544543 ', 'Irene Rollins', 'irenerollins370@yahoo.net', 48563);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('149-7964 Etiam Avenue', '551433257 ', 'Amaya Mcdaniel', 'amayamcdaniel6249@gmail.net', 99475);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('168-5558 Proin Rd.', '597174527 ', 'Hanna Whitfield', 'hannawhitfield@google.edu', 39663);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 833, 3521 Diam Rd.', '540281202 ', 'Jacqueline Keller', 'jacquelinekeller8356@aol.edu', 26241);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6124 Nunc Rd.', '545950178 ', 'Kasper Mercer', 'kaspermercer@icloud.org', 13227);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #703-6220 Quisque Ave', '504716532 ', 'Flavia Briggs', 'flaviabriggs@google.net', 35451);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('126-5444 Amet Road', '531523808 ', 'Shaeleigh Knight', 'shaeleighknight8537@google.edu', 68627);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('959-7292 Duis Rd.', '563702224 ', 'Isaac Chavez', 'isaacchavez@icloud.org', 24963);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #993-5160 Dui St.', '573687099 ', 'Henry Ochoa', 'henryochoa@google.ca', 45223);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('654-8068 Orci Street', '552158310 ', 'Aimee Schultz', 'aimeeschultz@yahoo.org', 49969);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('111-7283 Pede Avenue', '532535481 ', 'Megan Holt', 'meganholt@aol.com', 17989);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #407-9135 Viverra. St.', '533328760 ', 'Freya Colon', 'freyacolon5598@yahoo.ca', 52410);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #429-5258 Aliquam Rd.', '524152664 ', 'Marsden Branch', 'marsdenbranch26@icloud.com', 51383);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #700-8766 Odio St.', '555711127 ', 'Keegan Ramirez', 'keeganramirez@aol.couk', 26895);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #270-7822 Suspendisse St.', '518674728 ', 'Damian Holloway', 'damianholloway9510@icloud.org', 27379);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1483 Nisi. Rd.', '514431199 ', 'Honorato Lara', 'honoratolara@icloud.ca', 45674);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 418, 1128 Orci, Street', '514802815 ', 'Wallace Woodward', 'wallacewoodward9518@gmail.ca', 72375);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('12 bu Tel Aviv', '035798612 ', 'Mono OR', 'mono@gmail.com', 10000);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('123 Main St', '123456789 ', 'John Doe', 'john@email.com', 10001);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('456 Oak Ave', '987654321 ', 'Jane Smith', 'jane@email.com', 10002);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789 Elm St', '456789012 ', 'Michael Johnson', 'michael@email.com', 10003);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('321 Pine Rd', '789012345 ', 'Emily Davis', 'emily@email.com', 10004);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('654 Maple Ln', '345678901 ', 'David Wilson', 'david@email.com', 10005);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('987 Cedar Blvd', '678901234 ', 'Sarah Thompson', 'sarah@email.com', 10006);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246 Oak Ct', '901234567 ', 'Robert Anderson', 'robert@email.com', 10007);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('579 Elm Way', '234567890 ', 'Jessica Taylor', 'jessica@email.com', 10008);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('813 Pine Ave', '567890123 ', 'Chris Brown', 'chris@email.com', 10009);
commit;
prompt 400 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('159 Maple St', '890123456 ', 'Amanda Garcia', 'amanda@email.com', 10010);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('101 Birch St', '234123456 ', 'Oliver Martin', 'oliver@email.com', 10011);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('202 Spruce Ln', '567234567 ', 'Sophia Lee', 'sophia@email.com', 10012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('303 Cherry Ave', '890345678 ', 'Liam Martinez', 'liam@email.com', 10013);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('404 Willow Rd', '123456789 ', 'Mia Rodriguez', 'mia@email.com', 10014);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('505 Poplar St', '234567890 ', 'Noah Davis', 'noah@email.com', 10015);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('606 Aspen Ct', '345678901 ', 'Isabella Lewis', 'isabella@email.com', 10016);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('707 Beech Blvd', '456789012 ', 'James White', 'james@email.com', 10017);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('88 Magnolia Way', '567890123 ', 'Charl Walker', 'charlotte@email.com', 10018);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('909 Oak Dr', '678901234 ', 'Ben Hall', 'benjamin@email.com', 10019);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('100 Redwood Ave', '789012345 ', 'Amelia Young', 'amelia@email.com', 10020);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('196-696 Tincidunt Av.', '576802140 ', 'Shaine Sosa', 'shainesosa8233@gmail.couk', 71870);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #517-3634 Sed Street', '576163875 ', 'Kirsten Foreman', 'kirstenforeman55@google.org', 53162);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #105-1406 Lorem Av.', '577647211 ', 'Hillary Garrett', 'hillarygarrett@yahoo.org', 19365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 103, 7570 Vestibulum St.', '535653718 ', 'Susan Lester', 'susanlester3407@google.com', 69468);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 128, 3885 Vitae St.', '512974695 ', 'Brianna Holcomb', 'briannaholcomb5084@icloud.ca', 94853);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5640 Justo St.', '533026653 ', 'Imani Clayton', 'imaniclayton@icloud.com', 31979);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('235-3854 Ipsum St.', '554287212 ', 'Colleen Nichols', 'colleennichols3441@gmail.couk', 49506);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('764-1812 Velit. Street', '596111846 ', 'Constance Francis', 'constancefrancis@yahoo.net', 51524);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Neneh Price', null, 1);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Treat Dorff', null, 2);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Henry Rosas', null, 4);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Beverley Goldwyn', null, 5);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ernie Makeba', null, 6);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gilberto Satriani', null, 7);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jeffrey Albright', null, 8);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emm Craven', null, 9);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hex Folds', null, 10);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nigel Wincott', null, 12);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Taye Parm', null, 13);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chuck McKean', null, 14);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Clarence Dickinson', null, 15);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tara Harmon', null, 16);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Philip Ruffalo', null, 17);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Shirley Gough', null, 18);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nathan Prinze', null, 19);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Colin O''Neal', null, 21);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Pierce Butler', null, 22);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Isaiah Cobbs', null, 23);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jose Berenger', null, 24);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emerson Trejo', null, 25);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Coley Sawa', null, 26);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ashton Dafoe', null, 28);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Roddy Gordon', null, 29);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Vin Navarro', null, 30);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Paul Garfunkel', null, 31);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Debra Rodriguez', null, 32);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Andrea Hawn', null, 33);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chuck Mueller-Stahl', null, 35);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Christine Orbit', null, 36);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ellen Vanian', null, 37);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Julianna O''Neal', null, 38);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cameron Griffin', null, 39);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rita Lynne', null, 40);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hal Stevens', null, 41);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rhys Hershey', null, 42);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Adrien Navarro', null, 44);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sammy Cantrell', null, 45);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joseph Mattea', null, 46);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tilda Cohn', null, 47);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bridgette O''Donnell', null, 48);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Alan Dunst', null, 49);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Anthony Benet', null, 50);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kate Paymer', null, 51);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Phoebe Oates', null, 53);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'David McAnally', null, 54);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Daryle Hanley', null, 55);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Wade McDowell', null, 56);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dionne Daniels', null, 57);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jessica Wood', null, 58);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Austin Leachman', null, 59);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hex Paymer', null, 61);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Russell Oakenfold', null, 62);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rueben Sanchez', null, 63);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Steven Vassar', null, 64);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bryan Lemmon', null, 65);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emilio Tillis', null, 66);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Meg Diddley', null, 68);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jonatha Diaz', null, 69);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Wang Kurtz', null, 70);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Miguel Shand', null, 71);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Maura Gold', null, 72);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lila Lewis', null, 73);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dean Cozier', null, 74);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Frankie Thorton', null, 76);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dylan Negbaur', null, 77);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kathleen Hershey', null, 78);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rachael Thurman', null, 79);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Adina Lauper', null, 80);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nik Nakai', null, 81);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Wallace Sobieski', null, 82);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Doug Crouse', null, 84);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ossie Wen', null, 85);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chet Finn', null, 86);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mae Watley', null, 87);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Judi Yorn', null, 88);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tori Postlethwaite', null, 89);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Aida Holmes', null, 90);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gates Berkeley', null, 91);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Pete Kahn', null, 93);
commit;
prompt 500 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Eliza McLachlan', null, 94);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Delbert Scott', null, 95);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tzi Ferrell', null, 96);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chantֳƒֲ© Lloyd', null, 97);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Connie Vannelli', null, 98);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lindsey Heche', null, 99);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Eric Adler', null, 101);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joan Conley', null, 102);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Janeane Orton', null, 103);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Geena Pierce', null, 104);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Terence Clarkson', null, 105);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kirsten Sizemore', null, 106);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chubby Moore', null, 107);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Loretta Lewis', null, 109);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ed Fehr', null, 110);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tracy Lang', null, 111);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Freda Doucette', null, 112);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nick Kilmer', null, 113);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rolando Webb', null, 114);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Remy Heche', null, 115);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gordon Hunt', null, 117);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tamala MacDonald', null, 118);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Minnie Law', null, 119);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Andrew Palminteri', null, 120);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Albertina Makeba', null, 121);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Giancarlo Hawkins', null, 122);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Frederic Silverman', null, 123);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Catherine Jeter', null, 124);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Teri Santa Rosa', null, 126);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rory Margolyes', null, 127);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Phil Garofalo', null, 128);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marina Cervine', null, 129);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Liev Kudrow', null, 130);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Boyd Underwood', null, 131);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Stevie Pierce', null, 132);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mae Cross', null, 133);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Shannyn Burstyn', null, 134);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lauren Cartlidge', null, 136);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Neve Balaban', null, 137);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rosanna Rodgers', null, 138);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Andrae Willis', null, 139);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jeffrey Preston', null, 140);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kevn Fiennes', null, 141);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Alana Penders', null, 142);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Wes Duchovny', null, 143);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bill McGinley', null, 145);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Whoopi Stevenson', null, 146);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Scarlett Berry', null, 147);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Peter Tomei', null, 148);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Charlie Clayton', null, 149);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Allan Shepard', null, 150);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Pat Thurman', null, 151);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hikaru Burmester', null, 153);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cloris Jeter', null, 154);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Edward Kattan', null, 155);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Geggy Margulies', null, 156);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gina Davidson', null, 157);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mia Sharp', null, 158);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Powers King', null, 159);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Diamond Everett', null, 161);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jill Coughlan', null, 162);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cathy Birch', null, 163);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Taylor Singh', null, 164);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lennie Bates', null, 165);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ike Vaughan', null, 166);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Neve Rankin', null, 167);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Collective Horton', null, 168);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jim Orton', null, 169);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joan O''Hara', null, 170);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Natacha Spears', null, 171);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Xander Rock', null, 173);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Edgar Fiorentino', null, 174);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Miles Rauhofer', null, 175);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emm Brody', null, 176);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Crispin Berkley', null, 177);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cheryl Fox', null, 178);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nelly Flanagan', null, 179);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'David Paquin', null, 180);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Giovanni Trejo', null, 182);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Herbie Dreyfuss', null, 183);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lynn Ripley', null, 184);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dave Aiken', null, 185);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Katrin Head', null, 186);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Miles Sossamon', null, 187);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joey Rubinek', null, 189);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marc Leachman', null, 190);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jean Dean', null, 191);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Clive Luongo', null, 192);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Woody Cochran', null, 193);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Catherine Summer', null, 194);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Aidan Fichtner', null, 195);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Keith Azaria', null, 197);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kirsten Logue', null, 198);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Harrison Cromwell', null, 199);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Howard McLean', null, 200);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Vanessa Sawa', null, 201);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Andrae Hornsby', null, 202);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Drew Evanswood', null, 203);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Danni Whitmore', null, 205);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Red Boone', null, 206);
commit;
prompt 600 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Winona Redgrave', null, 207);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marlon Cara', null, 208);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Melanie Curry', null, 209);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Devon Epps', null, 210);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Denzel Pigott-Smith', null, 211);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lin Klein', null, 212);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Trick Sedaka', null, 214);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jill Visnjic', null, 215);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Terrence Dean', null, 216);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tanya Carradine', null, 217);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lauren Easton', null, 218);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nicholas Borden', null, 220);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Carrie-Anne Vince', null, 221);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Colin Utada', null, 222);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Judge Reeves', null, 223);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Pamela Thorton', null, 224);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bradley Daniels', null, 225);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dorry Furay', null, 227);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Darren Heron', null, 228);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Brooke Stone', null, 229);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Timothy Bean', null, 230);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lynette Lawrence', null, 231);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lois Warden', null, 232);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rebeka Harris', null, 236);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Luis Cooper', null, 237);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lily Davis', null, 238);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Diane Gandolfini', null, 239);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Oro Vannelli', null, 240);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Irene Adkins', null, 242);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Melba Bright', null, 243);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Coley Conroy', null, 244);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Drew Paige', null, 245);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Celia Sandoval', null, 246);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Al Mantegna', null, 247);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Spike Bridges', null, 248);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cameron Mirren', null, 249);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Woody Ramirez', null, 251);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Willem Burrows', null, 252);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Isaiah Briscoe', null, 253);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Aidan Hershey', null, 254);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rod David', null, 255);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Stellan Finn', null, 256);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Albertina Cazale', null, 257);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gaby Wainwright', null, 258);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dennis McCoy', null, 260);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Daryl MacDonald', null, 261);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Leon Strathairn', null, 262);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bernie Himmelman', null, 263);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Holland Zane', null, 264);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mae Stiers', null, 265);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Murray Leary', null, 266);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Burt Baranski', null, 268);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sammy Wariner', null, 269);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Suzanne Coolidge', null, 270);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Todd Sainte-Marie', null, 271);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Liev Burns', null, 272);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Benicio Weisberg', null, 274);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gilberto Mandrell', null, 275);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nils Kane', null, 277);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hope Young', null, 279);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rachel Andrews', null, 280);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Quentin Slater', null, 281);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Trace DiBiasio', null, 282);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Katrin Koteas', null, 284);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marlon Turner', null, 285);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lena Bergen', null, 287);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joseph Stowe', null, 289);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mika Ellis', null, 290);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gary Sirtis', null, 291);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Vickie Emmett', null, 293);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marianne Nicholas', null, 294);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rade Thomson', null, 295);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lindsay Margulies', null, 297);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ernest Sorvino', null, 299);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Taryn Belushi', null, 301);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Edgar Olin', null, 302);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rosie Payne', null, 303);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Glenn Lapointe', null, 304);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tamala Sweet', null, 306);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Alec Iglesias', null, 307);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Teri Atlas', null, 308);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Collin Gold', null, 311);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Boyd Ticotin', null, 312);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Woody Jackman', null, 313);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Adam Palminteri', null, 314);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jeffery Navarro', null, 316);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gary Frost', null, 317);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Linda Gough', null, 320);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jimmie Mohr', null, 321);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joely LuPone', null, 322);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kate Adams', null, 323);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Larnelle Downey', null, 326);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sigourney Dalton', null, 327);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Patty Makowicz', null, 328);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tim Farris', null, 329);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Manu Haysbert', null, 330);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Marisa Pitney', null, 331);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lloyd Lithgow', null, 332);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Victoria MacDowell', null, 333);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jennifer Mitra', null, 334);
commit;
prompt 700 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Udo Shatner', null, 335);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Laurie Cronin', null, 336);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'James Nash', null, 337);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ronnie Rispoli', null, 338);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lois Forrest', null, 339);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Amy Conlee', null, 340);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Taye Conley', null, 341);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emma Moriarty', null, 342);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Dean Zappacosta', null, 343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Melanie Tobolowsky', null, 344);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Demi Fiennes', null, 345);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Courtney Purefoy', null, 346);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Talvin Belle', null, 347);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Daryl Duncan', null, 348);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Gilberto Keith', null, 349);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Barbara DeLuise', null, 350);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Campbell Sobieski', null, 351);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Angie Crimson', null, 352);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Christian Sedgwick', null, 353);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Elvis Snider', null, 354);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Philip Ferry', null, 355);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joseph Judd', null, 356);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chaka Blige', null, 357);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ann Sizemore', null, 358);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sander Snipes', null, 359);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Rupert Harrison', null, 360);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nicole Belushi', null, 361);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Oliver Brooks', null, 362);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Christmas Wiedlin', null, 363);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lizzy Posener', null, 364);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Joaquim Pitney', null, 365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jean-Luc Dillon', null, 366);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lily Dorff', null, 367);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sigourney Lynn', null, 368);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Debbie Paquin', null, 369);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Wayman Shorter', null, 370);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Davis Arjona', null, 371);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Hazel Davidtz', null, 372);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sydney Malkovich', null, 373);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bret McBride', null, 374);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Linda MacNeil', null, 375);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jena Idle', null, 376);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Carlos Lynn', null, 377);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Aaron Payton', null, 378);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Daryle Shue', null, 379);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kelli Farrell', null, 380);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Patricia Roberts', null, 381);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Derrick Deejay', null, 382);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jonny Lee Teng', null, 383);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Vendetta Janssen', null, 384);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Beverley Clayton', null, 385);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Suzi Mac', null, 386);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sophie Patton', null, 387);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Brian Gough', null, 388);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bo Singletary', null, 389);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Azucar Ryder', null, 390);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Illeana Lovitz', null, 391);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Miguel Lloyd', null, 392);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cornell Candy', null, 393);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mickey Johansson', null, 394);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Laurence Collins', null, 395);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jake Stuermer', null, 396);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bette Biehn', null, 397);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kathy Affleck', null, 398);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Curtis Elizabeth', null, 399);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Emilio Carrere', null, 400);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chrissie Bale', null, 273);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kathleen Hall', null, 278);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Cherry Emmett', null, 283);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'David Keen', null, 288);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jack Walken', null, 292);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Oro Lillard', null, 296);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Buddy DeVito', null, 300);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mos Milsap', null, 305);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lydia Richardson', null, 309);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Daryl Osmond', null, 315);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Bryan Westerberg', null, 319);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tommy Portman', null, 3);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Woody Doucette', null, 11);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Carol Green', null, 20);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kitty Ripley', null, 27);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Annette Barnett', null, 34);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Mekhi O''Connor', null, 43);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Parker Ripley', null, 52);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Robby Gayle', null, 60);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Kurt Faithfull', null, 67);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Diane Arthur', null, 75);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Robert Whitford', null, 83);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Tori Iglesias', null, 92);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lauren Dourif', null, 100);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Nancy Matthau', null, 108);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Armand Lucien', null, 116);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Victoria Borgnine', null, 125);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Campbell Ness', null, 135);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Adrien Laurie', null, 144);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Suzy Fiennes', null, 152);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Stanley Rhys-Davies', null, 160);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Carol O''Connor', null, 172);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Sara Larter', null, 181);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Night Dafoe', null, 188);
commit;
prompt 800 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Brian Chilton', null, 196);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Lee von Sydow', null, 204);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Jon Bell', null, 213);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Diane Chan', null, 219);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Chris Paquin', null, 226);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ike DeLuise', null, 234);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Edgar McGoohan', null, 241);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Reese Guinness', null, 250);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Molly Brooks', null, 259);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Ronny Cassel', null, 267);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Moe Tinsley', null, 276);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Victor Lindley', null, 286);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'David Underwood', null, 298);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Seth Ford', null, 310);
insert into STAFF (saddress, smobile, sname, smail, sid)
values (null, null, 'Collective Buffalo', null, 318);
commit;
prompt 815 records loaded
prompt Loading DOCTOR...
insert into DOCTOR (license, specialties, sid)
values ('P088902', 'Cosmetic', 27192);
insert into DOCTOR (license, specialties, sid)
values ('R697730', 'Orthodontist''', 89350);
insert into DOCTOR (license, specialties, sid)
values ('W473497', 'Dentist', 68549);
insert into DOCTOR (license, specialties, sid)
values ('N608308', 'Dentist', 27715);
insert into DOCTOR (license, specialties, sid)
values ('N656165', 'Cosmetic', 11630);
insert into DOCTOR (license, specialties, sid)
values ('B766493', 'Orthodontist''', 49666);
insert into DOCTOR (license, specialties, sid)
values ('U508205', 'Cosmetic', 61546);
insert into DOCTOR (license, specialties, sid)
values ('I003396', 'Orthodontist''', 98364);
insert into DOCTOR (license, specialties, sid)
values ('M292821', 'Orthodontist''', 96750);
insert into DOCTOR (license, specialties, sid)
values ('I826892', 'Cosmetic', 34609);
insert into DOCTOR (license, specialties, sid)
values ('R548123', 'Orthodontist''', 37345);
insert into DOCTOR (license, specialties, sid)
values ('R386487', 'Orthodontist''', 92442);
insert into DOCTOR (license, specialties, sid)
values ('I665838', 'Cosmetic', 21996);
insert into DOCTOR (license, specialties, sid)
values ('Y223483', 'Orthodontist''', 10013);
insert into DOCTOR (license, specialties, sid)
values ('G593751', 'Cosmetic', 55269);
insert into DOCTOR (license, specialties, sid)
values ('M562872', 'Orthodontist''', 39663);
insert into DOCTOR (license, specialties, sid)
values ('V105043', 'Cosmetic', 38296);
insert into DOCTOR (license, specialties, sid)
values ('A478640', 'Dentist', 31151);
insert into DOCTOR (license, specialties, sid)
values ('P544230', 'Dentist', 18525);
insert into DOCTOR (license, specialties, sid)
values ('I104058', 'Dentist', 26135);
insert into DOCTOR (license, specialties, sid)
values ('D943728', 'Dentist', 63761);
insert into DOCTOR (license, specialties, sid)
values ('J269639', 'Orthodontist''', 35535);
insert into DOCTOR (license, specialties, sid)
values ('N935982', 'Dentist', 55546);
insert into DOCTOR (license, specialties, sid)
values ('A562040', 'Cosmetic', 80830);
insert into DOCTOR (license, specialties, sid)
values ('G366036', 'Cosmetic', 10014);
insert into DOCTOR (license, specialties, sid)
values ('H704207', 'Cosmetic', 43915);
insert into DOCTOR (license, specialties, sid)
values ('I715511', 'Dentist', 61696);
insert into DOCTOR (license, specialties, sid)
values ('Q068252', 'Orthodontist''', 13227);
insert into DOCTOR (license, specialties, sid)
values ('P311351', 'Orthodontist''', 37415);
insert into DOCTOR (license, specialties, sid)
values ('G702062', 'Dentist', 54635);
insert into DOCTOR (license, specialties, sid)
values ('T152511', 'Dentist', 43702);
insert into DOCTOR (license, specialties, sid)
values ('L216854', 'Cosmetic', 18401);
insert into DOCTOR (license, specialties, sid)
values ('J012983', 'Dentist', 44135);
insert into DOCTOR (license, specialties, sid)
values ('X377564', 'Orthodontist''', 15357);
insert into DOCTOR (license, specialties, sid)
values ('I877544', 'Cosmetic', 57569);
insert into DOCTOR (license, specialties, sid)
values ('S363634', 'Cosmetic', 49355);
insert into DOCTOR (license, specialties, sid)
values ('C707042', 'Cosmetic', 68229);
insert into DOCTOR (license, specialties, sid)
values ('N826726', 'Orthodontist''', 28053);
insert into DOCTOR (license, specialties, sid)
values ('D643611', 'Cosmetic', 89219);
insert into DOCTOR (license, specialties, sid)
values ('M859272', 'Orthodontist''', 47507);
insert into DOCTOR (license, specialties, sid)
values ('Z477842', 'Cosmetic', 17595);
insert into DOCTOR (license, specialties, sid)
values ('W262666', 'Cosmetic', 45148);
insert into DOCTOR (license, specialties, sid)
values ('T599229', 'Orthodontist''', 38187);
insert into DOCTOR (license, specialties, sid)
values ('T364122', 'Cosmetic', 91368);
insert into DOCTOR (license, specialties, sid)
values ('V082932', 'Cosmetic', 27379);
insert into DOCTOR (license, specialties, sid)
values ('K415785', 'Dentist', 88571);
insert into DOCTOR (license, specialties, sid)
values ('O149663', 'Orthodontist''', 15383);
insert into DOCTOR (license, specialties, sid)
values ('W784098', 'Cosmetic', 35130);
insert into DOCTOR (license, specialties, sid)
values ('E033901', 'Dentist', 99681);
insert into DOCTOR (license, specialties, sid)
values ('F557731', 'Cosmetic', 15343);
insert into DOCTOR (license, specialties, sid)
values ('W057505', 'Dentist', 19365);
insert into DOCTOR (license, specialties, sid)
values ('J329052', 'Orthodontist''', 82443);
insert into DOCTOR (license, specialties, sid)
values ('P738107', 'Orthodontist''', 55149);
insert into DOCTOR (license, specialties, sid)
values ('O296894', 'Dentist', 89337);
insert into DOCTOR (license, specialties, sid)
values ('D379867', 'Dentist', 64760);
insert into DOCTOR (license, specialties, sid)
values ('D478618', 'Orthodontist''', 24656);
insert into DOCTOR (license, specialties, sid)
values ('A797001', 'Orthodontist''', 50112);
insert into DOCTOR (license, specialties, sid)
values ('O802501', 'Orthodontist''', 79859);
insert into DOCTOR (license, specialties, sid)
values ('J966809', 'Cosmetic', 81894);
insert into DOCTOR (license, specialties, sid)
values ('B927814', 'Orthodontist''', 72820);
insert into DOCTOR (license, specialties, sid)
values ('W981873', 'Cosmetic', 10016);
insert into DOCTOR (license, specialties, sid)
values ('W122816', 'Orthodontist''', 64076);
insert into DOCTOR (license, specialties, sid)
values ('U041747', 'Cosmetic', 10011);
insert into DOCTOR (license, specialties, sid)
values ('L642104', 'Orthodontist''', 10652);
insert into DOCTOR (license, specialties, sid)
values ('N133159', 'Dentist', 12082);
insert into DOCTOR (license, specialties, sid)
values ('M508774', 'Cosmetic', 63961);
insert into DOCTOR (license, specialties, sid)
values ('V995822', 'Orthodontist''', 21570);
insert into DOCTOR (license, specialties, sid)
values ('U416915', 'Orthodontist''', 39306);
insert into DOCTOR (license, specialties, sid)
values ('C347945', 'Dentist', 31947);
insert into DOCTOR (license, specialties, sid)
values ('R864927', 'Orthodontist''', 10017);
insert into DOCTOR (license, specialties, sid)
values ('L461765', 'Orthodontist''', 29561);
insert into DOCTOR (license, specialties, sid)
values ('D757117', 'Dentist', 43931);
insert into DOCTOR (license, specialties, sid)
values ('R217729', 'Orthodontist''', 41224);
insert into DOCTOR (license, specialties, sid)
values ('E209644', 'Dentist', 62435);
insert into DOCTOR (license, specialties, sid)
values ('O066493', 'Dentist', 81284);
insert into DOCTOR (license, specialties, sid)
values ('B032623', 'Orthodontist''', 69221);
insert into DOCTOR (license, specialties, sid)
values ('M565314', 'Dentist', 73373);
insert into DOCTOR (license, specialties, sid)
values ('H212872', 'Dentist', 79819);
insert into DOCTOR (license, specialties, sid)
values ('X325759', 'Dentist', 31696);
insert into DOCTOR (license, specialties, sid)
values ('W791109', 'Orthodontist''', 15746);
insert into DOCTOR (license, specialties, sid)
values ('X491823', 'Dentist', 25922);
insert into DOCTOR (license, specialties, sid)
values ('B835741', 'Orthodontist''', 53998);
insert into DOCTOR (license, specialties, sid)
values ('M272594', 'Orthodontist''', 90668);
insert into DOCTOR (license, specialties, sid)
values ('K485723', 'Orthodontist''', 63036);
insert into DOCTOR (license, specialties, sid)
values ('E679996', 'Dentist', 87909);
insert into DOCTOR (license, specialties, sid)
values ('Q905640', 'Orthodontist''', 91539);
insert into DOCTOR (license, specialties, sid)
values ('Z994120', 'Cosmetic', 57567);
insert into DOCTOR (license, specialties, sid)
values ('O553443', 'Cosmetic', 13794);
insert into DOCTOR (license, specialties, sid)
values ('C052189', 'Orthodontist''', 34941);
insert into DOCTOR (license, specialties, sid)
values ('D227813', 'Orthodontist''', 66193);
insert into DOCTOR (license, specialties, sid)
values ('X525956', 'Cosmetic', 24608);
insert into DOCTOR (license, specialties, sid)
values ('G542657', 'Cosmetic', 52769);
insert into DOCTOR (license, specialties, sid)
values ('H250460', 'Orthodontist''', 19936);
insert into DOCTOR (license, specialties, sid)
values ('X554986', 'Cosmetic', 63284);
insert into DOCTOR (license, specialties, sid)
values ('G119221', 'Orthodontist''', 51672);
insert into DOCTOR (license, specialties, sid)
values ('P768257', 'Dentist', 69296);
insert into DOCTOR (license, specialties, sid)
values ('F113334', 'Orthodontist''', 67810);
insert into DOCTOR (license, specialties, sid)
values ('I221664', 'Cosmetic', 99778);
insert into DOCTOR (license, specialties, sid)
values ('V649726', 'Orthodontist''', 99769);
insert into DOCTOR (license, specialties, sid)
values ('B096930', 'Cosmetic', 20080);
commit;
prompt 100 records committed...
insert into DOCTOR (license, specialties, sid)
values ('I487690', 'Cosmetic', 79374);
insert into DOCTOR (license, specialties, sid)
values ('C535836', 'Orthodontist''', 86483);
insert into DOCTOR (license, specialties, sid)
values ('C758254', 'Orthodontist''', 77008);
insert into DOCTOR (license, specialties, sid)
values ('U588691', 'Orthodontist''', 84940);
insert into DOCTOR (license, specialties, sid)
values ('V315052', 'Cosmetic', 18802);
insert into DOCTOR (license, specialties, sid)
values ('H706091', 'Cosmetic', 74548);
insert into DOCTOR (license, specialties, sid)
values ('T588863', 'Dentist', 46150);
insert into DOCTOR (license, specialties, sid)
values ('W006606', 'Cosmetic', 40041);
insert into DOCTOR (license, specialties, sid)
values ('I792247', 'Dentist', 44156);
insert into DOCTOR (license, specialties, sid)
values ('F170783', 'Dentist', 10012);
insert into DOCTOR (license, specialties, sid)
values ('J088247', 'Dentist', 13261);
insert into DOCTOR (license, specialties, sid)
values ('O224323', 'Dentist', 69880);
insert into DOCTOR (license, specialties, sid)
values ('K392960', 'Dentist', 31845);
insert into DOCTOR (license, specialties, sid)
values ('T117649', 'Orthodontist''', 69468);
insert into DOCTOR (license, specialties, sid)
values ('J670811', 'Cosmetic', 68062);
insert into DOCTOR (license, specialties, sid)
values ('N449816', 'Dentist', 25991);
insert into DOCTOR (license, specialties, sid)
values ('A353940', 'Dentist', 32397);
insert into DOCTOR (license, specialties, sid)
values ('U144582', 'Cosmetic', 76380);
insert into DOCTOR (license, specialties, sid)
values ('F435698', 'Orthodontist''', 28516);
insert into DOCTOR (license, specialties, sid)
values ('B356800', 'Dentist', 50906);
insert into DOCTOR (license, specialties, sid)
values ('G103551', 'Cosmetic', 83782);
insert into DOCTOR (license, specialties, sid)
values ('W294829', 'Orthodontist''', 22236);
insert into DOCTOR (license, specialties, sid)
values ('X854968', 'Cosmetic', 52116);
insert into DOCTOR (license, specialties, sid)
values ('L133155', 'Dentist', 84301);
insert into DOCTOR (license, specialties, sid)
values ('L259846', 'Dentist', 70748);
insert into DOCTOR (license, specialties, sid)
values ('D124076', 'Orthodontist''', 99939);
insert into DOCTOR (license, specialties, sid)
values ('J214892', 'Orthodontist''', 72073);
insert into DOCTOR (license, specialties, sid)
values ('D055815', 'Cosmetic', 74841);
insert into DOCTOR (license, specialties, sid)
values ('D865174', 'Dentist', 91660);
insert into DOCTOR (license, specialties, sid)
values ('T022842', 'Cosmetic', 71959);
insert into DOCTOR (license, specialties, sid)
values ('W006606', 'Dentist', 95541);
insert into DOCTOR (license, specialties, sid)
values ('E401251', 'Orthodontist''', 86842);
insert into DOCTOR (license, specialties, sid)
values ('Z569941', 'Dentist', 96640);
insert into DOCTOR (license, specialties, sid)
values ('P260530', 'Dentist', 32568);
insert into DOCTOR (license, specialties, sid)
values ('Q840576', 'Cosmetic', 90716);
insert into DOCTOR (license, specialties, sid)
values ('C207049', 'Orthodontist''', 48188);
insert into DOCTOR (license, specialties, sid)
values ('N481123', 'Dentist', 74972);
insert into DOCTOR (license, specialties, sid)
values ('Y621780', 'Orthodontist''', 37004);
insert into DOCTOR (license, specialties, sid)
values ('L022602', 'Dentist', 45674);
insert into DOCTOR (license, specialties, sid)
values ('O985935', 'Dentist', 15963);
insert into DOCTOR (license, specialties, sid)
values ('Y119633', 'Dentist', 72479);
insert into DOCTOR (license, specialties, sid)
values ('L1234', 'Orthodontist', 10001);
insert into DOCTOR (license, specialties, sid)
values ('L5678', 'Cosmetic', 10002);
insert into DOCTOR (license, specialties, sid)
values ('L9012', 'Dentist', 10003);
insert into DOCTOR (license, specialties, sid)
values ('L3456', 'Dentist', 10004);
insert into DOCTOR (license, specialties, sid)
values ('L7890', 'Cosmetic', 10005);
insert into DOCTOR (license, specialties, sid)
values ('L2345', 'Dentist', 10006);
insert into DOCTOR (license, specialties, sid)
values ('L6789', 'Dentist', 10007);
insert into DOCTOR (license, specialties, sid)
values ('L0123', 'Orthodontist', 10008);
insert into DOCTOR (license, specialties, sid)
values ('L4567', 'Orthodontist', 10009);
insert into DOCTOR (license, specialties, sid)
values ('L8901', 'Dentist', 10010);
insert into DOCTOR (license, specialties, sid)
values ('N709690', 'Cosmetic', 33532);
insert into DOCTOR (license, specialties, sid)
values ('P790838', 'Orthodontist''', 33794);
insert into DOCTOR (license, specialties, sid)
values ('A853261', 'Orthodontist''', 65613);
insert into DOCTOR (license, specialties, sid)
values ('Y368303', 'Dentist', 51524);
insert into DOCTOR (license, specialties, sid)
values ('V607115', 'Orthodontist''', 95320);
insert into DOCTOR (license, specialties, sid)
values ('R797629', 'Orthodontist''', 25578);
insert into DOCTOR (license, specialties, sid)
values ('W268703', 'Dentist', 56476);
insert into DOCTOR (license, specialties, sid)
values ('M200552', 'Orthodontist''', 61435);
insert into DOCTOR (license, specialties, sid)
values ('V770498', 'Cosmetic', 64185);
insert into DOCTOR (license, specialties, sid)
values ('K750550', 'Orthodontist''', 74091);
insert into DOCTOR (license, specialties, sid)
values ('T346515', 'Orthodontist''', 80248);
insert into DOCTOR (license, specialties, sid)
values ('E998542', 'Cosmetic', 84092);
commit;
prompt 163 records loaded
prompt Loading PATIENT...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1972, '567-8655 Integer Ave', 'Reagan Berry', 'M', 727, 'pede.nec@outlook.edu', 513417574);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2003, '7681 Lorem, Avenue', 'Bradley Baxter', 'F', 764, 'enim.nunc.ut@aol.net', 515263776);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1957, '126-8581 Donec Rd.', 'Rajah Wilder', 'F', 934, 'posuere.at@yahoo.net', 555376138);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1950, 'Ap #936-210 Erat Avenue', 'Dana Wyatt', 'F', 354, 'dis.parturient.montes@aol.ca', 541603349);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1936, '228-2863 Curabitur Rd.', 'Megan Molina', 'F', 717, 'mauris.vel@outlook.net', 572442876);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1952, 'Ap #177-2381 Imperdiet, St.', 'Rooney Jennings', 'F', 350, 'eu.erat@protonmail.ca', 556334347);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1975, 'Ap #625-170 Vivamus Ave', 'Thomas Macias', 'M', 148, 'gravida.aliquam@protonmail.net', 565667249);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1970, '481-6951 Nascetur Ave', 'Adam Bond', 'M', 600, 'donec@outlook.couk', 533935363);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '349-3264 Pede, Avenue', 'Gloria Mckee', 'F', 910, 'massa.mauris.vestibulum@yahoo.couk', 594712703);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1998, 'P.O. Box 567, 6464 Ligula. Rd.', 'Basil Russo', 'F', 989, 'vitae.risus@google.edu', 526357271);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2023, 'Ap #446-6388 Etiam St.', 'Shay Dillon', 'F', 856, 'accumsan@icloud.com', 524682525);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1970, 'Ap #261-7637 Magna Av.', 'Quamar Welch', 'M', 392, 'vestibulum.ut@yahoo.org', 531137654);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, 'Ap #774-3061 Erat. Street', 'Cody Salinas', 'M', 163, 'amet.lorem@yahoo.net', 522779526);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, '505-6353 A Av.', 'Brittany Guerra', 'M', 219, 'magna.tellus@icloud.org', 572180527);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2000, '613-6144 Sollicitudin Avenue', 'Murphy Rodriguez', 'F', 399, 'vulputate.dui@aol.ca', 543917465);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1987, 'P.O. Box 920, 5357 Vel Av.', 'Kyle Hood', 'M', 290, 'magnis.dis@protonmail.ca', 543506775);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1950, 'Ap #496-1940 Nunc Rd.', 'Timon Dickson', 'M', 610, 'donec.luctus@protonmail.org', 581604265);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1984, '526-8631 Tellus. Rd.', 'Galvin Mueller', 'M', 308, 'quam.quis@protonmail.ca', 571592579);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1982, 'P.O. Box 189, 7664 Eget St.', 'Maxine Schmidt', 'M', 433, 'nec.tempus@outlook.edu', 565531776);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, 'P.O. Box 754, 8798 Orci. Avenue', 'Leo Jordan', 'M', 889, 'et.eros.proin@google.couk', 585112072);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'P.O. Box 903, 1703 Lorem Av.', 'Melissa Bennett', 'F', 408, 'et.magnis.dis@google.org', 514454657);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1974, '967-451 Sed, Street', 'Madison Madden', 'F', 676, 'lorem.ut@aol.ca', 571078114);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1951, '826 Euismod Rd.', 'Giselle Jimenez', 'M', 468, 'consectetuer.mauris@outlook.couk', 546537375);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1951, '7838 Nec, St.', 'Charlotte Nguyen', 'M', 736, 'metus@protonmail.com', 524684538);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1935, 'Ap #189-8861 Eget Ave', 'Cecilia Butler', 'F', 538, 'mi.enim@google.edu', 572109396);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2024, 'Ap #292-1074 Tristique Avenue', 'Shad Vance', 'M', 332, 'erat.volutpat@protonmail.org', 577455669);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2021, '244-6311 Semper St.', 'Xavier Bowen', 'F', 832, 'semper.cursus.integer@yahoo.net', 518848475);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1919, 'P.O. Box 512, 3296 Risus Av.', 'Alma Herrera', 'M', 662, 'ullamcorper.nisl@aol.net', 503221446);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, 'Ap #923-8893 Non, St.', 'Shaine Gonzalez', 'M', 657, 'laoreet.lectus@yahoo.edu', 515626843);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1939, '4526 Elit. Road', 'Fredericka Alexander', 'M', 777, 'hendrerit.neque@protonmail.net', 514117865);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, '873-1295 Et Street', 'Rinah Conley', 'M', 634, 'eros.nam@icloud.edu', 528954826);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2001, '4166 Scelerisque Avenue', 'Lamar Conrad', 'F', 672, 'fringilla@yahoo.org', 572746354);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, 'Ap #892-6022 Nisl. St.', 'May Mcleod', 'F', 420, 'eu.odio@aol.edu', 593277604);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, 'P.O. Box 597, 2340 Malesuada St.', 'Josiah Barker', 'F', 758, 'lorem.ipsum@aol.ca', 512575114);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1920, 'Ap #174-6408 Tortor. Ave', 'Irene Rodriguez', 'M', 328, 'nunc.in.at@hotmail.org', 564760474);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, 'Ap #862-6080 Dictum Road', 'Kerry Winters', 'M', 180, 'lorem.ipsum@icloud.ca', 592340126);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, '272-7923 Donec Av.', 'Jack Sanford', 'F', 994, 'ipsum.ac.mi@yahoo.edu', 538883878);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2022, 'Ap #387-1929 Nec Rd.', 'Kelly Parker', 'M', 117, 'senectus.et.netus@hotmail.net', 565457105);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'Ap #820-6929 Ut Av.', 'Kylan Peterson', 'M', 765, 'vivamus.molestie@protonmail.edu', 514709492);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1962, '719-5359 Convallis Ave', 'Erin Foster', 'M', 292, 'in.magna@aol.ca', 588289946);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1979, '708-5898 Nulla Rd.', 'Lynn Sheppard', 'M', 714, 'mauris@icloud.net', 554036557);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1985, '632-9752 Neque. Av.', 'Noelle Joyner', 'M', 274, 'eget.laoreet.posuere@hotmail.net', 597072866);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1941, 'P.O. Box 589, 725 Aenean Street', 'Paula Nash', 'F', 995, 'purus@icloud.org', 511750307);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1960, '982-868 Praesent Rd.', 'Lucius Gross', 'M', 766, 'fringilla.est@aol.org', 579876917);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1978, '952-1922 Nam St.', 'Rowan Pickett', 'M', 250, 'aenean@aol.net', 508722274);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1941, '837-1139 Lorem, Av.', 'Steven Anderson', 'M', 463, 'sit@google.net', 551252921);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1920, '119-565 Nibh St.', 'Cairo Clemons', 'F', 619, 'eu.odio@outlook.edu', 581353284);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1938, '987 Tellus. Rd.', 'Rhona Maxwell', 'M', 559, 'non.hendrerit@outlook.ca', 574848123);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1996, '824-7836 Sodales Av.', 'Evelyn Cervantes', 'F', 236, 'volutpat.nulla@outlook.couk', 583403513);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1995, '660-5198 Vestibulum St.', 'Cora Maddox', 'M', 259, 'sed.leo@outlook.ca', 543449110);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1942, '772-7183 Tempus Rd.', 'Mercedes Larsen', 'M', 962, 'vitae.purus.gravida@hotmail.couk', 530421879);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2003, '1233 Amet, Av.', 'Trevor Zamora', 'M', 800, 'sed.pede.nec@hotmail.org', 532928861);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1950, 'P.O. Box 681, 394 Mauris Av.', 'Calvin Whitehead', 'M', 201, 'leo.morbi@yahoo.edu', 523833797);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2022, '323-9960 Tempus St.', 'Bree Gates', 'F', 195, 'mi@icloud.com', 562490850);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, '2664 Donec St.', 'Donna Shelton', 'M', 129, 'nunc.sed.pede@aol.ca', 572817298);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1974, 'Ap #144-1855 Aliquet, Ave', 'Berk Buckner', 'M', 654, 'ornare@yahoo.net', 546831222);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, 'Ap #912-9015 Nulla Rd.', 'Mark Pate', 'F', 445, 'parturient.montes@aol.ca', 586184648);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, 'Ap #352-7450 Urna, Avenue', 'Bevis Wise', 'F', 839, 'et.libero@outlook.couk', 536227603);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1987, '248-2273 Tincidunt. Road', 'Chase Slater', 'M', 586, 'eu@protonmail.net', 510307871);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, 'P.O. Box 722, 4184 Ligula. St.', 'Nigel Maldonado', 'M', 267, 'scelerisque.sed@aol.net', 521264525);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, 'Ap #904-8376 Nulla St.', 'Travis Bowers', 'F', 199, 'vestibulum.lorem.sit@icloud.couk', 528815203);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2018, 'Ap #826-450 Lectus Road', 'Britanney Lott', 'M', 473, 'ipsum.phasellus@yahoo.ca', 570766632);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1963, '280 Elit Av.', 'Geoffrey Chang', 'M', 409, 'aliquam.nisl.nulla@aol.com', 574680069);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1997, '870-6394 Urna Rd.', 'Macon Russo', 'M', 530, 'non@google.net', 522401933);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, 'Ap #658-4466 Dictum Avenue', 'Hayden Macias', 'M', 701, 'leo.vivamus@icloud.ca', 582455104);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, 'P.O. Box 169, 939 Vitae Street', 'Kasimir Mejia', 'M', 652, 'eu.augue.porttitor@protonmail.net', 556404987);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1942, 'Ap #554-1952 Lacus, Ave', 'Carter Vaughn', 'M', 683, 'vitae.aliquam.eros@yahoo.com', 527446108);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1992, '328-5625 Vel Avenue', 'Ashely Wilcox', 'F', 984, 'eu.placerat.eget@protonmail.couk', 567831993);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1938, '535-9234 Enim Street', 'Audrey Shaw', 'M', 389, 'fringilla@hotmail.couk', 568275139);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, 'Ap #867-1820 Nascetur St.', 'Maris Witt', 'F', 775, 'nisi.nibh@yahoo.net', 591237837);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1995, '960-9821 Leo, Avenue', 'Ivana Bullock', 'F', 914, 'sed@outlook.edu', 567138256);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, '525-1272 Quam St.', 'Herrod Gill', 'F', 307, 'fusce.mi@google.edu', 536423781);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, '615-9113 Suspendisse Rd.', 'Harlan Dawson', 'F', 650, 'commodo.ipsum@yahoo.com', 526183215);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, '2483 Non Avenue', 'Lacota Roberts', 'F', 471, 'laoreet@yahoo.com', 528224623);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1928, 'Ap #187-6985 In, St.', 'Davis Glenn', 'M', 902, 'mauris.ut.quam@outlook.couk', 511168367);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, '888-2958 Nam Ave', 'Beau Ewing', 'M', 303, 'ultrices@protonmail.org', 548488365);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1923, '7121 Ornare. Av.', 'Kirk Maxwell', 'M', 225, 'nec.tempus@google.edu', 598374128);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1956, '401-6211 Sociis Road', 'Rashad Daugherty', 'F', 523, 'magna@icloud.ca', 579304529);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1921, 'Ap #337-3834 Justo Avenue', 'Vladimir Fields', 'M', 434, 'eget@aol.couk', 538171585);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1930, 'Ap #820-4662 Lorem Road', 'Alan Head', 'F', 518, 'aenean@hotmail.ca', 531375882);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, '5691 Neque Road', 'Brady Potts', 'F', 572, 'elit.pellentesque@protonmail.edu', 566222893);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1960, 'P.O. Box 745, 7434 Tincidunt, St.', 'Noble Wright', 'M', 374, 'quisque.libero@yahoo.net', 512147360);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1973, 'Ap #501-9078 Velit. Street', 'Cairo Jackson', 'M', 631, 'consequat.lectus@protonmail.edu', 566617418);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2001, '5611 Pellentesque Ave', 'Erich Pugh', 'M', 769, 'nullam.ut@hotmail.net', 535646221);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1964, 'P.O. Box 236, 3018 Nulla. St.', 'Levi Cohen', 'M', 351, 'aenean.eget@aol.ca', 572828727);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, 'Ap #826-6053 Tellus, Road', 'Nolan England', 'F', 151, 'mollis.duis@google.org', 523397837);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, 'Ap #255-383 Cum Ave', 'Brody Alvarado', 'M', 975, 'est.ac@icloud.org', 546115281);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1974, '6442 Lacus. Av.', 'Daphne Osborne', 'F', 585, 'ipsum.non@yahoo.com', 563583327);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1962, 'Ap #311-5051 Tellus. St.', 'Ezekiel Thomas', 'F', 656, 'metus@yahoo.net', 514597178);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1996, 'Ap #178-585 Quam St.', 'Florence Mcleod', 'M', 776, 'in.scelerisque@google.edu', 557195181);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1969, 'Ap #797-6365 Congue Avenue', 'Pascale Stafford', 'M', 899, 'ligula@icloud.edu', 587868950);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1934, 'P.O. Box 958, 4749 Mollis Road', 'Lisandra Guzman', 'M', 729, 'tempus.non.lacinia@hotmail.couk', 532714125);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, '728-7464 Nam St.', 'Giselle May', 'F', 511, 'gravida@outlook.com', 583795820);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1960, '1021 Conubia Rd.', 'Leilani Mathews', 'M', 170, 'eu@hotmail.couk', 545333791);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1931, '668-2386 Adipiscing St.', 'Laith Todd', 'F', 647, 'suspendisse.dui@outlook.couk', 503322286);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, '488-8967 Elit, Rd.', 'Maia Mcintyre', 'F', 867, 'tincidunt@icloud.edu', 536782405);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1933, 'Ap #245-1577 At Road', 'Levi Jennings', 'F', 140, 'donec@hotmail.ca', 537283414);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, 'P.O. Box 423, 7190 Morbi Ave', 'Risa Wynn', 'F', 804, 'risus.quis@hotmail.com', 575712566);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1970, 'Ap #557-8714 Nec Street', 'Christine Petersen', 'M', 298, 'erat.neque.non@icloud.couk', 514217163);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1972, '347-6464 Fermentum Avenue', 'Oren Navarro', 'F', 590, 'libero.proin@hotmail.net', 573753225);
commit;
prompt 100 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1923, '667-9508 Tristique Rd.', 'Cruz Lowe', 'M', 302, 'justo@aol.org', 584960543);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1953, 'P.O. Box 484, 6173 Nec, Street', 'Gary Black', 'F', 978, 'at@protonmail.org', 574820630);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2000, '538-8634 Nulla Ave', 'Hyatt Cain', 'F', 900, 'dis.parturient@icloud.couk', 512587712);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, '7833 Pede. Road', 'Castor Tyson', 'F', 231, 'nam.porttitor@icloud.edu', 541720336);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, 'P.O. Box 553, 4465 Risus, St.', 'Frances Harper', 'F', 831, 'orci@aol.org', 561218043);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1927, '256-7346 Justo. Street', 'Paki Mayo', 'M', 816, 'et.lacinia@icloud.org', 557772726);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1952, '518-7070 Non, Ave', 'Fay Castro', 'M', 884, 'nunc@hotmail.org', 517303930);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1923, '315-8278 Per St.', 'Stone Le', 'M', 144, 'ornare.tortor@icloud.edu', 511487414);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1932, '6742 Vel, Rd.', 'Armando Alford', 'F', 423, 'in.sodales@google.couk', 597860506);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1952, '3055 Orci. Road', 'Leilani Heath', 'F', 778, 'est@yahoo.com', 529482437);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1929, '203-1408 Nulla. Rd.', 'Sylvester Snow', 'F', 639, 'donec@yahoo.com', 568129712);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, '866-4257 Consectetuer St.', 'Jorden Britt', 'F', 922, 'iaculis.lacus.pede@google.org', 522788654);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1917, 'Ap #557-9780 Et Street', 'Garrison Ware', 'M', 805, 'mattis@protonmail.edu', 574622955);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, 'Ap #348-104 Tempor St.', 'Adara Sampson', 'F', 127, 'eleifend.non@protonmail.edu', 546236268);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2024, '885-6524 Ac, Ave', 'Brenna Sharpe', 'M', 391, 'aliquam.tincidunt@hotmail.org', 558403148);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1926, '449-8685 Et Street', 'Jesse Dominguez', 'F', 387, 'fusce.aliquet@yahoo.ca', 527445043);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1963, '152-502 Ipsum Rd.', 'Alma Welch', 'M', 556, 'elit.curabitur@protonmail.net', 534176481);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, '401-2521 Semper Rd.', 'Ivor Barron', 'M', 327, 'sollicitudin.adipiscing@yahoo.couk', 573557458);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1940, '9914 Tempor Ave', 'April Booth', 'M', 671, 'montes@protonmail.net', 509516731);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, '424-3481 Adipiscing Avenue', 'Oprah Williams', 'F', 100, 'eu.enim@google.com', 543825441);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, '3099 Sed Road', 'Dahlia Buckley', 'F', 501, 'faucibus.morbi@yahoo.ca', 553033828);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2021, 'Ap #938-5556 Ac St.', 'Addison Tran', 'M', 324, 'hymenaeos.mauris@icloud.net', 531821759);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, 'P.O. Box 657, 7513 Duis St.', 'Kieran Montoya', 'M', 686, 'sed.diam@protonmail.edu', 582571346);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, 'P.O. Box 891, 1528 Sed Street', 'Noelani Mcbride', 'M', 747, 'in.ornare@protonmail.ca', 595512563);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1955, 'Ap #209-1973 Natoque Road', 'Aline Ramos', 'M', 709, 'lobortis@google.couk', 510093856);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'P.O. Box 523, 1443 Rutrum, Road', 'Pascale Farley', 'M', 119, 'sapien.cursus@outlook.org', 564741632);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1932, 'Ap #963-5500 Urna, Street', 'Upton Hawkins', 'F', 715, 'eu@outlook.net', 529031517);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1922, '2057 Laoreet Street', 'Uriel Mayer', 'M', 980, 'a.aliquet@google.couk', 534800137);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, 'Ap #825-9686 Fermentum Road', 'Burton Baldwin', 'M', 206, 'ad@hotmail.org', 566837484);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, 'Ap #884-7342 Euismod Road', 'Ivory Peterson', 'F', 562, 'euismod.in@protonmail.edu', 561832664);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1991, 'Ap #344-8279 Elit, St.', 'Abra Franklin', 'M', 286, 'cursus.a@hotmail.org', 522137654);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, '5666 Sed Av.', 'Inez Hughes', 'M', 365, 'posuere.vulputate.lacus@google.ca', 563033647);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1971, 'Ap #480-5460 Curabitur Av.', 'Hedda Schwartz', 'F', 336, 'pede.cum.sociis@hotmail.edu', 541597774);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'Ap #812-5960 Sed St.', 'Nasim Washington', 'F', 310, 'convallis.convallis@icloud.couk', 586167344);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1967, 'P.O. Box 554, 1787 Dolor, Ave', 'Kane Fulton', 'M', 660, 'dolor@yahoo.ca', 512614204);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, '8704 Mattis Rd.', 'Genevieve Hebert', 'M', 755, 'euismod@hotmail.com', 511025768);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1968, 'P.O. Box 843, 4294 Etiam Road', 'Shellie Burke', 'F', 743, 'leo.in@protonmail.org', 526082430);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, 'P.O. Box 406, 4043 At Street', 'Jada Holcomb', 'F', 363, 'maecenas.ornare@protonmail.net', 588595851);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1938, 'P.O. Box 833, 467 Donec St.', 'Ian Ortiz', 'F', 121, 'mollis.integer@google.edu', 586226924);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1934, '6786 Mi, Avenue', 'Angelica Trujillo', 'M', 774, 'nulla.aliquet.proin@aol.ca', 528451591);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '503-703 Enim, Rd.', 'Tanya Bray', 'M', 136, 'libero.nec.ligula@outlook.com', 586848260);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1931, '5365 Vulputate, St.', 'Aladdin Haynes', 'F', 266, 'rutrum@outlook.org', 523582867);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1936, 'P.O. Box 178, 6688 Blandit St.', 'Arden Riley', 'M', 941, 'felis.purus.ac@aol.couk', 577781953);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1966, 'P.O. Box 640, 4984 Vulputate, Street', 'Kane Livingston', 'F', 901, 'sit.amet@outlook.org', 520616463);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, 'Ap #163-5667 Nascetur St.', 'Keefe Sanford', 'F', 513, 'fringilla.est@aol.com', 543771390);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2024, '3911 Vitae Road', 'Isaac Wilkerson', 'F', 230, 'sapien.molestie@hotmail.couk', 542639238);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1935, '541 Non Avenue', 'Bree Ware', 'M', 488, 'cubilia.curae@google.couk', 581403179);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1927, 'Ap #992-8410 Consequat Rd.', 'Alexa Workman', 'F', 668, 'lobortis.mauris@yahoo.couk', 598364753);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1981, '696-2363 At Rd.', 'Acton Phillips', 'M', 149, 'quisque.imperdiet@yahoo.org', 508858245);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1934, 'P.O. Box 104, 8453 Dapibus Rd.', 'Samuel Sampson', 'F', 369, 'odio.semper.cursus@icloud.org', 572861838);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1951, 'Ap #668-3587 Lacus. Rd.', 'Lyle Adams', 'M', 903, 'cras@hotmail.org', 559637780);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1979, '2305 Pellentesque Rd.', 'Brittany Alvarez', 'M', 242, 'nunc@icloud.couk', 557043575);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2000, 'Ap #995-8303 Interdum Avenue', 'Tate Wolfe', 'F', 885, 'felis@hotmail.couk', 587574194);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2000, '152 Diam Avenue', 'Leila Hunter', 'M', 153, 'non.justo@aol.org', 539505318);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1953, '236-8729 A, St.', 'Noble Brewer', 'M', 222, 'placerat.augue.sed@google.ca', 544763631);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1982, '223 Sed Rd.', 'Margaret May', 'F', 269, 'cum.sociis@icloud.com', 583664628);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, '796-5835 Dolor Rd.', 'Timon Osborn', 'F', 708, 'eu.elit@google.edu', 517831723);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1919, '620-1782 Vitae St.', 'Audrey Vega', 'M', 625, 'porttitor.eros@protonmail.ca', 569427425);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, '2857 Eleifend St.', 'Leilani Mcintyre', 'M', 877, 'nulla.tempor@protonmail.edu', 539744738);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, '6992 Ante. St.', 'Denton Burch', 'F', 469, 'aliquam.ultrices@aol.edu', 562627734);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1997, 'P.O. Box 905, 216 Donec Road', 'Inez Foster', 'M', 110, 'neque.pellentesque@icloud.com', 565073633);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1943, 'P.O. Box 724, 8911 Sit Av.', 'Vance Lane', 'M', 437, 'cursus.et.eros@icloud.couk', 586135673);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1948, '491-6805 Sem St.', 'Rashad Duncan', 'F', 726, 'malesuada.vel@protonmail.edu', 587214354);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2002, '719-6551 Aptent St.', 'Alexa Nielsen', 'F', 446, 'a.ultricies.adipiscing@yahoo.org', 534516221);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, '1207 Dui Rd.', 'Brynn Merritt', 'F', 760, 'litora.torquent.per@protonmail.com', 501242711);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1956, '735-4239 Ad Road', 'Aurelia Atkins', 'F', 150, 'urna.nunc@google.couk', 568063641);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1973, '1365 Arcu. Road', 'Conan Spencer', 'F', 135, 'molestie.arcu@outlook.edu', 564733787);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1976, '868-5363 Donec St.', 'Justina Todd', 'F', 220, 'fermentum.fermentum@google.com', 510833836);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1933, 'Ap #846-4907 Non Road', 'Lani Trujillo', 'M', 685, 'penatibus.et.magnis@protonmail.ca', 565641345);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2001, 'Ap #850-1932 Ac St.', 'Evan Osborne', 'F', 444, 'maecenas.iaculis.aliquet@aol.edu', 565732785);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1929, '756-3127 Sed St.', 'Carson Hartman', 'F', 828, 'eros.non.enim@protonmail.org', 555337963);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, '1495 Nisi. Street', 'Craig Kelley', 'M', 599, 'nibh@outlook.edu', 526186837);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1974, '663-3495 Primis Rd.', 'Odessa Mcmahon', 'F', 848, 'non.lorem@protonmail.ca', 539671235);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2019, '779-1233 Sapien St.', 'Ciaran Frost', 'M', 759, 'a@aol.edu', 543198517);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1968, '275-5328 Elit Ave', 'Chancellor Montgomery', 'M', 809, 'nunc.ullamcorper@google.ca', 523478709);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, '552-6760 Nec, St.', 'Reagan Franks', 'F', 618, 'enim.suspendisse@hotmail.com', 595022534);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1976, '161-2363 Phasellus Rd.', 'Camille Hayes', 'M', 651, 'fusce.mi.lorem@google.org', 578285774);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1952, 'Ap #758-9581 Sodales Rd.', 'Thaddeus Everett', 'F', 418, 'viverra.maecenas@google.edu', 522226676);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1994, 'Ap #377-189 Id, Road', 'Brady Duran', 'F', 588, 'ante.ipsum.primis@google.edu', 547952767);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2020, '254-4214 Aenean Ave', 'Demetrius Lott', 'M', 293, 'lectus.sit@hotmail.couk', 573252825);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1943, '344-5668 Arcu. Road', 'Sandra Barrett', 'F', 475, 'a.facilisis@protonmail.net', 510277447);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1923, '398-8859 Pharetra Road', 'Cynthia Howe', 'M', 705, 'nulla.donec@protonmail.couk', 572311852);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, '414 Gravida Rd.', 'Juliet Padilla', 'M', 745, 'facilisis@protonmail.couk', 535934563);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1977, '698-1264 Tempus, Avenue', 'Tyler Madden', 'F', 895, 'lectus.nullam@icloud.com', 574472946);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'Ap #774-8223 Pretium Ave', 'Donna Waters', 'M', 343, 'mattis.cras@google.net', 599349275);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1949, 'Ap #286-9930 Semper, Avenue', 'Jerome Huff', 'F', 803, 'natoque.penatibus@google.com', 526177687);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1930, 'Ap #636-1116 Ac Rd.', 'Basia Reid', 'M', 470, 'mi.tempor@icloud.com', 505532653);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1965, 'Ap #620-625 Lacus. St.', 'Renee Jimenez', 'F', 842, 'imperdiet@google.couk', 583375410);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1999, '801-4125 Elit. St.', 'Benjamin Joyce', 'F', 624, 'magna.lorem.ipsum@hotmail.net', 578562258);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, 'Ap #587-4620 Eget Ave', 'Clare Molina', 'M', 878, 'nec.euismod@protonmail.couk', 591702841);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, 'Ap #703-7034 Eu Ave', 'Micah Koch', 'F', 526, 'cras.eu@outlook.edu', 525405268);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1940, 'Ap #803-5954 Mauris Rd.', 'Miranda Raymond', 'M', 872, 'purus@aol.edu', 518211275);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1968, '4347 Aliquet Av.', 'Demetrius Romero', 'F', 807, 'consectetuer@icloud.org', 573046756);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2023, '9735 Pretium Rd.', 'Germane Floyd', 'F', 208, 'quisque.varius.nam@google.ca', 513968668);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1995, '171 Ut Avenue', 'Basil Weiss', 'F', 855, 'arcu.vestibulum@google.ca', 520233191);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1977, 'P.O. Box 878, 9543 Lectus. Street', 'Yuli Bullock', 'M', 178, 'nulla@icloud.org', 596167859);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1979, 'P.O. Box 328, 4362 Tristique Rd.', 'Barrett Bentley', 'M', 700, 'sem.egestas@yahoo.net', 585468446);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1983, 'P.O. Box 871, 5782 Ornare Road', 'Ross Chapman', 'M', 881, 'rutrum.fusce@icloud.edu', 502284436);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '123-5818 Lacus. Ave', 'Cameron Leblanc', 'M', 338, 'sed.molestie@outlook.couk', 548421496);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1917, '260-8086 Amet Rd.', 'Gregory Odom', 'F', 835, 'euismod.et.commodo@hotmail.org', 509584088);
commit;
prompt 200 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1962, 'Ap #188-9556 Cras Avenue', 'Naomi Paul', 'M', 567, 'mauris.morbi@icloud.net', 507110270);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1923, '929-368 Neque Ave', 'Portia Foster', 'M', 971, 'enim.nisl.elementum@outlook.couk', 562517208);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1998, '2077 Mauris Ave', 'Edan Warren', 'F', 568, 'fames@icloud.org', 535444860);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1959, 'Ap #905-980 Est Ave', 'Herrod Ingram', 'F', 322, 'auctor.mauris@google.org', 575339523);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1996, 'Ap #220-2101 Egestas Av.', 'Whitney Holt', 'F', 249, 'eget@hotmail.com', 580933718);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, '434-1217 Non Street', 'Hyatt Gay', 'F', 495, 'lacus.vestibulum@yahoo.org', 528533319);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, 'Ap #508-4203 Amet, Rd.', 'Mollie Nguyen', 'F', 221, 'sodales.nisi@icloud.org', 590449083);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1916, 'Ap #204-7890 Neque. Road', 'Hop Wright', 'M', 919, 'eu.lacus@icloud.net', 556847954);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1952, 'P.O. Box 394, 9604 Quis Rd.', 'David Sexton', 'F', 241, 'mattis.cras@protonmail.com', 531781517);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1939, '401-1982 Erat. Street', 'Harrison Estrada', 'F', 524, 'vivamus.sit.amet@google.ca', 581638292);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2021, '875-4218 Aliquam St.', 'Martin Pacheco', 'M', 864, 'pede.cum@protonmail.org', 586515972);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1951, 'P.O. Box 288, 6324 Primis Rd.', 'Jordan Mathis', 'M', 833, 'arcu.iaculis@protonmail.couk', 583375862);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1941, 'Ap #346-6650 Faucibus Road', 'Dahlia Reilly', 'F', 812, 'diam.pellentesque@hotmail.couk', 508338631);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, 'P.O. Box 321, 9761 Arcu. Rd.', 'Thomas Mendez', 'M', 725, 'tristique.senectus@hotmail.ca', 527817282);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1925, 'Ap #405-7497 Enim. Road', 'Isadora Monroe', 'M', 169, 'odio.etiam@protonmail.net', 521215647);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1943, '893-9162 Egestas. Av.', 'Marcia Arnold', 'F', 874, 'rutrum.eu@aol.com', 566075237);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2000, 'Ap #671-8494 Eu, Ave', 'Simone Suarez', 'F', 713, 'posuere.at@aol.org', 571085153);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, '4712 Nec Rd.', 'Galvin Reeves', 'M', 448, 'vehicula.risus.nulla@aol.edu', 576128443);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1983, '392-9303 Dui Road', 'Kenyon Hall', 'F', 841, 'elementum.dui@protonmail.ca', 566685505);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1959, '205-4410 Fringilla Rd.', 'Charlotte Duffy', 'M', 690, 'nunc@aol.ca', 582366338);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2018, 'P.O. Box 435, 2678 Sed Rd.', 'Brock Valenzuela', 'F', 281, 'et.ultrices.posuere@google.edu', 500338368);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1939, 'P.O. Box 124, 5624 Eget St.', 'Gannon Garza', 'M', 696, 'volutpat.nulla@hotmail.org', 533315498);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1942, 'Ap #110-4949 Nulla. St.', 'Cullen Greene', 'M', 952, 'tincidunt.donec@yahoo.net', 586368553);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, 'P.O. Box 145, 8216 Nascetur St.', 'Unity Ayala', 'M', 798, 'placerat@icloud.net', 559037161);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, 'Ap #339-3186 Velit. Av.', 'Xander Richards', 'M', 616, 'ut.odio@google.ca', 511854727);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1997, 'P.O. Box 243, 784 Facilisis Street', 'Shea Shepherd', 'M', 707, 'pellentesque@icloud.edu', 588528867);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1947, '983-655 Lectus Rd.', 'Dominic Dorsey', 'M', 457, 'tellus.aenean.egestas@google.net', 555922372);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1932, '252-2571 Purus, Rd.', 'Zeus Graham', 'M', 451, 'ipsum.primis.in@google.couk', 563453637);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '1327 Lorem, Road', 'Quamar Hughes', 'F', 689, 'turpis@protonmail.couk', 538045781);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1983, '899-2271 Arcu. Av.', 'Cairo Charles', 'M', 943, 'morbi.neque@icloud.org', 524371093);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1980, '7677 Ornare. Avenue', 'Quamar Bradshaw', 'F', 539, 'arcu.vestibulum@icloud.couk', 582360258);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1951, 'Ap #980-5532 Nec Rd.', 'Keane Jackson', 'M', 216, 'rhoncus@protonmail.com', 598038843);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2003, '510-2981 Vulputate St.', 'Shana Kent', 'F', 829, 'vitae.dolor@google.ca', 573914367);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1991, 'Ap #266-3776 Mus. St.', 'Armando Dillon', 'F', 183, 'eu.eleifend.nec@aol.couk', 571371101);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1993, 'P.O. Box 272, 8267 Lorem Street', 'Vincent Cotton', 'F', 379, 'mauris@google.edu', 569139768);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, '456 Oak Ave', 'Bob Smith', 'M', 25670, 'bob@email.com', 87654321);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, 'Ap #958-7751 Viverra. Ave', 'Eleanor Jefferson', 'F', 577, 'ac.metus@outlook.ca', 582175221);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, 'P.O. Box 175, 6500 Quisque Av.', 'Ira Day', 'M', 838, 'et.nunc.quisque@yahoo.ca', 524324167);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1934, '5479 Mi St.', 'Maisie Hampton', 'F', 502, 'penatibus.et@yahoo.couk', 512648528);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1980, 'Ap #839-3424 Mauris Rd.', 'Malachi Sanders', 'F', 597, 'tellus@google.ca', 565425717);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1935, '886-9121 Augue Rd.', 'Marcia Mcknight', 'M', 648, 'mattis.semper@hotmail.net', 542726797);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, '4755 Curabitur Rd.', 'Ariana Macias', 'F', 131, 'mi.eleifend@google.net', 504276541);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1918, '766-2061 Quam Street', 'Doris Martinez', 'F', 104, 'phasellus.libero@outlook.edu', 590863510);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1933, '274-2912 Morbi Rd.', 'Darryl Lewis', 'F', 377, 'ipsum@protonmail.net', 583347324);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, '897-649 In Rd.', 'Finn Henson', 'M', 134, 'eget@icloud.net', 532156133);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2003, '161-1546 Mauris Rd.', 'Raven Shannon', 'F', 846, 'pellentesque.tincidunt@google.com', 528119994);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1992, '482-163 Gravida Road', 'Lewis Mcclure', 'F', 584, 'et.rutrum@protonmail.net', 544183372);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, 'P.O. Box 281, 7540 Fringilla St.', 'Madison Lott', 'M', 553, 'nec.tellus@outlook.net', 514296380);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, '785-9518 Ipsum. Rd.', 'Maia Christensen', 'M', 897, 'nec.euismod@aol.org', 537300363);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1957, 'P.O. Box 392, 213 Imperdiet Avenue', 'Regina Puckett', 'F', 890, 'ante@hotmail.ca', 585168343);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, '367-2749 Suspendisse Ave', 'Daniel Hunt', 'M', 718, 'sem.nulla.interdum@google.net', 581680813);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1985, 'P.O. Box 872, 3679 Augue. Avenue', 'Abraham Barlow', 'F', 162, 'aliquet.lobortis@aol.couk', 538460423);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2001, 'Ap #358-8695 Tellus. Road', 'Connor Gardner', 'M', 314, 'facilisis.facilisis@yahoo.edu', 526443117);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2022, '570-5673 Pede Ave', 'Ferris Frazier', 'M', 609, 'bibendum.ullamcorper@icloud.couk', 555021722);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, '3977 Ultricies Rd.', 'Elvis Levy', 'F', 204, 'consectetuer.rhoncus@hotmail.org', 582961986);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1998, 'Ap #430-5686 Luctus Av.', 'Wade Moody', 'M', 633, 'vestibulum@aol.ca', 595886432);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '445-2329 Mauris Street', 'Armando Patterson', 'F', 207, 'nullam.velit.dui@google.org', 511530072);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, 'Ap #449-9425 Cursus Rd.', 'Summer George', 'F', 453, 'suspendisse.commodo@icloud.edu', 590947426);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1945, '112-7838 Amet, Rd.', 'Kylie Rogers', 'F', 659, 'morbi.quis@outlook.edu', 565830555);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1973, '593-1560 Enim Av.', 'Athena Strong', 'M', 827, 'vestibulum@hotmail.edu', 557706314);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1983, 'Ap #233-3372 Nibh St.', 'Pearl Warner', 'M', 309, 'in.faucibus@yahoo.couk', 546323805);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1918, '970-3570 Mi Rd.', 'Emi Figueroa', 'F', 632, 'varius.et@hotmail.org', 528318840);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1989, '262-6106 Semper St.', 'Hu Mays', 'F', 820, 'eros.nec.tellus@outlook.com', 517032784);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1995, '651-6496 A, Ave', 'Jesse Pacheco', 'M', 109, 'vitae.aliquam@google.couk', 573657210);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1933, '124-4192 Erat. Road', 'Illiana Suarez', 'M', 218, 'ultrices.sit@outlook.org', 583861577);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1930, 'Ap #269-7390 Sed Ave', 'Lee Nguyen', 'M', 991, 'tempor@hotmail.org', 539184201);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1991, '4353 Nonummy Rd.', 'Amaya Watson', 'F', 412, 'non.dapibus@hotmail.net', 572695437);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1972, 'Ap #477-887 Orci Avenue', 'Harriet Pickett', 'M', 923, 'duis.dignissim@aol.com', 575619318);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, 'Ap #665-3778 Et Road', 'Cole Bernard', 'F', 152, 'senectus.et@hotmail.couk', 575217512);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1977, '712-2897 Praesent Rd.', 'Allistair Sheppard', 'F', 669, 'gravida@protonmail.org', 514337512);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, '510-8367 Molestie Ave', 'Alyssa Lindsay', 'M', 564, 'vel@aol.couk', 511207573);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1919, 'Ap #706-589 Accumsan Rd.', 'Hamish Villarreal', 'M', 751, 'ultricies.ligula@outlook.net', 561625915);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1928, '102 Enim Road', 'Tatum Greene', 'M', 930, 'tincidunt.aliquam.arcu@hotmail.org', 581823827);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1929, '201-5882 Eros. Road', 'Idona Mckenzie', 'F', 779, 'enim.nunc@icloud.couk', 537280664);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, 'Ap #133-5930 Hendrerit. Rd.', 'Isabella Hampton', 'M', 313, 'lacus.cras@icloud.edu', 538009324);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1958, '985-4788 Ante Road', 'Acton Santana', 'M', 262, 'cursus.in@yahoo.edu', 578025532);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1925, '243-5841 Risus. St.', 'Anika Hopper', 'F', 349, 'neque@icloud.edu', 525324565);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1975, '597-2559 A, Street', 'Acton Christian', 'F', 762, 'semper@yahoo.net', 577816023);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, 'P.O. Box 729, 1228 Praesent Street', 'Alika Garcia', 'F', 926, 'etiam.laoreet@yahoo.net', 569664023);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2002, 'Ap #840-5414 Sem Rd.', 'Henry Manning', 'F', 130, 'in.consequat.enim@outlook.couk', 513806701);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2018, 'P.O. Box 157, 8989 Nisi Street', 'Sheila Cortez', 'M', 674, 'eget.ipsum@aol.edu', 514843167);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, 'Ap #203-2755 Parturient St.', 'Hyacinth Bass', 'F', 793, 'dapibus.id.blandit@google.net', 517681888);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1934, '238-5108 Posuere, Rd.', 'Beau Bailey', 'M', 543, 'cursus.nunc.mauris@google.ca', 597486069);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1932, '987-3703 Natoque St.', 'Maile Mcleod', 'F', 356, 'erat.vitae.risus@google.org', 598141537);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1953, 'Ap #565-9273 Duis Road', 'Illiana Mcfadden', 'F', 525, 'suscipit.nonummy.fusce@outlook.couk', 511842432);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1963, '951-6601 Arcu St.', 'Nero Maldonado', 'M', 753, 'donec.porttitor@google.net', 539454077);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2018, 'P.O. Box 837, 7068 Pellentesque Road', 'Yoko Buck', 'F', 552, 'nec.enim@yahoo.ca', 548747473);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1954, 'P.O. Box 490, 5580 Elit. Avenue', 'Kaitlin Forbes', 'M', 653, 'tempus.non.lacinia@outlook.org', 574104204);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1956, 'Ap #626-1553 Eu, Road', 'Noelle Underwood', 'F', 879, 'neque.vitae@aol.ca', 581020780);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2019, 'Ap #273-2683 Cubilia Av.', 'Blythe Stephenson', 'F', 698, 'magnis@aol.com', 561852315);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1971, 'Ap #729-7353 Purus Rd.', 'Tanisha Wolfe', 'M', 542, 'integer@icloud.org', 532636663);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1949, 'Ap #738-2791 Tincidunt. Av.', 'Tanek Bauer', 'M', 459, 'aliquam@yahoo.org', 598363862);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2002, '657-2634 Non, Avenue', 'Julie Barr', 'F', 593, 'etiam.vestibulum@aol.couk', 531478074);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2004, 'P.O. Box 494, 3451 Urna. St.', 'Walter Church', 'F', 198, 'ut.nisi.a@yahoo.org', 533015127);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1917, '111-9077 Consectetuer, Av.', 'Cheryl Carpenter', 'M', 863, 'lacus@hotmail.couk', 575556476);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1977, 'Ap #802-2802 Vitae St.', 'Graiden Cooley', 'F', 213, 'eget.metus@yahoo.net', 525842721);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1982, '8867 Sociis Ave', 'Odette Lucas', 'F', 799, 'ut@yahoo.ca', 541176882);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1937, 'Ap #491-6854 Sapien Rd.', 'Althea Randolph', 'M', 569, 'dolor.dolor@hotmail.org', 586357536);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1984, '929-347 Non Av.', 'Leo Palmer', 'M', 785, 'vivamus@yahoo.ca', 568868364);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1974, '882-7608 Gravida St.', 'Emerald Reynolds', 'M', 894, 'eros.turpis@hotmail.edu', 521851137);
commit;
prompt 300 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, 'P.O. Box 879, 5525 Duis Avenue', 'Sydnee Clay', 'F', 481, 'adipiscing.elit@aol.ca', 562543366);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1922, '673-6942 Sed Av.', 'Isadora Cortez', 'M', 181, 'et.commodo@hotmail.ca', 595953493);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1984, '288-7365 Etiam Avenue', 'Ronan Moss', 'F', 504, 'lectus.a@google.org', 516634785);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1980, '123 Main St', 'Alice Johnson', 'F', 20001, 'alice@email.com', 23456789);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1990, '456 Oak Ave', 'Bob Smith', 'M', 20002, 'bob@email.com', 87654321);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1985, '789 Elm St', 'Charlie Davis', 'M', 20003, 'charlie@email.com', 56789012);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1995, '321 Pine Rd', 'Danielle Wilson', 'F', 20004, 'danielle@email.com', 89012345);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1988, '654 Maple Ln', 'Evan Thompson', 'M', 20005, 'evan@email.com', 45678901);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1992, '987 Cedar Blvd', 'Fiona Anderson', 'F', 20006, 'fiona@email.com', 78901234);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1982, '246 Oak Ct', 'George Taylor', 'M', 20007, 'george@email.com', 1234567);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1998, '579 Elm Way', 'Hannah Brown', 'F', 20008, 'hannah@email.com', 34567890);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1991, '813 Pine Ave', 'Ian Garcia', 'M', 20009, 'ian@email.com', 67890123);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1987, '159 Maple St', 'Jill Roberts', 'F', 20010, 'jill@email.com', 90123456);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1987, '5429 Arcu. Street', 'Louis Harding', 'M', 783, 'commodo@yahoo.edu', 576085009);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1986, 'P.O. Box 643, 736 Mauris Rd.', 'Bruce Walton', 'F', 601, 'diam.duis.mi@yahoo.couk', 584338727);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1916, 'Ap #852-970 Neque. Street', 'Flynn Jensen', 'F', 871, 'ligula.aliquam@aol.net', 582426580);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1977, '725-2292 Mauris Ave', 'Noelle James', 'F', 410, 'et@yahoo.net', 563243318);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2003, '564-2259 Cras Ave', 'Kathleen Santana', 'M', 373, 'neque.non.quam@protonmail.edu', 551339756);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1996, 'Ap #265-7286 Sollicitudin St.', 'Macey Tucker', 'M', 168, 'malesuada.fames.ac@google.couk', 544411142);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (1991, '369-2700 Consectetuer Av.', 'Zephr Beach', 'F', 371, 'egestas.a.dui@hotmail.ca', 588485333);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, 'P.O. Box 640, 8387 Pulvinar Street', 'Amanda Mcmahon', 'F', 946, 'morbi.tristique@protonmail.ca', 512426537);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2020, '5806 Euismod Rd.', 'Wylie Mcclure', 'F', 362, 'mauris.integer.sem@google.edu', 544515855);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alexandra Wright', null, 1, null, 541868000);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Cameron Diaz', null, 3, null, 540884427);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Karen Clark', null, 4, null, 543497247);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Sarah Harris', null, 5, null, 575968929);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Theodore Evans', null, 7, null, 581154956);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Daniel Thomas', null, 9, null, 545467347);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Susan Anderson', null, 10, null, 556407681);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Keith Roberts', null, 12, null, 580489883);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Victoria Smith', null, 14, null, 583976968);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Charlene Hernandez', null, 15, null, 593016420);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Roy Moore', null, 16, null, 544552372);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Abigail Hernandez', null, 17, null, 546531441);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Andrew Clark', null, 18, null, 550254262);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Caroline Anderson', null, 19, null, 557114103);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Isaiah Nelson', null, 20, null, 519345594);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Sebastian Rogers', null, 25, null, 535170706);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Philip Wright', null, 28, null, 579950551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Stephanie Garcia', null, 29, null, 590374515);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Luna Cruz', null, 30, null, 527902077);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Sebastian Moore', null, 31, null, 526383220);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Teresa Jones', null, 34, null, 520755116);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Evelyn Jones', null, 35, null, 564431584);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Stephanie Hernandez', null, 36, null, 560034458);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Shirley Nguyen', null, 37, null, 511851887);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Timothy Young', null, 39, null, 556653152);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Jacob Nguyen', null, 40, null, 551354560);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Heather Robinson', null, 42, null, 565140285);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Charles Wilson', null, 43, null, 553151314);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Vincent Lee', null, 45, null, 543636551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Margaret Young', null, 47, null, 535175866);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Sebastian Scott', null, 50, null, 595869513);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Brian Taylor', null, 52, null, 550109206);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Courtney Clark', null, 53, null, 539075311);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Cody Campbell', null, 54, null, 589785335);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Leslie Miller', null, 55, null, 561934338);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Ryan Nelson', null, 56, null, 516240171);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Zachary Garcia', null, 57, null, 597518023);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Jennifer Lopez', null, 58, null, 562958849);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jayden Hernandez', null, 60, null, 578572076);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Scott Hall', null, 61, null, 549987298);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Julian Nguyen', null, 63, null, 547002676);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Anthony Moore', null, 65, null, 580891495);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Shirley Nelson', null, 66, null, 534178182);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Laura Wilson', null, 67, null, 537788912);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Courtney Rodriguez', null, 68, null, 548752704);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Nathan Anderson', null, 71, null, 556710704);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Edward Robinson', null, 72, null, 551852535);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Gregory Rodriguez', null, 73, null, 553872224);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Nicole Moore', null, 74, null, 583140414);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Xavier Scott', null, 76, null, 594596575);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Martha Hernandez', null, 77, null, 595223556);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Susan Brown', null, 78, null, 528048939);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Derek Walker', null, 79, null, 576353114);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Lisa Wright', null, 85, null, 597321822);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Derek Miller', null, 86, null, 525424277);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Linda Lewis', null, 87, null, 566196455);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Kelly Roberts', null, 88, null, 581748972);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Ava Williams', null, 89, null, 596273809);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Louise Robinson', null, 90, null, 542101305);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Gabriel Hernandez', null, 91, null, 519866412);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Claire Jones', null, 92, null, 549141214);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Victoria Evans', null, 93, null, 557330759);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Margaret Clark', null, 94, null, 571413868);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Lisa Green', null, 97, null, 557527598);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Derek Nelson', null, 98, null, 538919598);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Julia Jones', null, 99, null, 535976064);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Nicholas Garcia', null, 102, null, 527767652);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Anthony Hernandez', null, 106, null, 578863284);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Laura Taylor', null, 107, null, 527134416);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Stephanie Cruz', null, 108, null, 560920589);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Rose Green', null, 113, null, 547970151);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Cole Mitchell', null, 114, null, 560826081);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Lillian Lewis', null, 115, null, 585744067);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Dustin Lewis', null, 116, null, 575952384);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Aaron Lee', null, 118, null, 515240356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Julian Young', null, 120, null, 573074366);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Tyler Young', null, 123, null, 579075642);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Daniel Taylor', null, 124, null, 520503461);
commit;
prompt 400 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Harold Miller', null, 126, null, 548679916);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Faith Thomas', null, 132, null, 529068539);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Gabriel Sanchez', null, 133, null, 544371226);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Daniel Campbell', null, 137, null, 559233457);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Joshua Rodriguez', null, 138, null, 520986276);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Maya Lopez', null, 139, null, 593777356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Maya Scott', null, 141, null, 566859396);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kristen Allen', null, 142, null, 581300682);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Antonio Garcia', null, 143, null, 581545388);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Cole Walker', null, 145, null, 588083016);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Kristen Lewis', null, 146, null, 540713170);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Danielle Thompson', null, 147, null, 533784253);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Scott Phillips', null, 155, null, 553261420);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Jacob Mitchell', null, 157, null, 583258534);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Dustin Phillips', null, 161, null, 532238015);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Ethan Nelson', null, 164, null, 524915863);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Claudia Hernandez', null, 165, null, 571192317);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Lucy Hernandez', null, 166, null, 536027980);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Ezekiel Cruz', null, 167, null, 564088981);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Leonardo Rodriguez', null, 171, null, 566240465);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Adrian Hernandez', null, 173, null, 556958612);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alan Anderson', null, 174, null, 536787238);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jennifer Williams', null, 176, null, 523974313);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Fiona Roy', null, 177, null, 552456511);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Gregory Phillips', null, 179, null, 523459118);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jane Adams', null, 182, null, 564875750);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Charlene Allen', null, 185, null, 527430235);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Cameron Thompson', null, 188, null, 545599978);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Walter Lewis', null, 192, null, 584016953);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Vincent Garcia', null, 193, null, 520457401);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Miguel Lopez', null, 196, null, 581739043);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ashley Johnson', null, 197, null, 532919123);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Julia Green', null, 205, null, 597766757);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Jacob Moore', null, 209, null, 576620844);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ava Lee', null, 211, null, 522317020);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Benjamin Allen', null, 214, null, 515819212);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Lily Scott', null, 217, null, 546612610);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Katherine Nguyen', null, 223, null, 528782998);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Chad Clark', null, 224, null, 560166830);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Maria Hernandez', null, 226, null, 566892833);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Martha Allen', null, 228, null, 530745831);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Shannon Lopez', null, 229, null, 576677565);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Isabella Adams', null, 232, null, 540073645);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Diana Clark', null, 234, null, 524258229);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Trevor Taylor', null, 238, null, 536583996);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Felipe Walker', null, 239, null, 597779079);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Julia Nguyen', null, 244, null, 594277729);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Nancy Lewis', null, 248, null, 512823440);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Faith Young', null, 252, null, 515484767);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kimberly Williams', null, 253, null, 527819264);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Rebecca Roberts', null, 254, null, 526678219);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Sebastian Garcia', null, 255, null, 539086091);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Andrew Moore', null, 256, null, 578518565);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Thomas Nguyen', null, 258, null, 578525948);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Jasmine Wright', null, 268, null, 570799319);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Christopher Davis', null, 270, null, 549179700);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Abraham Moore', null, 272, null, 520336751);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Nicholas Allen', null, 273, null, 548807005);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Antonio Walker', null, 275, null, 536978813);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Juan Harris', null, 277, null, 594493653);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Sharon Rodriguez', null, 278, null, 584292886);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Cole Rodriguez', null, 282, null, 582569940);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Andrew Garcia', null, 283, null, 593034600);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Joseph Scott', null, 288, null, 590938354);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Austin Harris', null, 289, null, 584004460);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Chad Wright', null, 297, null, 528989557);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Lillian Campbell', null, 299, null, 525264680);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Sheila Wilson', null, 300, null, 576562686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Luke Johnson', null, 301, null, 511633279);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Claire Diaz', null, 304, null, 557610951);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Ava Robinson', null, 305, null, 545355795);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Gabriella Harris', null, 306, null, 598700130);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Kelly Hernandez', null, 311, null, 560470721);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Joan Taylor', null, 312, null, 588857941);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Peyton Miller', null, 316, null, 583989511);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Michelle Johnson', null, 317, null, 550953591);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Amelia Nguyen', null, 318, null, 511744231);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ezekiel Johnson', null, 319, null, 549479581);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Theodore Mitchell', null, 321, null, 557209428);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Albert Johnson', null, 325, null, 568120620);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Joan Wilson', null, 326, null, 583603253);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Albert Hernandez', null, 329, null, 579158122);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Cole Green', null, 330, null, 527620537);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Cecilia Lee', null, 334, null, 577064088);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Faith Wright', null, 339, null, 582327265);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jacqueline Robinson', null, 341, null, 519969862);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Derek Robinson', null, 342, null, 564044493);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Kelly Brown', null, 344, null, 580166566);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alana Sanchez', null, 345, null, 577658798);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Dylan Johnson', null, 346, null, 578330696);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Aisha Wright', null, 347, null, 571190461);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Lauren Lewis', null, 353, null, 572043588);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Aaron Hernandez', null, 355, null, 514831214);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Dustin Robinson', null, 357, null, 577076094);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Eric Allen', null, 359, null, 599020536);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Heather Mitchell', null, 360, null, 573224707);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Felipe Lee', null, 361, null, 511592484);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Luna Walker', null, 364, null, 599024067);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Lillian Watson', null, 366, null, 576661594);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Justin Rodriguez', null, 367, null, 518366894);
commit;
prompt 500 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jacqueline Lee', null, 372, null, 527372336);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Courtney Cruz', null, 376, null, 565100974);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jennifer Hernandez', null, 380, null, 520194852);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Lisa Clark', null, 384, null, 543853980);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ava Nelson', null, 385, null, 588869048);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Reagan Rogers', null, 386, null, 542615555);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Harold Roy', null, 388, null, 597631551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Ronald Miller', null, 390, null, 595377768);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Daniel Anderson', null, 395, null, 551746107);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Kyle Moore', null, 397, null, 563356205);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Brian Rodriguez', null, 402, null, 543721994);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Edward Lopez', null, 403, null, 522170895);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Evelyn Rodriguez', null, 404, null, 529192855);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Patricia Phillips', null, 405, null, 544981012);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Rachel Sanchez', null, 406, null, 536551170);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Jayden Allen', null, 407, null, 581185722);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Lauren Roy', null, 411, null, 550394341);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jayden Brown', null, 415, null, 548333734);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Chad Cruz', null, 416, null, 528206561);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Kyle Miller', null, 419, null, 572505806);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Samantha Hernandez', null, 421, null, 510399961);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Jennifer Mitchell', null, 424, null, 527992622);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Sarah Scott', null, 425, null, 514194094);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Douglas Lopez', null, 426, null, 582457357);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Karen Hernandez', null, 427, null, 568360925);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Dylan Lopez', null, 428, null, 552457681);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Nathan Campbell', null, 429, null, 559007588);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Karen Young', null, 431, null, 531485516);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Amanda Williams', null, 436, null, 558900968);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Thomas Moore', null, 440, null, 587134589);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Michelle Lopez', null, 441, null, 517227489);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Wesley Allen', null, 442, null, 579753538);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jonathan Moore', null, 443, null, 540772325);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Cecilia Mitchell', null, 450, null, 521163097);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Albert Rogers', null, 452, null, 528833675);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Dennis Hernandez', null, 460, null, 568083538);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Isaiah Allen', null, 461, null, 530861548);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Laura Lewis', null, 462, null, 557403039);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Sheila Nguyen', null, 465, null, 585737384);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Adam Thomas', null, 472, null, 520558017);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Leah Taylor', null, 474, null, 545462139);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Lydia Miller', null, 477, null, 558178262);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Kristen Hernandez', null, 482, null, 528972190);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Andrew Allen', null, 486, null, 540145845);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Hannah Rodriguez', null, 489, null, 596509605);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Peyton Johnson', null, 490, null, 526419787);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Cody Allen', null, 491, null, 536372889);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Jayden Lee', null, 492, null, 559026080);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Tiffany Mitchell', null, 493, null, 526229425);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Alan Wilson', null, 497, null, 511360739);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Bethany Allen', null, 498, null, 594947206);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Trevor Walker', null, 499, null, 566911947);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Mia Carter', null, 500, null, 585834404);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Jesse Adams', null, 506, null, 584779557);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Stephanie Jones', null, 508, null, 584390599);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Dorothy Davis', null, 512, null, 575881323);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Joan Garcia', null, 514, null, 543387263);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Dorothy Lopez', null, 515, null, 594713819);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Andrew Hernandez', null, 517, null, 549660321);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Philip Clark', null, 521, null, 579514546);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Douglas Moore', null, 522, null, 578874412);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'David Lee', null, 528, null, 599610357);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Lori Watson', null, 529, null, 580786248);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Katherine Lewis', null, 531, null, 562234140);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Michelle Davis', null, 532, null, 596374729);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Brenda Garcia', null, 533, null, 567454118);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Jordan Wilson', null, 535, null, 552776686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Mia Allen', null, 537, null, 528295129);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Sharon Hernandez', null, 540, null, 560037605);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kayla Hernandez', null, 544, null, 552131356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Lauren Lopez', null, 545, null, 594415213);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Molly Rodriguez', null, 546, null, 578629179);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Cody Garcia', null, 547, null, 585996919);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Alexandra Sanchez', null, 548, null, 515850530);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jack Miller', null, 550, null, 593473969);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Agnes Lopez', null, 551, null, 589763521);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Bethany Roy', null, 554, null, 569316969);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Diego Hernandez', null, 555, null, 526739358);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Julia Rodriguez', null, 557, null, 561606422);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Alana Rodriguez', null, 558, null, 565545671);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Bethany Scott', null, 561, null, 599685652);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jonathan Garcia', null, 563, null, 573222939);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Charles Rodriguez', null, 566, null, 595248105);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Lawrence Hernandez', null, 570, null, 593918858);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Julian Garcia', null, 573, null, 589857085);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Diana Adams', null, 576, null, 593531629);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Luke Mitchell', null, 578, null, 510706307);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Miguel Hall', null, 579, null, 589840333);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Gregory Lewis', null, 580, null, 543090541);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Wesley Williams', null, 581, null, 513708560);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Richard Young', null, 583, null, 562951274);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Diana King', null, 587, null, 537683003);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Kelly Rogers', null, 589, null, 596571631);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jayden Miller', null, 591, null, 592794306);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Margaret Lee', null, 592, null, 535593860);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Shannon Johnson', null, 594, null, 572320344);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Susan Hernandez', null, 595, null, 567304037);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Laura Rogers', null, 603, null, 597590684);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Paul Garcia', null, 604, null, 544134930);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Isaac Anderson', null, 606, null, 516079904);
commit;
prompt 600 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Christopher Allen', null, 608, null, 579253766);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Philip Rodriguez', null, 611, null, 548625592);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Madison Scott', null, 612, null, 548413117);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Samantha Lee', null, 613, null, 533722821);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Sophia Miller', null, 614, null, 590291749);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Allison Hernandez', null, 620, null, 598089613);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Laura Robinson', null, 621, null, 525105403);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Ronald Lopez', null, 622, null, 548349087);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Antonio Robinson', null, 626, null, 591888620);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Isaac Moore', null, 628, null, 534351674);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Alan Anderson', null, 630, null, 586482014);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Lillian Harris', null, 640, null, 563103381);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Rebecca Mitchell', null, 641, null, 527727499);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Adam Allen', null, 642, null, 510516990);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Alicia Wright', null, 643, null, 586953159);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'David Moore', null, 644, null, 592883965);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'John Johnson', null, 645, null, 599406644);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Kimberly Johnson', null, 646, null, 579087866);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Monica Lopez', null, 649, null, 586441380);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Amelia Walker', null, 655, null, 530183231);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Adam Scott', null, 661, null, 516905686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Lucas Clark', null, 665, null, 540550571);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Brittany Lee', null, 666, null, 534565097);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Andrew Rodriguez', null, 677, null, 578362269);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Hannah Rogers', null, 680, null, 568268137);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Xavier Hernandez', null, 682, null, 563721749);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Lawrence Garcia', null, 687, null, 521575431);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Natalie Allen', null, 688, null, 546803125);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Luke Allen', null, 695, null, 533313858);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Alexis Hall', null, 699, null, 541105192);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alexandra Wright', null, 1001, null, 541868000);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Cameron Diaz', null, 1003, null, 540884427);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Karen Clark', null, 1004, null, 543497247);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Sarah Harris', null, 1005, null, 575968929);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Theodore Evans', null, 1007, null, 581154956);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Daniel Thomas', null, 1009, null, 545467347);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Susan Anderson', null, 1010, null, 556407681);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Keith Roberts', null, 1012, null, 580489883);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Victoria Smith', null, 1014, null, 583976968);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Charlene Hernandez', null, 1015, null, 593016420);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Roy Moore', null, 1016, null, 544552372);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Abigail Hernandez', null, 1017, null, 546531441);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Andrew Clark', null, 1018, null, 550254262);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Caroline Anderson', null, 1019, null, 557114103);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Isaiah Nelson', null, 1020, null, 519345594);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Sebastian Rogers', null, 1025, null, 535170706);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Philip Wright', null, 1028, null, 579950551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Stephanie Garcia', null, 1029, null, 590374515);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Luna Cruz', null, 1030, null, 527902077);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Sebastian Moore', null, 1031, null, 526383220);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Teresa Jones', null, 1034, null, 520755116);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Evelyn Jones', null, 1035, null, 564431584);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Stephanie Hernandez', null, 1036, null, 560034458);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Shirley Nguyen', null, 1037, null, 511851887);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Timothy Young', null, 1039, null, 556653152);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Jacob Nguyen', null, 1040, null, 551354560);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Heather Robinson', null, 1042, null, 565140285);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Charles Wilson', null, 1043, null, 553151314);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Vincent Lee', null, 1045, null, 543636551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Margaret Young', null, 1047, null, 535175866);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Sebastian Scott', null, 1050, null, 595869513);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Brian Taylor', null, 1052, null, 550109206);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Courtney Clark', null, 1053, null, 539075311);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Cody Campbell', null, 1054, null, 589785335);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Leslie Miller', null, 1055, null, 561934338);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Ryan Nelson', null, 1056, null, 516240171);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Zachary Garcia', null, 1057, null, 597518023);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Jennifer Lopez', null, 1058, null, 562958849);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jayden Hernandez', null, 1060, null, 578572076);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Scott Hall', null, 1061, null, 549987298);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Julian Nguyen', null, 1063, null, 547002676);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Anthony Moore', null, 1065, null, 580891495);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Shirley Nelson', null, 1066, null, 534178182);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Laura Wilson', null, 1067, null, 537788912);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Courtney Rodriguez', null, 1068, null, 548752704);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Nathan Anderson', null, 1071, null, 556710704);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Edward Robinson', null, 1072, null, 551852535);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Gregory Rodriguez', null, 1073, null, 553872224);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Nicole Moore', null, 1074, null, 583140414);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Xavier Scott', null, 1076, null, 594596575);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Martha Hernandez', null, 1077, null, 595223556);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Susan Brown', null, 1078, null, 528048939);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Derek Walker', null, 1079, null, 576353114);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Lisa Wright', null, 1085, null, 597321822);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Derek Miller', null, 1086, null, 525424277);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Linda Lewis', null, 1087, null, 566196455);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Kelly Roberts', null, 1088, null, 581748972);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Ava Williams', null, 1089, null, 596273809);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Louise Robinson', null, 1090, null, 542101305);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Gabriel Hernandez', null, 1091, null, 519866412);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Claire Jones', null, 1092, null, 549141214);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Victoria Evans', null, 1093, null, 557330759);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Margaret Clark', null, 1094, null, 571413868);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Lisa Green', null, 1097, null, 557527598);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Derek Nelson', null, 1098, null, 538919598);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Julia Jones', null, 1099, null, 535976064);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Ruby Allen', null, 1100, null, 518985766);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Nicholas Garcia', null, 1102, null, 527767652);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Heather Roberts', null, 1104, null, 585481271);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Anthony Hernandez', null, 1106, null, 578863284);
commit;
prompt 700 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Laura Taylor', null, 1107, null, 527134416);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Stephanie Cruz', null, 1108, null, 560920589);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Rebecca Evans', null, 1109, null, 591609320);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Carlos Robinson', null, 1110, null, 592407738);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Rose Green', null, 1113, null, 547970151);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Cole Mitchell', null, 1114, null, 560826081);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Lillian Lewis', null, 1115, null, 585744067);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Dustin Lewis', null, 1116, null, 575952384);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Isaac Watson', null, 1117, null, 536388836);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Aaron Lee', null, 1118, null, 515240356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Amelia Allen', null, 1119, null, 590409951);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Julian Young', null, 1120, null, 573074366);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Joan Miller', null, 1121, null, 549667298);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Tyler Young', null, 1123, null, 579075642);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Daniel Taylor', null, 1124, null, 520503461);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Harold Miller', null, 1126, null, 548679916);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Charles Hernandez', null, 1127, null, 523482174);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Jonathan Williams', null, 1129, null, 544438996);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Theodore Lopez', null, 1131, null, 538078090);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Faith Thomas', null, 1132, null, 529068539);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Gabriel Sanchez', null, 1133, null, 544371226);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Leonardo Robinson', null, 1135, null, 593911753);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kevin Nguyen', null, 1136, null, 540228165);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Daniel Campbell', null, 1137, null, 559233457);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Joshua Rodriguez', null, 1138, null, 520986276);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Maya Lopez', null, 1139, null, 593777356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Oliver Robinson', null, 1140, null, 512288694);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Maya Scott', null, 1141, null, 566859396);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kristen Allen', null, 1142, null, 581300682);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Antonio Garcia', null, 1143, null, 581545388);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Jordan Lee', null, 1144, null, 581474390);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Cole Walker', null, 1145, null, 588083016);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Kristen Lewis', null, 1146, null, 540713170);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Danielle Thompson', null, 1147, null, 533784253);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'George Robinson', null, 1150, null, 519904369);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Stephen Garcia', null, 1151, null, 512127328);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Edward Williams', null, 1153, null, 587317546);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Scott Phillips', null, 1155, null, 553261420);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Jacob Mitchell', null, 1157, null, 583258534);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Dustin Phillips', null, 1161, null, 532238015);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Kevin Johnson', null, 1162, null, 554258249);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Ethan Nelson', null, 1164, null, 524915863);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Claudia Hernandez', null, 1165, null, 571192317);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Lucy Hernandez', null, 1166, null, 536027980);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Ezekiel Cruz', null, 1167, null, 564088981);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Molly Nguyen', null, 1168, null, 527248992);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Sarah Moore', null, 1169, null, 521561956);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Leonardo Rodriguez', null, 1171, null, 566240465);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Adrian Hernandez', null, 1173, null, 556958612);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alan Anderson', null, 1174, null, 536787238);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jennifer Williams', null, 1176, null, 523974313);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Fiona Roy', null, 1177, null, 552456511);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Isaiah Clark', null, 1178, null, 516199108);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Gregory Phillips', null, 1179, null, 523459118);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jane Adams', null, 1182, null, 564875750);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Charlene Allen', null, 1185, null, 527430235);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Cameron Thompson', null, 1188, null, 545599978);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Walter Lewis', null, 1192, null, 584016953);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Vincent Garcia', null, 1193, null, 520457401);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Miguel Lopez', null, 1196, null, 581739043);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ashley Johnson', null, 1197, null, 532919123);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Anthony Allen', null, 1199, null, 544268071);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Isaiah Wright', null, 1201, null, 570378447);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Julia Green', null, 1205, null, 597766757);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Samuel Campbell', null, 1206, null, 552429514);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Adam Moore', null, 1208, null, 583191610);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Jacob Moore', null, 1209, null, 576620844);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ava Lee', null, 1211, null, 522317020);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Lucia Hernandez', null, 1213, null, 523920417);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Benjamin Allen', null, 1214, null, 515819212);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Lily Scott', null, 1217, null, 546612610);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Philip Nguyen', null, 1218, null, 526936108);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Patricia Garcia', null, 1221, null, 530795249);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Nathan Rodriguez', null, 1222, null, 598129305);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Katherine Nguyen', null, 1223, null, 528782998);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Chad Clark', null, 1224, null, 560166830);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Maria Hernandez', null, 1226, null, 566892833);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Martha Allen', null, 1228, null, 530745831);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Shannon Lopez', null, 1229, null, 576677565);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Zachary Williams', null, 1230, null, 514774796);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Isabella Adams', null, 1232, null, 540073645);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Diana Clark', null, 1234, null, 524258229);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Trevor Taylor', null, 1238, null, 536583996);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Felipe Walker', null, 1239, null, 597779079);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Nathan Hernandez', null, 1241, null, 515684880);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Penelope Walker', null, 1242, null, 522351988);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Julia Nguyen', null, 1244, null, 594277729);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Nancy Lewis', null, 1248, null, 512823440);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Walter Phillips', null, 1249, null, 542792234);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Roy Rogers', null, 1250, null, 595221830);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Faith Young', null, 1252, null, 515484767);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kimberly Williams', null, 1253, null, 527819264);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Rebecca Roberts', null, 1254, null, 526678219);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Sebastian Garcia', null, 1255, null, 539086091);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Andrew Moore', null, 1256, null, 578518565);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Thomas Nguyen', null, 1258, null, 578525948);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Gabriella Garcia', null, 1259, null, 563231712);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Caroline Scott', null, 1262, null, 559372041);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Jasmine Wright', null, 1268, null, 570799319);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Penelope Campbell', null, 1269, null, 518205192);
commit;
prompt 800 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Christopher Davis', null, 1270, null, 549179700);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Abraham Moore', null, 1272, null, 520336751);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Nicholas Allen', null, 1273, null, 548807005);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Antonio Walker', null, 1275, null, 536978813);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Juan Harris', null, 1277, null, 594493653);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Sharon Rodriguez', null, 1278, null, 584292886);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Cole Rodriguez', null, 1282, null, 582569940);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Andrew Garcia', null, 1283, null, 593034600);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Lisa Lee', null, 1286, null, 520724991);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Joseph Scott', null, 1288, null, 590938354);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Austin Harris', null, 1289, null, 584004460);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Tiffany Walker', null, 1290, null, 540153861);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Julian Miller', null, 1292, null, 573122842);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Katherine Allen', null, 1293, null, 590605495);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Chad Wright', null, 1297, null, 528989557);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jacob Williams', null, 1298, null, 539690238);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Lillian Campbell', null, 1299, null, 525264680);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Sheila Wilson', null, 1300, null, 576562686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Luke Johnson', null, 1301, null, 511633279);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Claire Diaz', null, 1304, null, 557610951);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Ava Robinson', null, 1305, null, 545355795);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Gabriella Harris', null, 1306, null, 598700130);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Cole Moore', null, 1308, null, 568873605);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Kelly Hernandez', null, 1311, null, 560470721);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Joan Taylor', null, 1312, null, 588857941);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Mia Rogers', null, 1313, null, 567247544);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Peyton Miller', null, 1316, null, 583989511);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Michelle Johnson', null, 1317, null, 550953591);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Amelia Nguyen', null, 1318, null, 511744231);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ezekiel Johnson', null, 1319, null, 549479581);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Theodore Mitchell', null, 1321, null, 557209428);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Robert Lee', null, 1324, null, 581391047);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Albert Johnson', null, 1325, null, 568120620);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Joan Wilson', null, 1326, null, 583603253);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Scott Hernandez', null, 1328, null, 574516964);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Albert Hernandez', null, 1329, null, 579158122);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Cole Green', null, 1330, null, 527620537);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Edward Young', null, 1332, null, 587058364);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Cecilia Lee', null, 1334, null, 577064088);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Karen Young', null, 1336, null, 549565745);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Ronald Lee', null, 1338, null, 562343735);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Faith Wright', null, 1339, null, 582327265);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jacqueline Robinson', null, 1341, null, 519969862);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Derek Robinson', null, 1342, null, 564044493);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Jacob Moore', null, 1343, null, 589435793);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Kelly Brown', null, 1344, null, 580166566);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Alana Sanchez', null, 1345, null, 577658798);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Dylan Johnson', null, 1346, null, 578330696);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Aisha Wright', null, 1347, null, 571190461);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jade Roy', null, 1349, null, 570502563);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Antonio Walker', null, 1350, null, 520938719);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Scott Harris', null, 1351, null, 579419020);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Lauren Lewis', null, 1353, null, 572043588);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Caleb Sanchez', null, 1354, null, 595670306);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Aaron Hernandez', null, 1355, null, 514831214);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Martha Lee', null, 1356, null, 552321657);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Dustin Robinson', null, 1357, null, 577076094);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Eric Allen', null, 1359, null, 599020536);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Heather Mitchell', null, 1360, null, 573224707);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Felipe Lee', null, 1361, null, 511592484);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Martha Walker', null, 1363, null, 574952711);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Luna Walker', null, 1364, null, 599024067);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Diana Walker', null, 1365, null, 568990770);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Lillian Watson', null, 1366, null, 576661594);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Justin Rodriguez', null, 1367, null, 518366894);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Ethan Wright', null, 1369, null, 564051588);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jacqueline Lee', null, 1372, null, 527372336);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Albert Johnson', null, 1374, null, 583355063);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Courtney Cruz', null, 1376, null, 565100974);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Rebecca Evans', null, 1377, null, 547441855);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jennifer Hernandez', null, 1380, null, 520194852);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Lisa Clark', null, 1384, null, 543853980);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Ava Nelson', null, 1385, null, 588869048);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Reagan Rogers', null, 1386, null, 542615555);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Harold Roy', null, 1388, null, 597631551);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Ronald Miller', null, 1390, null, 595377768);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Gabriel Hernandez', null, 1391, null, 553250393);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Sean Rogers', null, 1392, null, 564326195);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Daniel Anderson', null, 1395, null, 551746107);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Kyle Moore', null, 1397, null, 563356205);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Catherine Moore', null, 1399, null, 555223398);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Brian Rodriguez', null, 1402, null, 543721994);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Edward Lopez', null, 1403, null, 522170895);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Evelyn Rodriguez', null, 1404, null, 529192855);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Patricia Phillips', null, 1405, null, 544981012);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Rachel Sanchez', null, 1406, null, 536551170);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Jayden Allen', null, 1407, null, 581185722);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Antonio Mitchell', null, 1408, null, 579176762);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Lauren Roy', null, 1411, null, 550394341);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Samantha Young', null, 1412, null, 522562885);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jayden Brown', null, 1415, null, 548333734);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Chad Cruz', null, 1416, null, 528206561);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Ezekiel Moore', null, 1418, null, 528311853);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Kyle Miller', null, 1419, null, 572505806);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Benjamin Hernandez', null, 1420, null, 510973964);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Samantha Hernandez', null, 1421, null, 510399961);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Isabella Evans', null, 1423, null, 593890678);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Jennifer Mitchell', null, 1424, null, 527992622);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Sarah Scott', null, 1425, null, 514194094);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Douglas Lopez', null, 1426, null, 582457357);
commit;
prompt 900 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Karen Hernandez', null, 1427, null, 568360925);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Dylan Lopez', null, 1428, null, 552457681);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Nathan Campbell', null, 1429, null, 559007588);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Karen Young', null, 1431, null, 531485516);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Fiona Moore', null, 1434, null, 591181653);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Amanda Williams', null, 1436, null, 558900968);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Javier Moore', null, 1437, null, 554643857);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Thomas Moore', null, 1440, null, 587134589);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Michelle Lopez', null, 1441, null, 517227489);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Wesley Allen', null, 1442, null, 579753538);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Jonathan Moore', null, 1443, null, 540772325);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Margaret Thomas', null, 1444, null, 530511867);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Vivian Hernandez', null, 1446, null, 553535875);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Laura Rodriguez', null, 1448, null, 510541878);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Cecilia Mitchell', null, 1450, null, 521163097);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Aaron Walker', null, 1451, null, 567835154);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Albert Rogers', null, 1452, null, 528833675);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Kristen Hernandez', null, 1457, null, 546381004);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Dennis Hernandez', null, 1460, null, 568083538);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Isaiah Allen', null, 1461, null, 530861548);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Laura Lewis', null, 1462, null, 557403039);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Rose Walker', null, 1463, null, 514208009);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Sheila Nguyen', null, 1465, null, 585737384);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Roy Wright', null, 1468, null, 593350352);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Adam Thomas', null, 1472, null, 520558017);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Leah Taylor', null, 1474, null, 545462139);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Luke Adams', null, 1475, null, 543996830);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Lydia Miller', null, 1477, null, 558178262);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Joshua Hall', null, 1481, null, 591762226);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Kristen Hernandez', null, 1482, null, 528972190);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Andrew Allen', null, 1486, null, 540145845);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Isaiah Taylor', null, 1488, null, 572458986);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Hannah Rodriguez', null, 1489, null, 596509605);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Peyton Johnson', null, 1490, null, 526419787);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Cody Allen', null, 1491, null, 536372889);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Jayden Lee', null, 1492, null, 559026080);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Tiffany Mitchell', null, 1493, null, 526229425);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Alan Wilson', null, 1497, null, 511360739);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Bethany Allen', null, 1498, null, 594947206);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Trevor Walker', null, 1499, null, 566911947);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Mia Carter', null, 1500, null, 585834404);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Alana Jones', null, 1501, null, 589091978);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Joshua Allen', null, 1502, null, 554905373);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Rebecca Campbell', null, 1504, null, 555012231);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Jesse Adams', null, 1506, null, 584779557);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Stephanie Jones', null, 1508, null, 584390599);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Dorothy Davis', null, 1512, null, 575881323);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Joan Garcia', null, 1514, null, 543387263);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Dorothy Lopez', null, 1515, null, 594713819);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Andrew Hernandez', null, 1517, null, 549660321);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Isaiah Scott', null, 1518, null, 583797642);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Philip Clark', null, 1521, null, 579514546);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Douglas Moore', null, 1522, null, 578874412);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Dorothy Clark', null, 1523, null, 529184493);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Owen Garcia', null, 1524, null, 563578217);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Agnes Jones', null, 1526, null, 589199013);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'David Lee', null, 1528, null, 599610357);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Lori Watson', null, 1529, null, 580786248);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Brandon Lee', null, 1530, null, 584748173);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Katherine Lewis', null, 1531, null, 562234140);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Michelle Davis', null, 1532, null, 596374729);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Brenda Garcia', null, 1533, null, 567454118);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Jordan Wilson', null, 1535, null, 552776686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Mia Allen', null, 1537, null, 528295129);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Aaron Lopez', null, 1538, null, 558730194);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Sharon Hernandez', null, 1540, null, 560037605);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Alice Clark', null, 1542, null, 599275027);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Jonathan Walker', null, 1543, null, 537922228);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Kayla Hernandez', null, 1544, null, 552131356);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Lauren Lopez', null, 1545, null, 594415213);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Molly Rodriguez', null, 1546, null, 578629179);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Cody Garcia', null, 1547, null, 585996919);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Alexandra Sanchez', null, 1548, null, 515850530);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jack Miller', null, 1550, null, 593473969);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Agnes Lopez', null, 1551, null, 589763521);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Juan Robinson', null, 1553, null, 582050929);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Bethany Roy', null, 1554, null, 569316969);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Diego Hernandez', null, 1555, null, 526739358);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Maria Roberts', null, 1556, null, 588731670);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Julia Rodriguez', null, 1557, null, 561606422);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Alana Rodriguez', null, 1558, null, 565545671);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Bethany Scott', null, 1561, null, 599685652);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Danielle Robinson', null, 1562, null, 539099365);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Jonathan Garcia', null, 1563, null, 573222939);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Charles Rodriguez', null, 1566, null, 595248105);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Stephen Rogers', null, 1567, null, 560866111);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Eric Davis', null, 1568, null, 579896592);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Lawrence Hernandez', null, 1570, null, 593918858);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Julian Garcia', null, 1573, null, 589857085);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Diana Adams', null, 1576, null, 593531629);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Peyton Lewis', null, 1577, null, 571532098);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Luke Mitchell', null, 1578, null, 510706307);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Miguel Hall', null, 1579, null, 589840333);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Gregory Lewis', null, 1580, null, 543090541);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Wesley Williams', null, 1581, null, 513708560);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Richard Young', null, 1583, null, 562951274);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Diana King', null, 1587, null, 537683003);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Dennis Scott', null, 1588, null, 591061170);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Kelly Rogers', null, 1589, null, 596571631);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Jayden Miller', null, 1591, null, 592794306);
commit;
prompt 1000 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Margaret Lee', null, 1592, null, 535593860);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Shannon Johnson', null, 1594, null, 572320344);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Susan Hernandez', null, 1595, null, 567304037);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Sebastian King', null, 1597, null, 534231552);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Jade Jones', null, 1599, null, 593101954);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Albert Lopez', null, 1600, null, 595256806);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Courtney Campbell', null, 1601, null, 534747728);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2013, null, 'Laura Rogers', null, 1603, null, 597590684);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Paul Garcia', null, 1604, null, 544134930);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Isaac Anderson', null, 1606, null, 516079904);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Christopher Allen', null, 1608, null, 579253766);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Alicia Williams', null, 1609, null, 528837993);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Penelope Campbell', null, 1610, null, 551120257);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Philip Rodriguez', null, 1611, null, 548625592);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Madison Scott', null, 1612, null, 548413117);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Samantha Lee', null, 1613, null, 533722821);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Sophia Miller', null, 1614, null, 590291749);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Philip Anderson', null, 1616, null, 595155058);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Sarah Williams', null, 1618, null, 563159031);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Michelle Nguyen', null, 1619, null, 578867512);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Allison Hernandez', null, 1620, null, 598089613);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Laura Robinson', null, 1621, null, 525105403);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Ronald Lopez', null, 1622, null, 548349087);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Caleb Rodriguez', null, 1624, null, 549622450);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Samuel Lee', null, 1625, null, 523927646);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Antonio Robinson', null, 1626, null, 591888620);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Isaac Moore', null, 1628, null, 534351674);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Alan Anderson', null, 1630, null, 586482014);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Catherine Nguyen', null, 1632, null, 548889300);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Harold Jones', null, 1633, null, 518328382);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Isabella Robinson', null, 1639, null, 577637063);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Lillian Harris', null, 1640, null, 563103381);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Rebecca Mitchell', null, 1641, null, 527727499);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Adam Allen', null, 1642, null, 510516990);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Alicia Wright', null, 1643, null, 586953159);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'David Moore', null, 1644, null, 592883965);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'John Johnson', null, 1645, null, 599406644);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2015, null, 'Kimberly Johnson', null, 1646, null, 579087866);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Travis Johnson', null, 1647, null, 597185745);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Monica Lopez', null, 1649, null, 586441380);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Shirley Garcia', null, 1651, null, 549206669);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Brittany Mitchell', null, 1653, null, 583193338);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Amelia Walker', null, 1655, null, 530183231);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Danielle Clark', null, 1656, null, 539683208);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2012, null, 'Alexandra Garcia', null, 1657, null, 588721025);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Jade Young', null, 1659, null, 580462552);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2005, null, 'Paul Martinez', null, 1660, null, 514960332);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Adam Scott', null, 1661, null, 516905686);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2016, null, 'Lucas Clark', null, 1665, null, 540550571);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Brittany Lee', null, 1666, null, 534565097);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Ava Hernandez', null, 1668, null, 594402160);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2011, null, 'Stephanie Rodriguez', null, 1669, null, 591340477);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2009, null, 'Sean Robinson', null, 1671, null, 517431477);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2008, null, 'Bethany Thompson', null, 1672, null, 523470854);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Abigail Miller', null, 1676, null, 559512168);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Andrew Rodriguez', null, 1677, null, 578362269);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2014, null, 'Hannah Rogers', null, 1680, null, 568268137);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Xavier Hernandez', null, 1682, null, 563721749);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Bridget Robinson', null, 1685, null, 559801222);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Lawrence Garcia', null, 1687, null, 521575431);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Natalie Allen', null, 1688, null, 546803125);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Philip Clark', null, 1689, null, 572557971);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2007, null, 'Luke Allen', null, 1695, null, 533313858);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2017, null, 'Luna Walker', null, 1696, null, 577689639);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2006, null, 'Diego Moore', null, 1698, null, 558699771);
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmail, cmobile)
values (2010, null, 'Alexis Hall', null, 1699, null, 541105192);
commit;
prompt 1066 records loaded
prompt Loading APPOINTMENT...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-08-2026', 'dd-mm-yyyy'), 49621, 69880, 685);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-06-2027', 'dd-mm-yyyy'), 19338, 44135, 745);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 61435, 15343, 914);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-08-2027', 'dd-mm-yyyy'), 53332, 18401, 504);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-02-2027', 'dd-mm-yyyy'), 81399, 10002, 562);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-01-2026', 'dd-mm-yyyy'), 76595, 37345, 136);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-01-2029', 'dd-mm-yyyy'), 59487, 74091, 736);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-08-2029', 'dd-mm-yyyy'), 18422, 71959, 713);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-04-2027', 'dd-mm-yyyy'), 93665, 51524, 562);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2024', 'dd-mm-yyyy'), 36944, 55149, 717);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-10-2026', 'dd-mm-yyyy'), 62424, 10013, 946);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-08-2027', 'dd-mm-yyyy'), 91818, 80830, 647);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-12-2027', 'dd-mm-yyyy'), 32922, 76380, 201);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-03-2028', 'dd-mm-yyyy'), 37512, 10002, 647);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-07-2029', 'dd-mm-yyyy'), 24947, 50112, 660);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-04-2027', 'dd-mm-yyyy'), 84937, 12082, 389);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-12-2024', 'dd-mm-yyyy'), 31448, 56476, 314);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-01-2028', 'dd-mm-yyyy'), 16195, 52769, 654);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-02-2029', 'dd-mm-yyyy'), 39257, 69468, 890);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-04-2026', 'dd-mm-yyyy'), 46594, 10007, 930);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-12-2026', 'dd-mm-yyyy'), 17698, 96640, 20007);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-02-2025', 'dd-mm-yyyy'), 43552, 69221, 488);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-01-2024', 'dd-mm-yyyy'), 66745, 64076, 468);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-11-2025', 'dd-mm-yyyy'), 82439, 83782, 324);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-05-2025', 'dd-mm-yyyy'), 45949, 26135, 885);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-04-2024', 'dd-mm-yyyy'), 14235, 80248, 624);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-10-2025', 'dd-mm-yyyy'), 46981, 49355, 20008);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-06-2025', 'dd-mm-yyyy'), 36499, 32397, 941);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-08-2024', 'dd-mm-yyyy'), 79234, 10011, 743);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-03-2028', 'dd-mm-yyyy'), 39953, 99681, 391);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-06-2028', 'dd-mm-yyyy'), 97666, 72479, 975);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-12-2027', 'dd-mm-yyyy'), 37495, 35535, 584);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-10-2029', 'dd-mm-yyyy'), 26699, 22236, 653);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-04-2025', 'dd-mm-yyyy'), 47288, 10009, 899);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-05-2027', 'dd-mm-yyyy'), 83316, 13261, 829);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-06-2028', 'dd-mm-yyyy'), 49699, 39663, 327);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-06-2024', 'dd-mm-yyyy'), 39876, 10001, 20001);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-07-2024', 'dd-mm-yyyy'), 59788, 79374, 930);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-07-2025', 'dd-mm-yyyy'), 57917, 10006, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-07-2026', 'dd-mm-yyyy'), 57987, 10007, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-07-2027', 'dd-mm-yyyy'), 36965, 66193, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-07-2025', 'dd-mm-yyyy'), 30093, 95541, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99860, 43931, 727);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99861, 43931, 727);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99862, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99863, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-07-2024', 'dd-mm-yyyy'), 59693, 39663, 130);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-07-2027', 'dd-mm-yyyy'), 59991, 39663, 119);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 84989, 39663, 20009);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99864, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99865, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99866, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99867, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99868, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99869, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99870, 38187, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-09-2027', 'dd-mm-yyyy'), 85315, 99769, 897);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 51477, 89337, 371);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-11-2025', 'dd-mm-yyyy'), 92754, 39306, 588);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-05-2028', 'dd-mm-yyyy'), 24385, 51524, 809);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-09-2029', 'dd-mm-yyyy'), 17326, 38187, 374);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-04-2026', 'dd-mm-yyyy'), 39425, 86842, 669);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 26926, 10004, 518);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-12-2026', 'dd-mm-yyyy'), 17642, 72820, 842);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-10-2028', 'dd-mm-yyyy'), 98965, 48188, 653);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-04-2025', 'dd-mm-yyyy'), 57934, 98364, 941);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-09-2024', 'dd-mm-yyyy'), 28113, 10004, 727);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-02-2029', 'dd-mm-yyyy'), 77442, 41224, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-03-2027', 'dd-mm-yyyy'), 43637, 84940, 662);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-05-2026', 'dd-mm-yyyy'), 76744, 90716, 833);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-01-2029', 'dd-mm-yyyy'), 65772, 15357, 828);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-03-2029', 'dd-mm-yyyy'), 37345, 17595, 747);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 36749, 87909, 144);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-12-2028', 'dd-mm-yyyy'), 34262, 69468, 153);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-04-2026', 'dd-mm-yyyy'), 44782, 87909, 219);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-05-2028', 'dd-mm-yyyy'), 63768, 84092, 760);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-07-2026', 'dd-mm-yyyy'), 83776, 68229, 577);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-12-2026', 'dd-mm-yyyy'), 11395, 61546, 901);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-09-2029', 'dd-mm-yyyy'), 53751, 49666, 903);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-09-2028', 'dd-mm-yyyy'), 37748, 62435, 208);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-06-2027', 'dd-mm-yyyy'), 69154, 15746, 328);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-06-2027', 'dd-mm-yyyy'), 66449, 13227, 812);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-08-2026', 'dd-mm-yyyy'), 41656, 10005, 201);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-01-2027', 'dd-mm-yyyy'), 66771, 86483, 871);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-06-2027', 'dd-mm-yyyy'), 11626, 98364, 609);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-03-2026', 'dd-mm-yyyy'), 52874, 89337, 648);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-04-2026', 'dd-mm-yyyy'), 54365, 26135, 674);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-01-2027', 'dd-mm-yyyy'), 54965, 28053, 208);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-03-2024', 'dd-mm-yyyy'), 32867, 54635, 399);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-10-2025', 'dd-mm-yyyy'), 84952, 45674, 470);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-07-2029', 'dd-mm-yyyy'), 42733, 74548, 162);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-05-2027', 'dd-mm-yyyy'), 78212, 79859, 618);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-12-2024', 'dd-mm-yyyy'), 18621, 10014, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-10-2029', 'dd-mm-yyyy'), 27341, 68062, 783);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-05-2029', 'dd-mm-yyyy'), 13927, 84092, 109);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-04-2027', 'dd-mm-yyyy'), 61472, 63961, 984);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-01-2029', 'dd-mm-yyyy'), 78759, 52116, 743);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-07-2024', 'dd-mm-yyyy'), 28593, 27715, 553);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-04-2028', 'dd-mm-yyyy'), 65252, 63284, 799);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-04-2027', 'dd-mm-yyyy'), 28734, 25578, 705);
commit;
prompt 100 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-08-2027', 'dd-mm-yyyy'), 86376, 63284, 513);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-02-2027', 'dd-mm-yyyy'), 91955, 12082, 715);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-11-2026', 'dd-mm-yyyy'), 37772, 92442, 567);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-03-2028', 'dd-mm-yyyy'), 37638, 35130, 218);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-07-2027', 'dd-mm-yyyy'), 98235, 83782, 110);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-08-2025', 'dd-mm-yyyy'), 42728, 31151, 842);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-06-2029', 'dd-mm-yyyy'), 69782, 39663, 221);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-03-2026', 'dd-mm-yyyy'), 44833, 10001, 408);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-07-2027', 'dd-mm-yyyy'), 82615, 44156, 689);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-11-2026', 'dd-mm-yyyy'), 26331, 24656, 778);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-03-2026', 'dd-mm-yyyy'), 38616, 43931, 660);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-11-2029', 'dd-mm-yyyy'), 82256, 41224, 502);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-04-2024', 'dd-mm-yyyy'), 73638, 46150, 309);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-08-2026', 'dd-mm-yyyy'), 53981, 55269, 633);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-03-2029', 'dd-mm-yyyy'), 36928, 18525, 552);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 39837, 17595, 975);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-03-2024', 'dd-mm-yyyy'), 78657, 68229, 698);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-05-2027', 'dd-mm-yyyy'), 44265, 19936, 747);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-05-2024', 'dd-mm-yyyy'), 79322, 52769, 307);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-11-2027', 'dd-mm-yyyy'), 41561, 10004, 832);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-09-2025', 'dd-mm-yyyy'), 55791, 21996, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-07-2026', 'dd-mm-yyyy'), 68462, 31947, 984);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-05-2025', 'dd-mm-yyyy'), 78169, 21570, 262);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-12-2025', 'dd-mm-yyyy'), 65466, 89337, 250);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-10-2024', 'dd-mm-yyyy'), 59588, 67810, 324);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-04-2028', 'dd-mm-yyyy'), 51446, 37415, 556);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-10-2025', 'dd-mm-yyyy'), 14242, 64076, 562);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-06-2025', 'dd-mm-yyyy'), 86627, 61696, 652);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-07-2027', 'dd-mm-yyyy'), 61521, 84092, 292);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-10-2025', 'dd-mm-yyyy'), 19776, 10652, 698);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-01-2029', 'dd-mm-yyyy'), 34362, 89337, 134);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-03-2027', 'dd-mm-yyyy'), 73524, 26135, 879);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-11-2025', 'dd-mm-yyyy'), 14115, 10004, 584);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-12-2024', 'dd-mm-yyyy'), 31496, 43915, 328);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('14-06-2024', 'dd-mm-yyyy'), 49211, 41224, 743);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-02-2027', 'dd-mm-yyyy'), 89217, 87909, 309);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-04-2027', 'dd-mm-yyyy'), 97122, 80248, 144);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-07-2026', 'dd-mm-yyyy'), 72942, 64760, 471);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-01-2029', 'dd-mm-yyyy'), 42978, 50906, 117);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-11-2027', 'dd-mm-yyyy'), 26256, 61435, 242);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-05-2025', 'dd-mm-yyyy'), 99138, 61546, 726);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-02-2026', 'dd-mm-yyyy'), 48557, 25578, 585);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-09-2027', 'dd-mm-yyyy'), 89616, 80830, 569);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-01-2027', 'dd-mm-yyyy'), 58911, 79374, 610);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-08-2029', 'dd-mm-yyyy'), 67992, 51672, 978);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-03-2026', 'dd-mm-yyyy'), 31948, 99939, 379);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-05-2027', 'dd-mm-yyyy'), 13184, 63284, 433);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-01-2029', 'dd-mm-yyyy'), 54111, 15343, 556);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-01-2029', 'dd-mm-yyyy'), 79599, 50112, 412);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-01-2024', 'dd-mm-yyyy'), 12617, 95320, 902);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-08-2026', 'dd-mm-yyyy'), 93739, 99681, 759);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-12-2026', 'dd-mm-yyyy'), 49174, 54635, 568);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-11-2028', 'dd-mm-yyyy'), 64847, 21996, 152);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-10-2029', 'dd-mm-yyyy'), 13358, 38296, 751);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-12-2027', 'dd-mm-yyyy'), 32614, 68549, 586);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-12-2026', 'dd-mm-yyyy'), 94727, 21996, 471);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-11-2025', 'dd-mm-yyyy'), 59883, 10652, 338);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-03-2026', 'dd-mm-yyyy'), 52254, 86842, 230);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-03-2026', 'dd-mm-yyyy'), 59864, 76380, 150);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-03-2026', 'dd-mm-yyyy'), 38929, 10007, 910);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-03-2029', 'dd-mm-yyyy'), 84576, 68229, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-03-2028', 'dd-mm-yyyy'), 83531, 88571, 816);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-06-2027', 'dd-mm-yyyy'), 84988, 66193, 119);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-07-2027', 'dd-mm-yyyy'), 33732, 61546, 349);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-06-2024', 'dd-mm-yyyy'), 95217, 43915, 495);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-07-2025', 'dd-mm-yyyy'), 25556, 69296, 351);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-01-2025', 'dd-mm-yyyy'), 27367, 11630, 599);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-03-2026', 'dd-mm-yyyy'), 62316, 56476, 889);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-03-2026', 'dd-mm-yyyy'), 21575, 53998, 778);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-04-2029', 'dd-mm-yyyy'), 54755, 33532, 20005);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-01-2027', 'dd-mm-yyyy'), 19548, 63284, 262);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-09-2027', 'dd-mm-yyyy'), 44623, 84092, 131);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-06-2028', 'dd-mm-yyyy'), 56368, 87909, 351);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-05-2027', 'dd-mm-yyyy'), 45389, 56476, 714);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-12-2026', 'dd-mm-yyyy'), 94296, 47507, 597);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-03-2029', 'dd-mm-yyyy'), 53498, 57567, 468);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-07-2027', 'dd-mm-yyyy'), 45686, 12082, 218);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-03-2026', 'dd-mm-yyyy'), 45835, 43702, 392);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-06-2028', 'dd-mm-yyyy'), 52137, 96750, 835);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-10-2024', 'dd-mm-yyyy'), 46912, 18401, 874);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-06-2024', 'dd-mm-yyyy'), 52596, 64185, 392);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-10-2027', 'dd-mm-yyyy'), 61651, 68062, 418);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-03-2026', 'dd-mm-yyyy'), 84117, 13794, 309);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-10-2026', 'dd-mm-yyyy'), 37869, 31845, 778);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-01-2024', 'dd-mm-yyyy'), 71125, 68062, 676);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-11-2027', 'dd-mm-yyyy'), 76411, 48188, 488);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-12-2026', 'dd-mm-yyyy'), 13121, 68229, 764);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-06-2024', 'dd-mm-yyyy'), 97618, 95541, 714);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-11-2028', 'dd-mm-yyyy'), 96463, 15746, 709);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-11-2029', 'dd-mm-yyyy'), 42735, 10013, 639);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-12-2025', 'dd-mm-yyyy'), 29134, 31151, 625);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-04-2027', 'dd-mm-yyyy'), 43913, 79819, 901);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-09-2025', 'dd-mm-yyyy'), 69466, 10014, 219);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-02-2025', 'dd-mm-yyyy'), 72115, 71959, 943);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-01-2028', 'dd-mm-yyyy'), 22834, 82443, 708);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-08-2029', 'dd-mm-yyyy'), 67984, 10014, 698);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-04-2026', 'dd-mm-yyyy'), 52292, 84940, 855);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-07-2028', 'dd-mm-yyyy'), 66364, 45148, 775);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-08-2028', 'dd-mm-yyyy'), 91912, 10017, 660);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-12-2025', 'dd-mm-yyyy'), 13831, 26135, 995);
commit;
prompt 200 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-03-2025', 'dd-mm-yyyy'), 69165, 10008, 709);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-12-2026', 'dd-mm-yyyy'), 17911, 63284, 798);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-04-2026', 'dd-mm-yyyy'), 34243, 69468, 362);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-03-2028', 'dd-mm-yyyy'), 76248, 33794, 878);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-02-2029', 'dd-mm-yyyy'), 25854, 51672, 934);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-09-2026', 'dd-mm-yyyy'), 38338, 84301, 199);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-06-2026', 'dd-mm-yyyy'), 68789, 32397, 991);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-03-2028', 'dd-mm-yyyy'), 51562, 12082, 151);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-04-2027', 'dd-mm-yyyy'), 43748, 44156, 418);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-12-2025', 'dd-mm-yyyy'), 62759, 56476, 769);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-06-2029', 'dd-mm-yyyy'), 92499, 69296, 322);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-07-2027', 'dd-mm-yyyy'), 74655, 12082, 274);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-01-2028', 'dd-mm-yyyy'), 72625, 26135, 874);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2026', 'dd-mm-yyyy'), 72766, 96640, 457);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-05-2024', 'dd-mm-yyyy'), 21632, 64185, 20008);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-09-2025', 'dd-mm-yyyy'), 82123, 64760, 715);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-04-2028', 'dd-mm-yyyy'), 87144, 63961, 839);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-05-2029', 'dd-mm-yyyy'), 41847, 96640, 700);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-03-2025', 'dd-mm-yyyy'), 84414, 21996, 569);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-01-2026', 'dd-mm-yyyy'), 48827, 80248, 774);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-02-2026', 'dd-mm-yyyy'), 81152, 52116, 884);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 52545, 27192, 943);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-11-2028', 'dd-mm-yyyy'), 28354, 74841, 336);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-09-2029', 'dd-mm-yyyy'), 31743, 41224, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-03-2026', 'dd-mm-yyyy'), 57217, 15963, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-08-2027', 'dd-mm-yyyy'), 49749, 35535, 610);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-11-2026', 'dd-mm-yyyy'), 24577, 89219, 293);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-09-2029', 'dd-mm-yyyy'), 65711, 11630, 848);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-02-2028', 'dd-mm-yyyy'), 36544, 10005, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-07-2024', 'dd-mm-yyyy'), 38161, 50112, 567);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-12-2029', 'dd-mm-yyyy'), 37782, 45148, 647);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-12-2028', 'dd-mm-yyyy'), 58994, 24608, 599);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-04-2026', 'dd-mm-yyyy'), 55163, 86842, 20005);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-12-2024', 'dd-mm-yyyy'), 19487, 68062, 743);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('14-04-2025', 'dd-mm-yyyy'), 17373, 63036, 877);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-01-2028', 'dd-mm-yyyy'), 66593, 91368, 181);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-01-2028', 'dd-mm-yyyy'), 24984, 69880, 556);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-01-2024', 'dd-mm-yyyy'), 31688, 64760, 901);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-02-2025', 'dd-mm-yyyy'), 42917, 72820, 20003);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-07-2025', 'dd-mm-yyyy'), 45659, 10652, 20002);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-06-2029', 'dd-mm-yyyy'), 88298, 81894, 281);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-09-2026', 'dd-mm-yyyy'), 13713, 99681, 717);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 21367, 51672, 219);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-11-2029', 'dd-mm-yyyy'), 83564, 43702, 469);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-08-2027', 'dd-mm-yyyy'), 92316, 76380, 833);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-11-2029', 'dd-mm-yyyy'), 53947, 95541, 459);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-07-2025', 'dd-mm-yyyy'), 71381, 87909, 872);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('14-03-2029', 'dd-mm-yyyy'), 96657, 33794, 448);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-03-2026', 'dd-mm-yyyy'), 47365, 35535, 328);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-02-2028', 'dd-mm-yyyy'), 24399, 64076, 328);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-08-2024', 'dd-mm-yyyy'), 34639, 10002, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-08-2027', 'dd-mm-yyyy'), 12567, 10009, 828);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-11-2029', 'dd-mm-yyyy'), 29966, 68549, 820);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-12-2025', 'dd-mm-yyyy'), 71127, 88571, 409);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-07-2025', 'dd-mm-yyyy'), 66549, 37004, 777);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-02-2027', 'dd-mm-yyyy'), 56515, 50112, 473);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-03-2026', 'dd-mm-yyyy'), 53336, 10012, 129);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-09-2025', 'dd-mm-yyyy'), 88626, 27379, 569);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-05-2024', 'dd-mm-yyyy'), 31554, 91539, 513);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-07-2025', 'dd-mm-yyyy'), 37223, 32568, 562);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-11-2029', 'dd-mm-yyyy'), 93742, 61546, 437);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-11-2026', 'dd-mm-yyyy'), 73721, 35535, 838);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-10-2025', 'dd-mm-yyyy'), 53587, 37004, 220);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-10-2029', 'dd-mm-yyyy'), 44887, 25922, 293);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2025', 'dd-mm-yyyy'), 68242, 39663, 856);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-06-2024', 'dd-mm-yyyy'), 24676, 99939, 584);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-07-2028', 'dd-mm-yyyy'), 16719, 82443, 332);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-07-2024', 'dd-mm-yyyy'), 11912, 54635, 207);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-07-2028', 'dd-mm-yyyy'), 14715, 64185, 709);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-01-2027', 'dd-mm-yyyy'), 62834, 70748, 877);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-04-2028', 'dd-mm-yyyy'), 22473, 68229, 559);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-08-2027', 'dd-mm-yyyy'), 99385, 11630, 543);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-04-2024', 'dd-mm-yyyy'), 92587, 55149, 941);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-11-2028', 'dd-mm-yyyy'), 25798, 10008, 409);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-04-2027', 'dd-mm-yyyy'), 66527, 55149, 855);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-11-2024', 'dd-mm-yyyy'), 23284, 55149, 350);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-12-2028', 'dd-mm-yyyy'), 86555, 64185, 220);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-01-2028', 'dd-mm-yyyy'), 33634, 25922, 206);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-09-2028', 'dd-mm-yyyy'), 18374, 34609, 776);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-10-2029', 'dd-mm-yyyy'), 81684, 31151, 556);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-11-2029', 'dd-mm-yyyy'), 71253, 69880, 152);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-08-2026', 'dd-mm-yyyy'), 35294, 35130, 379);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-09-2024', 'dd-mm-yyyy'), 65753, 24608, 885);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-08-2029', 'dd-mm-yyyy'), 45349, 51524, 799);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-11-2026', 'dd-mm-yyyy'), 68537, 79374, 855);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-05-2024', 'dd-mm-yyyy'), 99859, 19365, 799);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-02-2026', 'dd-mm-yyyy'), 48474, 63761, 362);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-10-2027', 'dd-mm-yyyy'), 29118, 13794, 764);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-11-2026', 'dd-mm-yyyy'), 94999, 21996, 890);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 36345, 31696, 303);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-09-2026', 'dd-mm-yyyy'), 85326, 25922, 392);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-03-2025', 'dd-mm-yyyy'), 25893, 84301, 759);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-05-2025', 'dd-mm-yyyy'), 12777, 54635, 20003);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('14-09-2029', 'dd-mm-yyyy'), 36381, 10006, 293);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-09-2024', 'dd-mm-yyyy'), 23487, 22236, 984);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-01-2025', 'dd-mm-yyyy'), 79857, 51672, 140);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-03-2027', 'dd-mm-yyyy'), 34432, 10012, 104);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-08-2027', 'dd-mm-yyyy'), 85761, 34941, 362);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-02-2025', 'dd-mm-yyyy'), 82511, 46150, 690);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-12-2029', 'dd-mm-yyyy'), 48971, 90668, 980);
commit;
prompt 300 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-05-2023', 'dd-mm-yyyy'), 30001, 10001, 20001);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-05-2023', 'dd-mm-yyyy'), 30002, 10006, 20002);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-05-2023', 'dd-mm-yyyy'), 30003, 10006, 20003);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-05-2023', 'dd-mm-yyyy'), 30004, 10001, 20004);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-05-2023', 'dd-mm-yyyy'), 30005, 10005, 20005);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-05-2023', 'dd-mm-yyyy'), 30006, 10006, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-03-2028', 'dd-mm-yyyy'), 71834, 19936, 501);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-12-2026', 'dd-mm-yyyy'), 25165, 57567, 829);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-07-2025', 'dd-mm-yyyy'), 39772, 76380, 434);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-04-2025', 'dd-mm-yyyy'), 73199, 79819, 783);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-08-2025', 'dd-mm-yyyy'), 96566, 79374, 601);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-05-2028', 'dd-mm-yyyy'), 44578, 10002, 736);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-09-2028', 'dd-mm-yyyy'), 38457, 74548, 803);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-06-2026', 'dd-mm-yyyy'), 35792, 54635, 178);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-06-2029', 'dd-mm-yyyy'), 29532, 10652, 475);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-10-2029', 'dd-mm-yyyy'), 54399, 63961, 799);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-09-2025', 'dd-mm-yyyy'), 31716, 10009, 874);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-11-2028', 'dd-mm-yyyy'), 22848, 27379, 567);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-11-2026', 'dd-mm-yyyy'), 62227, 63036, 513);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-02-2027', 'dd-mm-yyyy'), 97354, 21570, 736);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-07-2026', 'dd-mm-yyyy'), 37916, 51524, 903);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-09-2025', 'dd-mm-yyyy'), 64388, 86483, 302);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('27-05-2029', 'dd-mm-yyyy'), 74732, 11630, 391);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-11-2025', 'dd-mm-yyyy'), 24137, 27192, 941);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-09-2029', 'dd-mm-yyyy'), 39616, 31845, 633);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-12-2025', 'dd-mm-yyyy'), 17979, 99769, 552);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-10-2025', 'dd-mm-yyyy'), 99822, 61696, 198);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-07-2029', 'dd-mm-yyyy'), 16437, 10013, 839);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-11-2028', 'dd-mm-yyyy'), 66153, 86483, 778);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-07-2024', 'dd-mm-yyyy'), 96149, 10007, 259);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-07-2029', 'dd-mm-yyyy'), 55657, 39306, 250);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-06-2027', 'dd-mm-yyyy'), 55127, 69468, 568);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-06-2024', 'dd-mm-yyyy'), 43974, 84092, 800);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-03-2026', 'dd-mm-yyyy'), 35517, 22236, 259);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 26182, 10014, 293);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-09-2024', 'dd-mm-yyyy'), 65183, 96750, 890);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-07-2029', 'dd-mm-yyyy'), 86786, 21570, 309);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-07-2027', 'dd-mm-yyyy'), 18689, 48188, 168);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-01-2027', 'dd-mm-yyyy'), 32565, 45148, 314);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-05-2024', 'dd-mm-yyyy'), 96369, 43931, 839);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-05-2028', 'dd-mm-yyyy'), 33315, 15963, 150);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-11-2028', 'dd-mm-yyyy'), 41673, 54635, 446);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-12-2027', 'dd-mm-yyyy'), 36919, 64076, 674);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-03-2027', 'dd-mm-yyyy'), 82921, 48188, 914);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-10-2029', 'dd-mm-yyyy'), 19137, 18525, 633);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-07-2028', 'dd-mm-yyyy'), 87984, 88571, 371);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-07-2026', 'dd-mm-yyyy'), 97935, 98364, 104);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-11-2025', 'dd-mm-yyyy'), 34968, 21570, 683);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-08-2025', 'dd-mm-yyyy'), 43457, 10003, 356);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-08-2028', 'dd-mm-yyyy'), 84957, 72820, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-05-2028', 'dd-mm-yyyy'), 82652, 10016, 542);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-12-2028', 'dd-mm-yyyy'), 15747, 49666, 292);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-05-2026', 'dd-mm-yyyy'), 71739, 68062, 242);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-01-2029', 'dd-mm-yyyy'), 45388, 15383, 488);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-02-2028', 'dd-mm-yyyy'), 58778, 88571, 349);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-11-2024', 'dd-mm-yyyy'), 59549, 99778, 820);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-08-2025', 'dd-mm-yyyy'), 78559, 43702, 564);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-08-2027', 'dd-mm-yyyy'), 55324, 86483, 374);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('24-01-2027', 'dd-mm-yyyy'), 71465, 51672, 201);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-10-2029', 'dd-mm-yyyy'), 98797, 11630, 377);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-07-2029', 'dd-mm-yyyy'), 37461, 81284, 805);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-12-2025', 'dd-mm-yyyy'), 32826, 44135, 356);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('23-06-2027', 'dd-mm-yyyy'), 31819, 39663, 20008);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-09-2027', 'dd-mm-yyyy'), 96672, 10003, 593);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('14-05-2027', 'dd-mm-yyyy'), 41915, 67810, 20001);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-08-2029', 'dd-mm-yyyy'), 49689, 20080, 799);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-05-2026', 'dd-mm-yyyy'), 73262, 25991, 314);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-07-2024', 'dd-mm-yyyy'), 36165, 66193, 20006);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-01-2027', 'dd-mm-yyyy'), 59117, 10005, 399);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-10-2029', 'dd-mm-yyyy'), 35487, 21570, 104);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-09-2027', 'dd-mm-yyyy'), 17687, 99939, 568);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-02-2024', 'dd-mm-yyyy'), 11426, 74841, 266);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-06-2025', 'dd-mm-yyyy'), 98428, 25922, 448);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-10-2027', 'dd-mm-yyyy'), 83194, 31696, 198);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-04-2024', 'dd-mm-yyyy'), 29724, 86483, 755);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-11-2027', 'dd-mm-yyyy'), 44426, 79374, 399);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-03-2026', 'dd-mm-yyyy'), 59923, 91368, 20009);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-07-2028', 'dd-mm-yyyy'), 21759, 11630, 989);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-07-2027', 'dd-mm-yyyy'), 51688, 33794, 303);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-06-2029', 'dd-mm-yyyy'), 71895, 99769, 572);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-10-2027', 'dd-mm-yyyy'), 96628, 91368, 543);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-11-2028', 'dd-mm-yyyy'), 55427, 98364, 399);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-01-2026', 'dd-mm-yyyy'), 56328, 18802, 708);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('06-12-2025', 'dd-mm-yyyy'), 64612, 33532, 654);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('26-08-2029', 'dd-mm-yyyy'), 62629, 37415, 350);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-06-2029', 'dd-mm-yyyy'), 31299, 10008, 777);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('01-01-2027', 'dd-mm-yyyy'), 96736, 39663, 994);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('12-07-2024', 'dd-mm-yyyy'), 88645, 64076, 412);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-12-2025', 'dd-mm-yyyy'), 42873, 70748, 408);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-12-2028', 'dd-mm-yyyy'), 26335, 24656, 686);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-08-2026', 'dd-mm-yyyy'), 57292, 39663, 559);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-03-2024', 'dd-mm-yyyy'), 57853, 40041, 387);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-10-2029', 'dd-mm-yyyy'), 35784, 57567, 839);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-09-2029', 'dd-mm-yyyy'), 17117, 21570, 274);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-10-2027', 'dd-mm-yyyy'), 61135, 38187, 785);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-01-2027', 'dd-mm-yyyy'), 56388, 10007, 725);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-12-2026', 'dd-mm-yyyy'), 24777, 15383, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-01-2025', 'dd-mm-yyyy'), 85669, 64185, 328);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-02-2026', 'dd-mm-yyyy'), 38729, 47507, 195);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-07-2028', 'dd-mm-yyyy'), 37647, 25578, 446);
commit;
prompt 400 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-08-2029', 'dd-mm-yyyy'), 59736, 25578, 559);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-02-2029', 'dd-mm-yyyy'), 19974, 62435, 195);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-06-2029', 'dd-mm-yyyy'), 93442, 50112, 204);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-06-2027', 'dd-mm-yyyy'), 13944, 33794, 774);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-12-2027', 'dd-mm-yyyy'), 53274, 15343, 213);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('03-11-2029', 'dd-mm-yyyy'), 97579, 81284, 391);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('11-07-2028', 'dd-mm-yyyy'), 89358, 72820, 349);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-11-2026', 'dd-mm-yyyy'), 38952, 12082, 543);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('02-04-2026', 'dd-mm-yyyy'), 78281, 61546, 698);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-03-2026', 'dd-mm-yyyy'), 76832, 91539, 980);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('05-05-2028', 'dd-mm-yyyy'), 98548, 61435, 501);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('10-11-2024', 'dd-mm-yyyy'), 16511, 55546, 618);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-11-2026', 'dd-mm-yyyy'), 98371, 15383, 586);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-02-2024', 'dd-mm-yyyy'), 97927, 81894, 553);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-07-2025', 'dd-mm-yyyy'), 52192, 20080, 314);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-02-2026', 'dd-mm-yyyy'), 44344, 99939, 373);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-01-2024', 'dd-mm-yyyy'), 25675, 10017, 152);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 39472, 69468, 639);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('15-10-2026', 'dd-mm-yyyy'), 69358, 51524, 336);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('13-04-2024', 'dd-mm-yyyy'), 74361, 96640, 481);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-08-2027', 'dd-mm-yyyy'), 63995, 48188, 616);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('17-04-2028', 'dd-mm-yyyy'), 85644, 99939, 408);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('16-05-2024', 'dd-mm-yyyy'), 11416, 22236, 833);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('18-11-2025', 'dd-mm-yyyy'), 44484, 27379, 855);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-06-2027', 'dd-mm-yyyy'), 65632, 15383, 885);
commit;
prompt 425 records loaded
prompt Loading ROOM...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (1, 62, 1, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (2, 21, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (3, 55, 0, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (4, 63, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (5, 63, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (6, 66, 1, to_date('20-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (7, 69, 1, to_date('03-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (8, 64, 1, to_date('08-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (9, 42, 1, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (10, 66, 0, to_date('30-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (11, 59, 1, to_date('07-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (12, 70, 1, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (13, 57, 1, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (14, 27, 1, to_date('10-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (15, 36, 0, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (16, 48, 1, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (17, 27, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (18, 22, 1, to_date('13-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (19, 54, 1, to_date('16-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (20, 68, 0, to_date('02-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (21, 62, 1, to_date('12-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (22, 34, 0, to_date('22-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (23, 67, 0, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (24, 57, 0, to_date('17-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (25, 26, 1, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (26, 29, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (27, 40, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (28, 29, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (29, 48, 1, to_date('05-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (30, 40, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (31, 68, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (32, 32, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (33, 36, 1, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (34, 57, 0, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (35, 23, 1, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (36, 63, 0, to_date('08-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (37, 67, 1, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (38, 45, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (39, 23, 1, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (40, 28, 0, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (41, 23, 1, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (42, 24, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (43, 63, 1, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (44, 37, 0, to_date('18-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (45, 38, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (46, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (47, 66, 0, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (48, 50, 0, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (49, 59, 1, to_date('20-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (50, 20, 0, to_date('17-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (51, 43, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (52, 68, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (53, 60, 1, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (54, 30, 0, to_date('14-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (55, 24, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (56, 61, 1, to_date('06-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (57, 54, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (58, 52, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (59, 28, 0, to_date('16-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (60, 23, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (61, 45, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (62, 44, 0, to_date('16-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (63, 62, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (64, 61, 0, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (65, 47, 0, to_date('18-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (66, 37, 0, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (67, 45, 1, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (68, 44, 0, to_date('27-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (69, 36, 1, to_date('14-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (70, 39, 1, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (71, 24, 1, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (72, 24, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (73, 49, 1, to_date('24-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (74, 43, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (75, 38, 0, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (76, 24, 0, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (77, 56, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (78, 37, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (79, 32, 1, to_date('25-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (80, 55, 0, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (81, 41, 1, to_date('10-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (82, 57, 1, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (83, 61, 0, to_date('23-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (84, 69, 0, to_date('04-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (85, 69, 0, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (86, 45, 1, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (87, 41, 0, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (88, 59, 1, to_date('05-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (89, 68, 1, to_date('11-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (90, 56, 0, to_date('15-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (91, 36, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (92, 55, 1, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (93, 44, 1, to_date('02-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (94, 23, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (95, 35, 0, to_date('18-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (96, 30, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (97, 43, 1, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (98, 61, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (99, 56, 1, to_date('30-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (100, 67, 1, to_date('21-06-2021', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (101, 22, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (102, 50, 0, to_date('18-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (103, 47, 1, to_date('06-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (104, 53, 0, to_date('30-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (105, 56, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (106, 34, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (107, 47, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (108, 41, 1, to_date('02-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (109, 35, 0, to_date('21-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (110, 27, 1, to_date('08-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (111, 54, 0, to_date('19-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (112, 20, 0, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (113, 26, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (114, 67, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (115, 25, 1, to_date('03-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (116, 35, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (117, 23, 1, to_date('28-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (118, 30, 1, to_date('05-09-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (119, 57, 0, to_date('29-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (120, 68, 1, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (121, 69, 1, to_date('05-10-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (122, 56, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (123, 70, 0, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (124, 49, 0, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (125, 70, 1, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (126, 33, 1, to_date('08-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (127, 33, 1, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (128, 21, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (129, 55, 1, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (130, 27, 1, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (131, 31, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (132, 26, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (133, 20, 0, to_date('15-04-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (134, 48, 1, to_date('25-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (135, 20, 0, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (136, 67, 0, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (137, 33, 0, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (138, 39, 1, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (139, 65, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (140, 59, 0, to_date('18-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (141, 22, 1, to_date('20-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (142, 31, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (143, 24, 0, to_date('26-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (144, 23, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (145, 48, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (146, 38, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (147, 44, 1, to_date('16-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (148, 70, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (149, 54, 1, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (150, 49, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (151, 62, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (152, 47, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (153, 65, 0, to_date('17-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (154, 46, 0, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (155, 49, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (156, 46, 0, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (157, 66, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (158, 23, 1, to_date('25-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (159, 23, 0, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (160, 36, 0, to_date('20-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (161, 45, 1, to_date('19-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (162, 40, 0, to_date('16-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (163, 35, 0, to_date('01-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (164, 54, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (165, 69, 1, to_date('05-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (166, 70, 0, to_date('08-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (167, 22, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (168, 64, 1, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (169, 30, 0, to_date('16-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (170, 30, 1, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (171, 31, 0, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (172, 58, 1, to_date('28-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (173, 34, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (174, 28, 0, to_date('03-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (175, 64, 1, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (176, 67, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (177, 22, 1, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (178, 68, 0, to_date('03-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (179, 64, 1, to_date('26-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (180, 57, 0, to_date('31-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (181, 33, 1, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (182, 35, 0, to_date('07-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (183, 48, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (184, 58, 1, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (185, 70, 0, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (186, 48, 1, to_date('21-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (187, 58, 0, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (188, 42, 1, to_date('14-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (189, 44, 1, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (190, 32, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (191, 53, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (192, 49, 1, to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (193, 58, 0, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (194, 57, 1, to_date('21-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (195, 20, 0, to_date('17-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (196, 67, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (197, 51, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (198, 68, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (199, 33, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (200, 39, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (201, 54, 0, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (202, 55, 1, to_date('05-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (203, 48, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (204, 27, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (205, 55, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (206, 42, 1, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (207, 67, 0, to_date('27-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (208, 22, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (209, 48, 0, to_date('09-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (210, 49, 0, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (211, 67, 1, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (212, 69, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (213, 30, 0, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (214, 37, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (215, 59, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (216, 59, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (217, 56, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (218, 64, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (219, 42, 1, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (220, 47, 0, to_date('25-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (221, 38, 0, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (222, 40, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (223, 40, 0, to_date('11-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (224, 59, 0, to_date('11-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (225, 20, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (226, 40, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (227, 26, 0, to_date('12-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (228, 66, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (229, 46, 1, to_date('13-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (230, 63, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (231, 34, 1, to_date('01-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (232, 39, 0, to_date('23-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (233, 66, 1, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (234, 42, 1, to_date('19-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (235, 32, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (236, 70, 0, to_date('04-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (237, 41, 0, to_date('26-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (238, 37, 0, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (239, 55, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (240, 39, 0, to_date('18-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (241, 55, 0, to_date('25-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (242, 36, 0, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (243, 25, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (244, 61, 1, to_date('01-10-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (245, 58, 1, to_date('24-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (246, 70, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (247, 36, 1, to_date('08-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (248, 54, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (249, 53, 1, to_date('28-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (250, 22, 0, to_date('23-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (251, 62, 1, to_date('01-08-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (252, 27, 1, to_date('22-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (253, 51, 1, to_date('22-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (254, 21, 0, to_date('03-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (255, 33, 1, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (256, 34, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (257, 41, 0, to_date('21-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (258, 56, 1, to_date('31-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (259, 33, 0, to_date('08-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (260, 36, 1, to_date('10-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (261, 25, 1, to_date('28-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (262, 38, 1, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (263, 55, 0, to_date('25-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (264, 54, 1, to_date('28-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (265, 35, 1, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (266, 50, 1, to_date('05-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (267, 61, 1, to_date('27-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (268, 44, 0, to_date('22-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (269, 66, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (270, 68, 0, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (271, 25, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (272, 34, 0, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (273, 54, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (274, 33, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (275, 52, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (276, 25, 0, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (277, 23, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (278, 64, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (279, 25, 0, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (280, 46, 0, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (281, 45, 1, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (282, 36, 1, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (283, 40, 0, to_date('04-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (284, 63, 1, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (285, 54, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (286, 37, 0, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (287, 54, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (288, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (289, 61, 0, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (290, 22, 0, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (291, 57, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (292, 50, 0, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (293, 58, 0, to_date('13-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (294, 49, 1, to_date('16-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (295, 27, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (296, 22, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (297, 40, 1, to_date('22-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (298, 64, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (299, 27, 1, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (300, 22, 1, to_date('29-12-2023', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (301, 23, 0, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (302, 31, 0, to_date('09-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (303, 51, 1, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (304, 50, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (305, 40, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (306, 49, 1, to_date('13-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (307, 42, 0, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (308, 40, 0, to_date('02-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (309, 29, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (310, 67, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (311, 20, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (312, 36, 0, to_date('16-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (313, 25, 0, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (314, 40, 1, to_date('12-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (315, 63, 1, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (316, 41, 0, to_date('13-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (317, 38, 0, to_date('04-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (318, 44, 0, to_date('21-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (319, 51, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (320, 30, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (321, 51, 1, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (322, 64, 0, to_date('22-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (323, 54, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (324, 65, 1, to_date('17-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (325, 54, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (326, 61, 1, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (327, 36, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (328, 32, 0, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (329, 63, 0, to_date('01-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (330, 49, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (331, 37, 0, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (332, 36, 0, to_date('04-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (333, 28, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (334, 67, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (335, 30, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (336, 51, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (337, 40, 1, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (338, 47, 1, to_date('16-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (339, 34, 1, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (340, 65, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (341, 22, 0, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (342, 45, 0, to_date('11-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (343, 68, 0, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (344, 23, 0, to_date('04-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (345, 43, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (346, 53, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (347, 31, 0, to_date('03-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (348, 61, 0, to_date('11-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (349, 64, 1, to_date('22-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (350, 38, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (351, 49, 1, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (352, 55, 1, to_date('19-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (353, 67, 0, to_date('12-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (354, 58, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (355, 66, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (356, 22, 1, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (357, 20, 1, to_date('09-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (358, 61, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (359, 63, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (360, 69, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (361, 46, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (362, 49, 1, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (363, 59, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (364, 26, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (365, 63, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (366, 52, 1, to_date('31-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (367, 38, 0, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (368, 24, 1, to_date('30-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (369, 62, 0, to_date('19-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (370, 43, 1, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (371, 55, 1, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (372, 47, 0, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (373, 42, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (374, 27, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (375, 63, 0, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (376, 53, 1, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (377, 57, 0, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (378, 70, 1, to_date('13-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (379, 56, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (380, 32, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (381, 62, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (382, 57, 0, to_date('05-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (383, 45, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (384, 54, 1, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (385, 46, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (386, 36, 1, to_date('07-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (387, 26, 1, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (388, 49, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (389, 58, 1, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (390, 48, 1, to_date('13-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (391, 43, 0, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (392, 63, 0, to_date('25-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (393, 35, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (394, 37, 0, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (395, 23, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (396, 44, 1, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (397, 29, 0, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (398, 60, 1, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (399, 23, 0, to_date('20-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (400, 29, 1, to_date('04-03-2021', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading TEACHER...
insert into TEACHER (sid, hourly_salary, bonus)
values (1, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (2, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (4, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (5, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (6, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (7, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (8, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (9, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (10, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (12, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (13, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (14, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (15, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (16, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (17, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (18, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (19, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (21, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (22, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (23, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (24, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (25, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (26, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (28, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (29, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (30, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (31, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (32, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (33, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (35, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (36, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (37, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (38, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (39, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (40, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (41, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (42, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (44, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (45, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (46, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (47, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (48, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (49, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (50, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (51, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (53, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (54, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (55, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (56, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (57, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (58, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (59, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (61, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (62, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (63, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (64, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (65, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (66, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (68, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (69, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (70, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (71, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (72, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (73, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (74, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (76, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (77, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (78, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (79, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (80, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (81, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (82, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (84, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (85, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (86, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (87, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (88, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (89, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (90, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (91, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (93, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (94, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (95, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (96, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (97, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (98, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (99, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (101, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (102, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (103, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (104, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (105, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (106, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (107, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (109, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (110, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (111, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (112, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (113, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (114, 35, 0);
commit;
prompt 100 records committed...
insert into TEACHER (sid, hourly_salary, bonus)
values (115, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (117, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (118, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (119, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (120, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (121, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (122, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (123, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (124, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (126, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (127, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (128, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (129, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (130, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (131, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (132, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (133, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (134, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (136, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (137, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (138, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (139, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (140, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (141, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (142, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (143, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (145, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (146, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (147, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (148, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (149, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (150, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (151, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (153, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (154, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (155, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (156, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (157, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (158, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (159, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (161, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (162, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (163, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (164, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (165, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (166, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (167, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (168, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (169, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (170, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (171, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (173, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (174, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (175, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (176, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (177, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (178, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (179, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (180, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (182, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (183, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (184, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (185, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (186, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (187, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (189, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (190, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (191, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (192, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (193, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (194, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (195, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (197, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (198, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (199, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (200, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (201, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (202, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (203, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (205, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (206, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (207, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (208, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (209, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (210, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (211, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (212, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (214, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (215, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (216, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (217, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (218, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (220, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (221, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (222, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (223, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (224, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (225, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (227, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (228, 35, 0);
commit;
prompt 200 records committed...
insert into TEACHER (sid, hourly_salary, bonus)
values (229, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (230, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (231, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (232, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (236, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (237, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (238, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (239, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (240, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (242, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (243, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (244, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (245, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (246, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (247, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (248, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (249, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (251, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (252, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (253, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (254, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (255, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (256, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (257, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (258, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (260, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (261, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (262, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (263, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (264, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (265, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (266, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (268, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (269, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (270, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (271, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (272, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (274, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (275, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (277, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (279, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (280, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (281, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (282, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (284, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (285, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (287, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (289, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (290, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (291, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (293, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (294, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (295, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (297, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (299, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (301, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (302, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (303, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (304, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (306, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (307, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (308, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (311, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (312, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (313, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (314, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (316, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (317, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (320, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (321, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (322, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (323, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (326, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (327, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (328, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (329, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (330, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (331, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (332, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (333, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (334, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (335, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (336, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (337, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (338, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (339, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (340, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (341, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (342, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (343, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (344, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (345, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (346, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (347, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (348, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (349, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (350, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (351, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (352, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (353, 35, 0);
commit;
prompt 300 records committed...
insert into TEACHER (sid, hourly_salary, bonus)
values (354, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (355, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (356, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (357, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (358, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (359, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (360, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (361, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (362, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (363, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (364, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (365, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (366, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (367, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (368, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (369, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (370, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (371, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (372, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (373, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (374, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (375, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (376, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (377, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (378, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (379, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (380, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (381, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (382, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (383, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (384, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (385, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (386, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (387, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (388, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (389, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (390, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (391, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (392, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (393, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (394, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (395, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (396, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (397, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (398, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (399, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (400, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (273, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (278, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (283, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (288, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (292, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (296, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (300, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (305, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (309, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (315, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (319, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (3, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (11, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (20, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (27, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (34, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (43, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (52, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (60, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (67, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (75, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (83, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (92, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (100, 38.5, 50);
insert into TEACHER (sid, hourly_salary, bonus)
values (108, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (116, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (125, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (135, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (144, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (152, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (160, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (172, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (181, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (188, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (196, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (204, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (213, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (219, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (226, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (234, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (241, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (250, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (259, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (267, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (276, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (286, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (298, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (310, 35, 0);
insert into TEACHER (sid, hourly_salary, bonus)
values (318, 35, 0);
commit;
prompt 396 records loaded
prompt Loading CLASS_...
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (1, 2, 177, 238);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (2, 2, 207, 153);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (3, 1, 387, 137);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (4, 11, 315, 112);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (5, 11, 27, 224);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (6, 1, 272, 5);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (7, 12, 384, 106);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (8, 11, 353, 2);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (9, 2, 397, 157);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (10, 10, 103, 243);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (11, 12, 146, 85);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (12, 8, 63, 288);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (13, 9, 249, 228);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (14, 11, 269, 185);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (15, 1, 160, 263);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (16, 11, 181, 77);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (17, 12, 234, 316);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (18, 2, 5, 140);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (19, 8, 381, 3);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (20, 8, 364, 152);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (21, 1, 309, 104);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (22, 5, 365, 270);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (23, 5, 328, 259);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (24, 10, 242, 22);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (25, 5, 162, 302);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (26, 1, 212, 342);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (27, 7, 120, 64);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (28, 3, 89, 239);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (29, 12, 208, 58);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (30, 4, 144, 20);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (31, 10, 338, 347);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (32, 6, 290, 207);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (33, 2, 80, 26);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (34, 2, 383, 397);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (35, 4, 288, 60);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (36, 2, 39, 354);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (37, 5, 60, 310);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (38, 11, 302, 55);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (39, 10, 348, 341);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (40, 4, 237, 23);
commit;
prompt 40 records loaded
prompt Loading SUBJECT...
insert into SUBJECT (subject_id, subject_name, mandatory)
values (1, ' Anatomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (2, ' Astronomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (3, ' Algebra', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (4, ' Band/Orchestra', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (5, ' Ballet', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (6, ' Bible Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (7, ' Biology', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (8, ' Business and Entrepreneurship', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (9, ' Calculus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (10, ' Career Exploration', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (11, ' Chemistry', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (12, ' Chorus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (13, ' Civics and Government', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (14, ' Computer Science', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (15, ' Creative Writing', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (16, ' Dance', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (17, ' Digital Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (18, ' Drama', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (19, ' Economics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (20, ' Engineering Design', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (21, ' English Language Arts', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (22, ' Environmental Science', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (23, ' Film Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (24, ' Foreign Language (French)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (25, ' Foreign Language (German)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (26, ' Foreign Language (Hebrew)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (27, ' Foreign Language (Spanish)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (28, ' Geography', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (29, ' Health', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (30, ' Jewish History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (31, ' Jewish Philosophy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (32, ' Latin', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (33, ' Literature', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (34, ' Mathematics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (35, ' Media Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (36, ' Modern Art', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (37, ' Music', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (38, ' Mythology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (39, ' Physical Education', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (40, ' Physics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (41, ' Psychology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (42, ' Robotics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (43, ' Science (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (44, ' Social Studies (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (45, ' Sociology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (46, ' Speech and Debate', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (47, ' Sports', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (48, ' Statistics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (49, ' Talmud', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (50, ' United States History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (51, ' Visual Arts', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (52, ' World History', 1);
commit;
prompt 52 records loaded
prompt Loading LESSON...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (1, 3, 9, 18, 12, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (2, 3, 10, 1, 340, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (3, 1, 11, 36, 150, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (4, 4, 12, 14, 85, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (5, 4, 10, 6, 124, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (6, 5, 9, 16, 263, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (7, 3, 8, 2, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (8, 5, 10, 2, 269, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (9, 4, 9, 18, 185, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (10, 6, 11, 10, 172, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (11, 3, 14, 17, 160, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (12, 5, 14, 1, 232, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (13, 1, 14, 22, 125, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (14, 3, 13, 6, 5, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (15, 1, 12, 5, 147, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (16, 5, 9, 8, 135, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (17, 5, 16, 10, 129, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (18, 3, 8, 34, 283, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (19, 1, 10, 27, 157, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (20, 6, 11, 16, 148, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (21, 3, 12, 28, 6, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (22, 4, 8, 15, 243, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (24, 2, 10, 13, 226, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (25, 2, 13, 26, 390, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (26, 5, 11, 35, 163, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (27, 2, 11, 1, 176, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (28, 1, 16, 4, 149, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (29, 4, 14, 15, 388, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (30, 2, 8, 26, 65, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (31, 6, 13, 4, 70, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (32, 6, 11, 24, 305, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (33, 2, 13, 9, 88, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (34, 2, 15, 21, 344, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (35, 3, 9, 4, 41, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (36, 4, 10, 36, 184, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (37, 6, 12, 29, 90, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (38, 2, 11, 3, 318, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (39, 6, 11, 18, 211, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (40, 1, 14, 39, 48, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (41, 6, 12, 6, 304, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (42, 1, 12, 31, 39, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (43, 3, 15, 36, 270, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (44, 4, 15, 4, 150, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (45, 4, 12, 30, 342, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (46, 1, 15, 40, 360, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (47, 2, 8, 19, 27, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (48, 1, 12, 26, 374, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (49, 6, 8, 35, 367, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (50, 1, 14, 18, 5, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (51, 3, 13, 11, 316, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (52, 6, 14, 20, 45, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (53, 1, 10, 34, 131, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (54, 2, 10, 14, 34, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (55, 1, 13, 40, 50, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (56, 2, 12, 35, 210, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (57, 1, 8, 20, 52, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (58, 1, 12, 15, 237, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (59, 3, 10, 4, 128, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (60, 2, 8, 24, 331, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (61, 2, 13, 18, 268, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (62, 3, 8, 30, 76, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (63, 1, 14, 33, 180, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (64, 1, 13, 1, 270, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (65, 3, 8, 23, 117, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (66, 3, 15, 7, 81, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (67, 4, 14, 36, 238, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (68, 1, 16, 2, 138, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (69, 6, 13, 19, 183, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (71, 5, 14, 17, 343, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (72, 5, 13, 1, 266, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (73, 6, 13, 22, 354, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (74, 2, 12, 36, 370, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (75, 3, 8, 10, 369, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (76, 2, 11, 20, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (77, 1, 10, 12, 238, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (78, 4, 13, 19, 41, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (79, 6, 10, 33, 61, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (80, 1, 10, 2, 338, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (81, 1, 14, 32, 372, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (82, 1, 13, 26, 396, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (83, 6, 13, 17, 179, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (84, 6, 14, 27, 102, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (85, 1, 11, 14, 376, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (86, 1, 8, 10, 256, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (87, 2, 11, 12, 151, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (88, 2, 11, 21, 317, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (89, 5, 13, 6, 300, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (90, 5, 12, 30, 94, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (91, 6, 13, 37, 116, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (92, 3, 16, 35, 355, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (93, 3, 16, 1, 287, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (94, 3, 13, 7, 400, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (96, 3, 13, 22, 7, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (97, 3, 16, 37, 222, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (98, 5, 16, 36, 260, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (99, 5, 9, 10, 6, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (100, 5, 8, 25, 284, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (101, 1, 10, 19, 296, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (102, 5, 13, 13, 169, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (103, 4, 11, 1, 273, 37);
commit;
prompt 100 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (104, 5, 15, 18, 92, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (105, 3, 10, 31, 327, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (106, 4, 15, 2, 390, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (107, 5, 10, 26, 170, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (108, 4, 9, 34, 358, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (109, 5, 10, 29, 190, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (110, 1, 12, 32, 287, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (111, 1, 10, 4, 263, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (112, 6, 9, 34, 72, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (113, 5, 13, 32, 193, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (114, 3, 11, 9, 144, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (115, 3, 14, 36, 253, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (116, 4, 13, 8, 11, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (117, 6, 12, 22, 352, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (118, 3, 11, 26, 286, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (119, 1, 14, 3, 17, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (120, 6, 13, 34, 20, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (121, 6, 14, 13, 392, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (122, 1, 11, 39, 36, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (123, 3, 10, 10, 191, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (124, 6, 13, 28, 213, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (125, 2, 11, 27, 37, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (126, 5, 10, 23, 304, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (127, 2, 16, 35, 296, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (128, 6, 14, 28, 165, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (129, 3, 10, 18, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (130, 6, 8, 32, 150, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (131, 6, 12, 10, 95, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (132, 3, 15, 32, 267, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (134, 1, 8, 17, 118, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (135, 6, 11, 6, 378, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (137, 5, 16, 29, 148, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (138, 1, 12, 10, 80, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (139, 6, 14, 37, 266, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (140, 2, 10, 27, 33, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (141, 3, 11, 1, 7, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (142, 4, 14, 21, 193, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (143, 5, 16, 25, 231, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (145, 4, 13, 34, 14, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (146, 1, 11, 1, 94, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (147, 4, 9, 26, 126, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (148, 6, 11, 31, 368, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (149, 5, 10, 30, 100, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (150, 3, 9, 34, 357, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (151, 6, 13, 16, 13, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (152, 5, 14, 24, 398, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (153, 5, 13, 24, 318, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (154, 1, 12, 24, 321, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (155, 5, 11, 19, 88, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (156, 3, 13, 36, 204, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (157, 1, 12, 17, 143, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (158, 1, 9, 36, 111, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (159, 1, 14, 14, 97, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (160, 1, 14, 29, 400, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (161, 5, 13, 21, 54, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (162, 5, 14, 39, 373, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (163, 4, 14, 7, 333, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (164, 6, 14, 14, 237, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (165, 6, 14, 25, 323, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (166, 5, 14, 22, 147, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (167, 3, 11, 24, 16, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (168, 1, 9, 9, 82, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (169, 3, 9, 1, 71, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (172, 3, 8, 19, 54, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (173, 4, 8, 30, 129, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (174, 2, 11, 23, 307, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (175, 3, 14, 5, 344, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (176, 4, 12, 38, 71, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (177, 6, 10, 10, 147, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (178, 4, 8, 38, 47, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (179, 4, 15, 29, 69, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (180, 4, 16, 24, 277, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (181, 1, 12, 13, 94, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (182, 5, 16, 1, 360, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (183, 4, 14, 12, 290, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (184, 6, 15, 30, 136, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (185, 1, 14, 8, 398, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (186, 6, 15, 29, 366, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (187, 2, 11, 26, 22, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (188, 4, 14, 8, 133, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (189, 4, 10, 32, 263, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (190, 5, 10, 20, 398, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (192, 5, 9, 24, 174, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (193, 4, 16, 32, 208, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (194, 5, 15, 27, 109, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (196, 1, 14, 15, 50, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (197, 3, 15, 40, 184, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (198, 2, 15, 3, 72, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (199, 4, 11, 3, 326, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (200, 6, 9, 40, 216, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (201, 3, 13, 5, 285, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (202, 4, 14, 30, 176, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (203, 4, 14, 23, 121, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (204, 6, 10, 28, 81, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (205, 3, 12, 39, 30, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (206, 1, 9, 7, 239, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (207, 1, 13, 28, 161, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (208, 2, 14, 25, 258, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (209, 2, 13, 22, 237, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (212, 5, 10, 11, 147, 51);
commit;
prompt 200 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (213, 3, 11, 27, 39, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (214, 3, 16, 8, 239, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (216, 6, 13, 18, 326, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (217, 5, 8, 9, 86, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (218, 4, 16, 4, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (219, 2, 16, 17, 290, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (221, 4, 14, 37, 283, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (223, 4, 9, 20, 128, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (224, 2, 8, 39, 355, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (225, 6, 13, 9, 91, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (226, 1, 9, 8, 293, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (227, 5, 10, 14, 381, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (229, 1, 8, 3, 359, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (230, 1, 10, 5, 169, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (231, 1, 10, 6, 229, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (232, 3, 15, 1, 299, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (235, 3, 9, 33, 273, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (236, 5, 9, 31, 77, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (237, 4, 14, 11, 211, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (239, 6, 9, 33, 23, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (240, 5, 8, 22, 64, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (241, 3, 16, 23, 60, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (242, 1, 8, 13, 351, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (243, 3, 12, 31, 249, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (244, 2, 8, 36, 94, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (245, 4, 9, 7, 70, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (246, 6, 11, 7, 397, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (247, 4, 15, 9, 384, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (248, 1, 13, 4, 66, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (249, 1, 8, 19, 365, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (250, 5, 13, 40, 378, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (251, 4, 10, 5, 69, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (252, 2, 16, 28, 154, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (253, 5, 9, 13, 322, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (254, 2, 12, 16, 12, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (255, 1, 8, 27, 41, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (257, 4, 13, 40, 243, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (258, 2, 11, 35, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (259, 3, 12, 32, 55, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (262, 5, 14, 29, 366, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (263, 4, 11, 12, 27, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (264, 6, 10, 19, 334, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (265, 6, 13, 6, 383, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (266, 6, 8, 2, 30, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (267, 2, 15, 25, 306, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (268, 1, 11, 2, 312, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (269, 4, 11, 29, 208, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (270, 4, 15, 22, 59, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (271, 1, 13, 16, 253, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (272, 6, 12, 26, 165, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (273, 6, 8, 15, 322, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (274, 6, 11, 1, 286, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (275, 6, 14, 23, 32, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (276, 2, 16, 1, 340, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (277, 2, 12, 10, 355, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (278, 2, 8, 25, 93, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (279, 1, 8, 29, 206, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (280, 5, 14, 10, 59, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (281, 5, 14, 21, 149, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (282, 1, 13, 12, 156, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (283, 2, 13, 28, 218, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (285, 1, 8, 6, 329, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (286, 6, 10, 39, 177, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (287, 2, 14, 36, 176, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (288, 3, 15, 15, 42, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (290, 2, 12, 7, 131, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (291, 1, 10, 20, 8, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (292, 1, 14, 31, 305, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (293, 4, 15, 39, 291, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (295, 5, 12, 37, 203, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (296, 4, 16, 33, 326, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (297, 2, 16, 31, 298, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (298, 4, 15, 38, 254, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (299, 4, 13, 1, 19, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (300, 2, 16, 33, 164, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (301, 3, 14, 38, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (302, 2, 8, 18, 43, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (303, 6, 11, 29, 353, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (304, 6, 15, 24, 246, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (305, 3, 10, 12, 262, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (306, 4, 13, 13, 191, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (307, 2, 13, 13, 177, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (308, 5, 11, 25, 13, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (310, 5, 12, 1, 241, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (313, 1, 9, 29, 285, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (314, 3, 14, 18, 118, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (315, 4, 15, 30, 78, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (316, 2, 16, 5, 42, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (317, 4, 10, 39, 88, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (318, 3, 15, 14, 100, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (319, 5, 9, 15, 326, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (320, 6, 10, 9, 315, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (321, 6, 15, 27, 178, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (322, 6, 10, 25, 37, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (323, 4, 13, 16, 275, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (324, 4, 14, 16, 179, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (325, 3, 10, 5, 244, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (326, 1, 14, 25, 267, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (327, 2, 8, 10, 222, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (328, 4, 10, 27, 290, 28);
commit;
prompt 300 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (330, 2, 10, 4, 316, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (331, 5, 13, 27, 93, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (332, 4, 8, 16, 116, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (333, 5, 16, 3, 140, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (334, 3, 11, 3, 33, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (335, 5, 10, 17, 209, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (336, 5, 12, 31, 197, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (337, 6, 12, 39, 50, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (338, 5, 12, 24, 251, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (339, 4, 12, 33, 359, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (340, 3, 15, 5, 348, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (341, 2, 11, 31, 110, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (342, 3, 10, 26, 211, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (343, 5, 11, 23, 167, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (344, 1, 16, 18, 55, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (345, 4, 11, 7, 350, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (347, 6, 8, 20, 269, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (349, 5, 11, 38, 8, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (350, 3, 12, 19, 41, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (351, 6, 8, 29, 267, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (352, 1, 16, 10, 130, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (353, 6, 9, 13, 100, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (356, 4, 9, 2, 372, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (357, 3, 13, 28, 105, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (359, 5, 11, 17, 129, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (362, 1, 16, 25, 289, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (363, 2, 11, 36, 90, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (364, 2, 14, 38, 156, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (365, 6, 14, 29, 300, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (367, 4, 14, 24, 87, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (368, 2, 9, 9, 114, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (369, 2, 13, 11, 385, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (370, 1, 12, 8, 3, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (371, 6, 10, 37, 136, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (372, 1, 13, 18, 285, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (373, 5, 8, 6, 71, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (374, 2, 11, 28, 232, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (375, 2, 9, 28, 198, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (376, 3, 10, 27, 296, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (378, 4, 9, 36, 136, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (379, 2, 12, 33, 295, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (380, 5, 15, 23, 58, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (383, 3, 13, 39, 156, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (384, 4, 10, 25, 186, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (386, 4, 9, 19, 28, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (387, 1, 12, 12, 101, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (388, 2, 10, 26, 178, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (390, 3, 15, 9, 341, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (391, 5, 15, 20, 150, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (395, 4, 13, 25, 53, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (398, 4, 8, 14, 239, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (399, 5, 12, 26, 234, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (400, 2, 15, 30, 298, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (401, 6, 13, 14, 100, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (402, 6, 10, 24, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (404, 5, 16, 38, 72, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (406, 2, 15, 4, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (409, 1, 11, 7, 232, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (410, 2, 9, 1, 53, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (411, 5, 8, 11, 139, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (412, 2, 10, 36, 212, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (414, 6, 8, 19, 298, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (415, 4, 11, 19, 130, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (416, 4, 9, 8, 189, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (418, 3, 16, 12, 102, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (419, 1, 8, 36, 337, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (420, 2, 14, 20, 197, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (422, 5, 11, 12, 366, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (423, 3, 14, 16, 295, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (424, 6, 13, 27, 239, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (425, 1, 15, 25, 332, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (426, 6, 13, 32, 52, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (427, 6, 12, 18, 107, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (428, 6, 10, 29, 389, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (432, 1, 12, 33, 60, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (433, 4, 11, 23, 159, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (434, 4, 12, 15, 322, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (435, 1, 15, 15, 110, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (436, 2, 16, 16, 62, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (437, 2, 11, 16, 20, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (439, 1, 9, 25, 247, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (440, 2, 12, 9, 111, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (442, 3, 13, 21, 278, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (443, 3, 15, 38, 266, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (444, 4, 16, 18, 167, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (446, 6, 10, 36, 15, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (448, 2, 10, 23, 51, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (449, 3, 11, 10, 73, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (450, 1, 15, 8, 350, 30);
commit;
prompt 389 records loaded
prompt Loading MATERIAL...
insert into MATERIAL (mid, mname, amount)
values (82918, 'Anestethic Rpll', 173);
insert into MATERIAL (mid, mname, amount)
values (56184, 'Septanest Rpgcz', 62);
insert into MATERIAL (mid, mname, amount)
values (35844, 'Pills Rtwfzs', 147);
insert into MATERIAL (mid, mname, amount)
values (77986, 'Pills Demlia', 44);
insert into MATERIAL (mid, mname, amount)
values (49367, 'Pills Zigtyc', 239);
insert into MATERIAL (mid, mname, amount)
values (79534, 'Septanest Lomwy', 198);
insert into MATERIAL (mid, mname, amount)
values (49899, 'Anestethic Wwxj', 86);
insert into MATERIAL (mid, mname, amount)
values (97659, 'Septanest Zrxxf', 161);
insert into MATERIAL (mid, mname, amount)
values (11871, 'Antibiotic Nuel', 102);
insert into MATERIAL (mid, mname, amount)
values (56868, 'Septanest Ktypa', 211);
insert into MATERIAL (mid, mname, amount)
values (14964, 'Anestethic Myez', 50);
insert into MATERIAL (mid, mname, amount)
values (83983, 'Antibiotic Pcod', 47);
insert into MATERIAL (mid, mname, amount)
values (27259, 'Pills Dddlcb', 182);
insert into MATERIAL (mid, mname, amount)
values (88489, 'Septanest Kajjb', 192);
insert into MATERIAL (mid, mname, amount)
values (22944, 'Pills Svxahc', 162);
insert into MATERIAL (mid, mname, amount)
values (48298, 'Antibiotic Qwdn', 243);
insert into MATERIAL (mid, mname, amount)
values (33518, 'Septanest Oytrx', 172);
insert into MATERIAL (mid, mname, amount)
values (48693, 'Anestethic Tdto', 92);
insert into MATERIAL (mid, mname, amount)
values (92543, 'Pills Xbaqsj', 97);
insert into MATERIAL (mid, mname, amount)
values (28379, 'Anestethic Mbuw', 225);
insert into MATERIAL (mid, mname, amount)
values (97217, 'Pills Sfqmln', 153);
insert into MATERIAL (mid, mname, amount)
values (86223, 'Pills Ayvsog', 11);
insert into MATERIAL (mid, mname, amount)
values (53212, 'Septanest Qyqnt', 120);
insert into MATERIAL (mid, mname, amount)
values (36876, 'Antibiotic Oqex', 146);
insert into MATERIAL (mid, mname, amount)
values (25811, 'Antibiotic Kjsc', 141);
insert into MATERIAL (mid, mname, amount)
values (93566, 'Ointment Hsgzcb', 217);
insert into MATERIAL (mid, mname, amount)
values (44261, 'Ointment Bmotwx', 10);
insert into MATERIAL (mid, mname, amount)
values (64442, 'Ointment Wabyuf', 179);
insert into MATERIAL (mid, mname, amount)
values (26441, 'Anestethic Bqcr', 166);
insert into MATERIAL (mid, mname, amount)
values (55764, 'Ointment Aakmfl', 25);
insert into MATERIAL (mid, mname, amount)
values (44662, 'Ointment Itansw', 102);
insert into MATERIAL (mid, mname, amount)
values (83212, 'Pills Gxqwrt', 243);
insert into MATERIAL (mid, mname, amount)
values (56794, 'Ointment Qjgryy', 17);
insert into MATERIAL (mid, mname, amount)
values (51857, 'Anestethic Fhqu', 231);
insert into MATERIAL (mid, mname, amount)
values (18197, 'Anestethic Kcmt', 69);
insert into MATERIAL (mid, mname, amount)
values (76159, 'Anestethic Uuwy', 235);
insert into MATERIAL (mid, mname, amount)
values (22461, 'Septanest Qjwge', 143);
insert into MATERIAL (mid, mname, amount)
values (71339, 'Ointment Ggyvqx', 126);
insert into MATERIAL (mid, mname, amount)
values (59486, 'Pills Wjrfbr', 195);
insert into MATERIAL (mid, mname, amount)
values (74877, 'Ointment Cmcmhp', 120);
insert into MATERIAL (mid, mname, amount)
values (89574, 'Pills Rmiyre', 210);
insert into MATERIAL (mid, mname, amount)
values (31773, 'Septanest Hqvbn', 156);
insert into MATERIAL (mid, mname, amount)
values (72235, 'Septanest Tugsg', 206);
insert into MATERIAL (mid, mname, amount)
values (41858, 'Anestethic Qlly', 216);
insert into MATERIAL (mid, mname, amount)
values (24167, 'Pills Indtmy', 174);
insert into MATERIAL (mid, mname, amount)
values (52423, 'Pills Wtfbjj', 109);
insert into MATERIAL (mid, mname, amount)
values (44888, 'Antibiotic Itmt', 60);
insert into MATERIAL (mid, mname, amount)
values (29698, 'Septanest Lwjaw', 171);
insert into MATERIAL (mid, mname, amount)
values (78965, 'Pills Dmbycy', 14);
insert into MATERIAL (mid, mname, amount)
values (13198, 'Antibiotic Nyte', 42);
insert into MATERIAL (mid, mname, amount)
values (99962, 'Septanest Gxsre', 53);
insert into MATERIAL (mid, mname, amount)
values (67115, 'Anestethic Sqbm', 228);
insert into MATERIAL (mid, mname, amount)
values (92858, 'Pills Najkrx', 93);
insert into MATERIAL (mid, mname, amount)
values (68849, 'Septanest Nnlua', 196);
insert into MATERIAL (mid, mname, amount)
values (56873, 'Septanest Uqhjh', 19);
insert into MATERIAL (mid, mname, amount)
values (27386, 'Anestethic Tjjz', 204);
insert into MATERIAL (mid, mname, amount)
values (46679, 'Ointment Daiqef', 167);
insert into MATERIAL (mid, mname, amount)
values (44138, 'Anestethic Jqjq', 239);
insert into MATERIAL (mid, mname, amount)
values (49484, 'Antibiotic Sjbh', 191);
insert into MATERIAL (mid, mname, amount)
values (93137, 'Ointment Zqedwm', 161);
insert into MATERIAL (mid, mname, amount)
values (36133, 'Ointment Wcsipo', 143);
insert into MATERIAL (mid, mname, amount)
values (63236, 'Ointment Oujdht', 202);
insert into MATERIAL (mid, mname, amount)
values (15958, 'Anestethic Naha', 144);
insert into MATERIAL (mid, mname, amount)
values (79737, 'Anestethic Uogo', 60);
insert into MATERIAL (mid, mname, amount)
values (29122, 'Pills Fixbcp', 230);
insert into MATERIAL (mid, mname, amount)
values (75629, 'Pills Qnfrsr', 80);
insert into MATERIAL (mid, mname, amount)
values (63414, 'Septanest Lxgnf', 101);
insert into MATERIAL (mid, mname, amount)
values (39851, 'Septanest Vbald', 8);
insert into MATERIAL (mid, mname, amount)
values (86561, 'Antibiotic Hqdb', 206);
insert into MATERIAL (mid, mname, amount)
values (97875, 'Anestethic Khqg', 93);
insert into MATERIAL (mid, mname, amount)
values (24115, 'Antibiotic Wedk', 249);
insert into MATERIAL (mid, mname, amount)
values (25752, 'Anestethic Vhnh', 7);
insert into MATERIAL (mid, mname, amount)
values (64219, 'Pills Lftxqe', 60);
insert into MATERIAL (mid, mname, amount)
values (74929, 'Anestethic Mdjz', 190);
insert into MATERIAL (mid, mname, amount)
values (64317, 'Antibiotic Ejkf', 72);
insert into MATERIAL (mid, mname, amount)
values (63768, 'Anestethic Ruxu', 199);
insert into MATERIAL (mid, mname, amount)
values (24534, 'Septanest Efnsl', 128);
insert into MATERIAL (mid, mname, amount)
values (12999, 'Anestethic Tifg', 181);
insert into MATERIAL (mid, mname, amount)
values (41133, 'Septanest Ugxyy', 82);
insert into MATERIAL (mid, mname, amount)
values (98796, 'Ointment Dighqg', 138);
insert into MATERIAL (mid, mname, amount)
values (59841, 'Anestethic Uxou', 96);
insert into MATERIAL (mid, mname, amount)
values (32832, 'Antibiotic Toit', 191);
insert into MATERIAL (mid, mname, amount)
values (86758, 'Antibiotic Idwa', 59);
insert into MATERIAL (mid, mname, amount)
values (83186, 'Pills Ajrfks', 199);
insert into MATERIAL (mid, mname, amount)
values (84215, 'Antibiotic Bkfr', 107);
insert into MATERIAL (mid, mname, amount)
values (94698, 'Pills Etvpbc', 211);
insert into MATERIAL (mid, mname, amount)
values (63597, 'Pills Mlavlz', 226);
insert into MATERIAL (mid, mname, amount)
values (49529, 'Anestethic Cgji', 46);
insert into MATERIAL (mid, mname, amount)
values (89721, 'Anestethic Abxx', 233);
insert into MATERIAL (mid, mname, amount)
values (27219, 'Septanest Ajcyl', 99);
insert into MATERIAL (mid, mname, amount)
values (46665, 'Septanest Vphes', 243);
insert into MATERIAL (mid, mname, amount)
values (71862, 'Pills Ffhwfs', 125);
insert into MATERIAL (mid, mname, amount)
values (97128, 'Ointment Lwzyui', 167);
insert into MATERIAL (mid, mname, amount)
values (25522, 'Ointment Orvfil', 200);
insert into MATERIAL (mid, mname, amount)
values (76774, 'Pills Wtatpx', 3);
insert into MATERIAL (mid, mname, amount)
values (15869, 'Antibiotic Nvgj', 70);
insert into MATERIAL (mid, mname, amount)
values (23116, 'Ointment Yczfth', 56);
insert into MATERIAL (mid, mname, amount)
values (23628, 'Antibiotic Ynii', 50);
insert into MATERIAL (mid, mname, amount)
values (38771, 'Ointment Nyogrk', 123);
insert into MATERIAL (mid, mname, amount)
values (91329, 'Ointment Bzbycw', 207);
commit;
prompt 100 records committed...
insert into MATERIAL (mid, mname, amount)
values (15988, 'Anestethic Qlka', 9);
insert into MATERIAL (mid, mname, amount)
values (11127, 'Anestethic Eazf', 211);
insert into MATERIAL (mid, mname, amount)
values (53354, 'Antibiotic Taxj', 168);
insert into MATERIAL (mid, mname, amount)
values (68732, 'Antibiotic Abud', 184);
insert into MATERIAL (mid, mname, amount)
values (46333, 'Pills Qtzqne', 212);
insert into MATERIAL (mid, mname, amount)
values (36935, 'Antibiotic Mtho', 116);
insert into MATERIAL (mid, mname, amount)
values (75611, 'Antibiotic Ccqn', 14);
insert into MATERIAL (mid, mname, amount)
values (15484, 'Pills Kwtxwh', 133);
insert into MATERIAL (mid, mname, amount)
values (13657, 'Septanest Ndher', 193);
insert into MATERIAL (mid, mname, amount)
values (26927, 'Septanest Dkthy', 163);
insert into MATERIAL (mid, mname, amount)
values (36778, 'Ointment Yttrch', 46);
insert into MATERIAL (mid, mname, amount)
values (86938, 'Pills Ugdnqz', 243);
insert into MATERIAL (mid, mname, amount)
values (46122, 'Septanest Ybrhx', 238);
insert into MATERIAL (mid, mname, amount)
values (97441, 'Septanest Owlmu', 211);
insert into MATERIAL (mid, mname, amount)
values (68248, 'Septanest Eavhj', 212);
insert into MATERIAL (mid, mname, amount)
values (34377, 'Septanest Ngdzh', 60);
insert into MATERIAL (mid, mname, amount)
values (16475, 'Pills Onglod', 61);
insert into MATERIAL (mid, mname, amount)
values (26499, 'Anestethic Hcdn', 116);
insert into MATERIAL (mid, mname, amount)
values (48388, 'Ointment Wcvqrw', 224);
insert into MATERIAL (mid, mname, amount)
values (93786, 'Anestethic Eapy', 178);
insert into MATERIAL (mid, mname, amount)
values (86698, 'Antibiotic', 226);
insert into MATERIAL (mid, mname, amount)
values (14726, 'Thermometers', 37);
insert into MATERIAL (mid, mname, amount)
values (72115, 'Disinfectant', 59);
insert into MATERIAL (mid, mname, amount)
values (12570, 'Septanest', 83);
insert into MATERIAL (mid, mname, amount)
values (11654, 'Cotton Swabs', 120);
insert into MATERIAL (mid, mname, amount)
values (24208, 'Bandages', 136);
insert into MATERIAL (mid, mname, amount)
values (61185, 'Gauze', 167);
insert into MATERIAL (mid, mname, amount)
values (14470, 'Pills', 168);
insert into MATERIAL (mid, mname, amount)
values (70154, 'Gloves', 54);
insert into MATERIAL (mid, mname, amount)
values (99078, 'Anesthetic', 190);
insert into MATERIAL (mid, mname, amount)
values (73385, 'Syringes', 136);
insert into MATERIAL (mid, mname, amount)
values (16596, 'Pills', 69);
insert into MATERIAL (mid, mname, amount)
values (93815, 'Anestethic Ukof', 117);
insert into MATERIAL (mid, mname, amount)
values (47358, 'Ointment Ikjyfy', 176);
insert into MATERIAL (mid, mname, amount)
values (27189, 'Antibiotic Nzsg', 210);
insert into MATERIAL (mid, mname, amount)
values (53715, 'Septanest Llses', 222);
insert into MATERIAL (mid, mname, amount)
values (28735, 'Antibiotic Yidl', 99);
insert into MATERIAL (mid, mname, amount)
values (97524, 'Septanest Zbnsv', 118);
insert into MATERIAL (mid, mname, amount)
values (92666, 'Antibiotic Hyru', 196);
insert into MATERIAL (mid, mname, amount)
values (64876, 'Antibiotic Ximn', 140);
insert into MATERIAL (mid, mname, amount)
values (68545, 'Ointment Jpppkn', 207);
insert into MATERIAL (mid, mname, amount)
values (38529, 'Septanest Fluxb', 244);
insert into MATERIAL (mid, mname, amount)
values (81162, 'Ointment Uutppo', 63);
insert into MATERIAL (mid, mname, amount)
values (53257, 'Antibiotic Nycj', 4);
insert into MATERIAL (mid, mname, amount)
values (14131, 'Anestethic Qenv', 136);
insert into MATERIAL (mid, mname, amount)
values (93643, 'Anestethic Pqte', 98);
insert into MATERIAL (mid, mname, amount)
values (61271, 'Ointment Udfwoh', 41);
insert into MATERIAL (mid, mname, amount)
values (72479, 'Septanest Skzqm', 216);
insert into MATERIAL (mid, mname, amount)
values (32523, 'Pills Ysoxio', 248);
insert into MATERIAL (mid, mname, amount)
values (19776, 'Septanest Smxna', 59);
insert into MATERIAL (mid, mname, amount)
values (11997, 'Ointment Klsbvd', 88);
insert into MATERIAL (mid, mname, amount)
values (25633, 'Antibiotic Rvih', 90);
insert into MATERIAL (mid, mname, amount)
values (53999, 'Anestethic Qrti', 221);
insert into MATERIAL (mid, mname, amount)
values (61951, 'Septanest Kfvyg', 213);
insert into MATERIAL (mid, mname, amount)
values (81856, 'Ointment Qgwjjk', 7);
insert into MATERIAL (mid, mname, amount)
values (25392, 'Antibiotic Errn', 56);
insert into MATERIAL (mid, mname, amount)
values (11752, 'Septanest Gbfio', 142);
insert into MATERIAL (mid, mname, amount)
values (42637, 'Ointment Ppjadm', 153);
insert into MATERIAL (mid, mname, amount)
values (84617, 'Anestethic Prlj', 114);
insert into MATERIAL (mid, mname, amount)
values (43963, 'Pills Ifdohk', 118);
insert into MATERIAL (mid, mname, amount)
values (13655, 'Ointment Wjaaax', 89);
insert into MATERIAL (mid, mname, amount)
values (76277, 'Anestethic Vlyd', 169);
insert into MATERIAL (mid, mname, amount)
values (39168, 'Septanest Bfdcs', 236);
insert into MATERIAL (mid, mname, amount)
values (61695, 'Antibiotic Ufks', 50);
insert into MATERIAL (mid, mname, amount)
values (62838, 'Septanest Lzxau', 137);
insert into MATERIAL (mid, mname, amount)
values (96421, 'Anestethic Prca', 104);
insert into MATERIAL (mid, mname, amount)
values (75288, 'Ointment Irdnmr', 103);
insert into MATERIAL (mid, mname, amount)
values (13682, 'Anestethic Rgap', 144);
insert into MATERIAL (mid, mname, amount)
values (17776, 'Ointment Ddoald', 299);
insert into MATERIAL (mid, mname, amount)
values (66362, 'Ointment Tqyybg', 228);
insert into MATERIAL (mid, mname, amount)
values (49366, 'Antibiotic Ariz', 223);
insert into MATERIAL (mid, mname, amount)
values (84832, 'Pills Oynjzt', 127);
insert into MATERIAL (mid, mname, amount)
values (46698, 'Ointment Rogvzp', 113);
insert into MATERIAL (mid, mname, amount)
values (16683, 'Antibiotic Myuj', 12);
insert into MATERIAL (mid, mname, amount)
values (69235, 'Pills Hrzssu', 44);
insert into MATERIAL (mid, mname, amount)
values (51618, 'Septanest Vjaff', 186);
insert into MATERIAL (mid, mname, amount)
values (59168, 'Septanest Fmynx', 20);
insert into MATERIAL (mid, mname, amount)
values (15228, 'Antibiotic Qchd', 38);
insert into MATERIAL (mid, mname, amount)
values (14244, 'Ointment Btalqi', 98);
insert into MATERIAL (mid, mname, amount)
values (19857, 'Ointment Cfhsnu', 92);
insert into MATERIAL (mid, mname, amount)
values (22693, 'Septanest Xulkc', 195);
insert into MATERIAL (mid, mname, amount)
values (11844, 'Septanest Wvlrm', 59);
insert into MATERIAL (mid, mname, amount)
values (71452, 'Anestethic Wuyn', 234);
insert into MATERIAL (mid, mname, amount)
values (29554, 'Pills Hgmbsc', 230);
insert into MATERIAL (mid, mname, amount)
values (75587, 'Anestethic Fpih', 85);
insert into MATERIAL (mid, mname, amount)
values (14175, 'Septanest Huweg', 47);
insert into MATERIAL (mid, mname, amount)
values (12589, 'Pills Zebfva', 35);
insert into MATERIAL (mid, mname, amount)
values (95511, 'Pills Xojfck', 166);
insert into MATERIAL (mid, mname, amount)
values (12228, 'Antibiotic Gzer', 118);
insert into MATERIAL (mid, mname, amount)
values (58887, 'Ointment Quolsq', 146);
insert into MATERIAL (mid, mname, amount)
values (77556, 'Ointment Awggtn', 155);
insert into MATERIAL (mid, mname, amount)
values (69313, 'Pills Kjsmjo', 176);
insert into MATERIAL (mid, mname, amount)
values (21355, 'Anestethic Yvwy', 102);
insert into MATERIAL (mid, mname, amount)
values (75523, 'Antibiotic Uvna', 51);
insert into MATERIAL (mid, mname, amount)
values (36647, 'Ointment Xmaudd', 196);
insert into MATERIAL (mid, mname, amount)
values (82577, 'Ointment Fcvics', 61);
insert into MATERIAL (mid, mname, amount)
values (44524, 'Ointment Rwbpyv', 183);
insert into MATERIAL (mid, mname, amount)
values (57368, 'Antibiotic Qbzk', 8);
insert into MATERIAL (mid, mname, amount)
values (83128, 'Septanest Iyovq', 164);
insert into MATERIAL (mid, mname, amount)
values (66227, 'Antibiotic Ipls', 184);
commit;
prompt 200 records committed...
insert into MATERIAL (mid, mname, amount)
values (57861, 'Anestethic Atyu', 114);
insert into MATERIAL (mid, mname, amount)
values (34263, 'Anestethic Kjhd', 132);
insert into MATERIAL (mid, mname, amount)
values (52117, 'Antibiotic Earz', 94);
insert into MATERIAL (mid, mname, amount)
values (62511, 'Anestethic Lpxh', 192);
insert into MATERIAL (mid, mname, amount)
values (47254, 'Ointment Wrrpma', 226);
insert into MATERIAL (mid, mname, amount)
values (58322, 'Septanest Lmxzg', 147);
insert into MATERIAL (mid, mname, amount)
values (22956, 'Pills Qzlokv', 235);
insert into MATERIAL (mid, mname, amount)
values (18523, 'Ointment Xjygdr', 74);
insert into MATERIAL (mid, mname, amount)
values (51181, 'Anestethic Jazq', 33);
insert into MATERIAL (mid, mname, amount)
values (32666, 'Pills Irozgz', 184);
insert into MATERIAL (mid, mname, amount)
values (25813, 'Anestethic Kkfv', 221);
insert into MATERIAL (mid, mname, amount)
values (89432, 'Ointment Qenkyr', 101);
insert into MATERIAL (mid, mname, amount)
values (49631, 'Ointment Ndfbim', 55);
insert into MATERIAL (mid, mname, amount)
values (26412, 'Ointment Xqznvn', 201);
insert into MATERIAL (mid, mname, amount)
values (34865, 'Antibiotic Tdtw', 142);
insert into MATERIAL (mid, mname, amount)
values (24124, 'Pills Zjorvz', 3);
insert into MATERIAL (mid, mname, amount)
values (29411, 'Anestethic Wlnp', 29);
insert into MATERIAL (mid, mname, amount)
values (77646, 'Ointment Omrdjs', 231);
insert into MATERIAL (mid, mname, amount)
values (82665, 'Ointment Ovwqjm', 128);
insert into MATERIAL (mid, mname, amount)
values (81646, 'Antibiotic Pdls', 106);
insert into MATERIAL (mid, mname, amount)
values (54227, 'Ointment Dxmfcx', 107);
insert into MATERIAL (mid, mname, amount)
values (92714, 'Anestethic Gnvb', 7);
insert into MATERIAL (mid, mname, amount)
values (71723, 'Pills Klfnnf', 238);
insert into MATERIAL (mid, mname, amount)
values (54815, 'Anestethic Tqyt', 21);
insert into MATERIAL (mid, mname, amount)
values (88634, 'Pills Svvbwp', 18);
insert into MATERIAL (mid, mname, amount)
values (79344, 'Pills Mcucxa', 214);
insert into MATERIAL (mid, mname, amount)
values (42346, 'Antibiotic Mvyt', 150);
insert into MATERIAL (mid, mname, amount)
values (68343, 'Pills Byqoln', 68);
insert into MATERIAL (mid, mname, amount)
values (56126, 'Ointment Avboqi', 194);
insert into MATERIAL (mid, mname, amount)
values (53235, 'Anestethic Dlpo', 209);
insert into MATERIAL (mid, mname, amount)
values (57995, 'Anestethic Djcu', 220);
insert into MATERIAL (mid, mname, amount)
values (68496, 'Ointment Cosfiw', 144);
insert into MATERIAL (mid, mname, amount)
values (88294, 'Anestethic Xvyc', 241);
insert into MATERIAL (mid, mname, amount)
values (19246, 'Pills Qxsbfw', 84);
insert into MATERIAL (mid, mname, amount)
values (42668, 'Ointment Juyoms', 22);
insert into MATERIAL (mid, mname, amount)
values (51773, 'Anestethic Anju', 111);
insert into MATERIAL (mid, mname, amount)
values (83147, 'Pills Rgliei', 109);
insert into MATERIAL (mid, mname, amount)
values (29336, 'Septanest Iaaqm', 23);
insert into MATERIAL (mid, mname, amount)
values (18298, 'Septanest Blwpf', 52);
insert into MATERIAL (mid, mname, amount)
values (89394, 'Ointment Yakkre', 16);
insert into MATERIAL (mid, mname, amount)
values (78819, 'Antibiotic Axno', 221);
insert into MATERIAL (mid, mname, amount)
values (55438, 'Anestethic Kvzn', 214);
insert into MATERIAL (mid, mname, amount)
values (46422, 'Ointment Khmtdj', 99);
insert into MATERIAL (mid, mname, amount)
values (42395, 'Ointment Glnidn', 106);
insert into MATERIAL (mid, mname, amount)
values (59978, 'Ointment Beyglb', 58);
insert into MATERIAL (mid, mname, amount)
values (36313, 'Pills Vorqjq', 148);
insert into MATERIAL (mid, mname, amount)
values (48555, 'Anestethic Oycp', 88);
insert into MATERIAL (mid, mname, amount)
values (54715, 'Septanest Epclm', 84);
insert into MATERIAL (mid, mname, amount)
values (44141, 'Septanest Njuqc', 48);
insert into MATERIAL (mid, mname, amount)
values (27132, 'Pills Pfgykb', 180);
insert into MATERIAL (mid, mname, amount)
values (47428, 'Ointment Jdipcn', 12);
insert into MATERIAL (mid, mname, amount)
values (27995, 'Septanest Cjigm', 167);
insert into MATERIAL (mid, mname, amount)
values (99141, 'Pills Ndvoto', 59);
insert into MATERIAL (mid, mname, amount)
values (25128, 'Anestethic Wqwq', 232);
insert into MATERIAL (mid, mname, amount)
values (87588, 'Ointment Radkii', 61);
insert into MATERIAL (mid, mname, amount)
values (97963, 'Anestethic Unxi', 228);
insert into MATERIAL (mid, mname, amount)
values (59666, 'Septanest Dqumg', 122);
insert into MATERIAL (mid, mname, amount)
values (28318, 'Pills Lahrwv', 107);
insert into MATERIAL (mid, mname, amount)
values (64683, 'Anestethic Ngtq', 30);
insert into MATERIAL (mid, mname, amount)
values (94596, 'Ointment Pybbbs', 247);
insert into MATERIAL (mid, mname, amount)
values (22498, 'Anestethic Iabe', 70);
insert into MATERIAL (mid, mname, amount)
values (67121, 'Anestethic Zowp', 175);
insert into MATERIAL (mid, mname, amount)
values (29225, 'Antibiotic Ygyz', 4);
insert into MATERIAL (mid, mname, amount)
values (67598, 'Antibiotic Ckrp', 7);
insert into MATERIAL (mid, mname, amount)
values (61582, 'Pills Ulntgh', 100);
insert into MATERIAL (mid, mname, amount)
values (82444, 'Anestethic Snga', 250);
insert into MATERIAL (mid, mname, amount)
values (53126, 'Antibiotic Bhhc', 37);
insert into MATERIAL (mid, mname, amount)
values (63363, 'Antibiotic Psji', 100);
insert into MATERIAL (mid, mname, amount)
values (33316, 'Septanest Wvlys', 160);
insert into MATERIAL (mid, mname, amount)
values (63512, 'Septanest Nwrfp', 201);
insert into MATERIAL (mid, mname, amount)
values (19614, 'Anestethic Obvi', 76);
insert into MATERIAL (mid, mname, amount)
values (42862, 'Pills Sispeb', 232);
insert into MATERIAL (mid, mname, amount)
values (69521, 'Septanest Jvwsc', 24);
insert into MATERIAL (mid, mname, amount)
values (38921, 'Ointment Wbhppj', 229);
insert into MATERIAL (mid, mname, amount)
values (51927, 'Ointment Ikeukb', 149);
insert into MATERIAL (mid, mname, amount)
values (87956, 'Anestethic Dcrv', 133);
insert into MATERIAL (mid, mname, amount)
values (29738, 'Anestethic Vhvm', 150);
insert into MATERIAL (mid, mname, amount)
values (47597, 'Pills Ldyzcn', 99);
insert into MATERIAL (mid, mname, amount)
values (37596, 'Pills Zizmeu', 158);
insert into MATERIAL (mid, mname, amount)
values (97792, 'Pills Qzebbm', 232);
insert into MATERIAL (mid, mname, amount)
values (16331, 'Antibiotic Qnrr', 173);
insert into MATERIAL (mid, mname, amount)
values (88277, 'Anestethic Zfxg', 242);
insert into MATERIAL (mid, mname, amount)
values (41729, 'Pills Pmstzd', 119);
insert into MATERIAL (mid, mname, amount)
values (88563, 'Septanest Vvfwi', 3);
insert into MATERIAL (mid, mname, amount)
values (57612, 'Pills Tdfisa', 19);
insert into MATERIAL (mid, mname, amount)
values (92643, 'Pills Vbitqc', 179);
insert into MATERIAL (mid, mname, amount)
values (12353, 'Anestethic Vfmi', 212);
insert into MATERIAL (mid, mname, amount)
values (81575, 'Septanest Zzmgc', 243);
insert into MATERIAL (mid, mname, amount)
values (83229, 'Septanest Iquys', 88);
insert into MATERIAL (mid, mname, amount)
values (87251, 'Septanest Mktnj', 59);
insert into MATERIAL (mid, mname, amount)
values (17368, 'Antibiotic Qqui', 110);
insert into MATERIAL (mid, mname, amount)
values (71887, 'Antibiotic Llvm', 93);
insert into MATERIAL (mid, mname, amount)
values (61422, 'Antibiotic Vige', 52);
insert into MATERIAL (mid, mname, amount)
values (96936, 'Septanest Ujfze', 143);
insert into MATERIAL (mid, mname, amount)
values (98517, 'Antibiotic Kkkh', 43);
insert into MATERIAL (mid, mname, amount)
values (57726, 'Anestethic Yqux', 160);
insert into MATERIAL (mid, mname, amount)
values (78237, 'Septanest Uziez', 40);
insert into MATERIAL (mid, mname, amount)
values (64741, 'Pills Mfmyjw', 127);
insert into MATERIAL (mid, mname, amount)
values (86571, 'Antibiotic Larc', 210);
insert into MATERIAL (mid, mname, amount)
values (51142, 'Anestethic Qbnk', 187);
commit;
prompt 300 records committed...
insert into MATERIAL (mid, mname, amount)
values (13449, 'Ointment Fmctqu', 249);
insert into MATERIAL (mid, mname, amount)
values (96364, 'Anestethic Xsgu', 45);
insert into MATERIAL (mid, mname, amount)
values (74315, 'Pills Qjxgbd', 199);
insert into MATERIAL (mid, mname, amount)
values (32992, 'Septanest Ljztg', 5);
insert into MATERIAL (mid, mname, amount)
values (83936, 'Antibiotic Myjy', 5);
insert into MATERIAL (mid, mname, amount)
values (44631, 'Ointment Fpbfkd', 250);
insert into MATERIAL (mid, mname, amount)
values (91849, 'Septanest Oenyr', 90);
insert into MATERIAL (mid, mname, amount)
values (63651, 'Anestethic Numh', 89);
insert into MATERIAL (mid, mname, amount)
values (53673, 'Septanest Vugtw', 203);
insert into MATERIAL (mid, mname, amount)
values (95165, 'Septanest Ttoke', 78);
insert into MATERIAL (mid, mname, amount)
values (54674, 'Septanest Ogvbn', 13);
insert into MATERIAL (mid, mname, amount)
values (29138, 'Antibiotic Vsmt', 81);
insert into MATERIAL (mid, mname, amount)
values (56631, 'Ointment Aziqll', 169);
insert into MATERIAL (mid, mname, amount)
values (15199, 'Antibiotic Wcgq', 104);
insert into MATERIAL (mid, mname, amount)
values (94219, 'Anestethic Qrjk', 51);
insert into MATERIAL (mid, mname, amount)
values (41311, 'Anestethic Gxjv', 206);
insert into MATERIAL (mid, mname, amount)
values (68746, 'Anestethic Bbge', 47);
insert into MATERIAL (mid, mname, amount)
values (11323, 'Antibiotic Yeek', 182);
insert into MATERIAL (mid, mname, amount)
values (34646, 'Ointment Drlrcp', 232);
insert into MATERIAL (mid, mname, amount)
values (75214, 'Pills Axbsrh', 97);
insert into MATERIAL (mid, mname, amount)
values (62615, 'Antibiotic Jkxt', 137);
insert into MATERIAL (mid, mname, amount)
values (22792, 'Pills Qhjijs', 74);
insert into MATERIAL (mid, mname, amount)
values (46242, 'Ointment Adtpue', 216);
insert into MATERIAL (mid, mname, amount)
values (44583, 'Anestethic Egzt', 73);
insert into MATERIAL (mid, mname, amount)
values (93576, 'Pills Ofuxtn', 155);
insert into MATERIAL (mid, mname, amount)
values (31714, 'Antibiotic Jxvh', 237);
insert into MATERIAL (mid, mname, amount)
values (63993, 'Antibiotic Idnp', 36);
insert into MATERIAL (mid, mname, amount)
values (97823, 'Anestethic Yufm', 236);
insert into MATERIAL (mid, mname, amount)
values (55661, 'Anestethic Fqkj', 213);
insert into MATERIAL (mid, mname, amount)
values (33712, 'Anestethic Hckw', 175);
insert into MATERIAL (mid, mname, amount)
values (19976, 'Ointment Gfxbqe', 107);
insert into MATERIAL (mid, mname, amount)
values (67682, 'Antibiotic Yjxl', 93);
insert into MATERIAL (mid, mname, amount)
values (83539, 'Anestethic Bzps', 123);
insert into MATERIAL (mid, mname, amount)
values (29885, 'Septanest Yitro', 83);
insert into MATERIAL (mid, mname, amount)
values (16971, 'Septanest Vrdqv', 8);
insert into MATERIAL (mid, mname, amount)
values (28932, 'Ointment Fuouff', 173);
insert into MATERIAL (mid, mname, amount)
values (92816, 'Pills Mivdrc', 195);
insert into MATERIAL (mid, mname, amount)
values (18182, 'Anestethic Tnpn', 41);
insert into MATERIAL (mid, mname, amount)
values (26497, 'Anestethic Cjmk', 118);
insert into MATERIAL (mid, mname, amount)
values (25558, 'Anestethic Niaa', 219);
insert into MATERIAL (mid, mname, amount)
values (12188, 'Anestethic Iwnq', 4);
insert into MATERIAL (mid, mname, amount)
values (14789, 'Ointment Eljeqy', 116);
insert into MATERIAL (mid, mname, amount)
values (21275, 'Ointment Dwpums', 231);
insert into MATERIAL (mid, mname, amount)
values (88796, 'Pills Gvyrcn', 58);
insert into MATERIAL (mid, mname, amount)
values (37142, 'Septanest Liqhb', 182);
insert into MATERIAL (mid, mname, amount)
values (98712, 'Anestethic Lyeg', 7);
insert into MATERIAL (mid, mname, amount)
values (73532, 'Antibiotic Yoss', 121);
insert into MATERIAL (mid, mname, amount)
values (95514, 'Anestethic Owxt', 98);
insert into MATERIAL (mid, mname, amount)
values (44786, 'Ointment Cwrhma', 67);
insert into MATERIAL (mid, mname, amount)
values (45711, 'Ointment Virrzw', 214);
insert into MATERIAL (mid, mname, amount)
values (85784, 'Septanest Nawvc', 34);
insert into MATERIAL (mid, mname, amount)
values (11126, 'Anestethic Oiif', 189);
insert into MATERIAL (mid, mname, amount)
values (52425, 'Septanest Smmdh', 155);
insert into MATERIAL (mid, mname, amount)
values (44272, 'Septanest Eviux', 2);
insert into MATERIAL (mid, mname, amount)
values (36458, 'Antibiotic Yoms', 222);
insert into MATERIAL (mid, mname, amount)
values (75612, 'Septanest Jgqrt', 161);
insert into MATERIAL (mid, mname, amount)
values (69498, 'Pills Fsnzbo', 114);
insert into MATERIAL (mid, mname, amount)
values (64295, 'Septanest Zmmii', 241);
insert into MATERIAL (mid, mname, amount)
values (72459, 'Antibiotic Hqep', 123);
insert into MATERIAL (mid, mname, amount)
values (93941, 'Ointment Ljniao', 151);
insert into MATERIAL (mid, mname, amount)
values (38569, 'Septanest Fikbq', 63);
insert into MATERIAL (mid, mname, amount)
values (17584, 'Septanest Jlrvw', 38);
insert into MATERIAL (mid, mname, amount)
values (95721, 'Septanest Thobn', 152);
insert into MATERIAL (mid, mname, amount)
values (75759, 'Anestethic Urzx', 172);
insert into MATERIAL (mid, mname, amount)
values (55567, 'Antibiotic Mefv', 21);
insert into MATERIAL (mid, mname, amount)
values (37483, 'Septanest Hglww', 125);
insert into MATERIAL (mid, mname, amount)
values (26222, 'Antibiotic Uqsj', 112);
insert into MATERIAL (mid, mname, amount)
values (55873, 'Pills Yvxnii', 145);
insert into MATERIAL (mid, mname, amount)
values (91854, 'Ointment Lhrigi', 185);
insert into MATERIAL (mid, mname, amount)
values (43389, 'Anestethic Spxm', 61);
insert into MATERIAL (mid, mname, amount)
values (44175, 'Antibiotic Kuqx', 48);
insert into MATERIAL (mid, mname, amount)
values (16418, 'Pills Ucakkk', 225);
insert into MATERIAL (mid, mname, amount)
values (88214, 'Antibiotic Egwh', 36);
insert into MATERIAL (mid, mname, amount)
values (15953, 'Antibiotic Vmvv', 21);
insert into MATERIAL (mid, mname, amount)
values (45884, 'Anestethic Wfnu', 183);
insert into MATERIAL (mid, mname, amount)
values (52478, 'Anestethic Grqt', 29);
insert into MATERIAL (mid, mname, amount)
values (61678, 'Antibiotic Paxt', 246);
insert into MATERIAL (mid, mname, amount)
values (71615, 'Septanest Piyfz', 91);
insert into MATERIAL (mid, mname, amount)
values (42712, 'Anestethic Qeww', 130);
insert into MATERIAL (mid, mname, amount)
values (29767, 'Ointment Vynolg', 249);
insert into MATERIAL (mid, mname, amount)
values (50001, 'Gauze', 100);
insert into MATERIAL (mid, mname, amount)
values (50002, 'Bandages', 75);
insert into MATERIAL (mid, mname, amount)
values (50003, 'Syringes', 200);
insert into MATERIAL (mid, mname, amount)
values (50004, 'Scalpels', 50);
insert into MATERIAL (mid, mname, amount)
values (50005, 'Gloves', 300);
insert into MATERIAL (mid, mname, amount)
values (50006, 'Sutures', 125);
insert into MATERIAL (mid, mname, amount)
values (50007, 'Cotton Swabs', 400);
insert into MATERIAL (mid, mname, amount)
values (50008, 'Disinfectant', 150);
insert into MATERIAL (mid, mname, amount)
values (50009, 'Thermometers', 75);
insert into MATERIAL (mid, mname, amount)
values (50010, 'Stethoscopes', 25);
insert into MATERIAL (mid, mname, amount)
values (79172, 'Septanest', 67);
insert into MATERIAL (mid, mname, amount)
values (24511, 'Pills', 142);
insert into MATERIAL (mid, mname, amount)
values (17846, 'Septanest', 26);
insert into MATERIAL (mid, mname, amount)
values (25767, 'Septanest', 209);
insert into MATERIAL (mid, mname, amount)
values (94688, 'Antibiotic', 192);
insert into MATERIAL (mid, mname, amount)
values (24183, 'Septanest', 214);
insert into MATERIAL (mid, mname, amount)
values (82698, 'Ointment', 68);
insert into MATERIAL (mid, mname, amount)
values (84826, 'Ointment', 83);
insert into MATERIAL (mid, mname, amount)
values (44571, 'Septanest', 12);
insert into MATERIAL (mid, mname, amount)
values (22533, 'Septanest', 27);
commit;
prompt 400 records committed...
insert into MATERIAL (mid, mname, amount)
values (64341, 'Septanest', 106);
insert into MATERIAL (mid, mname, amount)
values (18288, 'Septanest', 81);
insert into MATERIAL (mid, mname, amount)
values (66187, 'Ointment', 211);
insert into MATERIAL (mid, mname, amount)
values (23616, 'Eskrvj', 98);
insert into MATERIAL (mid, mname, amount)
values (38187, 'Jiwzkx', 137);
insert into MATERIAL (mid, mname, amount)
values (49119, 'Geyiew', 46);
insert into MATERIAL (mid, mname, amount)
values (53977, 'Opuvnw', 71);
insert into MATERIAL (mid, mname, amount)
values (32816, 'Oiggzd', 68);
insert into MATERIAL (mid, mname, amount)
values (66817, 'Wgsrax', 156);
insert into MATERIAL (mid, mname, amount)
values (39792, 'Ananxr', 238);
insert into MATERIAL (mid, mname, amount)
values (79135, 'Yfoxcj', 46);
insert into MATERIAL (mid, mname, amount)
values (18661, 'Hebnsr', 163);
insert into MATERIAL (mid, mname, amount)
values (17889, 'Egafnl', 40);
insert into MATERIAL (mid, mname, amount)
values (75396, 'Cagmkc', 91);
insert into MATERIAL (mid, mname, amount)
values (46421, 'Wxpvdc', 12);
insert into MATERIAL (mid, mname, amount)
values (57723, 'Xsgjru', 29);
insert into MATERIAL (mid, mname, amount)
values (11462, 'Crrnew', 96);
insert into MATERIAL (mid, mname, amount)
values (51432, 'Jtthgp', 125);
insert into MATERIAL (mid, mname, amount)
values (85824, 'Evztwl', 143);
insert into MATERIAL (mid, mname, amount)
values (44572, 'Exbulu', 77);
insert into MATERIAL (mid, mname, amount)
values (25765, 'Keszqx', 196);
insert into MATERIAL (mid, mname, amount)
values (73858, 'Pills Nuknpt', 239);
insert into MATERIAL (mid, mname, amount)
values (51973, 'Anestethic Mcrq', 3);
insert into MATERIAL (mid, mname, amount)
values (91563, 'Antibiotic Ldix', 106);
insert into MATERIAL (mid, mname, amount)
values (77593, 'Antibiotic Orrh', 90);
insert into MATERIAL (mid, mname, amount)
values (81624, 'Ointment Fkevwa', 108);
insert into MATERIAL (mid, mname, amount)
values (55635, 'Ointment Fxwcsr', 189);
insert into MATERIAL (mid, mname, amount)
values (22677, 'Pills Fiouyv', 170);
insert into MATERIAL (mid, mname, amount)
values (99117, 'Ointment Cfuzwa', 192);
insert into MATERIAL (mid, mname, amount)
values (24568, 'Ointment Ncibgp', 59);
insert into MATERIAL (mid, mname, amount)
values (63222, 'Ointment Bojqar', 70);
insert into MATERIAL (mid, mname, amount)
values (66972, 'Anestethic Vaup', 216);
insert into MATERIAL (mid, mname, amount)
values (26199, 'Anestethic Lpfa', 221);
insert into MATERIAL (mid, mname, amount)
values (63677, 'Anestethic Lrrj', 245);
insert into MATERIAL (mid, mname, amount)
values (62152, 'Pills Nzwazu', 131);
insert into MATERIAL (mid, mname, amount)
values (61574, 'Ointment Jnadds', 196);
insert into MATERIAL (mid, mname, amount)
values (23585, 'Septanest Gdhfg', 36);
insert into MATERIAL (mid, mname, amount)
values (82597, 'Septanest Faqqo', 7);
insert into MATERIAL (mid, mname, amount)
values (32358, 'Anestethic Swft', 8);
insert into MATERIAL (mid, mname, amount)
values (68834, 'Ointment Qiklfe', 243);
insert into MATERIAL (mid, mname, amount)
values (64735, 'Anestethic Xkad', 68);
insert into MATERIAL (mid, mname, amount)
values (18938, 'Antibiotic Tajd', 176);
insert into MATERIAL (mid, mname, amount)
values (35459, 'Antibiotic Ptbw', 96);
insert into MATERIAL (mid, mname, amount)
values (37651, 'Anestethic Nzew', 89);
insert into MATERIAL (mid, mname, amount)
values (16538, 'Ointment Jleljh', 214);
insert into MATERIAL (mid, mname, amount)
values (86826, 'Pills Jrhiju', 83);
insert into MATERIAL (mid, mname, amount)
values (78514, 'Pills Cdakhz', 182);
insert into MATERIAL (mid, mname, amount)
values (98781, 'Pills Qngwzc', 129);
insert into MATERIAL (mid, mname, amount)
values (68771, 'Ointment Gwhsio', 117);
insert into MATERIAL (mid, mname, amount)
values (29442, 'Septanest Kqsdp', 55);
insert into MATERIAL (mid, mname, amount)
values (95625, 'Ointment Fozfai', 101);
commit;
prompt 451 records loaded
prompt Loading TREATMENT...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 1962, 61466, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 417, 97162, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13434, 39569, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9295, 55856, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5042, 11536, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14941, 38646, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14038, 56679, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 76, 47955, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 10210, 68228, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 5980, 14261, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10489, 64213, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11926, 61751, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13914, 42874, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14430, 81263, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 10283, 64193, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3691, 85923, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 7849, 97218, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6915, 59576, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9284, 75819, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1259, 76218, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 7314, 61278, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2095, 75574, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6512, 97845, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13737, 51563, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 975, 92627, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7224, 67274, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 11708, 92978, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 859, 91414, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 10565, 37659, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12371, 58261, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4465, 69548, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 361, 82736, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2974, 36999, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 2349, 43562, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1148, 29779, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 13072, 69989, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 13553, 45299, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12520, 86448, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5965, 55194, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11913, 65894, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 761, 31856, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2085, 51917, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 7022, 81291, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9567, 98519, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11783, 23115, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4228, 45919, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 5749, 92957, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 136, 77953, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13404, 66237, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 4641, 48389, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14426, 71824, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 4715, 26426, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1317, 86193, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 6625, 13865, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 10672, 31498, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6004, 61161, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 876, 68541, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5232, 72641, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6595, 48317, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14697, 28613, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6039, 22389, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12521, 82416, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3562, 57499, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11874, 81556, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4376, 11741, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9774, 95589, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 8247, 21534, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1103, 28279, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 281, 22218, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4332, 49126, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6247, 94664, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8491, 55128, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12640, 62348, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 633, 69323, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12016, 41269, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3283, 19138, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3245, 57734, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 13998, 69888, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 7383, 73447, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9950, 87763, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7208, 75421, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 1710, 52724, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12844, 64556, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12540, 98431, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 2103, 91341, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6651, 44897, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9771, 35753, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10848, 39324, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 5835, 72284, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10625, 92639, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14143, 36176, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 10124, 93545, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 6525, 45115, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1688, 69637, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1350, 32573, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12258, 48678, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9385, 72427, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 11267, 67681, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14423, 64624, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 4509, 22851, 7);
commit;
prompt 100 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 91, 14552, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1353, 78488, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2803, 99588, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1546, 19964, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14940, 67922, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3540, 98297, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11887, 74871, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 7188, 86759, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 859, 95638, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 3528, 26691, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11738, 94421, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14118, 29827, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 1233, 48123, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11605, 48329, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 2915, 55853, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9569, 73797, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6714, 35821, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 12360, 18339, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9548, 75664, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3568, 86933, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 9909, 17936, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13926, 22789, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7078, 14355, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10354, 36526, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 14253, 46961, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2170, 41662, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 275, 69417, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7041, 41861, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5212, 43463, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12620, 46755, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7421, 79892, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4319, 69687, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6326, 41214, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4231, 32426, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 9361, 96629, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 658, 54973, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 7388, 65132, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9053, 65137, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 6231, 93326, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 1007, 78657, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 6517, 53955, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9476, 75261, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 11745, 39411, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 10788, 23557, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12652, 91757, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 14537, 89623, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 13081, 64274, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4744, 59859, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 11778, 63961, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7718, 43564, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 3479, 43229, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5841, 79265, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 414, 76278, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5324, 89395, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 723, 19389, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 5797, 77355, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9829, 85796, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4499, 43898, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1112, 97898, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 11071, 78516, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 7691, 89835, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9397, 63439, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11639, 87911, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 8510, 75129, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 1155, 89365, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13795, 82369, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 7844, 88828, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7392, 23243, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11308, 45358, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1602, 73173, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12398, 95197, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 4406, 71249, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11242, 64259, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 517, 59848, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14785, 91318, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5868, 94324, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13481, 14955, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3604, 35345, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9386, 22378, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6039, 87723, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2827, 99444, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10837, 25155, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14356, 23348, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 3534, 33551, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 13162, 76614, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 14727, 78153, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14991, 34794, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 2069, 57236, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14991, 52125, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3439, 65959, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12207, 68714, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9928, 43285, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 4485, 35174, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 244, 63187, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 7903, 87629, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 9080, 18675, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12577, 42976, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14817, 58267, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 287, 55159, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4040, 18985, 5);
commit;
prompt 200 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 2510, 22211, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13602, 57256, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 1855, 34368, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9772, 56844, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 9736, 52748, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 3416, 67698, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14396, 14543, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 10420, 42172, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2328, 26551, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8835, 46517, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6273, 32691, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3169, 36339, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4483, 16258, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 1850, 17632, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 586, 34578, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12479, 92566, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12839, 64585, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12208, 76939, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7006, 19598, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2135, 81758, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 11901, 68378, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10887, 55476, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14902, 64435, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7841, 66853, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14630, 79335, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9255, 18323, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2721, 16866, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5522, 81239, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9074, 17119, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 13467, 15973, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14699, 87568, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10284, 53636, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2721, 85642, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 260, 46923, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12101, 48244, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7131, 86775, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11034, 18841, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1145, 75494, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11414, 58469, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8213, 58861, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11101, 68449, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 10501, 24741, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5986, 81366, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9759, 95395, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 3124, 55142, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14751, 73772, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2873, 36449, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13910, 13622, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5526, 33123, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11068, 14675, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11611, 71465, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 8305, 61725, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1497, 22573, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 8549, 77463, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 554, 97684, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7983, 65135, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2218, 44524, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 218, 74348, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5063, 43531, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 7168, 95993, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 1035, 52941, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 1773, 11355, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11782, 95429, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9681, 83316, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 13428, 87726, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 914, 53372, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6639, 99975, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6996, 29468, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9650, 19434, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 14312, 26161, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 14925, 62824, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 11519, 67319, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 14531, 16754, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11795, 58257, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12080, 61916, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14252, 62262, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 9141, 59883, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 2181, 55534, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6397, 82913, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4312, 71983, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 3989, 63726, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14364, 26847, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2900, 51324, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 8248, 42949, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1821, 91954, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 5821, 14839, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4366, 85577, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4633, 43825, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6154, 83652, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2637, 73179, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6101, 93262, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 9004, 58264, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 1179, 46956, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9718, 46212, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 5043, 36836, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9393, 85741, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9172, 31183, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12887, 55837, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 998, 31771, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7807, 27147, 9);
commit;
prompt 300 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 13773, 87322, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12511, 21241, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 3793, 51348, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4856, 54551, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3994, 83824, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9978, 55941, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 4053, 83715, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 7617, 17141, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 8840, 95253, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6547, 25522, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 3624, 72198, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10087, 72385, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11109, 43414, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 3162, 22349, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11029, 23699, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3883, 96533, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6455, 81992, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8453, 49863, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 787, 11826, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 5907, 33742, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14048, 16365, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 6100, 94996, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 3621, 58514, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 3670, 94371, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13372, 23661, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 942, 35736, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 4955, 45421, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 6812, 86917, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 9698, 43548, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12772, 18558, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5604, 54149, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8341, 89842, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 924, 51682, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10105, 12265, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4273, 94556, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 6749, 89886, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10961, 91977, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4224, 41882, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9106, 45394, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 4655, 27635, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14668, 24245, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4232, 61571, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9823, 89622, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 8056, 89584, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 1753, 67264, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 1099, 25749, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10200, 35145, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9118, 91955, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12119, 63454, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2874, 17496, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 122, 54948, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13953, 63453, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8814, 35732, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12448, 71531, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4324, 38162, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1145, 52387, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11643, 76852, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7436, 68654, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4835, 82157, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 14500, 92415, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6242, 87874, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 427, 85435, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 1313, 48196, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14138, 43627, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 14288, 25514, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 7453, 41155, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 13758, 85517, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10860, 81339, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11600, 16211, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 10385, 35666, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 263, 75487, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10708, 46326, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 12513, 76229, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 2754, 15866, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10078, 56151, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9102, 11153, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 4961, 34644, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 5669, 93974, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5885, 77591, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 3520, 61469, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12463, 69992, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 414, 76324, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1528, 83436, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2631, 55383, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14032, 94471, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2539, 63929, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 588, 81329, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10357, 58882, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 11881, 56217, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10338, 24957, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 10862, 63569, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1628, 66786, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12741, 57765, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13801, 66121, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9833, 22486, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9608, 83735, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14929, 34718, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 995, 92264, 8);
commit;
prompt 398 records loaded
prompt Loading MUSEDINT...
insert into MUSEDINT (tid, mid)
values (11153, 53212);
insert into MUSEDINT (tid, mid)
values (11153, 53235);
insert into MUSEDINT (tid, mid)
values (11153, 68732);
insert into MUSEDINT (tid, mid)
values (11355, 15953);
insert into MUSEDINT (tid, mid)
values (11355, 19246);
insert into MUSEDINT (tid, mid)
values (11355, 29554);
insert into MUSEDINT (tid, mid)
values (11536, 25813);
insert into MUSEDINT (tid, mid)
values (11536, 46122);
insert into MUSEDINT (tid, mid)
values (11741, 18661);
insert into MUSEDINT (tid, mid)
values (11741, 47428);
insert into MUSEDINT (tid, mid)
values (11741, 52478);
insert into MUSEDINT (tid, mid)
values (11741, 64741);
insert into MUSEDINT (tid, mid)
values (11741, 83539);
insert into MUSEDINT (tid, mid)
values (11826, 13682);
insert into MUSEDINT (tid, mid)
values (12265, 96421);
insert into MUSEDINT (tid, mid)
values (14261, 42712);
insert into MUSEDINT (tid, mid)
values (14261, 52478);
insert into MUSEDINT (tid, mid)
values (14261, 64876);
insert into MUSEDINT (tid, mid)
values (14355, 83983);
insert into MUSEDINT (tid, mid)
values (14543, 22693);
insert into MUSEDINT (tid, mid)
values (14675, 74877);
insert into MUSEDINT (tid, mid)
values (14839, 25633);
insert into MUSEDINT (tid, mid)
values (14839, 41133);
insert into MUSEDINT (tid, mid)
values (14839, 46242);
insert into MUSEDINT (tid, mid)
values (14839, 96364);
insert into MUSEDINT (tid, mid)
values (14955, 14244);
insert into MUSEDINT (tid, mid)
values (14955, 15953);
insert into MUSEDINT (tid, mid)
values (14955, 75759);
insert into MUSEDINT (tid, mid)
values (15866, 29138);
insert into MUSEDINT (tid, mid)
values (15866, 63597);
insert into MUSEDINT (tid, mid)
values (15973, 13657);
insert into MUSEDINT (tid, mid)
values (15973, 76277);
insert into MUSEDINT (tid, mid)
values (16211, 18288);
insert into MUSEDINT (tid, mid)
values (16211, 31714);
insert into MUSEDINT (tid, mid)
values (16211, 81856);
insert into MUSEDINT (tid, mid)
values (16258, 62838);
insert into MUSEDINT (tid, mid)
values (16365, 47597);
insert into MUSEDINT (tid, mid)
values (16754, 83128);
insert into MUSEDINT (tid, mid)
values (16866, 67121);
insert into MUSEDINT (tid, mid)
values (16866, 91563);
insert into MUSEDINT (tid, mid)
values (17119, 34865);
insert into MUSEDINT (tid, mid)
values (17119, 51927);
insert into MUSEDINT (tid, mid)
values (17119, 69498);
insert into MUSEDINT (tid, mid)
values (17141, 31773);
insert into MUSEDINT (tid, mid)
values (17141, 39792);
insert into MUSEDINT (tid, mid)
values (17141, 57726);
insert into MUSEDINT (tid, mid)
values (17496, 63222);
insert into MUSEDINT (tid, mid)
values (17496, 82698);
insert into MUSEDINT (tid, mid)
values (17632, 31773);
insert into MUSEDINT (tid, mid)
values (17632, 92816);
insert into MUSEDINT (tid, mid)
values (17936, 24534);
insert into MUSEDINT (tid, mid)
values (17936, 41133);
insert into MUSEDINT (tid, mid)
values (17936, 48388);
insert into MUSEDINT (tid, mid)
values (17936, 83212);
insert into MUSEDINT (tid, mid)
values (18323, 36313);
insert into MUSEDINT (tid, mid)
values (18323, 93576);
insert into MUSEDINT (tid, mid)
values (18339, 24183);
insert into MUSEDINT (tid, mid)
values (18339, 29336);
insert into MUSEDINT (tid, mid)
values (18339, 46698);
insert into MUSEDINT (tid, mid)
values (18558, 28379);
insert into MUSEDINT (tid, mid)
values (18558, 64442);
insert into MUSEDINT (tid, mid)
values (18675, 32358);
insert into MUSEDINT (tid, mid)
values (18675, 49119);
insert into MUSEDINT (tid, mid)
values (18675, 77986);
insert into MUSEDINT (tid, mid)
values (18675, 87251);
insert into MUSEDINT (tid, mid)
values (18675, 95721);
insert into MUSEDINT (tid, mid)
values (18841, 25522);
insert into MUSEDINT (tid, mid)
values (18841, 39168);
insert into MUSEDINT (tid, mid)
values (18841, 62838);
insert into MUSEDINT (tid, mid)
values (18841, 75587);
insert into MUSEDINT (tid, mid)
values (18985, 39792);
insert into MUSEDINT (tid, mid)
values (19389, 12188);
insert into MUSEDINT (tid, mid)
values (19389, 15958);
insert into MUSEDINT (tid, mid)
values (19389, 75759);
insert into MUSEDINT (tid, mid)
values (19964, 56794);
insert into MUSEDINT (tid, mid)
values (21241, 37596);
insert into MUSEDINT (tid, mid)
values (21241, 49899);
insert into MUSEDINT (tid, mid)
values (21241, 55635);
insert into MUSEDINT (tid, mid)
values (21241, 84826);
insert into MUSEDINT (tid, mid)
values (21534, 29442);
insert into MUSEDINT (tid, mid)
values (22211, 69521);
insert into MUSEDINT (tid, mid)
values (22211, 98781);
insert into MUSEDINT (tid, mid)
values (22218, 85824);
insert into MUSEDINT (tid, mid)
values (22349, 17889);
insert into MUSEDINT (tid, mid)
values (22349, 28735);
insert into MUSEDINT (tid, mid)
values (22378, 49367);
insert into MUSEDINT (tid, mid)
values (22389, 78819);
insert into MUSEDINT (tid, mid)
values (22389, 99117);
insert into MUSEDINT (tid, mid)
values (22486, 64442);
insert into MUSEDINT (tid, mid)
values (22789, 57726);
insert into MUSEDINT (tid, mid)
values (22789, 62152);
insert into MUSEDINT (tid, mid)
values (22851, 59978);
insert into MUSEDINT (tid, mid)
values (22851, 93576);
insert into MUSEDINT (tid, mid)
values (23115, 75629);
insert into MUSEDINT (tid, mid)
values (23243, 24124);
insert into MUSEDINT (tid, mid)
values (23243, 88796);
insert into MUSEDINT (tid, mid)
values (23348, 12353);
insert into MUSEDINT (tid, mid)
values (23348, 27219);
insert into MUSEDINT (tid, mid)
values (23348, 28735);
insert into MUSEDINT (tid, mid)
values (23348, 53715);
commit;
prompt 100 records committed...
insert into MUSEDINT (tid, mid)
values (23661, 16331);
insert into MUSEDINT (tid, mid)
values (24245, 27386);
insert into MUSEDINT (tid, mid)
values (24245, 29767);
insert into MUSEDINT (tid, mid)
values (24245, 68732);
insert into MUSEDINT (tid, mid)
values (24245, 85824);
insert into MUSEDINT (tid, mid)
values (24741, 36458);
insert into MUSEDINT (tid, mid)
values (24957, 42346);
insert into MUSEDINT (tid, mid)
values (24957, 63993);
insert into MUSEDINT (tid, mid)
values (25155, 23628);
insert into MUSEDINT (tid, mid)
values (25155, 29885);
insert into MUSEDINT (tid, mid)
values (25155, 68746);
insert into MUSEDINT (tid, mid)
values (25514, 16331);
insert into MUSEDINT (tid, mid)
values (25514, 33712);
insert into MUSEDINT (tid, mid)
values (25514, 50007);
insert into MUSEDINT (tid, mid)
values (25514, 53212);
insert into MUSEDINT (tid, mid)
values (25522, 15484);
insert into MUSEDINT (tid, mid)
values (25522, 66972);
insert into MUSEDINT (tid, mid)
values (25749, 46333);
insert into MUSEDINT (tid, mid)
values (26161, 86223);
insert into MUSEDINT (tid, mid)
values (26426, 23585);
insert into MUSEDINT (tid, mid)
values (26426, 43389);
insert into MUSEDINT (tid, mid)
values (26426, 49366);
insert into MUSEDINT (tid, mid)
values (26426, 97875);
insert into MUSEDINT (tid, mid)
values (26551, 49631);
insert into MUSEDINT (tid, mid)
values (26551, 55873);
insert into MUSEDINT (tid, mid)
values (26691, 24534);
insert into MUSEDINT (tid, mid)
values (26691, 62615);
insert into MUSEDINT (tid, mid)
values (26691, 83936);
insert into MUSEDINT (tid, mid)
values (26847, 92714);
insert into MUSEDINT (tid, mid)
values (26847, 96936);
insert into MUSEDINT (tid, mid)
values (27147, 11126);
insert into MUSEDINT (tid, mid)
values (27147, 36647);
insert into MUSEDINT (tid, mid)
values (27147, 63414);
insert into MUSEDINT (tid, mid)
values (27147, 73532);
insert into MUSEDINT (tid, mid)
values (27635, 25767);
insert into MUSEDINT (tid, mid)
values (28279, 11844);
insert into MUSEDINT (tid, mid)
values (28279, 68343);
insert into MUSEDINT (tid, mid)
values (29468, 12188);
insert into MUSEDINT (tid, mid)
values (29468, 74877);
insert into MUSEDINT (tid, mid)
values (29468, 88214);
insert into MUSEDINT (tid, mid)
values (29468, 93137);
insert into MUSEDINT (tid, mid)
values (29779, 23628);
insert into MUSEDINT (tid, mid)
values (29779, 33518);
insert into MUSEDINT (tid, mid)
values (29779, 56126);
insert into MUSEDINT (tid, mid)
values (29827, 25752);
insert into MUSEDINT (tid, mid)
values (31183, 24183);
insert into MUSEDINT (tid, mid)
values (31498, 11997);
insert into MUSEDINT (tid, mid)
values (31498, 56126);
insert into MUSEDINT (tid, mid)
values (31498, 98796);
insert into MUSEDINT (tid, mid)
values (31771, 21275);
insert into MUSEDINT (tid, mid)
values (31771, 38921);
insert into MUSEDINT (tid, mid)
values (31771, 51973);
insert into MUSEDINT (tid, mid)
values (31771, 99141);
insert into MUSEDINT (tid, mid)
values (31856, 34646);
insert into MUSEDINT (tid, mid)
values (31856, 72235);
insert into MUSEDINT (tid, mid)
values (32426, 11462);
insert into MUSEDINT (tid, mid)
values (32426, 51927);
insert into MUSEDINT (tid, mid)
values (32426, 71452);
insert into MUSEDINT (tid, mid)
values (32573, 23585);
insert into MUSEDINT (tid, mid)
values (32573, 47428);
insert into MUSEDINT (tid, mid)
values (32573, 68496);
insert into MUSEDINT (tid, mid)
values (32691, 56631);
insert into MUSEDINT (tid, mid)
values (33123, 14244);
insert into MUSEDINT (tid, mid)
values (33123, 44583);
insert into MUSEDINT (tid, mid)
values (33123, 46242);
insert into MUSEDINT (tid, mid)
values (33123, 50005);
insert into MUSEDINT (tid, mid)
values (33123, 56794);
insert into MUSEDINT (tid, mid)
values (33551, 15958);
insert into MUSEDINT (tid, mid)
values (33551, 27259);
insert into MUSEDINT (tid, mid)
values (33551, 34865);
insert into MUSEDINT (tid, mid)
values (33551, 42668);
insert into MUSEDINT (tid, mid)
values (33551, 49899);
insert into MUSEDINT (tid, mid)
values (33742, 26927);
insert into MUSEDINT (tid, mid)
values (33742, 27386);
insert into MUSEDINT (tid, mid)
values (33742, 32358);
insert into MUSEDINT (tid, mid)
values (33742, 50010);
insert into MUSEDINT (tid, mid)
values (33742, 72479);
insert into MUSEDINT (tid, mid)
values (33742, 78819);
insert into MUSEDINT (tid, mid)
values (33742, 88563);
insert into MUSEDINT (tid, mid)
values (34578, 41311);
insert into MUSEDINT (tid, mid)
values (34578, 44175);
insert into MUSEDINT (tid, mid)
values (34578, 69235);
insert into MUSEDINT (tid, mid)
values (34644, 44631);
insert into MUSEDINT (tid, mid)
values (34718, 32816);
insert into MUSEDINT (tid, mid)
values (34718, 94688);
insert into MUSEDINT (tid, mid)
values (34718, 97823);
insert into MUSEDINT (tid, mid)
values (34794, 68248);
insert into MUSEDINT (tid, mid)
values (35145, 27189);
insert into MUSEDINT (tid, mid)
values (35145, 87251);
insert into MUSEDINT (tid, mid)
values (35345, 11126);
insert into MUSEDINT (tid, mid)
values (35345, 24183);
insert into MUSEDINT (tid, mid)
values (35345, 55764);
insert into MUSEDINT (tid, mid)
values (35666, 17776);
insert into MUSEDINT (tid, mid)
values (35666, 36647);
insert into MUSEDINT (tid, mid)
values (35666, 57861);
insert into MUSEDINT (tid, mid)
values (35732, 29225);
insert into MUSEDINT (tid, mid)
values (35732, 44524);
insert into MUSEDINT (tid, mid)
values (35732, 68834);
insert into MUSEDINT (tid, mid)
values (35753, 64876);
insert into MUSEDINT (tid, mid)
values (35821, 11127);
commit;
prompt 200 records committed...
insert into MUSEDINT (tid, mid)
values (36176, 63993);
insert into MUSEDINT (tid, mid)
values (36176, 77556);
insert into MUSEDINT (tid, mid)
values (36526, 16418);
insert into MUSEDINT (tid, mid)
values (36836, 11126);
insert into MUSEDINT (tid, mid)
values (36836, 49899);
insert into MUSEDINT (tid, mid)
values (36999, 48693);
insert into MUSEDINT (tid, mid)
values (37659, 15199);
insert into MUSEDINT (tid, mid)
values (37659, 22792);
insert into MUSEDINT (tid, mid)
values (37659, 45884);
insert into MUSEDINT (tid, mid)
values (37659, 61582);
insert into MUSEDINT (tid, mid)
values (38162, 43389);
insert into MUSEDINT (tid, mid)
values (38162, 75523);
insert into MUSEDINT (tid, mid)
values (38646, 11752);
insert into MUSEDINT (tid, mid)
values (38646, 16418);
insert into MUSEDINT (tid, mid)
values (38646, 22693);
insert into MUSEDINT (tid, mid)
values (38646, 26412);
insert into MUSEDINT (tid, mid)
values (38646, 61574);
insert into MUSEDINT (tid, mid)
values (38646, 63363);
insert into MUSEDINT (tid, mid)
values (38646, 75523);
insert into MUSEDINT (tid, mid)
values (38646, 88796);
insert into MUSEDINT (tid, mid)
values (39324, 28318);
insert into MUSEDINT (tid, mid)
values (39324, 38569);
insert into MUSEDINT (tid, mid)
values (39324, 82597);
insert into MUSEDINT (tid, mid)
values (39324, 83983);
insert into MUSEDINT (tid, mid)
values (39569, 15988);
insert into MUSEDINT (tid, mid)
values (39569, 27189);
insert into MUSEDINT (tid, mid)
values (39569, 51432);
insert into MUSEDINT (tid, mid)
values (39569, 55567);
insert into MUSEDINT (tid, mid)
values (41155, 17776);
insert into MUSEDINT (tid, mid)
values (41155, 64683);
insert into MUSEDINT (tid, mid)
values (41155, 73532);
insert into MUSEDINT (tid, mid)
values (41214, 75587);
insert into MUSEDINT (tid, mid)
values (41269, 11462);
insert into MUSEDINT (tid, mid)
values (41269, 61678);
insert into MUSEDINT (tid, mid)
values (41662, 38187);
insert into MUSEDINT (tid, mid)
values (41861, 49484);
insert into MUSEDINT (tid, mid)
values (41861, 51857);
insert into MUSEDINT (tid, mid)
values (41861, 99141);
insert into MUSEDINT (tid, mid)
values (42172, 28735);
insert into MUSEDINT (tid, mid)
values (42172, 44631);
insert into MUSEDINT (tid, mid)
values (42172, 66972);
insert into MUSEDINT (tid, mid)
values (42874, 62511);
insert into MUSEDINT (tid, mid)
values (42949, 38921);
insert into MUSEDINT (tid, mid)
values (42976, 53977);
insert into MUSEDINT (tid, mid)
values (43229, 37483);
insert into MUSEDINT (tid, mid)
values (43229, 54227);
insert into MUSEDINT (tid, mid)
values (43229, 61678);
insert into MUSEDINT (tid, mid)
values (43229, 77986);
insert into MUSEDINT (tid, mid)
values (43285, 26441);
insert into MUSEDINT (tid, mid)
values (43285, 27995);
insert into MUSEDINT (tid, mid)
values (43414, 18182);
insert into MUSEDINT (tid, mid)
values (43414, 77986);
insert into MUSEDINT (tid, mid)
values (43463, 32832);
insert into MUSEDINT (tid, mid)
values (43463, 44141);
insert into MUSEDINT (tid, mid)
values (43463, 47428);
insert into MUSEDINT (tid, mid)
values (43531, 42346);
insert into MUSEDINT (tid, mid)
values (43548, 94688);
insert into MUSEDINT (tid, mid)
values (43562, 17776);
insert into MUSEDINT (tid, mid)
values (43562, 23628);
insert into MUSEDINT (tid, mid)
values (43562, 24183);
insert into MUSEDINT (tid, mid)
values (43562, 43963);
insert into MUSEDINT (tid, mid)
values (43562, 55764);
insert into MUSEDINT (tid, mid)
values (43564, 19776);
insert into MUSEDINT (tid, mid)
values (43564, 61271);
insert into MUSEDINT (tid, mid)
values (43627, 68746);
insert into MUSEDINT (tid, mid)
values (43627, 86938);
insert into MUSEDINT (tid, mid)
values (43825, 38529);
insert into MUSEDINT (tid, mid)
values (43825, 51773);
insert into MUSEDINT (tid, mid)
values (43825, 66187);
insert into MUSEDINT (tid, mid)
values (43825, 76774);
insert into MUSEDINT (tid, mid)
values (43898, 89721);
insert into MUSEDINT (tid, mid)
values (43898, 92666);
insert into MUSEDINT (tid, mid)
values (43898, 94688);
insert into MUSEDINT (tid, mid)
values (44524, 66972);
insert into MUSEDINT (tid, mid)
values (44897, 16418);
insert into MUSEDINT (tid, mid)
values (44897, 34263);
insert into MUSEDINT (tid, mid)
values (44897, 95165);
insert into MUSEDINT (tid, mid)
values (45115, 49367);
insert into MUSEDINT (tid, mid)
values (45115, 63512);
insert into MUSEDINT (tid, mid)
values (45115, 64683);
insert into MUSEDINT (tid, mid)
values (45299, 23116);
insert into MUSEDINT (tid, mid)
values (45299, 39792);
insert into MUSEDINT (tid, mid)
values (45299, 64295);
insert into MUSEDINT (tid, mid)
values (45358, 13655);
insert into MUSEDINT (tid, mid)
values (45358, 36458);
insert into MUSEDINT (tid, mid)
values (45358, 84215);
insert into MUSEDINT (tid, mid)
values (45358, 88489);
insert into MUSEDINT (tid, mid)
values (45358, 91563);
insert into MUSEDINT (tid, mid)
values (45394, 37596);
insert into MUSEDINT (tid, mid)
values (45421, 42637);
insert into MUSEDINT (tid, mid)
values (45421, 56794);
insert into MUSEDINT (tid, mid)
values (45421, 79344);
insert into MUSEDINT (tid, mid)
values (45421, 93815);
insert into MUSEDINT (tid, mid)
values (45919, 12228);
insert into MUSEDINT (tid, mid)
values (46212, 51181);
insert into MUSEDINT (tid, mid)
values (46212, 59978);
insert into MUSEDINT (tid, mid)
values (46212, 68834);
insert into MUSEDINT (tid, mid)
values (46212, 72235);
insert into MUSEDINT (tid, mid)
values (46212, 97792);
insert into MUSEDINT (tid, mid)
values (46326, 28379);
commit;
prompt 300 records committed...
insert into MUSEDINT (tid, mid)
values (46326, 32523);
insert into MUSEDINT (tid, mid)
values (46517, 72479);
insert into MUSEDINT (tid, mid)
values (46755, 44141);
insert into MUSEDINT (tid, mid)
values (46923, 50004);
insert into MUSEDINT (tid, mid)
values (46923, 81624);
insert into MUSEDINT (tid, mid)
values (46961, 26412);
insert into MUSEDINT (tid, mid)
values (46961, 75523);
insert into MUSEDINT (tid, mid)
values (47955, 15199);
insert into MUSEDINT (tid, mid)
values (47955, 47358);
insert into MUSEDINT (tid, mid)
values (47955, 99117);
insert into MUSEDINT (tid, mid)
values (48196, 86826);
insert into MUSEDINT (tid, mid)
values (48317, 24534);
insert into MUSEDINT (tid, mid)
values (48317, 94596);
insert into MUSEDINT (tid, mid)
values (48329, 75214);
insert into MUSEDINT (tid, mid)
values (48389, 29767);
insert into MUSEDINT (tid, mid)
values (48678, 50004);
insert into MUSEDINT (tid, mid)
values (48678, 53715);
insert into MUSEDINT (tid, mid)
values (48678, 97963);
insert into MUSEDINT (tid, mid)
values (49126, 25522);
insert into MUSEDINT (tid, mid)
values (49126, 50004);
insert into MUSEDINT (tid, mid)
values (49126, 61271);
insert into MUSEDINT (tid, mid)
values (49863, 72235);
insert into MUSEDINT (tid, mid)
values (49863, 72479);
insert into MUSEDINT (tid, mid)
values (51348, 66227);
insert into MUSEDINT (tid, mid)
values (51563, 50005);
insert into MUSEDINT (tid, mid)
values (51563, 98712);
insert into MUSEDINT (tid, mid)
values (51682, 35459);
insert into MUSEDINT (tid, mid)
values (51682, 75396);
insert into MUSEDINT (tid, mid)
values (51682, 99962);
insert into MUSEDINT (tid, mid)
values (51917, 47428);
insert into MUSEDINT (tid, mid)
values (51917, 85824);
insert into MUSEDINT (tid, mid)
values (52125, 29225);
insert into MUSEDINT (tid, mid)
values (52125, 69498);
insert into MUSEDINT (tid, mid)
values (52125, 88294);
insert into MUSEDINT (tid, mid)
values (52387, 38771);
insert into MUSEDINT (tid, mid)
values (52387, 75587);
insert into MUSEDINT (tid, mid)
values (52724, 71723);
insert into MUSEDINT (tid, mid)
values (52748, 25522);
insert into MUSEDINT (tid, mid)
values (52748, 68732);
insert into MUSEDINT (tid, mid)
values (52748, 93815);
insert into MUSEDINT (tid, mid)
values (52941, 24167);
insert into MUSEDINT (tid, mid)
values (52941, 37596);
insert into MUSEDINT (tid, mid)
values (52941, 50002);
insert into MUSEDINT (tid, mid)
values (52941, 83128);
insert into MUSEDINT (tid, mid)
values (52941, 83212);
insert into MUSEDINT (tid, mid)
values (53372, 32816);
insert into MUSEDINT (tid, mid)
values (53636, 61582);
insert into MUSEDINT (tid, mid)
values (53955, 71339);
insert into MUSEDINT (tid, mid)
values (53955, 91854);
insert into MUSEDINT (tid, mid)
values (54149, 22461);
insert into MUSEDINT (tid, mid)
values (54149, 23616);
insert into MUSEDINT (tid, mid)
values (54149, 38187);
insert into MUSEDINT (tid, mid)
values (54149, 50010);
insert into MUSEDINT (tid, mid)
values (54973, 19857);
insert into MUSEDINT (tid, mid)
values (55128, 34865);
insert into MUSEDINT (tid, mid)
values (55128, 66227);
insert into MUSEDINT (tid, mid)
values (55128, 98517);
insert into MUSEDINT (tid, mid)
values (55142, 15869);
insert into MUSEDINT (tid, mid)
values (55142, 91329);
insert into MUSEDINT (tid, mid)
values (55159, 49631);
insert into MUSEDINT (tid, mid)
values (55194, 68771);
insert into MUSEDINT (tid, mid)
values (55383, 64876);
insert into MUSEDINT (tid, mid)
values (55476, 53673);
insert into MUSEDINT (tid, mid)
values (55476, 63597);
insert into MUSEDINT (tid, mid)
values (55476, 84617);
insert into MUSEDINT (tid, mid)
values (55476, 93815);
insert into MUSEDINT (tid, mid)
values (55534, 63768);
insert into MUSEDINT (tid, mid)
values (55534, 81162);
insert into MUSEDINT (tid, mid)
values (55837, 15869);
insert into MUSEDINT (tid, mid)
values (55837, 74315);
insert into MUSEDINT (tid, mid)
values (55853, 22677);
insert into MUSEDINT (tid, mid)
values (55856, 11997);
insert into MUSEDINT (tid, mid)
values (55856, 16475);
insert into MUSEDINT (tid, mid)
values (55856, 87588);
insert into MUSEDINT (tid, mid)
values (55856, 94219);
insert into MUSEDINT (tid, mid)
values (55941, 19246);
insert into MUSEDINT (tid, mid)
values (55941, 98712);
insert into MUSEDINT (tid, mid)
values (56151, 27219);
insert into MUSEDINT (tid, mid)
values (56151, 59486);
insert into MUSEDINT (tid, mid)
values (56151, 64219);
insert into MUSEDINT (tid, mid)
values (56217, 13657);
insert into MUSEDINT (tid, mid)
values (56679, 75629);
insert into MUSEDINT (tid, mid)
values (56679, 75759);
insert into MUSEDINT (tid, mid)
values (57236, 18661);
insert into MUSEDINT (tid, mid)
values (57236, 24124);
insert into MUSEDINT (tid, mid)
values (57256, 64683);
insert into MUSEDINT (tid, mid)
values (57499, 50003);
insert into MUSEDINT (tid, mid)
values (57734, 56794);
insert into MUSEDINT (tid, mid)
values (57734, 88294);
insert into MUSEDINT (tid, mid)
values (57765, 29767);
insert into MUSEDINT (tid, mid)
values (58257, 15199);
insert into MUSEDINT (tid, mid)
values (58257, 27995);
insert into MUSEDINT (tid, mid)
values (58261, 29738);
insert into MUSEDINT (tid, mid)
values (58261, 33518);
insert into MUSEDINT (tid, mid)
values (58261, 46679);
insert into MUSEDINT (tid, mid)
values (58261, 84215);
insert into MUSEDINT (tid, mid)
values (58264, 15869);
insert into MUSEDINT (tid, mid)
values (58264, 32523);
insert into MUSEDINT (tid, mid)
values (58264, 37596);
insert into MUSEDINT (tid, mid)
values (58264, 57612);
commit;
prompt 400 records committed...
insert into MUSEDINT (tid, mid)
values (58264, 87588);
insert into MUSEDINT (tid, mid)
values (58264, 98712);
insert into MUSEDINT (tid, mid)
values (58267, 88563);
insert into MUSEDINT (tid, mid)
values (58469, 13655);
insert into MUSEDINT (tid, mid)
values (58469, 50010);
insert into MUSEDINT (tid, mid)
values (58469, 55873);
insert into MUSEDINT (tid, mid)
values (58514, 97524);
insert into MUSEDINT (tid, mid)
values (58861, 37596);
insert into MUSEDINT (tid, mid)
values (58861, 43963);
insert into MUSEDINT (tid, mid)
values (58861, 84617);
insert into MUSEDINT (tid, mid)
values (58882, 13449);
insert into MUSEDINT (tid, mid)
values (58882, 57861);
insert into MUSEDINT (tid, mid)
values (59576, 79135);
insert into MUSEDINT (tid, mid)
values (59576, 97441);
insert into MUSEDINT (tid, mid)
values (59848, 56184);
insert into MUSEDINT (tid, mid)
values (59859, 61951);
insert into MUSEDINT (tid, mid)
values (59859, 94698);
insert into MUSEDINT (tid, mid)
values (59859, 97217);
insert into MUSEDINT (tid, mid)
values (59883, 91563);
insert into MUSEDINT (tid, mid)
values (61161, 16418);
insert into MUSEDINT (tid, mid)
values (61161, 93566);
insert into MUSEDINT (tid, mid)
values (61161, 99141);
insert into MUSEDINT (tid, mid)
values (61278, 67682);
insert into MUSEDINT (tid, mid)
values (61278, 82918);
insert into MUSEDINT (tid, mid)
values (61278, 97217);
insert into MUSEDINT (tid, mid)
values (61466, 92816);
insert into MUSEDINT (tid, mid)
values (61469, 50008);
insert into MUSEDINT (tid, mid)
values (61469, 52425);
insert into MUSEDINT (tid, mid)
values (61571, 38921);
insert into MUSEDINT (tid, mid)
values (61571, 93815);
insert into MUSEDINT (tid, mid)
values (61725, 68545);
insert into MUSEDINT (tid, mid)
values (61725, 69521);
insert into MUSEDINT (tid, mid)
values (61725, 78237);
insert into MUSEDINT (tid, mid)
values (61725, 92816);
insert into MUSEDINT (tid, mid)
values (61751, 26927);
insert into MUSEDINT (tid, mid)
values (61751, 44888);
insert into MUSEDINT (tid, mid)
values (61751, 93643);
insert into MUSEDINT (tid, mid)
values (61751, 99117);
insert into MUSEDINT (tid, mid)
values (62262, 27219);
insert into MUSEDINT (tid, mid)
values (62262, 75629);
insert into MUSEDINT (tid, mid)
values (62348, 97792);
insert into MUSEDINT (tid, mid)
values (62824, 34263);
insert into MUSEDINT (tid, mid)
values (62824, 36876);
insert into MUSEDINT (tid, mid)
values (62824, 69498);
insert into MUSEDINT (tid, mid)
values (63187, 31714);
insert into MUSEDINT (tid, mid)
values (63187, 67121);
insert into MUSEDINT (tid, mid)
values (63439, 36935);
insert into MUSEDINT (tid, mid)
values (63453, 64219);
insert into MUSEDINT (tid, mid)
values (63454, 38569);
insert into MUSEDINT (tid, mid)
values (63454, 44261);
insert into MUSEDINT (tid, mid)
values (63454, 64735);
insert into MUSEDINT (tid, mid)
values (63569, 74929);
insert into MUSEDINT (tid, mid)
values (63726, 21275);
insert into MUSEDINT (tid, mid)
values (63726, 69235);
insert into MUSEDINT (tid, mid)
values (63929, 35459);
insert into MUSEDINT (tid, mid)
values (63929, 76277);
insert into MUSEDINT (tid, mid)
values (63961, 59486);
insert into MUSEDINT (tid, mid)
values (63961, 75612);
insert into MUSEDINT (tid, mid)
values (63961, 76774);
insert into MUSEDINT (tid, mid)
values (64193, 12999);
insert into MUSEDINT (tid, mid)
values (64193, 97659);
insert into MUSEDINT (tid, mid)
values (64213, 13682);
insert into MUSEDINT (tid, mid)
values (64274, 56126);
insert into MUSEDINT (tid, mid)
values (64274, 66187);
insert into MUSEDINT (tid, mid)
values (64435, 17368);
insert into MUSEDINT (tid, mid)
values (64435, 44888);
insert into MUSEDINT (tid, mid)
values (64435, 56873);
insert into MUSEDINT (tid, mid)
values (64435, 86571);
insert into MUSEDINT (tid, mid)
values (64556, 68496);
insert into MUSEDINT (tid, mid)
values (64624, 50006);
insert into MUSEDINT (tid, mid)
values (65132, 42712);
insert into MUSEDINT (tid, mid)
values (65132, 53354);
insert into MUSEDINT (tid, mid)
values (65132, 63677);
insert into MUSEDINT (tid, mid)
values (65135, 97875);
insert into MUSEDINT (tid, mid)
values (65137, 48693);
insert into MUSEDINT (tid, mid)
values (65137, 50007);
insert into MUSEDINT (tid, mid)
values (65137, 68834);
insert into MUSEDINT (tid, mid)
values (65894, 19776);
insert into MUSEDINT (tid, mid)
values (65894, 47254);
insert into MUSEDINT (tid, mid)
values (65894, 55764);
insert into MUSEDINT (tid, mid)
values (65959, 81624);
insert into MUSEDINT (tid, mid)
values (66121, 27219);
insert into MUSEDINT (tid, mid)
values (66121, 62838);
insert into MUSEDINT (tid, mid)
values (66786, 68545);
insert into MUSEDINT (tid, mid)
values (66786, 97524);
insert into MUSEDINT (tid, mid)
values (66853, 29738);
insert into MUSEDINT (tid, mid)
values (66853, 79534);
insert into MUSEDINT (tid, mid)
values (67264, 53999);
insert into MUSEDINT (tid, mid)
values (67698, 61271);
insert into MUSEDINT (tid, mid)
values (67698, 71862);
insert into MUSEDINT (tid, mid)
values (67698, 79135);
insert into MUSEDINT (tid, mid)
values (67922, 23116);
insert into MUSEDINT (tid, mid)
values (67922, 26497);
insert into MUSEDINT (tid, mid)
values (68228, 11997);
insert into MUSEDINT (tid, mid)
values (68228, 92858);
insert into MUSEDINT (tid, mid)
values (68378, 29767);
insert into MUSEDINT (tid, mid)
values (68449, 24511);
insert into MUSEDINT (tid, mid)
values (68449, 44261);
insert into MUSEDINT (tid, mid)
values (68541, 64442);
insert into MUSEDINT (tid, mid)
values (69323, 23116);
commit;
prompt 500 records committed...
insert into MUSEDINT (tid, mid)
values (69323, 44572);
insert into MUSEDINT (tid, mid)
values (69417, 26412);
insert into MUSEDINT (tid, mid)
values (69417, 45884);
insert into MUSEDINT (tid, mid)
values (69548, 24115);
insert into MUSEDINT (tid, mid)
values (69637, 36778);
insert into MUSEDINT (tid, mid)
values (69989, 63677);
insert into MUSEDINT (tid, mid)
values (69992, 25392);
insert into MUSEDINT (tid, mid)
values (69992, 48693);
insert into MUSEDINT (tid, mid)
values (69992, 83212);
insert into MUSEDINT (tid, mid)
values (71249, 29225);
insert into MUSEDINT (tid, mid)
values (71249, 98712);
insert into MUSEDINT (tid, mid)
values (71465, 63414);
insert into MUSEDINT (tid, mid)
values (71531, 58887);
insert into MUSEDINT (tid, mid)
values (71531, 89574);
insert into MUSEDINT (tid, mid)
values (71824, 33316);
insert into MUSEDINT (tid, mid)
values (71824, 92858);
insert into MUSEDINT (tid, mid)
values (71983, 32832);
insert into MUSEDINT (tid, mid)
values (72198, 17846);
insert into MUSEDINT (tid, mid)
values (72284, 51927);
insert into MUSEDINT (tid, mid)
values (72385, 55635);
insert into MUSEDINT (tid, mid)
values (72385, 84832);
insert into MUSEDINT (tid, mid)
values (72427, 25765);
insert into MUSEDINT (tid, mid)
values (72427, 50007);
insert into MUSEDINT (tid, mid)
values (72427, 66187);
insert into MUSEDINT (tid, mid)
values (72641, 53673);
insert into MUSEDINT (tid, mid)
values (72641, 82597);
insert into MUSEDINT (tid, mid)
values (73173, 11462);
insert into MUSEDINT (tid, mid)
values (73173, 38187);
insert into MUSEDINT (tid, mid)
values (73173, 61695);
insert into MUSEDINT (tid, mid)
values (73179, 15228);
insert into MUSEDINT (tid, mid)
values (73447, 42395);
insert into MUSEDINT (tid, mid)
values (73447, 51142);
insert into MUSEDINT (tid, mid)
values (73447, 53715);
insert into MUSEDINT (tid, mid)
values (73447, 84832);
insert into MUSEDINT (tid, mid)
values (73772, 66187);
insert into MUSEDINT (tid, mid)
values (73797, 72235);
insert into MUSEDINT (tid, mid)
values (74348, 41729);
insert into MUSEDINT (tid, mid)
values (74348, 86571);
insert into MUSEDINT (tid, mid)
values (74871, 18661);
insert into MUSEDINT (tid, mid)
values (74871, 26199);
insert into MUSEDINT (tid, mid)
values (74871, 53235);
insert into MUSEDINT (tid, mid)
values (74871, 74315);
insert into MUSEDINT (tid, mid)
values (74871, 84832);
insert into MUSEDINT (tid, mid)
values (75261, 15199);
insert into MUSEDINT (tid, mid)
values (75261, 46242);
insert into MUSEDINT (tid, mid)
values (75261, 50007);
insert into MUSEDINT (tid, mid)
values (75261, 53212);
insert into MUSEDINT (tid, mid)
values (75261, 53715);
insert into MUSEDINT (tid, mid)
values (75421, 29336);
insert into MUSEDINT (tid, mid)
values (75421, 33316);
insert into MUSEDINT (tid, mid)
values (75421, 42712);
insert into MUSEDINT (tid, mid)
values (75421, 43389);
insert into MUSEDINT (tid, mid)
values (75487, 50007);
insert into MUSEDINT (tid, mid)
values (75487, 57726);
insert into MUSEDINT (tid, mid)
values (75574, 27132);
insert into MUSEDINT (tid, mid)
values (75664, 50005);
insert into MUSEDINT (tid, mid)
values (75819, 12353);
insert into MUSEDINT (tid, mid)
values (75819, 84215);
insert into MUSEDINT (tid, mid)
values (76218, 16538);
insert into MUSEDINT (tid, mid)
values (76218, 19976);
insert into MUSEDINT (tid, mid)
values (76218, 42637);
insert into MUSEDINT (tid, mid)
values (76218, 69498);
insert into MUSEDINT (tid, mid)
values (76229, 32666);
insert into MUSEDINT (tid, mid)
values (76229, 75759);
insert into MUSEDINT (tid, mid)
values (76278, 54715);
insert into MUSEDINT (tid, mid)
values (76278, 79135);
insert into MUSEDINT (tid, mid)
values (76278, 83212);
insert into MUSEDINT (tid, mid)
values (76324, 15953);
insert into MUSEDINT (tid, mid)
values (76324, 22533);
insert into MUSEDINT (tid, mid)
values (76324, 86223);
insert into MUSEDINT (tid, mid)
values (76614, 64741);
insert into MUSEDINT (tid, mid)
values (76614, 93786);
insert into MUSEDINT (tid, mid)
values (76852, 19976);
insert into MUSEDINT (tid, mid)
values (76852, 44786);
insert into MUSEDINT (tid, mid)
values (76939, 15484);
insert into MUSEDINT (tid, mid)
values (76939, 18938);
insert into MUSEDINT (tid, mid)
values (76939, 59486);
insert into MUSEDINT (tid, mid)
values (76939, 61582);
insert into MUSEDINT (tid, mid)
values (76939, 79172);
insert into MUSEDINT (tid, mid)
values (76939, 99117);
insert into MUSEDINT (tid, mid)
values (77463, 25558);
insert into MUSEDINT (tid, mid)
values (77463, 97217);
insert into MUSEDINT (tid, mid)
values (77591, 12999);
insert into MUSEDINT (tid, mid)
values (77591, 64735);
insert into MUSEDINT (tid, mid)
values (78153, 18182);
insert into MUSEDINT (tid, mid)
values (78153, 36313);
insert into MUSEDINT (tid, mid)
values (78153, 51857);
insert into MUSEDINT (tid, mid)
values (78153, 63993);
insert into MUSEDINT (tid, mid)
values (78488, 63597);
insert into MUSEDINT (tid, mid)
values (78516, 18288);
insert into MUSEDINT (tid, mid)
values (78516, 24511);
insert into MUSEDINT (tid, mid)
values (78516, 29738);
insert into MUSEDINT (tid, mid)
values (78516, 36935);
insert into MUSEDINT (tid, mid)
values (78516, 37142);
insert into MUSEDINT (tid, mid)
values (78516, 45711);
insert into MUSEDINT (tid, mid)
values (78657, 22461);
insert into MUSEDINT (tid, mid)
values (78657, 83147);
insert into MUSEDINT (tid, mid)
values (79265, 25767);
insert into MUSEDINT (tid, mid)
values (79265, 32358);
insert into MUSEDINT (tid, mid)
values (79265, 33316);
commit;
prompt 600 records committed...
insert into MUSEDINT (tid, mid)
values (79265, 78237);
insert into MUSEDINT (tid, mid)
values (79265, 95625);
insert into MUSEDINT (tid, mid)
values (79335, 54715);
insert into MUSEDINT (tid, mid)
values (79892, 11997);
insert into MUSEDINT (tid, mid)
values (81239, 66227);
insert into MUSEDINT (tid, mid)
values (81239, 77556);
insert into MUSEDINT (tid, mid)
values (81239, 83539);
insert into MUSEDINT (tid, mid)
values (81263, 78514);
insert into MUSEDINT (tid, mid)
values (81263, 83229);
insert into MUSEDINT (tid, mid)
values (81291, 50001);
insert into MUSEDINT (tid, mid)
values (81329, 54715);
insert into MUSEDINT (tid, mid)
values (81329, 67682);
insert into MUSEDINT (tid, mid)
values (81339, 12353);
insert into MUSEDINT (tid, mid)
values (81339, 26222);
insert into MUSEDINT (tid, mid)
values (81339, 27219);
insert into MUSEDINT (tid, mid)
values (81339, 29122);
insert into MUSEDINT (tid, mid)
values (81339, 29138);
insert into MUSEDINT (tid, mid)
values (81366, 25392);
insert into MUSEDINT (tid, mid)
values (81366, 50004);
insert into MUSEDINT (tid, mid)
values (81366, 97875);
insert into MUSEDINT (tid, mid)
values (81556, 63651);
insert into MUSEDINT (tid, mid)
values (81556, 97441);
insert into MUSEDINT (tid, mid)
values (81758, 27259);
insert into MUSEDINT (tid, mid)
values (81758, 72235);
insert into MUSEDINT (tid, mid)
values (81992, 34646);
insert into MUSEDINT (tid, mid)
values (81992, 44175);
insert into MUSEDINT (tid, mid)
values (82157, 36647);
insert into MUSEDINT (tid, mid)
values (82157, 55661);
insert into MUSEDINT (tid, mid)
values (82157, 57368);
insert into MUSEDINT (tid, mid)
values (82416, 19857);
insert into MUSEDINT (tid, mid)
values (82416, 43389);
insert into MUSEDINT (tid, mid)
values (82416, 82665);
insert into MUSEDINT (tid, mid)
values (82736, 82444);
insert into MUSEDINT (tid, mid)
values (83316, 44583);
insert into MUSEDINT (tid, mid)
values (83316, 55764);
insert into MUSEDINT (tid, mid)
values (83436, 97128);
insert into MUSEDINT (tid, mid)
values (83652, 28379);
insert into MUSEDINT (tid, mid)
values (83652, 29442);
insert into MUSEDINT (tid, mid)
values (83652, 42712);
insert into MUSEDINT (tid, mid)
values (83715, 15869);
insert into MUSEDINT (tid, mid)
values (83715, 42346);
insert into MUSEDINT (tid, mid)
values (83715, 47254);
insert into MUSEDINT (tid, mid)
values (83715, 86561);
insert into MUSEDINT (tid, mid)
values (83735, 12353);
insert into MUSEDINT (tid, mid)
values (83735, 18298);
insert into MUSEDINT (tid, mid)
values (83735, 50003);
insert into MUSEDINT (tid, mid)
values (83735, 51857);
insert into MUSEDINT (tid, mid)
values (83735, 88489);
insert into MUSEDINT (tid, mid)
values (83824, 13449);
insert into MUSEDINT (tid, mid)
values (83824, 57368);
insert into MUSEDINT (tid, mid)
values (83824, 63597);
insert into MUSEDINT (tid, mid)
values (83824, 68834);
insert into MUSEDINT (tid, mid)
values (83824, 75288);
insert into MUSEDINT (tid, mid)
values (85435, 77646);
insert into MUSEDINT (tid, mid)
values (85517, 11871);
insert into MUSEDINT (tid, mid)
values (85517, 15484);
insert into MUSEDINT (tid, mid)
values (85517, 44175);
insert into MUSEDINT (tid, mid)
values (85577, 15958);
insert into MUSEDINT (tid, mid)
values (85642, 50010);
insert into MUSEDINT (tid, mid)
values (85642, 53235);
insert into MUSEDINT (tid, mid)
values (85642, 54715);
insert into MUSEDINT (tid, mid)
values (85741, 24183);
insert into MUSEDINT (tid, mid)
values (85741, 86223);
insert into MUSEDINT (tid, mid)
values (85796, 32358);
insert into MUSEDINT (tid, mid)
values (85796, 64219);
insert into MUSEDINT (tid, mid)
values (85923, 59486);
insert into MUSEDINT (tid, mid)
values (86193, 99962);
insert into MUSEDINT (tid, mid)
values (86448, 25811);
insert into MUSEDINT (tid, mid)
values (86448, 29442);
insert into MUSEDINT (tid, mid)
values (86448, 46333);
insert into MUSEDINT (tid, mid)
values (86448, 59841);
insert into MUSEDINT (tid, mid)
values (86759, 36935);
insert into MUSEDINT (tid, mid)
values (86759, 91329);
insert into MUSEDINT (tid, mid)
values (86775, 47254);
insert into MUSEDINT (tid, mid)
values (86933, 44141);
insert into MUSEDINT (tid, mid)
values (86933, 68343);
insert into MUSEDINT (tid, mid)
values (87568, 14131);
insert into MUSEDINT (tid, mid)
values (87568, 29411);
insert into MUSEDINT (tid, mid)
values (87568, 75759);
insert into MUSEDINT (tid, mid)
values (87629, 54227);
insert into MUSEDINT (tid, mid)
values (87629, 74929);
insert into MUSEDINT (tid, mid)
values (87629, 92543);
insert into MUSEDINT (tid, mid)
values (87723, 64442);
insert into MUSEDINT (tid, mid)
values (87726, 32358);
insert into MUSEDINT (tid, mid)
values (87726, 32832);
insert into MUSEDINT (tid, mid)
values (87726, 51773);
insert into MUSEDINT (tid, mid)
values (87726, 54815);
insert into MUSEDINT (tid, mid)
values (87726, 97792);
insert into MUSEDINT (tid, mid)
values (87874, 49899);
insert into MUSEDINT (tid, mid)
values (87874, 75629);
insert into MUSEDINT (tid, mid)
values (87911, 75523);
insert into MUSEDINT (tid, mid)
values (88828, 42862);
insert into MUSEDINT (tid, mid)
values (88828, 75214);
insert into MUSEDINT (tid, mid)
values (88828, 96364);
insert into MUSEDINT (tid, mid)
values (89365, 47254);
insert into MUSEDINT (tid, mid)
values (89365, 49119);
insert into MUSEDINT (tid, mid)
values (89365, 63222);
insert into MUSEDINT (tid, mid)
values (89395, 61678);
insert into MUSEDINT (tid, mid)
values (89584, 53354);
insert into MUSEDINT (tid, mid)
values (89584, 57726);
commit;
prompt 700 records committed...
insert into MUSEDINT (tid, mid)
values (89622, 75759);
insert into MUSEDINT (tid, mid)
values (89623, 22792);
insert into MUSEDINT (tid, mid)
values (89835, 72459);
insert into MUSEDINT (tid, mid)
values (89842, 17584);
insert into MUSEDINT (tid, mid)
values (89842, 33316);
insert into MUSEDINT (tid, mid)
values (89842, 73532);
insert into MUSEDINT (tid, mid)
values (89842, 88277);
insert into MUSEDINT (tid, mid)
values (89842, 89721);
insert into MUSEDINT (tid, mid)
values (89886, 44583);
insert into MUSEDINT (tid, mid)
values (89886, 64295);
insert into MUSEDINT (tid, mid)
values (91341, 15958);
insert into MUSEDINT (tid, mid)
values (91341, 17776);
insert into MUSEDINT (tid, mid)
values (91341, 24183);
insert into MUSEDINT (tid, mid)
values (91341, 26499);
insert into MUSEDINT (tid, mid)
values (91341, 99117);
insert into MUSEDINT (tid, mid)
values (91414, 59978);
insert into MUSEDINT (tid, mid)
values (91414, 71339);
insert into MUSEDINT (tid, mid)
values (91414, 74929);
insert into MUSEDINT (tid, mid)
values (91414, 98781);
insert into MUSEDINT (tid, mid)
values (91757, 61271);
insert into MUSEDINT (tid, mid)
values (91757, 87251);
insert into MUSEDINT (tid, mid)
values (91954, 78965);
insert into MUSEDINT (tid, mid)
values (91977, 53257);
insert into MUSEDINT (tid, mid)
values (91977, 81162);
insert into MUSEDINT (tid, mid)
values (91977, 87251);
insert into MUSEDINT (tid, mid)
values (92264, 32523);
insert into MUSEDINT (tid, mid)
values (92264, 97792);
insert into MUSEDINT (tid, mid)
values (92415, 96421);
insert into MUSEDINT (tid, mid)
values (92415, 99117);
insert into MUSEDINT (tid, mid)
values (92566, 66972);
insert into MUSEDINT (tid, mid)
values (92627, 19246);
insert into MUSEDINT (tid, mid)
values (92639, 19976);
insert into MUSEDINT (tid, mid)
values (92639, 75612);
insert into MUSEDINT (tid, mid)
values (92957, 66362);
insert into MUSEDINT (tid, mid)
values (92957, 97823);
insert into MUSEDINT (tid, mid)
values (92978, 14175);
insert into MUSEDINT (tid, mid)
values (92978, 16331);
insert into MUSEDINT (tid, mid)
values (92978, 66362);
insert into MUSEDINT (tid, mid)
values (92978, 79737);
insert into MUSEDINT (tid, mid)
values (93262, 16331);
insert into MUSEDINT (tid, mid)
values (93326, 43963);
insert into MUSEDINT (tid, mid)
values (93326, 68834);
insert into MUSEDINT (tid, mid)
values (93545, 27386);
insert into MUSEDINT (tid, mid)
values (93545, 28379);
insert into MUSEDINT (tid, mid)
values (93974, 91849);
insert into MUSEDINT (tid, mid)
values (93974, 94698);
insert into MUSEDINT (tid, mid)
values (94371, 15484);
insert into MUSEDINT (tid, mid)
values (94371, 72479);
insert into MUSEDINT (tid, mid)
values (94471, 27386);
insert into MUSEDINT (tid, mid)
values (94471, 33518);
insert into MUSEDINT (tid, mid)
values (94471, 63597);
insert into MUSEDINT (tid, mid)
values (94471, 82918);
insert into MUSEDINT (tid, mid)
values (94556, 63677);
insert into MUSEDINT (tid, mid)
values (94556, 78965);
insert into MUSEDINT (tid, mid)
values (94664, 11127);
insert into MUSEDINT (tid, mid)
values (94664, 75611);
insert into MUSEDINT (tid, mid)
values (94996, 17889);
insert into MUSEDINT (tid, mid)
values (94996, 43389);
insert into MUSEDINT (tid, mid)
values (95197, 54674);
insert into MUSEDINT (tid, mid)
values (95253, 93566);
insert into MUSEDINT (tid, mid)
values (95395, 46421);
insert into MUSEDINT (tid, mid)
values (95395, 62838);
insert into MUSEDINT (tid, mid)
values (95429, 19857);
insert into MUSEDINT (tid, mid)
values (95429, 33316);
insert into MUSEDINT (tid, mid)
values (95429, 83983);
insert into MUSEDINT (tid, mid)
values (95589, 43389);
insert into MUSEDINT (tid, mid)
values (95993, 41311);
insert into MUSEDINT (tid, mid)
values (95993, 66187);
insert into MUSEDINT (tid, mid)
values (95993, 71452);
insert into MUSEDINT (tid, mid)
values (95993, 81624);
insert into MUSEDINT (tid, mid)
values (96533, 23585);
insert into MUSEDINT (tid, mid)
values (96533, 50010);
insert into MUSEDINT (tid, mid)
values (96629, 22533);
insert into MUSEDINT (tid, mid)
values (96629, 52117);
insert into MUSEDINT (tid, mid)
values (96629, 91854);
insert into MUSEDINT (tid, mid)
values (96629, 92543);
insert into MUSEDINT (tid, mid)
values (97162, 38921);
insert into MUSEDINT (tid, mid)
values (97162, 55438);
insert into MUSEDINT (tid, mid)
values (97218, 98796);
insert into MUSEDINT (tid, mid)
values (97845, 49119);
insert into MUSEDINT (tid, mid)
values (97845, 63768);
insert into MUSEDINT (tid, mid)
values (97898, 18197);
insert into MUSEDINT (tid, mid)
values (97898, 49631);
insert into MUSEDINT (tid, mid)
values (97898, 97441);
insert into MUSEDINT (tid, mid)
values (98297, 34263);
insert into MUSEDINT (tid, mid)
values (98297, 43389);
insert into MUSEDINT (tid, mid)
values (98297, 94596);
insert into MUSEDINT (tid, mid)
values (98519, 95514);
insert into MUSEDINT (tid, mid)
values (99444, 26412);
insert into MUSEDINT (tid, mid)
values (99444, 36778);
insert into MUSEDINT (tid, mid)
values (99444, 54227);
insert into MUSEDINT (tid, mid)
values (99444, 71723);
insert into MUSEDINT (tid, mid)
values (99588, 56873);
insert into MUSEDINT (tid, mid)
values (99588, 63236);
insert into MUSEDINT (tid, mid)
values (99588, 98517);
insert into MUSEDINT (tid, mid)
values (99975, 42668);
insert into MUSEDINT (tid, mid)
values (99975, 97441);
commit;
prompt 797 records loaded
prompt Loading OFFICE...
insert into OFFICE (otype, sid)
values ('Customer Servic', 21395);
insert into OFFICE (otype, sid)
values ('Customer Servic', 40705);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15536);
insert into OFFICE (otype, sid)
values ('Shift Manager', 55546);
insert into OFFICE (otype, sid)
values ('Shift Manager', 22236);
insert into OFFICE (otype, sid)
values ('Customer Servic', 17595);
insert into OFFICE (otype, sid)
values ('IT', 69468);
insert into OFFICE (otype, sid)
values ('Counter', 12053);
insert into OFFICE (otype, sid)
values ('Counter', 83271);
insert into OFFICE (otype, sid)
values ('Shift Manager', 56476);
insert into OFFICE (otype, sid)
values ('Shift Manager', 74548);
insert into OFFICE (otype, sid)
values ('IT', 70482);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 51524);
insert into OFFICE (otype, sid)
values ('IT', 64185);
insert into OFFICE (otype, sid)
values ('Customer Servic', 90152);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 41120);
insert into OFFICE (otype, sid)
values ('IT', 83831);
insert into OFFICE (otype, sid)
values ('Shift Manager', 17989);
insert into OFFICE (otype, sid)
values ('Customer Servic', 30696);
insert into OFFICE (otype, sid)
values ('IT', 74841);
insert into OFFICE (otype, sid)
values ('Shift Manager', 59839);
insert into OFFICE (otype, sid)
values ('Customer Servic', 98364);
insert into OFFICE (otype, sid)
values ('Counter', 96640);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 24608);
insert into OFFICE (otype, sid)
values ('Customer Servic', 17105);
insert into OFFICE (otype, sid)
values ('Counter', 91539);
insert into OFFICE (otype, sid)
values ('Customer Servic', 28053);
insert into OFFICE (otype, sid)
values ('Shift Manager', 23821);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 45223);
insert into OFFICE (otype, sid)
values ('Shift Manager', 53805);
insert into OFFICE (otype, sid)
values ('Shift Manager', 76380);
insert into OFFICE (otype, sid)
values ('IT', 27991);
insert into OFFICE (otype, sid)
values ('IT', 89350);
insert into OFFICE (otype, sid)
values ('Shift Manager', 22440);
insert into OFFICE (otype, sid)
values ('Counter', 81284);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15746);
insert into OFFICE (otype, sid)
values ('IT', 34609);
insert into OFFICE (otype, sid)
values ('Customer Servic', 15343);
insert into OFFICE (otype, sid)
values ('IT', 82187);
insert into OFFICE (otype, sid)
values ('Customer Servic', 20080);
insert into OFFICE (otype, sid)
values ('IT', 55295);
insert into OFFICE (otype, sid)
values ('IT', 93908);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99681);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61546);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99769);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61039);
insert into OFFICE (otype, sid)
values ('Counter', 19671);
insert into OFFICE (otype, sid)
values ('Counter', 27600);
insert into OFFICE (otype, sid)
values ('Shift Manager', 91660);
insert into OFFICE (otype, sid)
values ('Counter', 39306);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61721);
insert into OFFICE (otype, sid)
values ('IT', 67343);
insert into OFFICE (otype, sid)
values ('Customer Servic', 91368);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18401);
insert into OFFICE (otype, sid)
values ('IT', 65741);
insert into OFFICE (otype, sid)
values ('Shift Manager', 18863);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 95541);
insert into OFFICE (otype, sid)
values ('Customer Servic', 84940);
insert into OFFICE (otype, sid)
values ('Shift Manager', 66029);
insert into OFFICE (otype, sid)
values ('Counter', 55244);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 10005);
insert into OFFICE (otype, sid)
values ('IT', 58235);
insert into OFFICE (otype, sid)
values ('IT', 33143);
insert into OFFICE (otype, sid)
values ('IT', 16012);
insert into OFFICE (otype, sid)
values ('Counter', 54662);
insert into OFFICE (otype, sid)
values ('Customer Servic', 59791);
insert into OFFICE (otype, sid)
values ('IT', 57210);
insert into OFFICE (otype, sid)
values ('IT', 49666);
insert into OFFICE (otype, sid)
values ('Customer Servic', 51861);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 42991);
insert into OFFICE (otype, sid)
values ('Counter', 15962);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 97879);
insert into OFFICE (otype, sid)
values ('IT', 70610);
insert into OFFICE (otype, sid)
values ('Shift Manager', 25922);
insert into OFFICE (otype, sid)
values ('Counter', 90376);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99778);
insert into OFFICE (otype, sid)
values ('Shift Manager', 26135);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18773);
insert into OFFICE (otype, sid)
values ('Counter', 27637);
insert into OFFICE (otype, sid)
values ('IT', 98750);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 54266);
insert into OFFICE (otype, sid)
values ('Counter', 89885);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15963);
insert into OFFICE (otype, sid)
values ('Counter', 79374);
insert into OFFICE (otype, sid)
values ('Counter', 12082);
insert into OFFICE (otype, sid)
values ('Counter', 37345);
insert into OFFICE (otype, sid)
values ('IT', 44433);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 16063);
insert into OFFICE (otype, sid)
values ('Customer Servic', 31151);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 33749);
insert into OFFICE (otype, sid)
values ('Shift Manager', 77955);
insert into OFFICE (otype, sid)
values ('Shift Manager', 37415);
insert into OFFICE (otype, sid)
values ('Counter', 10009);
insert into OFFICE (otype, sid)
values ('IT', 19936);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 92960);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 30379);
insert into OFFICE (otype, sid)
values ('IT', 45377);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 39663);
insert into OFFICE (otype, sid)
values ('Customer Servic', 62741);
insert into OFFICE (otype, sid)
values ('Counter', 23953);
commit;
prompt 100 records committed...
insert into OFFICE (otype, sid)
values ('IT', 89337);
insert into OFFICE (otype, sid)
values ('Shift Manager', 92935);
insert into OFFICE (otype, sid)
values ('Counter', 83211);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 73025);
insert into OFFICE (otype, sid)
values ('Shift Manager', 81157);
insert into OFFICE (otype, sid)
values ('Counter', 88541);
insert into OFFICE (otype, sid)
values ('Customer Servic', 36012);
insert into OFFICE (otype, sid)
values ('IT', 66193);
insert into OFFICE (otype, sid)
values ('Customer Servic', 92716);
insert into OFFICE (otype, sid)
values ('Customer Servic', 19365);
insert into OFFICE (otype, sid)
values ('Customer Servic', 39365);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99553);
insert into OFFICE (otype, sid)
values ('Customer Servic', 30063);
insert into OFFICE (otype, sid)
values ('Shift Manager', 72375);
insert into OFFICE (otype, sid)
values ('Counter', 44156);
insert into OFFICE (otype, sid)
values ('IT', 42679);
insert into OFFICE (otype, sid)
values ('Customer Servic', 21570);
insert into OFFICE (otype, sid)
values ('Customer Servic', 35553);
insert into OFFICE (otype, sid)
values ('IT', 46197);
insert into OFFICE (otype, sid)
values ('Customer Servic', 72497);
insert into OFFICE (otype, sid)
values ('Shift Manager', 28651);
insert into OFFICE (otype, sid)
values ('Shift Manager', 27715);
insert into OFFICE (otype, sid)
values ('IT', 26952);
insert into OFFICE (otype, sid)
values ('Shift Manager', 91865);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 19618);
insert into OFFICE (otype, sid)
values ('Customer Servic', 96641);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 96456);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 49506);
insert into OFFICE (otype, sid)
values ('Counter', 99475);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 19098);
insert into OFFICE (otype, sid)
values ('Shift Manager', 40849);
insert into OFFICE (otype, sid)
values ('Customer Servic', 49449);
insert into OFFICE (otype, sid)
values ('Shift Manager', 27277);
insert into OFFICE (otype, sid)
values ('Customer Servic', 34404);
insert into OFFICE (otype, sid)
values ('IT', 91156);
insert into OFFICE (otype, sid)
values ('IT', 79591);
insert into OFFICE (otype, sid)
values ('IT', 32568);
insert into OFFICE (otype, sid)
values ('IT', 31845);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 40041);
insert into OFFICE (otype, sid)
values ('IT', 45148);
insert into OFFICE (otype, sid)
values ('IT', 94830);
insert into OFFICE (otype, sid)
values ('Customer Servic', 31696);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 68229);
insert into OFFICE (otype, sid)
values ('Shift Manager', 86842);
insert into OFFICE (otype, sid)
values ('Secretariat', 10011);
insert into OFFICE (otype, sid)
values ('Sales', 10012);
insert into OFFICE (otype, sid)
values ('Secretariat', 10013);
insert into OFFICE (otype, sid)
values ('Sales', 10014);
insert into OFFICE (otype, sid)
values ('Secretariat', 10015);
insert into OFFICE (otype, sid)
values ('Secretariat', 10016);
insert into OFFICE (otype, sid)
values ('Sales', 10017);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10018);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10019);
insert into OFFICE (otype, sid)
values ('Sales', 10020);
insert into OFFICE (otype, sid)
values ('Shift Manager', 12979);
insert into OFFICE (otype, sid)
values ('Sales', 68062);
insert into OFFICE (otype, sid)
values ('Customer Servic', 59041);
insert into OFFICE (otype, sid)
values ('Secretariat''', 73373);
insert into OFFICE (otype, sid)
values ('Shift Manager', 87171);
insert into OFFICE (otype, sid)
values ('Secretariat''', 78572);
insert into OFFICE (otype, sid)
values ('Secretariat''', 41224);
insert into OFFICE (otype, sid)
values ('Shift Manager', 86483);
insert into OFFICE (otype, sid)
values ('Sales', 57569);
insert into OFFICE (otype, sid)
values ('Secretariat''', 29872);
insert into OFFICE (otype, sid)
values ('Secretariat''', 25578);
insert into OFFICE (otype, sid)
values ('Customer Servic', 98375);
insert into OFFICE (otype, sid)
values ('Secretariat''', 26921);
insert into OFFICE (otype, sid)
values ('Shift Manager', 69582);
insert into OFFICE (otype, sid)
values ('Secretariat''', 38296);
insert into OFFICE (otype, sid)
values ('Shift Manager', 64636);
insert into OFFICE (otype, sid)
values ('Customer Servic', 45839);
insert into OFFICE (otype, sid)
values ('Counter', 34002);
insert into OFFICE (otype, sid)
values ('Secretariat''', 18802);
insert into OFFICE (otype, sid)
values ('Secretariat''', 55385);
insert into OFFICE (otype, sid)
values ('Secretariat''', 81894);
insert into OFFICE (otype, sid)
values ('IT', 49969);
insert into OFFICE (otype, sid)
values ('Counter', 51383);
insert into OFFICE (otype, sid)
values ('Shift Manager', 65613);
insert into OFFICE (otype, sid)
values ('Sales', 10334);
insert into OFFICE (otype, sid)
values ('Counter', 16712);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99596);
insert into OFFICE (otype, sid)
values ('Secretariat''', 47970);
insert into OFFICE (otype, sid)
values ('Customer Servic', 29127);
insert into OFFICE (otype, sid)
values ('Secretariat''', 33360);
insert into OFFICE (otype, sid)
values ('IT', 83782);
insert into OFFICE (otype, sid)
values ('Counter', 47962);
insert into OFFICE (otype, sid)
values ('Counter', 74972);
insert into OFFICE (otype, sid)
values ('Sales', 32397);
insert into OFFICE (otype, sid)
values ('Shift Manager', 41470);
insert into OFFICE (otype, sid)
values ('Shift Manager', 29561);
insert into OFFICE (otype, sid)
values ('Sales', 68429);
insert into OFFICE (otype, sid)
values ('IT', 55269);
insert into OFFICE (otype, sid)
values ('Sales', 36074);
insert into OFFICE (otype, sid)
values ('IT', 10006);
insert into OFFICE (otype, sid)
values ('IT', 50598);
insert into OFFICE (otype, sid)
values ('Counter', 88762);
insert into OFFICE (otype, sid)
values ('Counter', 76589);
insert into OFFICE (otype, sid)
values ('IT', 24963);
insert into OFFICE (otype, sid)
values ('Shift Manager', 81875);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 60334);
commit;
prompt 200 records committed...
insert into OFFICE (otype, sid)
values ('Shift Manager', 65725);
insert into OFFICE (otype, sid)
values ('IT', 88875);
insert into OFFICE (otype, sid)
values ('IT', 30610);
insert into OFFICE (otype, sid)
values ('Customer Servic', 74331);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 76479);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10007);
insert into OFFICE (otype, sid)
values ('Counter', 84092);
insert into OFFICE (otype, sid)
values ('Shift Manager', 48212);
insert into OFFICE (otype, sid)
values ('Counter', 47027);
insert into OFFICE (otype, sid)
values ('Counter', 34941);
insert into OFFICE (otype, sid)
values ('Counter', 13261);
insert into OFFICE (otype, sid)
values ('Counter', 10008);
insert into OFFICE (otype, sid)
values ('Customer Servic', 24626);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 18791);
insert into OFFICE (otype, sid)
values ('Customer Servic', 69880);
insert into OFFICE (otype, sid)
values ('IT', 66715);
insert into OFFICE (otype, sid)
values ('Customer Servic', 69221);
insert into OFFICE (otype, sid)
values ('Customer Servic', 48188);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 25190);
insert into OFFICE (otype, sid)
values ('IT', 35877);
insert into OFFICE (otype, sid)
values ('IT', 10010);
insert into OFFICE (otype, sid)
values ('Shift Manager', 45109);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31448);
insert into OFFICE (otype, sid)
values ('IT', 63762);
insert into OFFICE (otype, sid)
values ('Counter', 83526);
insert into OFFICE (otype, sid)
values ('Customer Servic', 42122);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31947);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 10003);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 63761);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 70250);
insert into OFFICE (otype, sid)
values ('IT', 95896);
insert into OFFICE (otype, sid)
values ('IT', 64076);
insert into OFFICE (otype, sid)
values ('Counter', 10770);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 11630);
insert into OFFICE (otype, sid)
values ('IT', 83689);
insert into OFFICE (otype, sid)
values ('Counter', 43573);
insert into OFFICE (otype, sid)
values ('Customer Servic', 78475);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 13243);
insert into OFFICE (otype, sid)
values ('IT', 12245);
insert into OFFICE (otype, sid)
values ('IT', 50112);
insert into OFFICE (otype, sid)
values ('Counter', 82258);
insert into OFFICE (otype, sid)
values ('Shift Manager', 11311);
insert into OFFICE (otype, sid)
values ('IT', 89219);
insert into OFFICE (otype, sid)
values ('Customer Servic', 67810);
insert into OFFICE (otype, sid)
values ('Shift Manager', 83250);
insert into OFFICE (otype, sid)
values ('Shift Manager', 21996);
insert into OFFICE (otype, sid)
values ('IT', 74091);
insert into OFFICE (otype, sid)
values ('Customer Servic', 72073);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 62317);
insert into OFFICE (otype, sid)
values ('Customer Servic', 68890);
insert into OFFICE (otype, sid)
values ('IT', 49355);
insert into OFFICE (otype, sid)
values ('IT', 47411);
insert into OFFICE (otype, sid)
values ('Counter', 51251);
insert into OFFICE (otype, sid)
values ('Customer Servic', 48224);
insert into OFFICE (otype, sid)
values ('Counter', 86538);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 13854);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 80248);
insert into OFFICE (otype, sid)
values ('Counter', 66915);
insert into OFFICE (otype, sid)
values ('Customer Servic', 16017);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 58938);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99939);
insert into OFFICE (otype, sid)
values ('IT', 21312);
insert into OFFICE (otype, sid)
values ('IT', 80830);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 81184);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18525);
insert into OFFICE (otype, sid)
values ('Counter', 95320);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31979);
insert into OFFICE (otype, sid)
values ('IT', 89061);
insert into OFFICE (otype, sid)
values ('Customer Servic', 71870);
insert into OFFICE (otype, sid)
values ('Shift Manager', 34214);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 68549);
insert into OFFICE (otype, sid)
values ('Customer Servic', 14599);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 32593);
insert into OFFICE (otype, sid)
values ('IT', 57567);
insert into OFFICE (otype, sid)
values ('Customer Servic', 51125);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 35535);
insert into OFFICE (otype, sid)
values ('Customer Servic', 73586);
insert into OFFICE (otype, sid)
values ('Customer Servic', 43915);
commit;
prompt 278 records loaded
prompt Loading OMAKEA...
insert into OMAKEA (appointmentid, sid)
values (11395, 41224);
insert into OMAKEA (appointmentid, sid)
values (11416, 83782);
insert into OMAKEA (appointmentid, sid)
values (11912, 55269);
insert into OMAKEA (appointmentid, sid)
values (12777, 12979);
insert into OMAKEA (appointmentid, sid)
values (13121, 10018);
insert into OMAKEA (appointmentid, sid)
values (13121, 65613);
insert into OMAKEA (appointmentid, sid)
values (13184, 32397);
insert into OMAKEA (appointmentid, sid)
values (13713, 98375);
insert into OMAKEA (appointmentid, sid)
values (13831, 10018);
insert into OMAKEA (appointmentid, sid)
values (13927, 47970);
insert into OMAKEA (appointmentid, sid)
values (13944, 36074);
insert into OMAKEA (appointmentid, sid)
values (14115, 10018);
insert into OMAKEA (appointmentid, sid)
values (14235, 10334);
insert into OMAKEA (appointmentid, sid)
values (14235, 50598);
insert into OMAKEA (appointmentid, sid)
values (14235, 74972);
insert into OMAKEA (appointmentid, sid)
values (14235, 87171);
insert into OMAKEA (appointmentid, sid)
values (14715, 69582);
insert into OMAKEA (appointmentid, sid)
values (15747, 87171);
insert into OMAKEA (appointmentid, sid)
values (16195, 10015);
insert into OMAKEA (appointmentid, sid)
values (16437, 10011);
insert into OMAKEA (appointmentid, sid)
values (16511, 10020);
insert into OMAKEA (appointmentid, sid)
values (17642, 83782);
insert into OMAKEA (appointmentid, sid)
values (18374, 10334);
insert into OMAKEA (appointmentid, sid)
values (18374, 57569);
insert into OMAKEA (appointmentid, sid)
values (18422, 10012);
insert into OMAKEA (appointmentid, sid)
values (18422, 33360);
insert into OMAKEA (appointmentid, sid)
values (18621, 29127);
insert into OMAKEA (appointmentid, sid)
values (18621, 64636);
insert into OMAKEA (appointmentid, sid)
values (19338, 78572);
insert into OMAKEA (appointmentid, sid)
values (19338, 98375);
insert into OMAKEA (appointmentid, sid)
values (19487, 16712);
insert into OMAKEA (appointmentid, sid)
values (19548, 50598);
insert into OMAKEA (appointmentid, sid)
values (21632, 34002);
insert into OMAKEA (appointmentid, sid)
values (21759, 83782);
insert into OMAKEA (appointmentid, sid)
values (22473, 10017);
insert into OMAKEA (appointmentid, sid)
values (22473, 29561);
insert into OMAKEA (appointmentid, sid)
values (22473, 47970);
insert into OMAKEA (appointmentid, sid)
values (22834, 16712);
insert into OMAKEA (appointmentid, sid)
values (22834, 87171);
insert into OMAKEA (appointmentid, sid)
values (22848, 59041);
insert into OMAKEA (appointmentid, sid)
values (23284, 10011);
insert into OMAKEA (appointmentid, sid)
values (23284, 32397);
insert into OMAKEA (appointmentid, sid)
values (23284, 41224);
insert into OMAKEA (appointmentid, sid)
values (23284, 98375);
insert into OMAKEA (appointmentid, sid)
values (23487, 65613);
insert into OMAKEA (appointmentid, sid)
values (24137, 10017);
insert into OMAKEA (appointmentid, sid)
values (24137, 47970);
insert into OMAKEA (appointmentid, sid)
values (24137, 88762);
insert into OMAKEA (appointmentid, sid)
values (24385, 59041);
insert into OMAKEA (appointmentid, sid)
values (24399, 29872);
insert into OMAKEA (appointmentid, sid)
values (24676, 50598);
insert into OMAKEA (appointmentid, sid)
values (24676, 64636);
insert into OMAKEA (appointmentid, sid)
values (24777, 10014);
insert into OMAKEA (appointmentid, sid)
values (24777, 10015);
insert into OMAKEA (appointmentid, sid)
values (24947, 41224);
insert into OMAKEA (appointmentid, sid)
values (24984, 29872);
insert into OMAKEA (appointmentid, sid)
values (24984, 68429);
insert into OMAKEA (appointmentid, sid)
values (25165, 10011);
insert into OMAKEA (appointmentid, sid)
values (25165, 10016);
insert into OMAKEA (appointmentid, sid)
values (25165, 41224);
insert into OMAKEA (appointmentid, sid)
values (25556, 55385);
insert into OMAKEA (appointmentid, sid)
values (25556, 87171);
insert into OMAKEA (appointmentid, sid)
values (25854, 47970);
insert into OMAKEA (appointmentid, sid)
values (25854, 83782);
insert into OMAKEA (appointmentid, sid)
values (25893, 16712);
insert into OMAKEA (appointmentid, sid)
values (25893, 73373);
insert into OMAKEA (appointmentid, sid)
values (26256, 38296);
insert into OMAKEA (appointmentid, sid)
values (26331, 10334);
insert into OMAKEA (appointmentid, sid)
values (26331, 33360);
insert into OMAKEA (appointmentid, sid)
values (26335, 49969);
insert into OMAKEA (appointmentid, sid)
values (26335, 88762);
insert into OMAKEA (appointmentid, sid)
values (26699, 36074);
insert into OMAKEA (appointmentid, sid)
values (26699, 41470);
insert into OMAKEA (appointmentid, sid)
values (26926, 47970);
insert into OMAKEA (appointmentid, sid)
values (26926, 81894);
insert into OMAKEA (appointmentid, sid)
values (27341, 29872);
insert into OMAKEA (appointmentid, sid)
values (27341, 69582);
insert into OMAKEA (appointmentid, sid)
values (28113, 18802);
insert into OMAKEA (appointmentid, sid)
values (28593, 10006);
insert into OMAKEA (appointmentid, sid)
values (28734, 68429);
insert into OMAKEA (appointmentid, sid)
values (28734, 98375);
insert into OMAKEA (appointmentid, sid)
values (28734, 99596);
insert into OMAKEA (appointmentid, sid)
values (29134, 69582);
insert into OMAKEA (appointmentid, sid)
values (29532, 12979);
insert into OMAKEA (appointmentid, sid)
values (29724, 26921);
insert into OMAKEA (appointmentid, sid)
values (29966, 59041);
insert into OMAKEA (appointmentid, sid)
values (29966, 69582);
insert into OMAKEA (appointmentid, sid)
values (30001, 47962);
insert into OMAKEA (appointmentid, sid)
values (30001, 86483);
insert into OMAKEA (appointmentid, sid)
values (30002, 10018);
insert into OMAKEA (appointmentid, sid)
values (30002, 45839);
insert into OMAKEA (appointmentid, sid)
values (30002, 68062);
insert into OMAKEA (appointmentid, sid)
values (30003, 18802);
insert into OMAKEA (appointmentid, sid)
values (30003, 29127);
insert into OMAKEA (appointmentid, sid)
values (30003, 57569);
insert into OMAKEA (appointmentid, sid)
values (30003, 78572);
insert into OMAKEA (appointmentid, sid)
values (30003, 86483);
insert into OMAKEA (appointmentid, sid)
values (30004, 10012);
insert into OMAKEA (appointmentid, sid)
values (30005, 10014);
insert into OMAKEA (appointmentid, sid)
values (30005, 10017);
commit;
prompt 100 records committed...
insert into OMAKEA (appointmentid, sid)
values (30005, 99596);
insert into OMAKEA (appointmentid, sid)
values (30006, 10334);
insert into OMAKEA (appointmentid, sid)
values (30006, 18802);
insert into OMAKEA (appointmentid, sid)
values (30006, 51383);
insert into OMAKEA (appointmentid, sid)
values (30006, 73373);
insert into OMAKEA (appointmentid, sid)
values (30006, 81894);
insert into OMAKEA (appointmentid, sid)
values (31299, 12979);
insert into OMAKEA (appointmentid, sid)
values (31299, 41470);
insert into OMAKEA (appointmentid, sid)
values (31299, 81894);
insert into OMAKEA (appointmentid, sid)
values (31554, 50598);
insert into OMAKEA (appointmentid, sid)
values (31554, 55385);
insert into OMAKEA (appointmentid, sid)
values (31554, 68429);
insert into OMAKEA (appointmentid, sid)
values (31688, 74972);
insert into OMAKEA (appointmentid, sid)
values (31716, 41470);
insert into OMAKEA (appointmentid, sid)
values (31716, 81894);
insert into OMAKEA (appointmentid, sid)
values (31743, 47962);
insert into OMAKEA (appointmentid, sid)
values (31743, 59041);
insert into OMAKEA (appointmentid, sid)
values (31819, 55385);
insert into OMAKEA (appointmentid, sid)
values (31819, 59041);
insert into OMAKEA (appointmentid, sid)
values (32867, 74972);
insert into OMAKEA (appointmentid, sid)
values (33634, 41224);
insert into OMAKEA (appointmentid, sid)
values (33634, 49969);
insert into OMAKEA (appointmentid, sid)
values (33732, 33360);
insert into OMAKEA (appointmentid, sid)
values (34243, 10018);
insert into OMAKEA (appointmentid, sid)
values (34243, 83782);
insert into OMAKEA (appointmentid, sid)
values (34362, 10018);
insert into OMAKEA (appointmentid, sid)
values (34362, 64636);
insert into OMAKEA (appointmentid, sid)
values (34432, 73373);
insert into OMAKEA (appointmentid, sid)
values (34968, 74972);
insert into OMAKEA (appointmentid, sid)
values (35792, 74972);
insert into OMAKEA (appointmentid, sid)
values (36345, 10020);
insert into OMAKEA (appointmentid, sid)
values (36345, 29872);
insert into OMAKEA (appointmentid, sid)
values (36544, 10018);
insert into OMAKEA (appointmentid, sid)
values (36544, 12979);
insert into OMAKEA (appointmentid, sid)
values (36544, 59041);
insert into OMAKEA (appointmentid, sid)
values (36749, 86483);
insert into OMAKEA (appointmentid, sid)
values (36919, 33360);
insert into OMAKEA (appointmentid, sid)
values (36928, 18802);
insert into OMAKEA (appointmentid, sid)
values (36928, 81894);
insert into OMAKEA (appointmentid, sid)
values (36944, 10020);
insert into OMAKEA (appointmentid, sid)
values (36944, 50598);
insert into OMAKEA (appointmentid, sid)
values (37223, 10018);
insert into OMAKEA (appointmentid, sid)
values (37223, 41224);
insert into OMAKEA (appointmentid, sid)
values (37461, 57569);
insert into OMAKEA (appointmentid, sid)
values (37461, 99596);
insert into OMAKEA (appointmentid, sid)
values (37512, 10012);
insert into OMAKEA (appointmentid, sid)
values (37512, 81894);
insert into OMAKEA (appointmentid, sid)
values (37638, 74972);
insert into OMAKEA (appointmentid, sid)
values (37647, 29127);
insert into OMAKEA (appointmentid, sid)
values (37647, 33360);
insert into OMAKEA (appointmentid, sid)
values (37782, 29872);
insert into OMAKEA (appointmentid, sid)
values (37782, 32397);
insert into OMAKEA (appointmentid, sid)
values (37869, 88762);
insert into OMAKEA (appointmentid, sid)
values (38338, 10017);
insert into OMAKEA (appointmentid, sid)
values (38338, 29872);
insert into OMAKEA (appointmentid, sid)
values (38616, 29561);
insert into OMAKEA (appointmentid, sid)
values (38729, 29127);
insert into OMAKEA (appointmentid, sid)
values (38729, 47970);
insert into OMAKEA (appointmentid, sid)
values (39257, 10015);
insert into OMAKEA (appointmentid, sid)
values (39257, 33360);
insert into OMAKEA (appointmentid, sid)
values (39425, 10017);
insert into OMAKEA (appointmentid, sid)
values (39425, 81894);
insert into OMAKEA (appointmentid, sid)
values (39616, 34002);
insert into OMAKEA (appointmentid, sid)
values (39772, 87171);
insert into OMAKEA (appointmentid, sid)
values (39837, 99596);
insert into OMAKEA (appointmentid, sid)
values (41561, 32397);
insert into OMAKEA (appointmentid, sid)
values (41656, 10017);
insert into OMAKEA (appointmentid, sid)
values (41847, 57569);
insert into OMAKEA (appointmentid, sid)
values (41915, 10006);
insert into OMAKEA (appointmentid, sid)
values (41915, 10013);
insert into OMAKEA (appointmentid, sid)
values (41915, 10015);
insert into OMAKEA (appointmentid, sid)
values (42733, 10013);
insert into OMAKEA (appointmentid, sid)
values (42873, 10017);
insert into OMAKEA (appointmentid, sid)
values (42917, 55385);
insert into OMAKEA (appointmentid, sid)
values (43457, 41470);
insert into OMAKEA (appointmentid, sid)
values (43457, 49969);
insert into OMAKEA (appointmentid, sid)
values (44265, 64636);
insert into OMAKEA (appointmentid, sid)
values (44265, 74972);
insert into OMAKEA (appointmentid, sid)
values (44426, 18802);
insert into OMAKEA (appointmentid, sid)
values (44484, 32397);
insert into OMAKEA (appointmentid, sid)
values (44578, 10015);
insert into OMAKEA (appointmentid, sid)
values (44578, 78572);
insert into OMAKEA (appointmentid, sid)
values (44623, 12979);
insert into OMAKEA (appointmentid, sid)
values (44623, 59041);
insert into OMAKEA (appointmentid, sid)
values (44623, 68429);
insert into OMAKEA (appointmentid, sid)
values (44833, 10014);
insert into OMAKEA (appointmentid, sid)
values (45388, 59041);
insert into OMAKEA (appointmentid, sid)
values (45388, 74972);
insert into OMAKEA (appointmentid, sid)
values (45388, 88762);
insert into OMAKEA (appointmentid, sid)
values (45389, 10006);
insert into OMAKEA (appointmentid, sid)
values (45389, 51383);
insert into OMAKEA (appointmentid, sid)
values (45659, 10018);
insert into OMAKEA (appointmentid, sid)
values (45686, 10013);
insert into OMAKEA (appointmentid, sid)
values (45835, 10018);
insert into OMAKEA (appointmentid, sid)
values (46594, 41224);
insert into OMAKEA (appointmentid, sid)
values (46912, 83782);
insert into OMAKEA (appointmentid, sid)
values (47288, 68429);
insert into OMAKEA (appointmentid, sid)
values (47365, 29872);
insert into OMAKEA (appointmentid, sid)
values (47365, 87171);
insert into OMAKEA (appointmentid, sid)
values (48474, 10014);
commit;
prompt 200 records committed...
insert into OMAKEA (appointmentid, sid)
values (48557, 10334);
insert into OMAKEA (appointmentid, sid)
values (48827, 29127);
insert into OMAKEA (appointmentid, sid)
values (48827, 81894);
insert into OMAKEA (appointmentid, sid)
values (48971, 64636);
insert into OMAKEA (appointmentid, sid)
values (48971, 65613);
insert into OMAKEA (appointmentid, sid)
values (48971, 68062);
insert into OMAKEA (appointmentid, sid)
values (49174, 10006);
insert into OMAKEA (appointmentid, sid)
values (49174, 29127);
insert into OMAKEA (appointmentid, sid)
values (49174, 68429);
insert into OMAKEA (appointmentid, sid)
values (49211, 73373);
insert into OMAKEA (appointmentid, sid)
values (49211, 81894);
insert into OMAKEA (appointmentid, sid)
values (49689, 10018);
insert into OMAKEA (appointmentid, sid)
values (49689, 29127);
insert into OMAKEA (appointmentid, sid)
values (49689, 38296);
insert into OMAKEA (appointmentid, sid)
values (49699, 10020);
insert into OMAKEA (appointmentid, sid)
values (49749, 32397);
insert into OMAKEA (appointmentid, sid)
values (51688, 18802);
insert into OMAKEA (appointmentid, sid)
values (51688, 29872);
insert into OMAKEA (appointmentid, sid)
values (51688, 88762);
insert into OMAKEA (appointmentid, sid)
values (52192, 12979);
insert into OMAKEA (appointmentid, sid)
values (52192, 47962);
insert into OMAKEA (appointmentid, sid)
values (52192, 64636);
insert into OMAKEA (appointmentid, sid)
values (52254, 29561);
insert into OMAKEA (appointmentid, sid)
values (52254, 45839);
insert into OMAKEA (appointmentid, sid)
values (52254, 88762);
insert into OMAKEA (appointmentid, sid)
values (52545, 68429);
insert into OMAKEA (appointmentid, sid)
values (52545, 69582);
insert into OMAKEA (appointmentid, sid)
values (52874, 10018);
insert into OMAKEA (appointmentid, sid)
values (53274, 10017);
insert into OMAKEA (appointmentid, sid)
values (53498, 10011);
insert into OMAKEA (appointmentid, sid)
values (53587, 38296);
insert into OMAKEA (appointmentid, sid)
values (53587, 86483);
insert into OMAKEA (appointmentid, sid)
values (53947, 10006);
insert into OMAKEA (appointmentid, sid)
values (53981, 10014);
insert into OMAKEA (appointmentid, sid)
values (54399, 47970);
insert into OMAKEA (appointmentid, sid)
values (54755, 55269);
insert into OMAKEA (appointmentid, sid)
values (54755, 57569);
insert into OMAKEA (appointmentid, sid)
values (54965, 10017);
insert into OMAKEA (appointmentid, sid)
values (55163, 55385);
insert into OMAKEA (appointmentid, sid)
values (55163, 83782);
insert into OMAKEA (appointmentid, sid)
values (55427, 68429);
insert into OMAKEA (appointmentid, sid)
values (55657, 33360);
insert into OMAKEA (appointmentid, sid)
values (56515, 10014);
insert into OMAKEA (appointmentid, sid)
values (56515, 29872);
insert into OMAKEA (appointmentid, sid)
values (57292, 10016);
insert into OMAKEA (appointmentid, sid)
values (57853, 12979);
insert into OMAKEA (appointmentid, sid)
values (58994, 81894);
insert into OMAKEA (appointmentid, sid)
values (59117, 16712);
insert into OMAKEA (appointmentid, sid)
values (59117, 68062);
insert into OMAKEA (appointmentid, sid)
values (59487, 55385);
insert into OMAKEA (appointmentid, sid)
values (59549, 34002);
insert into OMAKEA (appointmentid, sid)
values (59549, 74972);
insert into OMAKEA (appointmentid, sid)
values (59588, 49969);
insert into OMAKEA (appointmentid, sid)
values (59736, 29561);
insert into OMAKEA (appointmentid, sid)
values (59736, 68429);
insert into OMAKEA (appointmentid, sid)
values (59864, 10014);
insert into OMAKEA (appointmentid, sid)
values (59864, 10019);
insert into OMAKEA (appointmentid, sid)
values (59883, 16712);
insert into OMAKEA (appointmentid, sid)
values (59883, 41224);
insert into OMAKEA (appointmentid, sid)
values (59923, 64636);
insert into OMAKEA (appointmentid, sid)
values (61435, 10012);
insert into OMAKEA (appointmentid, sid)
values (61435, 25578);
insert into OMAKEA (appointmentid, sid)
values (61472, 26921);
insert into OMAKEA (appointmentid, sid)
values (61472, 78572);
insert into OMAKEA (appointmentid, sid)
values (61521, 10017);
insert into OMAKEA (appointmentid, sid)
values (61521, 12979);
insert into OMAKEA (appointmentid, sid)
values (61521, 47970);
insert into OMAKEA (appointmentid, sid)
values (61651, 83782);
insert into OMAKEA (appointmentid, sid)
values (62227, 10019);
insert into OMAKEA (appointmentid, sid)
values (62227, 25578);
insert into OMAKEA (appointmentid, sid)
values (62227, 55269);
insert into OMAKEA (appointmentid, sid)
values (62316, 55269);
insert into OMAKEA (appointmentid, sid)
values (62629, 10019);
insert into OMAKEA (appointmentid, sid)
values (62629, 29561);
insert into OMAKEA (appointmentid, sid)
values (63768, 59041);
insert into OMAKEA (appointmentid, sid)
values (63768, 78572);
insert into OMAKEA (appointmentid, sid)
values (63995, 18802);
insert into OMAKEA (appointmentid, sid)
values (63995, 41470);
insert into OMAKEA (appointmentid, sid)
values (64612, 10006);
insert into OMAKEA (appointmentid, sid)
values (64612, 41224);
insert into OMAKEA (appointmentid, sid)
values (64612, 51383);
insert into OMAKEA (appointmentid, sid)
values (65183, 10013);
insert into OMAKEA (appointmentid, sid)
values (65252, 68062);
insert into OMAKEA (appointmentid, sid)
values (65252, 86483);
insert into OMAKEA (appointmentid, sid)
values (65466, 59041);
insert into OMAKEA (appointmentid, sid)
values (65632, 10015);
insert into OMAKEA (appointmentid, sid)
values (65632, 12979);
insert into OMAKEA (appointmentid, sid)
values (65711, 68062);
insert into OMAKEA (appointmentid, sid)
values (65753, 10012);
insert into OMAKEA (appointmentid, sid)
values (66153, 10006);
insert into OMAKEA (appointmentid, sid)
values (66364, 10016);
insert into OMAKEA (appointmentid, sid)
values (66364, 68062);
insert into OMAKEA (appointmentid, sid)
values (66449, 10013);
insert into OMAKEA (appointmentid, sid)
values (66449, 38296);
insert into OMAKEA (appointmentid, sid)
values (66549, 10012);
insert into OMAKEA (appointmentid, sid)
values (66549, 47970);
insert into OMAKEA (appointmentid, sid)
values (67984, 33360);
insert into OMAKEA (appointmentid, sid)
values (67984, 99596);
insert into OMAKEA (appointmentid, sid)
values (67992, 26921);
insert into OMAKEA (appointmentid, sid)
values (67992, 29561);
commit;
prompt 300 records committed...
insert into OMAKEA (appointmentid, sid)
values (67992, 45839);
insert into OMAKEA (appointmentid, sid)
values (68242, 10016);
insert into OMAKEA (appointmentid, sid)
values (69154, 65613);
insert into OMAKEA (appointmentid, sid)
values (69358, 83782);
insert into OMAKEA (appointmentid, sid)
values (69466, 74972);
insert into OMAKEA (appointmentid, sid)
values (71381, 29127);
insert into OMAKEA (appointmentid, sid)
values (71465, 10014);
insert into OMAKEA (appointmentid, sid)
values (71465, 74972);
insert into OMAKEA (appointmentid, sid)
values (71465, 86483);
insert into OMAKEA (appointmentid, sid)
values (71834, 16712);
insert into OMAKEA (appointmentid, sid)
values (72625, 12979);
insert into OMAKEA (appointmentid, sid)
values (72625, 55269);
insert into OMAKEA (appointmentid, sid)
values (72942, 10016);
insert into OMAKEA (appointmentid, sid)
values (72942, 69582);
insert into OMAKEA (appointmentid, sid)
values (72942, 98375);
insert into OMAKEA (appointmentid, sid)
values (73199, 51383);
insert into OMAKEA (appointmentid, sid)
values (74655, 10013);
insert into OMAKEA (appointmentid, sid)
values (74655, 98375);
insert into OMAKEA (appointmentid, sid)
values (74732, 10011);
insert into OMAKEA (appointmentid, sid)
values (76248, 33360);
insert into OMAKEA (appointmentid, sid)
values (76248, 36074);
insert into OMAKEA (appointmentid, sid)
values (76248, 81894);
insert into OMAKEA (appointmentid, sid)
values (76411, 69582);
insert into OMAKEA (appointmentid, sid)
values (76595, 36074);
insert into OMAKEA (appointmentid, sid)
values (76595, 73373);
insert into OMAKEA (appointmentid, sid)
values (76744, 25578);
insert into OMAKEA (appointmentid, sid)
values (76744, 41224);
insert into OMAKEA (appointmentid, sid)
values (76832, 10011);
insert into OMAKEA (appointmentid, sid)
values (76832, 45839);
insert into OMAKEA (appointmentid, sid)
values (78169, 50598);
insert into OMAKEA (appointmentid, sid)
values (78281, 74972);
insert into OMAKEA (appointmentid, sid)
values (78559, 50598);
insert into OMAKEA (appointmentid, sid)
values (78559, 55269);
insert into OMAKEA (appointmentid, sid)
values (78559, 88762);
insert into OMAKEA (appointmentid, sid)
values (79322, 73373);
insert into OMAKEA (appointmentid, sid)
values (79322, 78572);
insert into OMAKEA (appointmentid, sid)
values (79599, 57569);
insert into OMAKEA (appointmentid, sid)
values (79599, 69582);
insert into OMAKEA (appointmentid, sid)
values (79599, 98375);
insert into OMAKEA (appointmentid, sid)
values (79857, 10013);
insert into OMAKEA (appointmentid, sid)
values (79857, 10016);
insert into OMAKEA (appointmentid, sid)
values (82123, 10016);
insert into OMAKEA (appointmentid, sid)
values (82439, 10012);
insert into OMAKEA (appointmentid, sid)
values (82439, 10020);
insert into OMAKEA (appointmentid, sid)
values (82511, 55269);
insert into OMAKEA (appointmentid, sid)
values (82921, 10017);
insert into OMAKEA (appointmentid, sid)
values (82921, 29872);
insert into OMAKEA (appointmentid, sid)
values (83194, 64636);
insert into OMAKEA (appointmentid, sid)
values (83316, 29561);
insert into OMAKEA (appointmentid, sid)
values (83564, 41470);
insert into OMAKEA (appointmentid, sid)
values (83564, 55385);
insert into OMAKEA (appointmentid, sid)
values (84414, 10016);
insert into OMAKEA (appointmentid, sid)
values (84952, 10016);
insert into OMAKEA (appointmentid, sid)
values (84957, 10015);
insert into OMAKEA (appointmentid, sid)
values (84957, 51383);
insert into OMAKEA (appointmentid, sid)
values (85326, 33360);
insert into OMAKEA (appointmentid, sid)
values (85644, 10013);
insert into OMAKEA (appointmentid, sid)
values (85669, 49969);
insert into OMAKEA (appointmentid, sid)
values (85669, 98375);
insert into OMAKEA (appointmentid, sid)
values (86376, 32397);
insert into OMAKEA (appointmentid, sid)
values (86627, 36074);
insert into OMAKEA (appointmentid, sid)
values (86786, 26921);
insert into OMAKEA (appointmentid, sid)
values (86786, 47962);
insert into OMAKEA (appointmentid, sid)
values (87144, 57569);
insert into OMAKEA (appointmentid, sid)
values (87984, 10011);
insert into OMAKEA (appointmentid, sid)
values (88298, 10020);
insert into OMAKEA (appointmentid, sid)
values (88298, 29127);
insert into OMAKEA (appointmentid, sid)
values (88645, 10011);
insert into OMAKEA (appointmentid, sid)
values (88645, 10016);
insert into OMAKEA (appointmentid, sid)
values (88645, 18802);
insert into OMAKEA (appointmentid, sid)
values (89358, 47962);
insert into OMAKEA (appointmentid, sid)
values (89358, 55269);
insert into OMAKEA (appointmentid, sid)
values (91955, 25578);
insert into OMAKEA (appointmentid, sid)
values (92316, 47970);
insert into OMAKEA (appointmentid, sid)
values (92316, 81894);
insert into OMAKEA (appointmentid, sid)
values (92499, 10017);
insert into OMAKEA (appointmentid, sid)
values (92587, 69582);
insert into OMAKEA (appointmentid, sid)
values (92754, 98375);
insert into OMAKEA (appointmentid, sid)
values (93665, 25578);
insert into OMAKEA (appointmentid, sid)
values (93739, 32397);
insert into OMAKEA (appointmentid, sid)
values (94296, 68062);
insert into OMAKEA (appointmentid, sid)
values (94727, 10334);
insert into OMAKEA (appointmentid, sid)
values (95217, 69582);
insert into OMAKEA (appointmentid, sid)
values (96566, 10334);
insert into OMAKEA (appointmentid, sid)
values (96566, 18802);
insert into OMAKEA (appointmentid, sid)
values (96566, 73373);
insert into OMAKEA (appointmentid, sid)
values (96566, 99596);
insert into OMAKEA (appointmentid, sid)
values (96672, 10017);
insert into OMAKEA (appointmentid, sid)
values (96672, 32397);
insert into OMAKEA (appointmentid, sid)
values (97122, 10012);
insert into OMAKEA (appointmentid, sid)
values (97122, 41224);
insert into OMAKEA (appointmentid, sid)
values (97354, 10019);
insert into OMAKEA (appointmentid, sid)
values (97579, 10017);
insert into OMAKEA (appointmentid, sid)
values (97579, 51383);
insert into OMAKEA (appointmentid, sid)
values (97666, 45839);
insert into OMAKEA (appointmentid, sid)
values (97666, 81894);
insert into OMAKEA (appointmentid, sid)
values (98235, 69582);
insert into OMAKEA (appointmentid, sid)
values (98371, 10013);
insert into OMAKEA (appointmentid, sid)
values (98371, 10019);
insert into OMAKEA (appointmentid, sid)
values (98371, 38296);
commit;
prompt 400 records committed...
insert into OMAKEA (appointmentid, sid)
values (98428, 45839);
insert into OMAKEA (appointmentid, sid)
values (98428, 55269);
insert into OMAKEA (appointmentid, sid)
values (98548, 10014);
insert into OMAKEA (appointmentid, sid)
values (98548, 16712);
insert into OMAKEA (appointmentid, sid)
values (98548, 50598);
insert into OMAKEA (appointmentid, sid)
values (98797, 87171);
insert into OMAKEA (appointmentid, sid)
values (98965, 29127);
insert into OMAKEA (appointmentid, sid)
values (99138, 51383);
insert into OMAKEA (appointmentid, sid)
values (99822, 10016);
commit;
prompt 409 records loaded
prompt Loading STUDENT...
insert into STUDENT (cid, fathername, mothername, class_id)
values (1001, 'Derek', 'Deborah', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1003, 'Lucas', 'Samantha', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1004, 'Charles', 'Cheryl', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1005, 'Douglas', 'Brenda', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1007, 'Henry', 'Jennifer', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1009, 'Joseph', 'Patricia', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1010, 'Adam', 'Lucia', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1012, 'Patrick', 'Janet', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1014, 'Travis', 'Pamela', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1015, 'Justin', 'Helena', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1016, 'Ethan', 'Mia', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1017, 'Eric', 'Stephanie', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1018, 'Diego', 'Phoebe', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1019, 'Walter', 'Phoebe', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1020, 'Ronald', 'Lisa', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1025, 'Paul', 'Brenda', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1028, 'Richard', 'Agnes', 14);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1029, 'Austin', 'Abigail', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1030, 'Eric', 'Natalie', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1031, 'Walter', 'Alicia', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1034, 'Derek', 'Helena', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1035, 'Zachary', 'Penelope', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1036, 'Shannon', 'Alexandra', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1037, 'Gregory', 'Danielle', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1039, 'Christopher', 'Maria', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1040, 'Richard', 'Linda', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1042, 'Eric', 'Tiffany', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1043, 'Juan', 'Nancy', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1045, 'Sebastian', 'Monica', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1047, 'Andrew', 'Lydia', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1050, 'Dylan', 'Brittany', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1052, 'Cole', 'Rachel', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1053, 'George', 'Audrey', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1054, 'Albert', 'Stephanie', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1055, 'Isaac', 'Danielle', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1056, 'Cody', 'Alexis', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1057, 'Cody', 'Kelly', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1058, 'Jayden', 'Sarah', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1060, 'Harold', 'Claudia', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1061, 'Gabriel', 'Hannah', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1063, 'Ezekiel', 'Amanda', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1065, 'William', 'Penelope', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1066, 'Abraham', 'Jasmine', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1067, 'Adam', 'Charlotte', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1068, 'Jacob', 'Sophia', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1071, 'Vincent', 'Jennifer', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1072, 'Antonio', 'Maya', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1073, 'Adam', 'Lucy', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1074, 'Felipe', 'Claire', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1076, 'John', 'Leslie', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1077, 'Eric', 'Reagan', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1078, 'Thomas', 'Agnes', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1079, 'Samuel', 'Mia', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1085, 'Albert', 'Alice', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1086, 'Joshua', 'Jasmine', 9);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1087, 'Owen', 'Victoria', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1088, 'Edward', 'Diana', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1089, 'Nicholas', 'Abigail', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1090, 'Ronald', 'Heather', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1091, 'Dennis', 'Caroline', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1092, 'Cameron', 'Louise', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1093, 'Owen', 'Rose', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1094, 'Walter', 'Jade', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1097, 'Ezekiel', 'Jacqueline', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1098, 'Cameron', 'Charlotte', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1099, 'Gabriel', 'Samantha', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1100, 'Jonathan', 'Nancy', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1102, 'Derek', 'Linda', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1104, 'Jesse', 'Madison', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1106, 'Christopher', 'Sandra', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1107, 'Zachary', 'Alana', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1108, 'Luke', 'Peyton', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1109, 'Jacob', 'Audrey', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1110, 'Douglas', 'Sarah', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1113, 'Jacob', 'Jasmine', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1114, 'Brandon', 'Carla', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1115, 'Sebastian', 'Tiffany', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1116, 'George', 'Rachel', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1117, 'Julian', 'Madison', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1118, 'Julian', 'Cheryl', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1119, 'Wesley', 'Nancy', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1120, 'Dennis', 'Kelly', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1121, 'Sean', 'Penelope', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1123, 'Andrew', 'Amanda', 9);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1124, 'Ryan', 'Bridget', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1126, 'Caleb', 'Michelle', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1127, 'Jacob', 'Angela', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1129, 'Brian', 'Kristen', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1131, 'Wyatt', 'Alicia', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1132, 'Brian', 'Evelyn', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1133, 'Owen', 'Laura', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1135, 'Cole', 'Shirley', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1136, 'Sebastian', 'Luna', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1137, 'Jack', 'Leah', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1138, 'Adrian', 'Teresa', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1139, 'Javier', 'Amelia', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1140, 'Eric', 'Charlotte', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1141, 'Joan', 'Lily', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1142, 'Walter', 'Cheryl', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1143, 'Javier', 'Luna', 37);
commit;
prompt 100 records committed...
insert into STUDENT (cid, fathername, mothername, class_id)
values (1144, 'Leonardo', 'Ruby', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1145, 'Nathaniel', 'Ruby', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1146, 'Lawrence', 'Tiffany', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1147, 'Scott', 'Phoebe', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1150, 'Ryan', 'Natalie', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1151, 'Joseph', 'Catherine', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1153, 'Owen', 'Ashley', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1155, 'Dennis', 'Natalie', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1157, 'Edward', 'Rachel', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1161, 'Brandon', 'Bridget', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1162, 'Brandon', 'Bethany', 14);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1164, 'Jordan', 'Lillian', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1165, 'David', 'Kayla', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1166, 'Lawrence', 'Jacqueline', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1167, 'Cody', 'Monica', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1168, 'Isaiah', 'Linda', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1169, 'Paul', 'Angela', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1171, 'Jayden', 'Julia', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1173, 'Timothy', 'Meghan', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1174, 'Nathan', 'Peyton', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1176, 'Trevor', 'Kayla', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1177, 'Tyler', 'Lisa', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1178, 'Luke', 'Helena', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1179, 'Anthony', 'Susan', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1182, 'Zachary', 'Lauren', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1185, 'Isaiah', 'Abigail', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1188, 'Tyler', 'Ava', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1192, 'Philip', 'Brittany', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1193, 'Xavier', 'Diana', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1196, 'Vincent', 'Samantha', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1197, 'Antonio', 'Bridget', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1199, 'Chad', 'Gabriella', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1201, 'George', 'Amanda', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1205, 'Scott', 'Courtney', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1206, 'Sebastian', 'Lisa', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1208, 'Trevor', 'Ruby', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1209, 'Stephen', 'Abigail', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1211, 'Theodore', 'Linda', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1213, 'Nicholas', 'Vivian', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1214, 'Diego', 'Kayla', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1217, 'Joshua', 'Sydney', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1218, 'Wyatt', 'Lillian', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1221, 'Joseph', 'Charlene', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1222, 'Trevor', 'Monica', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1223, 'Julian', 'Nicole', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1224, 'Jacob', 'Stephanie', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1226, 'George', 'Alexis', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1228, 'Cody', 'Hannah', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1229, 'Austin', 'Isabella', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1230, 'Ryan', 'Agnes', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1232, 'Julian', 'Sandra', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1234, 'Joan', 'Nicole', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1238, 'Walter', 'Olivia', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1239, 'Austin', 'Lydia', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1241, 'Christopher', 'Meghan', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1242, 'Dustin', 'Brittany', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1244, 'Chad', 'Rose', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1248, 'Stephen', 'Lauren', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1249, 'Julian', 'Courtney', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1250, 'David', 'Linda', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1252, 'Daniel', 'Leslie', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1253, 'Kevin', 'Maria', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1254, 'Miguel', 'Courtney', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1255, 'Dennis', 'Jade', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1256, 'Cody', 'Sheila', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1258, 'Justin', 'Brenda', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1259, 'Alan', 'Pamela', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1262, 'Austin', 'Julia', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1268, 'Thomas', 'Rose', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1269, 'Wyatt', 'Penelope', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1270, 'Patrick', 'Cecilia', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1272, 'Abraham', 'Kayla', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1273, 'Ezekiel', 'Pamela', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1275, 'Andrew', 'Danielle', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1277, 'Joseph', 'Lillian', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1278, 'Gabriel', 'Katherine', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1282, 'John', 'Sarah', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1283, 'Wesley', 'Lucy', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1286, 'Ethan', 'Caroline', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1288, 'Isaac', 'Courtney', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1289, 'Antonio', 'Charlotte', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1290, 'Cody', 'Karen', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1292, 'Patrick', 'Michelle', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1293, 'Zachary', 'Ava', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1297, 'Dustin', 'Louise', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1298, 'Nathaniel', 'Rachel', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1299, 'Daniel', 'Alana', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1300, 'Isaac', 'Charlotte', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1301, 'Trevor', 'Alice', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1304, 'Sebastian', 'Bridget', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1305, 'Dennis', 'Lydia', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1306, 'Aaron', 'Reagan', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1308, 'Aaron', 'Martha', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1311, 'Philip', 'Allison', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1312, 'Joshua', 'Hayley', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1313, 'Richard', 'Linda', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1316, 'Dustin', 'Taylor', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1317, 'Philip', 'Penelope', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1318, 'Eric', 'Lily', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1319, 'Shannon', 'Jessica', 22);
commit;
prompt 200 records committed...
insert into STUDENT (cid, fathername, mothername, class_id)
values (1321, 'Adrian', 'Alexandra', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1324, 'Ryan', 'Catherine', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1325, 'Ezekiel', 'Martha', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1326, 'Trevor', 'Brittany', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1328, 'Ezekiel', 'Penelope', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1329, 'Joan', 'Maya', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1330, 'Keith', 'Sheila', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1332, 'Jordan', 'Reagan', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1334, 'Travis', 'Sharon', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1336, 'Philip', 'Susan', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1338, 'Richard', 'Stephanie', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1339, 'Sebastian', 'Kayla', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1341, 'Cameron', 'Margaret', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1342, 'Isaac', 'Janet', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1343, 'Tyler', 'Faith', 14);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1344, 'Harold', 'Gabriella', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1345, 'Daniel', 'Kristen', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1346, 'Jack', 'Hayley', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1347, 'Harold', 'Ashley', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1349, 'Adrian', 'Lucy', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1350, 'Sebastian', 'Aisha', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1351, 'Dustin', 'Sheila', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1353, 'Jonathan', 'Evelyn', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1354, 'Abraham', 'Monica', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1355, 'Diego', 'Lisa', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1356, 'Owen', 'Lillian', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1357, 'Xavier', 'Penelope', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1359, 'Richard', 'Bethany', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1360, 'Antonio', 'Faith', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1361, 'Jordan', 'Sandra', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1363, 'Benjamin', 'Lucy', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1364, 'Aaron', 'Diana', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1365, 'Lucas', 'Maya', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1366, 'Eric', 'Alice', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1367, 'Roy', 'Claire', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1369, 'Stephen', 'Jane', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1372, 'Albert', 'Claire', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1374, 'Benjamin', 'Nancy', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1376, 'Roy', 'Maya', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1377, 'Derek', 'Jennifer', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1380, 'Oliver', 'Evelyn', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1384, 'Cole', 'Linda', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1385, 'Sebastian', 'Faith', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1386, 'Brandon', 'Taylor', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1388, 'Isaac', 'Caroline', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1390, 'Philip', 'Sheila', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1391, 'Isaiah', 'Monica', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1392, 'Kyle', 'Heather', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1395, 'Austin', 'Jade', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1397, 'Adrian', 'Isabella', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1399, 'Nathan', 'Bridget', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1402, 'Ezekiel', 'Agnes', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1403, 'Travis', 'Alexis', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1404, 'Wesley', 'Diana', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1405, 'Xavier', 'Sophia', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1406, 'Theodore', 'Mia', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1407, 'Adam', 'Margaret', 8);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1408, 'Christopher', 'Penelope', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1411, 'Andrew', 'Teresa', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1412, 'Joseph', 'Audrey', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1415, 'Miguel', 'Lillian', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1416, 'Jacob', 'Courtney', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1418, 'Antonio', 'Claudia', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1419, 'Nathan', 'Meghan', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1420, 'Jesse', 'Lisa', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1421, 'Anthony', 'Jacqueline', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1423, 'Anthony', 'Katherine', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1424, 'Theodore', 'Margaret', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1425, 'Eric', 'Penelope', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1426, 'Dustin', 'Diana', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1427, 'Charles', 'Helena', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1428, 'Luke', 'Jillian', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1429, 'Lawrence', 'Meghan', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1431, 'Henry', 'Lori', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1434, 'Jesse', 'Hayley', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1436, 'Edward', 'Pamela', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1437, 'Paul', 'Cheryl', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1440, 'Derek', 'Pamela', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1441, 'Gabriel', 'Rachel', 9);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1442, 'Richard', 'Meghan', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1443, 'Albert', 'Joan', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1444, 'Samuel', 'Olivia', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1446, 'Oliver', 'Shirley', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1448, 'Gabriel', 'Angela', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1450, 'Oliver', 'Taylor', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1451, 'Lucas', 'Kelly', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1452, 'Gabriel', 'Stephanie', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1457, 'Adrian', 'Hannah', 28);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1460, 'Diego', 'Heather', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1461, 'Julian', 'Maria', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1462, 'Ezekiel', 'Tiffany', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1463, 'Edward', 'Phoebe', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1465, 'Austin', 'Isabella', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1468, 'Luke', 'Dorothy', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1472, 'Leonardo', 'Kimberly', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1474, 'Cody', 'Maya', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1475, 'Isaiah', 'Joan', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1477, 'Tyler', 'Abigail', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1481, 'Travis', 'Amelia', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1482, 'Harold', 'Rachel', 5);
commit;
prompt 300 records committed...
insert into STUDENT (cid, fathername, mothername, class_id)
values (1486, 'Albert', 'Diana', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1488, 'Owen', 'Lucy', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1489, 'Tyler', 'Mia', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1490, 'Dennis', 'Hannah', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1491, 'Isaac', 'Kelly', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1492, 'Abraham', 'Isabella', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1493, 'Sebastian', 'Jane', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1497, 'Dustin', 'Maya', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1498, 'Travis', 'Louise', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1499, 'Douglas', 'Jasmine', 14);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1500, 'Nathan', 'Fiona', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1501, 'Joseph', 'Ashley', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1502, 'Lawrence', 'Lauren', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1504, 'Jesse', 'Mia', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1506, 'Roy', 'Diana', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1508, 'Eric', 'Peyton', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1512, 'John', 'Agnes', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1514, 'Daniel', 'Rebecca', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1515, 'Chad', 'Alexis', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1517, 'Cameron', 'Kristen', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1518, 'Julian', 'Shirley', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1521, 'Lawrence', 'Hannah', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1522, 'Zachary', 'Leah', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1523, 'Aaron', 'Sheila', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1524, 'Cole', 'Rebecca', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1526, 'Austin', 'Danielle', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1528, 'Nicholas', 'Taylor', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1529, 'Jesse', 'Ruby', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1530, 'Jonathan', 'Ruby', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1531, 'Brandon', 'Jessica', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1532, 'Felipe', 'Lisa', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1533, 'Douglas', 'Sandra', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1535, 'Abraham', 'Samantha', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1537, 'Antonio', 'Isabella', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1538, 'Cameron', 'Kelly', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1540, 'Jordan', 'Vivian', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1542, 'Joshua', 'Sheila', 34);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1543, 'Walter', 'Alice', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1544, 'Nathaniel', 'Audrey', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1545, 'Joseph', 'Claire', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1546, 'Lawrence', 'Diana', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1547, 'Benjamin', 'Danielle', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1548, 'Alan', 'Heather', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1550, 'Ezekiel', 'Ava', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1551, 'Nathan', 'Shirley', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1553, 'Ezekiel', 'Lily', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1554, 'Wyatt', 'Alexandra', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1555, 'Jacob', 'Heather', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1556, 'Derek', 'Lily', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1557, 'Abraham', 'Rachel', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1558, 'Harold', 'Shirley', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1561, 'Nathan', 'Olivia', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1562, 'Henry', 'Nicole', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1563, 'Alan', 'Kimberly', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1566, 'Nathaniel', 'Heather', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1567, 'Christopher', 'Charlene', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1568, 'Douglas', 'Lauren', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1570, 'William', 'Lisa', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1573, 'Christopher', 'Ruby', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1576, 'Shannon', 'Alexandra', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1577, 'Scott', 'Bridget', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1578, 'Travis', 'Diana', 16);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1579, 'Douglas', 'Olivia', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1580, 'Joseph', 'Danielle', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1581, 'George', 'Sandra', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1583, 'Cameron', 'Lucy', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1587, 'Xavier', 'Nicole', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1588, 'Keith', 'Kristen', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1589, 'Sean', 'Alexis', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1591, 'Scott', 'Bethany', 38);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1592, 'Nathaniel', 'Angela', 12);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1594, 'George', 'Lydia', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1595, 'Brian', 'Linda', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1597, 'John', 'Cecilia', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1599, 'Douglas', 'Lori', 20);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1600, 'Samuel', 'Leslie', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1601, 'Tyler', 'Carla', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1603, 'Jacob', 'Maria', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1604, 'Carlos', 'Charlene', 30);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1606, 'Ryan', 'Shirley', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1608, 'Henry', 'Leah', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1609, 'Samuel', 'Caroline', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1610, 'Dennis', 'Diana', 19);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1611, 'Henry', 'Jennifer', 29);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1612, 'Jacob', 'Alexis', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1613, 'Philip', 'Jennifer', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1614, 'Carlos', 'Linda', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1616, 'Henry', 'Ashley', 15);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1618, 'Joan', 'Alexis', 6);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1619, 'Joshua', 'Allison', 4);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1620, 'Luke', 'Claire', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1621, 'Joseph', 'Joan', 36);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1622, 'Ethan', 'Bethany', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1624, 'Daniel', 'Stephanie', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1625, 'Chad', 'Maria', 23);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1626, 'Sebastian', 'Lucia', 2);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1628, 'Gabriel', 'Danielle', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1630, 'Antonio', 'Deborah', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1632, 'Daniel', 'Madison', 40);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1633, 'Chad', 'Sophia', 16);
commit;
prompt 400 records committed...
insert into STUDENT (cid, fathername, mothername, class_id)
values (1639, 'Kyle', 'Evelyn', 11);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1640, 'Felipe', 'Lisa', 10);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1641, 'Chad', 'Jennifer', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1642, 'Timothy', 'Rebecca', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1643, 'Stephen', 'Samantha', 1);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1644, 'Cameron', 'Kristen', 5);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1645, 'Xavier', 'Teresa', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1646, 'Juan', 'Monica', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1647, 'Harold', 'Jillian', 31);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1649, 'Isaac', 'Alexis', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1651, 'Christopher', 'Heather', 33);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1653, 'Luke', 'Cecilia', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1655, 'Austin', 'Kimberly', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1656, 'Dustin', 'Claire', 32);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1657, 'Noah', 'Hannah', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1659, 'Cody', 'Penelope', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1660, 'Kyle', 'Samantha', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1661, 'Alan', 'Jacqueline', 25);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1665, 'Tyler', 'Fiona', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1666, 'Travis', 'Cecilia', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1668, 'Theodore', 'Rachel', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1669, 'Joshua', 'Jade', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1671, 'Eric', 'Alice', 17);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1672, 'Joseph', 'Lillian', 24);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1676, 'Xavier', 'Courtney', 13);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1677, 'Jordan', 'Claire', 3);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1680, 'Cody', 'Sheila', 21);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1682, 'Edward', 'Jessica', 22);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1685, 'Sebastian', 'Madison', 18);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1687, 'Zachary', 'Ashley', 26);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1688, 'Theodore', 'Meghan', 37);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1689, 'Keith', 'Olivia', 35);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1695, 'Sebastian', 'Samantha', 27);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1696, 'Paul', 'Olivia', 7);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1698, 'Albert', 'Alana', 39);
insert into STUDENT (cid, fathername, mothername, class_id)
values (1699, 'Javier', 'Abigail', 29);
commit;
prompt 436 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (37328, 2308, to_date('20-12-2024', 'dd-mm-yyyy'), 98548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55543, 1465, to_date('12-09-2026', 'dd-mm-yyyy'), 57217, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17421, 1915, to_date('03-04-2026', 'dd-mm-yyyy'), 61521, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (21271, 640, to_date('02-03-2027', 'dd-mm-yyyy'), 18621, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (94623, 1397, to_date('19-04-2028', 'dd-mm-yyyy'), 21759, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48576, 1215, to_date('04-07-2025', 'dd-mm-yyyy'), 43552, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15756, 2306, to_date('13-09-2025', 'dd-mm-yyyy'), 96149, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (68514, 2388, to_date('09-04-2025', 'dd-mm-yyyy'), 98428, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14935, 1009, to_date('16-11-2024', 'dd-mm-yyyy'), 44623, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (46339, 743, to_date('22-08-2026', 'dd-mm-yyyy'), 45835, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (59368, 882, to_date('05-09-2025', 'dd-mm-yyyy'), 45686, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88362, 2445, to_date('19-01-2026', 'dd-mm-yyyy'), 37772, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55971, 994, to_date('13-01-2027', 'dd-mm-yyyy'), 18621, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (42529, 167, to_date('28-10-2027', 'dd-mm-yyyy'), 68462, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72747, 1256, to_date('24-07-2026', 'dd-mm-yyyy'), 37916, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17253, 1752, to_date('12-10-2025', 'dd-mm-yyyy'), 89217, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58768, 503, to_date('12-03-2026', 'dd-mm-yyyy'), 79857, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66941, 2431, to_date('16-11-2026', 'dd-mm-yyyy'), 29966, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55553, 1643, to_date('24-10-2025', 'dd-mm-yyyy'), 39837, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (52753, 1729, to_date('28-10-2026', 'dd-mm-yyyy'), 53336, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73486, 340, to_date('12-11-2028', 'dd-mm-yyyy'), 88626, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81876, 1551, to_date('18-09-2027', 'dd-mm-yyyy'), 19548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (71678, 1912, to_date('30-12-2029', 'dd-mm-yyyy'), 88298, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (26254, 1922, to_date('23-08-2025', 'dd-mm-yyyy'), 25165, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (18724, 612, to_date('31-08-2026', 'dd-mm-yyyy'), 31688, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85591, 1428, to_date('04-05-2028', 'dd-mm-yyyy'), 59588, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88925, 1231, to_date('08-10-2024', 'dd-mm-yyyy'), 82123, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (37785, 2356, to_date('15-10-2024', 'dd-mm-yyyy'), 74732, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11215, 727, to_date('15-04-2026', 'dd-mm-yyyy'), 35294, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (42631, 1736, to_date('10-11-2026', 'dd-mm-yyyy'), 11426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81431, 424, to_date('17-11-2028', 'dd-mm-yyyy'), 64612, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49929, 1181, to_date('01-12-2026', 'dd-mm-yyyy'), 46594, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (31191, 1747, to_date('13-07-2025', 'dd-mm-yyyy'), 17687, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96125, 277, to_date('19-06-2027', 'dd-mm-yyyy'), 66549, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (86299, 1966, to_date('03-03-2028', 'dd-mm-yyyy'), 47365, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67648, 1726, to_date('04-10-2028', 'dd-mm-yyyy'), 41847, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (24517, 1684, to_date('16-04-2025', 'dd-mm-yyyy'), 31716, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12261, 2382, to_date('11-06-2028', 'dd-mm-yyyy'), 17698, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (45529, 582, to_date('30-07-2029', 'dd-mm-yyyy'), 93739, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (33779, 746, to_date('27-02-2027', 'dd-mm-yyyy'), 78169, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17359, 205, to_date('18-07-2029', 'dd-mm-yyyy'), 96657, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14372, 2106, to_date('06-03-2028', 'dd-mm-yyyy'), 69782, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66462, 2054, to_date('18-02-2025', 'dd-mm-yyyy'), 33732, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14887, 174, to_date('13-01-2025', 'dd-mm-yyyy'), 97666, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17116, 978, to_date('15-05-2027', 'dd-mm-yyyy'), 11426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (24297, 1034, to_date('22-02-2025', 'dd-mm-yyyy'), 30001, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98684, 2063, to_date('18-12-2027', 'dd-mm-yyyy'), 35294, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58463, 2424, to_date('03-06-2025', 'dd-mm-yyyy'), 37916, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41244, 2274, to_date('09-12-2028', 'dd-mm-yyyy'), 72942, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56933, 1229, to_date('30-11-2029', 'dd-mm-yyyy'), 31688, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11621, 292, to_date('12-04-2024', 'dd-mm-yyyy'), 39953, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83341, 979, to_date('05-06-2025', 'dd-mm-yyyy'), 39472, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83725, 1664, to_date('09-07-2029', 'dd-mm-yyyy'), 19487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12682, 529, to_date('24-02-2029', 'dd-mm-yyyy'), 54755, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (21784, 429, to_date('26-05-2027', 'dd-mm-yyyy'), 52292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (25775, 1557, to_date('08-04-2028', 'dd-mm-yyyy'), 58994, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58669, 724, to_date('21-06-2027', 'dd-mm-yyyy'), 55791, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83912, 1951, to_date('10-08-2027', 'dd-mm-yyyy'), 11395, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85988, 763, to_date('22-09-2029', 'dd-mm-yyyy'), 31948, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72155, 950, to_date('29-03-2025', 'dd-mm-yyyy'), 65252, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12691, 333, to_date('27-03-2024', 'dd-mm-yyyy'), 32565, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (51589, 1938, to_date('19-02-2024', 'dd-mm-yyyy'), 52192, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (21991, 1234, to_date('05-10-2026', 'dd-mm-yyyy'), 66593, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69997, 1128, to_date('01-10-2025', 'dd-mm-yyyy'), 33634, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (28934, 669, to_date('15-05-2024', 'dd-mm-yyyy'), 78212, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96535, 2111, to_date('06-09-2029', 'dd-mm-yyyy'), 16511, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34518, 1086, to_date('03-02-2029', 'dd-mm-yyyy'), 54399, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (43574, 2189, to_date('14-04-2027', 'dd-mm-yyyy'), 28113, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39944, 1216, to_date('06-07-2029', 'dd-mm-yyyy'), 45349, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (59397, 2219, to_date('14-04-2025', 'dd-mm-yyyy'), 71465, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12751, 1215, to_date('31-05-2026', 'dd-mm-yyyy'), 21367, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (28763, 2356, to_date('05-06-2027', 'dd-mm-yyyy'), 36499, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11598, 756, to_date('24-05-2026', 'dd-mm-yyyy'), 13184, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82461, 2488, to_date('29-01-2028', 'dd-mm-yyyy'), 66364, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67868, 1819, to_date('01-07-2029', 'dd-mm-yyyy'), 31448, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58291, 330, to_date('10-11-2029', 'dd-mm-yyyy'), 53947, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (53546, 2079, to_date('03-11-2028', 'dd-mm-yyyy'), 95217, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (31645, 1269, to_date('13-04-2025', 'dd-mm-yyyy'), 22834, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48762, 2399, to_date('23-03-2028', 'dd-mm-yyyy'), 37772, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (89528, 2345, to_date('09-05-2026', 'dd-mm-yyyy'), 93442, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39217, 221, to_date('11-10-2029', 'dd-mm-yyyy'), 25798, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (16279, 2096, to_date('21-03-2028', 'dd-mm-yyyy'), 41561, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (57945, 1757, to_date('25-07-2027', 'dd-mm-yyyy'), 45686, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12923, 1276, to_date('20-03-2025', 'dd-mm-yyyy'), 31688, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36466, 1924, to_date('21-04-2024', 'dd-mm-yyyy'), 82652, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19894, 349, to_date('28-07-2029', 'dd-mm-yyyy'), 26335, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66359, 1139, to_date('01-02-2029', 'dd-mm-yyyy'), 59487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11896, 538, to_date('16-01-2025', 'dd-mm-yyyy'), 96149, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87783, 283, to_date('28-05-2027', 'dd-mm-yyyy'), 65711, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67639, 1015, to_date('05-05-2025', 'dd-mm-yyyy'), 37461, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (27649, 2452, to_date('19-02-2029', 'dd-mm-yyyy'), 16719, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34635, 553, to_date('14-01-2024', 'dd-mm-yyyy'), 33634, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (95349, 618, to_date('25-04-2029', 'dd-mm-yyyy'), 66527, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82458, 1721, to_date('07-09-2025', 'dd-mm-yyyy'), 14115, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23892, 1866, to_date('11-02-2027', 'dd-mm-yyyy'), 82123, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (76836, 357, to_date('24-12-2026', 'dd-mm-yyyy'), 42873, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (84423, 2068, to_date('23-08-2028', 'dd-mm-yyyy'), 54399, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39842, 2470, to_date('12-05-2028', 'dd-mm-yyyy'), 26926, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (65777, 432, to_date('03-08-2028', 'dd-mm-yyyy'), 44484, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (22839, 1168, to_date('29-08-2027', 'dd-mm-yyyy'), 16437, 'Appointment', null);
commit;
prompt 100 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (47524, 2295, to_date('30-10-2027', 'dd-mm-yyyy'), 26256, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (84258, 607, to_date('14-09-2025', 'dd-mm-yyyy'), 30004, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36526, 754, to_date('19-01-2027', 'dd-mm-yyyy'), 37782, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (29569, 2330, to_date('16-12-2025', 'dd-mm-yyyy'), 12567, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (76733, 617, to_date('26-05-2026', 'dd-mm-yyyy'), 13358, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (44265, 1003, to_date('22-02-2028', 'dd-mm-yyyy'), 69466, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (43947, 2387, to_date('27-01-2025', 'dd-mm-yyyy'), 56328, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (22698, 1314, to_date('09-11-2027', 'dd-mm-yyyy'), 23487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73144, 354, to_date('24-12-2026', 'dd-mm-yyyy'), 28593, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (63494, 1955, to_date('14-03-2028', 'dd-mm-yyyy'), 37647, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55733, 1839, to_date('30-04-2028', 'dd-mm-yyyy'), 71253, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (77665, 770, to_date('01-06-2027', 'dd-mm-yyyy'), 37647, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36312, 1778, to_date('15-04-2029', 'dd-mm-yyyy'), 36345, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96395, 2240, to_date('28-06-2024', 'dd-mm-yyyy'), 76411, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (79165, 1970, to_date('01-08-2027', 'dd-mm-yyyy'), 98548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (97975, 1475, to_date('20-10-2024', 'dd-mm-yyyy'), 61521, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88982, 2112, to_date('20-02-2024', 'dd-mm-yyyy'), 55163, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (18964, 1108, to_date('24-09-2027', 'dd-mm-yyyy'), 84414, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (25397, 242, to_date('10-09-2028', 'dd-mm-yyyy'), 19974, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98338, 2333, to_date('12-04-2026', 'dd-mm-yyyy'), 21367, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (37382, 232, to_date('07-06-2029', 'dd-mm-yyyy'), 76595, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (25392, 641, to_date('18-09-2024', 'dd-mm-yyyy'), 44833, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87386, 472, to_date('11-08-2028', 'dd-mm-yyyy'), 44344, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (94834, 373, to_date('10-03-2026', 'dd-mm-yyyy'), 96369, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (84339, 1368, to_date('03-03-2024', 'dd-mm-yyyy'), 37512, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66258, 1047, to_date('08-05-2026', 'dd-mm-yyyy'), 49749, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85648, 1077, to_date('20-05-2027', 'dd-mm-yyyy'), 84117, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88714, 157, to_date('23-12-2024', 'dd-mm-yyyy'), 41673, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (97995, 650, to_date('13-06-2026', 'dd-mm-yyyy'), 25556, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49627, 660, to_date('14-08-2025', 'dd-mm-yyyy'), 14715, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72982, 2125, to_date('24-02-2028', 'dd-mm-yyyy'), 85761, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (42742, 2019, to_date('11-03-2029', 'dd-mm-yyyy'), 72625, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (74682, 1912, to_date('14-06-2027', 'dd-mm-yyyy'), 78759, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (64391, 641, to_date('13-08-2027', 'dd-mm-yyyy'), 30006, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (45226, 639, to_date('21-02-2025', 'dd-mm-yyyy'), 56328, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49553, 2072, to_date('15-06-2027', 'dd-mm-yyyy'), 44578, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (64731, 1239, to_date('17-06-2027', 'dd-mm-yyyy'), 39472, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34755, 281, to_date('06-07-2025', 'dd-mm-yyyy'), 29134, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19583, 2344, to_date('11-09-2027', 'dd-mm-yyyy'), 57292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41351, 1607, to_date('29-06-2026', 'dd-mm-yyyy'), 92587, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (33596, 1070, to_date('05-11-2029', 'dd-mm-yyyy'), 53947, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19255, 1696, to_date('01-08-2024', 'dd-mm-yyyy'), 32614, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (79675, 515, to_date('22-03-2024', 'dd-mm-yyyy'), 24676, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81344, 2393, to_date('16-02-2027', 'dd-mm-yyyy'), 76411, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (89675, 795, to_date('29-01-2029', 'dd-mm-yyyy'), 57934, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (74612, 430, to_date('14-03-2024', 'dd-mm-yyyy'), 69782, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (31115, 1834, to_date('29-03-2024', 'dd-mm-yyyy'), 14242, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (46391, 1974, to_date('09-04-2024', 'dd-mm-yyyy'), 61521, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (18813, 1457, to_date('21-09-2028', 'dd-mm-yyyy'), 38729, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85672, 1906, to_date('25-10-2029', 'dd-mm-yyyy'), 13831, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34929, 530, to_date('12-05-2028', 'dd-mm-yyyy'), 66549, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11282, 722, to_date('07-12-2024', 'dd-mm-yyyy'), 28354, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15553, 2167, to_date('26-06-2027', 'dd-mm-yyyy'), 29966, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (61447, 2316, to_date('16-08-2025', 'dd-mm-yyyy'), 38729, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56311, 1182, to_date('14-09-2028', 'dd-mm-yyyy'), 59923, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41836, 993, to_date('19-09-2025', 'dd-mm-yyyy'), 38457, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (57821, 1783, to_date('21-11-2025', 'dd-mm-yyyy'), 44782, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93129, 1266, to_date('29-08-2025', 'dd-mm-yyyy'), 11395, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (43997, 966, to_date('13-07-2024', 'dd-mm-yyyy'), 17911, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15347, 991, to_date('08-08-2024', 'dd-mm-yyyy'), 52254, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (92445, 1004, to_date('16-04-2025', 'dd-mm-yyyy'), 38161, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69789, 2281, to_date('08-02-2029', 'dd-mm-yyyy'), 96463, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23832, 1859, to_date('19-03-2027', 'dd-mm-yyyy'), 31554, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56617, 606, to_date('20-06-2025', 'dd-mm-yyyy'), 83776, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93433, 627, to_date('24-12-2027', 'dd-mm-yyyy'), 68537, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67157, 506, to_date('28-12-2029', 'dd-mm-yyyy'), 65252, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (71671, 829, to_date('20-11-2029', 'dd-mm-yyyy'), 62227, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34582, 798, to_date('10-10-2028', 'dd-mm-yyyy'), 16719, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (27992, 1745, to_date('11-01-2025', 'dd-mm-yyyy'), 45389, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19384, 1890, to_date('08-04-2028', 'dd-mm-yyyy'), 33315, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (22161, 1661, to_date('27-04-2028', 'dd-mm-yyyy'), 79322, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (28964, 2490, to_date('05-10-2024', 'dd-mm-yyyy'), 97122, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (53997, 1129, to_date('14-05-2027', 'dd-mm-yyyy'), 13831, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (64931, 263, to_date('20-03-2025', 'dd-mm-yyyy'), 71739, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (95355, 546, to_date('16-09-2029', 'dd-mm-yyyy'), 18374, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (16327, 631, to_date('12-07-2025', 'dd-mm-yyyy'), 92587, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (33931, 1289, to_date('03-05-2029', 'dd-mm-yyyy'), 74732, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (54474, 2052, to_date('20-10-2028', 'dd-mm-yyyy'), 18374, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (52417, 2104, to_date('20-01-2024', 'dd-mm-yyyy'), 72625, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (54221, 736, to_date('16-06-2027', 'dd-mm-yyyy'), 89358, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (61278, 2064, to_date('20-10-2027', 'dd-mm-yyyy'), 21632, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14942, 492, to_date('08-11-2026', 'dd-mm-yyyy'), 82439, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96427, 1006, to_date('10-04-2028', 'dd-mm-yyyy'), 19974, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73931, 1408, to_date('05-12-2026', 'dd-mm-yyyy'), 76744, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12257, 2322, to_date('20-07-2028', 'dd-mm-yyyy'), 76248, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35955, 299, to_date('22-10-2027', 'dd-mm-yyyy'), 84937, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (33847, 1648, to_date('17-09-2028', 'dd-mm-yyyy'), 65183, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (71758, 548, to_date('07-06-2029', 'dd-mm-yyyy'), 98965, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35795, 1407, to_date('20-06-2025', 'dd-mm-yyyy'), 52292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39895, 791, to_date('12-03-2025', 'dd-mm-yyyy'), 65711, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39253, 1849, to_date('16-10-2029', 'dd-mm-yyyy'), 97354, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (57321, 2414, to_date('18-07-2025', 'dd-mm-yyyy'), 56368, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72612, 1491, to_date('11-07-2024', 'dd-mm-yyyy'), 29532, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87556, 586, to_date('21-08-2027', 'dd-mm-yyyy'), 37461, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (68386, 2258, to_date('13-01-2024', 'dd-mm-yyyy'), 65753, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82321, 1161, to_date('08-12-2026', 'dd-mm-yyyy'), 21632, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82367, 522, to_date('18-10-2025', 'dd-mm-yyyy'), 74361, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81772, 2307, to_date('09-11-2028', 'dd-mm-yyyy'), 45659, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88378, 1649, to_date('23-01-2028', 'dd-mm-yyyy'), 51446, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (51131, 2002, to_date('16-05-2024', 'dd-mm-yyyy'), 78759, 'Appointment', null);
commit;
prompt 200 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87137, 1630, to_date('11-06-2029', 'dd-mm-yyyy'), 30003, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99937, 825, to_date('30-08-2025', 'dd-mm-yyyy'), 35487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (52623, 1627, to_date('30-07-2028', 'dd-mm-yyyy'), 32614, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23724, 2398, to_date('17-09-2029', 'dd-mm-yyyy'), 41656, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93861, 1365, to_date('21-09-2029', 'dd-mm-yyyy'), 62424, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73531, 2070, to_date('17-12-2029', 'dd-mm-yyyy'), 59736, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83833, 1921, to_date('23-05-2024', 'dd-mm-yyyy'), 78657, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35426, 1465, to_date('28-11-2027', 'dd-mm-yyyy'), 29134, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23686, 1461, to_date('26-12-2026', 'dd-mm-yyyy'), 29724, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (61479, 1868, to_date('01-10-2026', 'dd-mm-yyyy'), 79234, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15146, 387, to_date('26-05-2026', 'dd-mm-yyyy'), 19487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23566, 2320, to_date('01-01-2025', 'dd-mm-yyyy'), 25893, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41649, 1775, to_date('04-09-2027', 'dd-mm-yyyy'), 25854, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (92476, 2402, to_date('15-02-2028', 'dd-mm-yyyy'), 82123, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (53368, 2413, to_date('05-08-2027', 'dd-mm-yyyy'), 29118, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (44659, 331, to_date('21-02-2024', 'dd-mm-yyyy'), 74732, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (57689, 293, to_date('30-04-2026', 'dd-mm-yyyy'), 82615, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15211, 453, to_date('09-04-2025', 'dd-mm-yyyy'), 28113, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17981, 2108, to_date('21-01-2027', 'dd-mm-yyyy'), 28734, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93998, 1924, to_date('21-07-2025', 'dd-mm-yyyy'), 18374, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (38443, 179, to_date('01-08-2029', 'dd-mm-yyyy'), 59864, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (17126, 1509, to_date('20-06-2024', 'dd-mm-yyyy'), 11912, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72979, 1112, to_date('20-12-2029', 'dd-mm-yyyy'), 35784, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (95552, 1070, to_date('27-07-2026', 'dd-mm-yyyy'), 73524, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34944, 374, to_date('28-02-2026', 'dd-mm-yyyy'), 98548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87256, 957, to_date('04-02-2029', 'dd-mm-yyyy'), 98965, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (27291, 1543, to_date('09-08-2029', 'dd-mm-yyyy'), 72115, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35984, 447, to_date('11-08-2027', 'dd-mm-yyyy'), 11426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96662, 294, to_date('18-11-2028', 'dd-mm-yyyy'), 52545, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (52338, 538, to_date('13-08-2027', 'dd-mm-yyyy'), 41673, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35873, 1294, to_date('30-04-2025', 'dd-mm-yyyy'), 91912, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98737, 2035, to_date('09-03-2026', 'dd-mm-yyyy'), 64612, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (84214, 2187, to_date('29-08-2026', 'dd-mm-yyyy'), 82921, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66268, 1294, to_date('03-08-2029', 'dd-mm-yyyy'), 13184, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56655, 1087, to_date('07-08-2028', 'dd-mm-yyyy'), 30002, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67328, 2414, to_date('28-11-2028', 'dd-mm-yyyy'), 17117, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12591, 1723, to_date('02-07-2026', 'dd-mm-yyyy'), 64612, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (37244, 1221, to_date('04-09-2029', 'dd-mm-yyyy'), 38729, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (42118, 2122, to_date('22-12-2026', 'dd-mm-yyyy'), 24984, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (96733, 2104, to_date('05-07-2029', 'dd-mm-yyyy'), 74361, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (38453, 1372, to_date('06-02-2026', 'dd-mm-yyyy'), 36928, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48396, 2306, to_date('15-11-2024', 'dd-mm-yyyy'), 14115, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41818, 1178, to_date('10-04-2024', 'dd-mm-yyyy'), 59736, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72289, 997, to_date('16-06-2024', 'dd-mm-yyyy'), 43637, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (84381, 760, to_date('27-07-2029', 'dd-mm-yyyy'), 34432, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (74421, 2453, to_date('26-09-2027', 'dd-mm-yyyy'), 35517, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (22495, 469, to_date('07-12-2027', 'dd-mm-yyyy'), 97354, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (16832, 597, to_date('10-11-2025', 'dd-mm-yyyy'), 19338, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99294, 1123, to_date('25-06-2026', 'dd-mm-yyyy'), 72625, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56318, 224, to_date('04-05-2026', 'dd-mm-yyyy'), 52292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55583, 759, to_date('30-03-2028', 'dd-mm-yyyy'), 95217, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83491, 1732, to_date('24-01-2027', 'dd-mm-yyyy'), 96628, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34752, 504, to_date('30-11-2024', 'dd-mm-yyyy'), 99859, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72752, 961, to_date('29-02-2028', 'dd-mm-yyyy'), 39953, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82199, 641, to_date('10-09-2028', 'dd-mm-yyyy'), 36345, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (31273, 292, to_date('30-04-2029', 'dd-mm-yyyy'), 74732, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11865, 1590, to_date('29-01-2025', 'dd-mm-yyyy'), 83316, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15426, 1306, to_date('13-07-2024', 'dd-mm-yyyy'), 24577, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (94532, 1484, to_date('18-01-2025', 'dd-mm-yyyy'), 44426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (87447, 2466, to_date('08-03-2026', 'dd-mm-yyyy'), 96369, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72294, 1962, to_date('06-12-2026', 'dd-mm-yyyy'), 86555, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (21373, 1494, to_date('05-07-2027', 'dd-mm-yyyy'), 42728, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (63725, 181, to_date('08-11-2026', 'dd-mm-yyyy'), 34639, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49118, 1914, to_date('23-02-2024', 'dd-mm-yyyy'), 77442, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36815, 366, to_date('21-02-2026', 'dd-mm-yyyy'), 34262, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72713, 746, to_date('01-02-2029', 'dd-mm-yyyy'), 17979, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41461, 266, to_date('11-04-2025', 'dd-mm-yyyy'), 53332, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (71187, 1167, to_date('07-11-2027', 'dd-mm-yyyy'), 16511, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (12812, 187, to_date('21-06-2028', 'dd-mm-yyyy'), 58911, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (38863, 1629, to_date('30-10-2026', 'dd-mm-yyyy'), 84414, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14928, 1434, to_date('05-05-2027', 'dd-mm-yyyy'), 24984, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55313, 2031, to_date('01-07-2025', 'dd-mm-yyyy'), 94296, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (91841, 730, to_date('24-06-2028', 'dd-mm-yyyy'), 28354, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11551, 2215, to_date('29-10-2025', 'dd-mm-yyyy'), 66153, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (27924, 368, to_date('11-07-2024', 'dd-mm-yyyy'), 30003, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82664, 240, to_date('26-09-2028', 'dd-mm-yyyy'), 25854, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (24515, 2165, to_date('25-08-2024', 'dd-mm-yyyy'), 69154, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67723, 1911, to_date('23-01-2029', 'dd-mm-yyyy'), 83531, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19733, 534, to_date('06-10-2027', 'dd-mm-yyyy'), 17117, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (83428, 841, to_date('17-11-2028', 'dd-mm-yyyy'), 59736, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15449, 628, to_date('07-11-2028', 'dd-mm-yyyy'), 13927, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81812, 2141, to_date('22-02-2028', 'dd-mm-yyyy'), 30004, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48569, 379, to_date('08-10-2024', 'dd-mm-yyyy'), 76411, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (76795, 212, to_date('06-07-2025', 'dd-mm-yyyy'), 21575, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (43187, 1688, to_date('19-03-2028', 'dd-mm-yyyy'), 49699, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (57366, 1888, to_date('25-05-2024', 'dd-mm-yyyy'), 82652, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (94825, 2239, to_date('20-10-2027', 'dd-mm-yyyy'), 89616, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (91237, 2193, to_date('18-06-2024', 'dd-mm-yyyy'), 35784, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55778, 1132, to_date('04-01-2024', 'dd-mm-yyyy'), 43748, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (78463, 2034, to_date('11-11-2026', 'dd-mm-yyyy'), 44344, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40001, 100, to_date('01-05-2023', 'dd-mm-yyyy'), 30001, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40003, 75, to_date('03-05-2023', 'dd-mm-yyyy'), 30003, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40005, 126, to_date('05-05-2023', 'dd-mm-yyyy'), 30005, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (64674, 2131, to_date('27-08-2025', 'dd-mm-yyyy'), 83564, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48632, 2042, to_date('13-04-2026', 'dd-mm-yyyy'), 34432, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (18447, 1631, to_date('05-01-2028', 'dd-mm-yyyy'), 32826, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (45981, 798, to_date('06-09-2024', 'dd-mm-yyyy'), 54111, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69791, 750, to_date('26-03-2028', 'dd-mm-yyyy'), 30002, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (75485, 1853, to_date('04-02-2027', 'dd-mm-yyyy'), 65252, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (44216, 1442, to_date('12-06-2029', 'dd-mm-yyyy'), 15747, 'Appointment', null);
commit;
prompt 300 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14888, 985, to_date('08-04-2025', 'dd-mm-yyyy'), 16437, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (95454, 2226, to_date('04-07-2027', 'dd-mm-yyyy'), 76832, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49713, 174, to_date('12-06-2025', 'dd-mm-yyyy'), 49699, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99222, 348, to_date('19-06-2028', 'dd-mm-yyyy'), 72942, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (97299, 2180, to_date('25-06-2028', 'dd-mm-yyyy'), 59923, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15939, 2217, to_date('13-03-2028', 'dd-mm-yyyy'), 37495, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (45575, 1530, to_date('10-02-2027', 'dd-mm-yyyy'), 82256, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (86862, 1752, to_date('09-09-2026', 'dd-mm-yyyy'), 30002, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (79483, 1607, to_date('02-06-2025', 'dd-mm-yyyy'), 37638, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48277, 1917, to_date('16-07-2029', 'dd-mm-yyyy'), 84414, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69529, 1507, to_date('15-11-2025', 'dd-mm-yyyy'), 78657, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41167, 197, to_date('09-03-2025', 'dd-mm-yyyy'), 42978, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (25196, 1749, to_date('26-04-2028', 'dd-mm-yyyy'), 28734, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (91169, 1962, to_date('13-06-2028', 'dd-mm-yyyy'), 47288, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85647, 2054, to_date('22-07-2027', 'dd-mm-yyyy'), 41656, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15977, 1068, to_date('04-11-2027', 'dd-mm-yyyy'), 54365, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (26731, 2110, to_date('18-04-2028', 'dd-mm-yyyy'), 65753, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (26844, 1947, to_date('11-06-2025', 'dd-mm-yyyy'), 38338, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82843, 863, to_date('30-06-2024', 'dd-mm-yyyy'), 39837, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36662, 2430, to_date('13-01-2028', 'dd-mm-yyyy'), 26335, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (59354, 1811, to_date('09-06-2028', 'dd-mm-yyyy'), 32922, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (66864, 1552, to_date('28-12-2026', 'dd-mm-yyyy'), 65753, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36549, 1159, to_date('21-07-2024', 'dd-mm-yyyy'), 54365, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (71392, 1006, to_date('16-11-2024', 'dd-mm-yyyy'), 65183, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69676, 1742, to_date('18-04-2029', 'dd-mm-yyyy'), 42733, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58241, 1225, to_date('31-03-2024', 'dd-mm-yyyy'), 94296, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (22885, 2249, to_date('07-06-2026', 'dd-mm-yyyy'), 23284, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (47881, 2411, to_date('28-10-2027', 'dd-mm-yyyy'), 14242, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98379, 1575, to_date('23-09-2026', 'dd-mm-yyyy'), 66449, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98654, 2425, to_date('26-02-2026', 'dd-mm-yyyy'), 52292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (86571, 1380, to_date('07-06-2025', 'dd-mm-yyyy'), 55163, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (68928, 380, to_date('19-08-2025', 'dd-mm-yyyy'), 30005, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (27548, 1033, to_date('20-02-2028', 'dd-mm-yyyy'), 42873, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (78642, 376, to_date('06-12-2026', 'dd-mm-yyyy'), 56328, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11751, 2210, to_date('20-07-2025', 'dd-mm-yyyy'), 58911, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88625, 235, to_date('30-09-2027', 'dd-mm-yyyy'), 37647, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (74463, 723, to_date('29-01-2027', 'dd-mm-yyyy'), 38457, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (43688, 2231, to_date('28-11-2027', 'dd-mm-yyyy'), 34639, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93494, 1682, to_date('16-12-2027', 'dd-mm-yyyy'), 67992, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (39613, 1927, to_date('02-01-2028', 'dd-mm-yyyy'), 59864, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (86512, 174, to_date('25-03-2026', 'dd-mm-yyyy'), 99859, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (51173, 2484, to_date('14-10-2029', 'dd-mm-yyyy'), 36944, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (51696, 2315, to_date('08-11-2025', 'dd-mm-yyyy'), 72942, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99184, 1465, to_date('02-10-2028', 'dd-mm-yyyy'), 45389, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (29916, 1522, to_date('30-11-2027', 'dd-mm-yyyy'), 64612, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (48598, 668, to_date('16-07-2026', 'dd-mm-yyyy'), 73721, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (49397, 460, to_date('02-05-2025', 'dd-mm-yyyy'), 38616, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (13174, 2199, to_date('16-05-2026', 'dd-mm-yyyy'), 78281, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35835, 1794, to_date('03-08-2027', 'dd-mm-yyyy'), 56515, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (75718, 879, to_date('16-08-2027', 'dd-mm-yyyy'), 16437, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56928, 1246, to_date('29-11-2024', 'dd-mm-yyyy'), 68537, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82587, 843, to_date('30-08-2029', 'dd-mm-yyyy'), 48971, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72553, 2448, to_date('19-01-2024', 'dd-mm-yyyy'), 87984, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (89989, 223, to_date('06-08-2029', 'dd-mm-yyyy'), 35517, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85596, 1954, to_date('01-01-2025', 'dd-mm-yyyy'), 54399, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (32437, 1828, to_date('11-02-2025', 'dd-mm-yyyy'), 25675, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (98595, 1093, to_date('11-11-2025', 'dd-mm-yyyy'), 65772, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (14394, 2222, to_date('05-02-2026', 'dd-mm-yyyy'), 73199, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (81879, 201, to_date('10-03-2026', 'dd-mm-yyyy'), 53751, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (47571, 268, to_date('02-01-2027', 'dd-mm-yyyy'), 11426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72129, 2180, to_date('18-07-2026', 'dd-mm-yyyy'), 98548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34169, 766, to_date('02-05-2024', 'dd-mm-yyyy'), 54111, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (21528, 1861, to_date('07-09-2029', 'dd-mm-yyyy'), 11426, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73135, 1456, to_date('21-01-2028', 'dd-mm-yyyy'), 14242, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56416, 493, to_date('18-09-2029', 'dd-mm-yyyy'), 37512, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11296, 2264, to_date('30-11-2026', 'dd-mm-yyyy'), 42873, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (42694, 1246, to_date('27-02-2027', 'dd-mm-yyyy'), 46912, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34568, 310, to_date('02-11-2029', 'dd-mm-yyyy'), 29532, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (23558, 1999, to_date('11-04-2027', 'dd-mm-yyyy'), 93742, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (62627, 579, to_date('09-09-2027', 'dd-mm-yyyy'), 92316, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (88186, 296, to_date('18-10-2025', 'dd-mm-yyyy'), 37869, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (77746, 2259, to_date('30-12-2029', 'dd-mm-yyyy'), 45388, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (85115, 834, to_date('13-09-2025', 'dd-mm-yyyy'), 65753, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40002, 151, to_date('02-05-2023', 'dd-mm-yyyy'), 30002, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40004, 200, to_date('04-05-2023', 'dd-mm-yyyy'), 30004, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (40006, 176, to_date('06-05-2023', 'dd-mm-yyyy'), 30006, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (77195, 586, to_date('06-07-2025', 'dd-mm-yyyy'), 66153, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99119, 1817, to_date('31-08-2029', 'dd-mm-yyyy'), 85315, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (72412, 556, to_date('10-11-2026', 'dd-mm-yyyy'), 30003, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (41888, 1970, to_date('18-05-2029', 'dd-mm-yyyy'), 61135, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93818, 571, to_date('01-08-2025', 'dd-mm-yyyy'), 14715, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58316, 221, to_date('18-04-2026', 'dd-mm-yyyy'), 57292, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (69477, 1070, to_date('22-01-2024', 'dd-mm-yyyy'), 76744, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (19487, 685, to_date('22-02-2027', 'dd-mm-yyyy'), 69154, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (35972, 1477, to_date('17-09-2025', 'dd-mm-yyyy'), 84937, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (95683, 1955, to_date('02-07-2027', 'dd-mm-yyyy'), 74361, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (82612, 1233, to_date('05-02-2029', 'dd-mm-yyyy'), 27367, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73147, 1020, to_date('24-02-2026', 'dd-mm-yyyy'), 84957, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (75556, 591, to_date('01-03-2026', 'dd-mm-yyyy'), 53274, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (86562, 2475, to_date('29-11-2024', 'dd-mm-yyyy'), 84576, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11126, 985, to_date('17-07-2027', 'dd-mm-yyyy'), 76832, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (67266, 2323, to_date('27-04-2025', 'dd-mm-yyyy'), 99385, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (11432, 1041, to_date('15-11-2024', 'dd-mm-yyyy'), 69358, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73836, 543, to_date('13-11-2026', 'dd-mm-yyyy'), 42917, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (47186, 2226, to_date('24-01-2024', 'dd-mm-yyyy'), 13927, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55376, 507, to_date('27-10-2024', 'dd-mm-yyyy'), 78169, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (76395, 2462, to_date('20-11-2029', 'dd-mm-yyyy'), 86376, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (15176, 1218, to_date('30-11-2028', 'dd-mm-yyyy'), 73262, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (56651, 183, to_date('01-01-2025', 'dd-mm-yyyy'), 82256, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (55664, 421, to_date('30-03-2027', 'dd-mm-yyyy'), 83316, 'Appointment', null);
commit;
prompt 400 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (29236, 573, to_date('21-10-2025', 'dd-mm-yyyy'), 25854, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34332, 2259, to_date('19-04-2025', 'dd-mm-yyyy'), 37748, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (94973, 1146, to_date('08-12-2024', 'dd-mm-yyyy'), 76248, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (99438, 693, to_date('08-06-2024', 'dd-mm-yyyy'), 24577, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (24531, 2060, to_date('02-11-2026', 'dd-mm-yyyy'), 94727, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (38228, 1435, to_date('14-03-2027', 'dd-mm-yyyy'), 72942, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (26716, 1795, to_date('30-12-2024', 'dd-mm-yyyy'), 69358, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (77587, 1359, to_date('18-12-2027', 'dd-mm-yyyy'), 98548, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (34526, 2367, to_date('11-09-2025', 'dd-mm-yyyy'), 45388, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (58579, 1801, to_date('18-04-2027', 'dd-mm-yyyy'), 62424, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (73548, 2460, to_date('10-08-2026', 'dd-mm-yyyy'), 55427, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (59685, 1897, to_date('01-03-2025', 'dd-mm-yyyy'), 47365, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (33213, 845, to_date('13-03-2028', 'dd-mm-yyyy'), 36345, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36149, 1820, to_date('01-01-2029', 'dd-mm-yyyy'), 69466, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (93459, 558, to_date('24-06-2025', 'dd-mm-yyyy'), 59588, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (29162, 1567, to_date('19-08-2029', 'dd-mm-yyyy'), 94727, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (37582, 2005, to_date('27-09-2025', 'dd-mm-yyyy'), 61435, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (36256, 460, to_date('25-03-2024', 'dd-mm-yyyy'), 59487, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (63784, 2442, to_date('12-05-2024', 'dd-mm-yyyy'), 96672, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (45895, 1857, to_date('01-08-2026', 'dd-mm-yyyy'), 17642, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (97359, 1437, to_date('23-07-2029', 'dd-mm-yyyy'), 96566, 'Appointment', null);
insert into PAYMENT (id, totalprice, pdate, appointmentid, paymenttype, student_id)
values (60000, 230, to_date('20-07-2024', 'dd-mm-yyyy'), null, 'School', 1004);
commit;
prompt 422 records loaded
prompt Loading TPREFORMEDINA...
prompt Table is empty
prompt Enabling foreign key constraints for APPOINTMENT...
alter table APPOINTMENT enable constraint SYS_C007566;
prompt Enabling foreign key constraints for TEACHER...
alter table TEACHER enable constraint FK_T_S;
prompt Enabling foreign key constraints for CLASS_...
alter table CLASS_ enable constraint SYS_C007472;
alter table CLASS_ enable constraint SYS_C007473;
prompt Enabling foreign key constraints for LESSON...
alter table LESSON enable constraint SYS_C007485;
alter table LESSON enable constraint SYS_C007486;
alter table LESSON enable constraint SYS_C007487;
prompt Enabling foreign key constraints for STUDENT...
alter table STUDENT enable constraint FK_STUDENT_PATIENT;
alter table STUDENT enable constraint SYS_C007497;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint FK_PAYMENT_STUDENT;
alter table PAYMENT enable constraint SYS_C007344;
prompt Enabling triggers for STAFF...
alter table STAFF enable all triggers;
prompt Enabling triggers for DOCTOR...
alter table DOCTOR enable all triggers;
prompt Enabling triggers for PATIENT...
alter table PATIENT enable all triggers;
prompt Enabling triggers for APPOINTMENT...
alter table APPOINTMENT enable all triggers;
prompt Enabling triggers for ROOM...
alter table ROOM enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;
prompt Enabling triggers for CLASS_...
alter table CLASS_ enable all triggers;
prompt Enabling triggers for SUBJECT...
alter table SUBJECT enable all triggers;
prompt Enabling triggers for LESSON...
alter table LESSON enable all triggers;
prompt Enabling triggers for MATERIAL...
alter table MATERIAL enable all triggers;
prompt Enabling triggers for TREATMENT...
alter table TREATMENT enable all triggers;
prompt Enabling triggers for MUSEDINT...
alter table MUSEDINT enable all triggers;
prompt Enabling triggers for OFFICE...
alter table OFFICE enable all triggers;
prompt Enabling triggers for OMAKEA...
alter table OMAKEA enable all triggers;
prompt Enabling triggers for STUDENT...
alter table STUDENT enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA enable all triggers;
set feedback on
set define on
prompt Done.

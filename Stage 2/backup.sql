prompt PL/SQL Developer import file
prompt Created on יום שני 17 יוני 2024 by maria
set feedback off
set define off
prompt Creating STAFF...
create table STAFF
(
  saddress VARCHAR2(55) not null,
  smobile  CHAR(10) not null,
  sname    VARCHAR2(30) not null,
  smail    VARCHAR2(35) not null,
  sid      NUMBER(5) not null
)
;
alter table STAFF
  add primary key (SID);
grant select, update, delete on STAFF to MIRIAM;

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
  references STAFF (SID);
grant select, update, delete on DOCTOR to MIRIAM;

prompt Creating PATIENT...
create table PATIENT
(
  cbirthyear NUMBER(4) not null,
  caddress   VARCHAR2(55) not null,
  cname      VARCHAR2(30) not null,
  cgender    VARCHAR2(5) not null,
  cid        NUMBER(5) not null,
  cmobile    VARCHAR2(10) not null,
  cmail      VARCHAR2(35) not null
)
;
alter table PATIENT
  add primary key (CID);
alter table PATIENT
  add constraint CHECK_MOBILE_PATIENT
  check (CMOBILE LIKE '0%');
alter table PATIENT
  add constraint CHECK_PATIENT_MOBILE
  check (CMOBILE LIKE '0%');
alter table PATIENT
  add constraint CHECK_PATIENT_PHONE
  check (CMOBILE LIKE '0%');
grant select, update, delete on PATIENT to MIRIAM;

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
  references DOCTOR (SID);
alter table APPOINTMENT
  add foreign key (CID)
  references PATIENT (CID);
grant select, insert, update, delete on APPOINTMENT to MIRIAM;

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
grant select, update, delete on MATERIAL to MIRIAM;

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
grant select, update, delete on TREATMENT to MIRIAM;

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
  references TREATMENT (TID);
alter table MUSEDINT
  add foreign key (MID)
  references MATERIAL (MID);
grant select, update, delete on MUSEDINT to MIRIAM;

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
  references STAFF (SID);
grant select, update, delete on OFFICE to MIRIAM;

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
  references APPOINTMENT (APPOINTMENTID);
alter table OMAKEA
  add foreign key (SID)
  references OFFICE (SID);
grant select, update, delete on OMAKEA to MIRIAM;

prompt Creating PAYMENT...
create table PAYMENT
(
  id            NUMBER(5) not null,
  totalprice    NUMBER(10) not null,
  pdate         DATE not null,
  appointmentid NUMBER(5) not null
)
;
alter table PAYMENT
  add primary key (ID);
alter table PAYMENT
  add foreign key (APPOINTMENTID)
  references APPOINTMENT (APPOINTMENTID);
grant select, update, delete on PAYMENT to MIRIAM;

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
  references TREATMENT (TID);
alter table TPREFORMEDINA
  add foreign key (APPOINTMENTID)
  references APPOINTMENT (APPOINTMENTID);
grant select, update, delete on TPREFORMEDINA to MIRIAM;

prompt Disabling triggers for STAFF...
alter table STAFF disable all triggers;
prompt Disabling triggers for DOCTOR...
alter table DOCTOR disable all triggers;
prompt Disabling triggers for PATIENT...
alter table PATIENT disable all triggers;
prompt Disabling triggers for APPOINTMENT...
alter table APPOINTMENT disable all triggers;
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
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA disable all triggers;
prompt Disabling foreign key constraints for DOCTOR...
alter table DOCTOR disable constraint SYS_C007299;
prompt Disabling foreign key constraints for APPOINTMENT...
alter table APPOINTMENT disable constraint SYS_C007313;
alter table APPOINTMENT disable constraint SYS_C007314;
prompt Disabling foreign key constraints for MUSEDINT...
alter table MUSEDINT disable constraint SYS_C007328;
alter table MUSEDINT disable constraint SYS_C007329;
prompt Disabling foreign key constraints for OFFICE...
alter table OFFICE disable constraint SYS_C007333;
prompt Disabling foreign key constraints for OMAKEA...
alter table OMAKEA disable constraint SYS_C007337;
alter table OMAKEA disable constraint SYS_C007338;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint SYS_C007344;
prompt Disabling foreign key constraints for TPREFORMEDINA...
alter table TPREFORMEDINA disable constraint SYS_C007348;
alter table TPREFORMEDINA disable constraint SYS_C007349;
prompt Deleting TPREFORMEDINA...
delete from TPREFORMEDINA;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
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
values ('5850 Sed Road', '545186956 ', 'MacKenzie Rivera', 'mackenzierivera4426@google.couk', 36074);
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
commit;
prompt 200 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #603-6530 Auctor St.', '535493434 ', 'Seth Mcdonald', 'sethmcdonald2053@icloud.edu', 89885);
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
commit;
prompt 419 records loaded
prompt Loading DOCTOR...
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
commit;
prompt 100 records committed...
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
commit;
prompt 163 records loaded
prompt Loading PATIENT...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1972, '567-8655 Integer Ave', 'Reagan Berry', 'M', 727, '0513417574', 'pede.nec@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2003, '7681 Lorem, Avenue', 'Bradley Baxter', 'F', 764, '0515263776', 'enim.nunc.ut@aol.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1957, '126-8581 Donec Rd.', 'Rajah Wilder', 'F', 934, '0555376138', 'posuere.at@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1950, 'Ap #936-210 Erat Avenue', 'Dana Wyatt', 'F', 354, '0541603349', 'dis.parturient.montes@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1936, '228-2863 Curabitur Rd.', 'Megan Molina', 'F', 717, '0572442876', 'mauris.vel@outlook.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1952, 'Ap #177-2381 Imperdiet, St.', 'Rooney Jennings', 'F', 350, '0556334347', 'eu.erat@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1975, 'Ap #625-170 Vivamus Ave', 'Thomas Macias', 'M', 148, '0565667249', 'gravida.aliquam@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1970, '481-6951 Nascetur Ave', 'Adam Bond', 'M', 600, '0533935363', 'donec@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '349-3264 Pede, Avenue', 'Gloria Mckee', 'F', 910, '0594712703', 'massa.mauris.vestibulum@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1998, 'P.O. Box 567, 6464 Ligula. Rd.', 'Basil Russo', 'F', 989, '0526357271', 'vitae.risus@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2023, 'Ap #446-6388 Etiam St.', 'Shay Dillon', 'F', 856, '0524682525', 'accumsan@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1970, 'Ap #261-7637 Magna Av.', 'Quamar Welch', 'M', 392, '0531137654', 'vestibulum.ut@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, 'Ap #774-3061 Erat. Street', 'Cody Salinas', 'M', 163, '0522779526', 'amet.lorem@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, '505-6353 A Av.', 'Brittany Guerra', 'M', 219, '0572180527', 'magna.tellus@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2000, '613-6144 Sollicitudin Avenue', 'Murphy Rodriguez', 'F', 399, '0543917465', 'vulputate.dui@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1987, 'P.O. Box 920, 5357 Vel Av.', 'Kyle Hood', 'M', 290, '0543506775', 'magnis.dis@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1950, 'Ap #496-1940 Nunc Rd.', 'Timon Dickson', 'M', 610, '0581604265', 'donec.luctus@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1984, '526-8631 Tellus. Rd.', 'Galvin Mueller', 'M', 308, '0571592579', 'quam.quis@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1982, 'P.O. Box 189, 7664 Eget St.', 'Maxine Schmidt', 'M', 433, '0565531776', 'nec.tempus@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2012, 'P.O. Box 754, 8798 Orci. Avenue', 'Leo Jordan', 'M', 889, '0585112072', 'et.eros.proin@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'P.O. Box 903, 1703 Lorem Av.', 'Melissa Bennett', 'F', 408, '0514454657', 'et.magnis.dis@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1974, '967-451 Sed, Street', 'Madison Madden', 'F', 676, '0571078114', 'lorem.ut@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1951, '826 Euismod Rd.', 'Giselle Jimenez', 'M', 468, '0546537375', 'consectetuer.mauris@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1951, '7838 Nec, St.', 'Charlotte Nguyen', 'M', 736, '0524684538', 'metus@protonmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1935, 'Ap #189-8861 Eget Ave', 'Cecilia Butler', 'F', 538, '0572109396', 'mi.enim@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2024, 'Ap #292-1074 Tristique Avenue', 'Shad Vance', 'M', 332, '0577455669', 'erat.volutpat@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2021, '244-6311 Semper St.', 'Xavier Bowen', 'F', 832, '0518848475', 'semper.cursus.integer@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1919, 'P.O. Box 512, 3296 Risus Av.', 'Alma Herrera', 'M', 662, '0503221446', 'ullamcorper.nisl@aol.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, 'Ap #923-8893 Non, St.', 'Shaine Gonzalez', 'M', 657, '0515626843', 'laoreet.lectus@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1939, '4526 Elit. Road', 'Fredericka Alexander', 'M', 777, '0514117865', 'hendrerit.neque@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2014, '873-1295 Et Street', 'Rinah Conley', 'M', 634, '0528954826', 'eros.nam@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2001, '4166 Scelerisque Avenue', 'Lamar Conrad', 'F', 672, '0572746354', 'fringilla@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2015, 'Ap #892-6022 Nisl. St.', 'May Mcleod', 'F', 420, '0593277604', 'eu.odio@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2010, 'P.O. Box 597, 2340 Malesuada St.', 'Josiah Barker', 'F', 758, '0512575114', 'lorem.ipsum@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1920, 'Ap #174-6408 Tortor. Ave', 'Irene Rodriguez', 'M', 328, '0564760474', 'nunc.in.at@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, 'Ap #862-6080 Dictum Road', 'Kerry Winters', 'M', 180, '0592340126', 'lorem.ipsum@icloud.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, '272-7923 Donec Av.', 'Jack Sanford', 'F', 994, '0538883878', 'ipsum.ac.mi@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2022, 'Ap #387-1929 Nec Rd.', 'Kelly Parker', 'M', 117, '0565457105', 'senectus.et.netus@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'Ap #820-6929 Ut Av.', 'Kylan Peterson', 'M', 765, '0514709492', 'vivamus.molestie@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1962, '719-5359 Convallis Ave', 'Erin Foster', 'M', 292, '0588289946', 'in.magna@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1979, '708-5898 Nulla Rd.', 'Lynn Sheppard', 'M', 714, '0554036557', 'mauris@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1985, '632-9752 Neque. Av.', 'Noelle Joyner', 'M', 274, '0597072866', 'eget.laoreet.posuere@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1941, 'P.O. Box 589, 725 Aenean Street', 'Paula Nash', 'F', 995, '0511750307', 'purus@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1960, '982-868 Praesent Rd.', 'Lucius Gross', 'M', 766, '0579876917', 'fringilla.est@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1978, '952-1922 Nam St.', 'Rowan Pickett', 'M', 250, '0508722274', 'aenean@aol.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1941, '837-1139 Lorem, Av.', 'Steven Anderson', 'M', 463, '0551252921', 'sit@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1920, '119-565 Nibh St.', 'Cairo Clemons', 'F', 619, '0581353284', 'eu.odio@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1938, '987 Tellus. Rd.', 'Rhona Maxwell', 'M', 559, '0574848123', 'non.hendrerit@outlook.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1996, '824-7836 Sodales Av.', 'Evelyn Cervantes', 'F', 236, '0583403513', 'volutpat.nulla@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1995, '660-5198 Vestibulum St.', 'Cora Maddox', 'M', 259, '0543449110', 'sed.leo@outlook.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1942, '772-7183 Tempus Rd.', 'Mercedes Larsen', 'M', 962, '0530421879', 'vitae.purus.gravida@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2003, '1233 Amet, Av.', 'Trevor Zamora', 'M', 800, '0532928861', 'sed.pede.nec@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1950, 'P.O. Box 681, 394 Mauris Av.', 'Calvin Whitehead', 'M', 201, '0523833797', 'leo.morbi@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2022, '323-9960 Tempus St.', 'Bree Gates', 'F', 195, '0562490850', 'mi@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, '2664 Donec St.', 'Donna Shelton', 'M', 129, '0572817298', 'nunc.sed.pede@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1974, 'Ap #144-1855 Aliquet, Ave', 'Berk Buckner', 'M', 654, '0546831222', 'ornare@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, 'Ap #912-9015 Nulla Rd.', 'Mark Pate', 'F', 445, '0586184648', 'parturient.montes@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, 'Ap #352-7450 Urna, Avenue', 'Bevis Wise', 'F', 839, '0536227603', 'et.libero@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1987, '248-2273 Tincidunt. Road', 'Chase Slater', 'M', 586, '0510307871', 'eu@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, 'P.O. Box 722, 4184 Ligula. St.', 'Nigel Maldonado', 'M', 267, '0521264525', 'scelerisque.sed@aol.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, 'Ap #904-8376 Nulla St.', 'Travis Bowers', 'F', 199, '0528815203', 'vestibulum.lorem.sit@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2018, 'Ap #826-450 Lectus Road', 'Britanney Lott', 'M', 473, '0570766632', 'ipsum.phasellus@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1963, '280 Elit Av.', 'Geoffrey Chang', 'M', 409, '0574680069', 'aliquam.nisl.nulla@aol.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1997, '870-6394 Urna Rd.', 'Macon Russo', 'M', 530, '0522401933', 'non@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, 'Ap #658-4466 Dictum Avenue', 'Hayden Macias', 'M', 701, '0582455104', 'leo.vivamus@icloud.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2009, 'P.O. Box 169, 939 Vitae Street', 'Kasimir Mejia', 'M', 652, '0556404987', 'eu.augue.porttitor@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1942, 'Ap #554-1952 Lacus, Ave', 'Carter Vaughn', 'M', 683, '0527446108', 'vitae.aliquam.eros@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1992, '328-5625 Vel Avenue', 'Ashely Wilcox', 'F', 984, '0567831993', 'eu.placerat.eget@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1938, '535-9234 Enim Street', 'Audrey Shaw', 'M', 389, '0568275139', 'fringilla@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, 'Ap #867-1820 Nascetur St.', 'Maris Witt', 'F', 775, '0591237837', 'nisi.nibh@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1995, '960-9821 Leo, Avenue', 'Ivana Bullock', 'F', 914, '0567138256', 'sed@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, '525-1272 Quam St.', 'Herrod Gill', 'F', 307, '0536423781', 'fusce.mi@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2006, '615-9113 Suspendisse Rd.', 'Harlan Dawson', 'F', 650, '0526183215', 'commodo.ipsum@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, '2483 Non Avenue', 'Lacota Roberts', 'F', 471, '0528224623', 'laoreet@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1928, 'Ap #187-6985 In, St.', 'Davis Glenn', 'M', 902, '0511168367', 'mauris.ut.quam@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, '888-2958 Nam Ave', 'Beau Ewing', 'M', 303, '0548488365', 'ultrices@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1923, '7121 Ornare. Av.', 'Kirk Maxwell', 'M', 225, '0598374128', 'nec.tempus@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1956, '401-6211 Sociis Road', 'Rashad Daugherty', 'F', 523, '0579304529', 'magna@icloud.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1921, 'Ap #337-3834 Justo Avenue', 'Vladimir Fields', 'M', 434, '0538171585', 'eget@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1930, 'Ap #820-4662 Lorem Road', 'Alan Head', 'F', 518, '0531375882', 'aenean@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, '5691 Neque Road', 'Brady Potts', 'F', 572, '0566222893', 'elit.pellentesque@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1960, 'P.O. Box 745, 7434 Tincidunt, St.', 'Noble Wright', 'M', 374, '0512147360', 'quisque.libero@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1973, 'Ap #501-9078 Velit. Street', 'Cairo Jackson', 'M', 631, '0566617418', 'consequat.lectus@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2001, '5611 Pellentesque Ave', 'Erich Pugh', 'M', 769, '0535646221', 'nullam.ut@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1964, 'P.O. Box 236, 3018 Nulla. St.', 'Levi Cohen', 'M', 351, '0572828727', 'aenean.eget@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2013, 'Ap #826-6053 Tellus, Road', 'Nolan England', 'F', 151, '0523397837', 'mollis.duis@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, 'Ap #255-383 Cum Ave', 'Brody Alvarado', 'M', 975, '0546115281', 'est.ac@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1974, '6442 Lacus. Av.', 'Daphne Osborne', 'F', 585, '0563583327', 'ipsum.non@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1962, 'Ap #311-5051 Tellus. St.', 'Ezekiel Thomas', 'F', 656, '0514597178', 'metus@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1996, 'Ap #178-585 Quam St.', 'Florence Mcleod', 'M', 776, '0557195181', 'in.scelerisque@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1969, 'Ap #797-6365 Congue Avenue', 'Pascale Stafford', 'M', 899, '0587868950', 'ligula@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1934, 'P.O. Box 958, 4749 Mollis Road', 'Lisandra Guzman', 'M', 729, '0532714125', 'tempus.non.lacinia@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, '728-7464 Nam St.', 'Giselle May', 'F', 511, '0583795820', 'gravida@outlook.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1960, '1021 Conubia Rd.', 'Leilani Mathews', 'M', 170, '0545333791', 'eu@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1931, '668-2386 Adipiscing St.', 'Laith Todd', 'F', 647, '0503322286', 'suspendisse.dui@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2016, '488-8967 Elit, Rd.', 'Maia Mcintyre', 'F', 867, '0536782405', 'tincidunt@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1933, 'Ap #245-1577 At Road', 'Levi Jennings', 'F', 140, '0537283414', 'donec@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, 'P.O. Box 423, 7190 Morbi Ave', 'Risa Wynn', 'F', 804, '0575712566', 'risus.quis@hotmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1970, 'Ap #557-8714 Nec Street', 'Christine Petersen', 'M', 298, '0514217163', 'erat.neque.non@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1972, '347-6464 Fermentum Avenue', 'Oren Navarro', 'F', 590, '0573753225', 'libero.proin@hotmail.net');
commit;
prompt 100 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1923, '667-9508 Tristique Rd.', 'Cruz Lowe', 'M', 302, '0584960543', 'justo@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1953, 'P.O. Box 484, 6173 Nec, Street', 'Gary Black', 'F', 978, '0574820630', 'at@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2000, '538-8634 Nulla Ave', 'Hyatt Cain', 'F', 900, '0512587712', 'dis.parturient@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2006, '7833 Pede. Road', 'Castor Tyson', 'F', 231, '0541720336', 'nam.porttitor@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, 'P.O. Box 553, 4465 Risus, St.', 'Frances Harper', 'F', 831, '0561218043', 'orci@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1927, '256-7346 Justo. Street', 'Paki Mayo', 'M', 816, '0557772726', 'et.lacinia@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1952, '518-7070 Non, Ave', 'Fay Castro', 'M', 884, '0517303930', 'nunc@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1923, '315-8278 Per St.', 'Stone Le', 'M', 144, '0511487414', 'ornare.tortor@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1932, '6742 Vel, Rd.', 'Armando Alford', 'F', 423, '0597860506', 'in.sodales@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1952, '3055 Orci. Road', 'Leilani Heath', 'F', 778, '0529482437', 'est@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1929, '203-1408 Nulla. Rd.', 'Sylvester Snow', 'F', 639, '0568129712', 'donec@yahoo.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, '866-4257 Consectetuer St.', 'Jorden Britt', 'F', 922, '0522788654', 'iaculis.lacus.pede@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1917, 'Ap #557-9780 Et Street', 'Garrison Ware', 'M', 805, '0574622955', 'mattis@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, 'Ap #348-104 Tempor St.', 'Adara Sampson', 'F', 127, '0546236268', 'eleifend.non@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2024, '885-6524 Ac, Ave', 'Brenna Sharpe', 'M', 391, '0558403148', 'aliquam.tincidunt@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1926, '449-8685 Et Street', 'Jesse Dominguez', 'F', 387, '0527445043', 'fusce.aliquet@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1963, '152-502 Ipsum Rd.', 'Alma Welch', 'M', 556, '0534176481', 'elit.curabitur@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2013, '401-2521 Semper Rd.', 'Ivor Barron', 'M', 327, '0573557458', 'sollicitudin.adipiscing@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1940, '9914 Tempor Ave', 'April Booth', 'M', 671, '0509516731', 'montes@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, '424-3481 Adipiscing Avenue', 'Oprah Williams', 'F', 100, '0543825441', 'eu.enim@google.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2010, '3099 Sed Road', 'Dahlia Buckley', 'F', 501, '0553033828', 'faucibus.morbi@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2021, 'Ap #938-5556 Ac St.', 'Addison Tran', 'M', 324, '0531821759', 'hymenaeos.mauris@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, 'P.O. Box 657, 7513 Duis St.', 'Kieran Montoya', 'M', 686, '0582571346', 'sed.diam@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, 'P.O. Box 891, 1528 Sed Street', 'Noelani Mcbride', 'M', 747, '0595512563', 'in.ornare@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1955, 'Ap #209-1973 Natoque Road', 'Aline Ramos', 'M', 709, '0510093856', 'lobortis@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'P.O. Box 523, 1443 Rutrum, Road', 'Pascale Farley', 'M', 119, '0564741632', 'sapien.cursus@outlook.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1932, 'Ap #963-5500 Urna, Street', 'Upton Hawkins', 'F', 715, '0529031517', 'eu@outlook.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1922, '2057 Laoreet Street', 'Uriel Mayer', 'M', 980, '0534800137', 'a.aliquet@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, 'Ap #825-9686 Fermentum Road', 'Burton Baldwin', 'M', 206, '0566837484', 'ad@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, 'Ap #884-7342 Euismod Road', 'Ivory Peterson', 'F', 562, '0561832664', 'euismod.in@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1991, 'Ap #344-8279 Elit, St.', 'Abra Franklin', 'M', 286, '0522137654', 'cursus.a@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, '5666 Sed Av.', 'Inez Hughes', 'M', 365, '0563033647', 'posuere.vulputate.lacus@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1971, 'Ap #480-5460 Curabitur Av.', 'Hedda Schwartz', 'F', 336, '0541597774', 'pede.cum.sociis@hotmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'Ap #812-5960 Sed St.', 'Nasim Washington', 'F', 310, '0586167344', 'convallis.convallis@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1967, 'P.O. Box 554, 1787 Dolor, Ave', 'Kane Fulton', 'M', 660, '0512614204', 'dolor@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2014, '8704 Mattis Rd.', 'Genevieve Hebert', 'M', 755, '0511025768', 'euismod@hotmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1968, 'P.O. Box 843, 4294 Etiam Road', 'Shellie Burke', 'F', 743, '0526082430', 'leo.in@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2013, 'P.O. Box 406, 4043 At Street', 'Jada Holcomb', 'F', 363, '0588595851', 'maecenas.ornare@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1938, 'P.O. Box 833, 467 Donec St.', 'Ian Ortiz', 'F', 121, '0586226924', 'mollis.integer@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1934, '6786 Mi, Avenue', 'Angelica Trujillo', 'M', 774, '0528451591', 'nulla.aliquet.proin@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '503-703 Enim, Rd.', 'Tanya Bray', 'M', 136, '0586848260', 'libero.nec.ligula@outlook.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1931, '5365 Vulputate, St.', 'Aladdin Haynes', 'F', 266, '0523582867', 'rutrum@outlook.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1936, 'P.O. Box 178, 6688 Blandit St.', 'Arden Riley', 'M', 941, '0577781953', 'felis.purus.ac@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1966, 'P.O. Box 640, 4984 Vulputate, Street', 'Kane Livingston', 'F', 901, '0520616463', 'sit.amet@outlook.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2014, 'Ap #163-5667 Nascetur St.', 'Keefe Sanford', 'F', 513, '0543771390', 'fringilla.est@aol.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2024, '3911 Vitae Road', 'Isaac Wilkerson', 'F', 230, '0542639238', 'sapien.molestie@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1935, '541 Non Avenue', 'Bree Ware', 'M', 488, '0581403179', 'cubilia.curae@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1927, 'Ap #992-8410 Consequat Rd.', 'Alexa Workman', 'F', 668, '0598364753', 'lobortis.mauris@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1981, '696-2363 At Rd.', 'Acton Phillips', 'M', 149, '0508858245', 'quisque.imperdiet@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1934, 'P.O. Box 104, 8453 Dapibus Rd.', 'Samuel Sampson', 'F', 369, '0572861838', 'odio.semper.cursus@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1951, 'Ap #668-3587 Lacus. Rd.', 'Lyle Adams', 'M', 903, '0559637780', 'cras@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1979, '2305 Pellentesque Rd.', 'Brittany Alvarez', 'M', 242, '0557043575', 'nunc@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2000, 'Ap #995-8303 Interdum Avenue', 'Tate Wolfe', 'F', 885, '0587574194', 'felis@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2000, '152 Diam Avenue', 'Leila Hunter', 'M', 153, '0539505318', 'non.justo@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1953, '236-8729 A, St.', 'Noble Brewer', 'M', 222, '0544763631', 'placerat.augue.sed@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1982, '223 Sed Rd.', 'Margaret May', 'F', 269, '0583664628', 'cum.sociis@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, '796-5835 Dolor Rd.', 'Timon Osborn', 'F', 708, '0517831723', 'eu.elit@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1919, '620-1782 Vitae St.', 'Audrey Vega', 'M', 625, '0569427425', 'porttitor.eros@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2013, '2857 Eleifend St.', 'Leilani Mcintyre', 'M', 877, '0539744738', 'nulla.tempor@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, '6992 Ante. St.', 'Denton Burch', 'F', 469, '0562627734', 'aliquam.ultrices@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1997, 'P.O. Box 905, 216 Donec Road', 'Inez Foster', 'M', 110, '0565073633', 'neque.pellentesque@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1943, 'P.O. Box 724, 8911 Sit Av.', 'Vance Lane', 'M', 437, '0586135673', 'cursus.et.eros@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1948, '491-6805 Sem St.', 'Rashad Duncan', 'F', 726, '0587214354', 'malesuada.vel@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2002, '719-6551 Aptent St.', 'Alexa Nielsen', 'F', 446, '0534516221', 'a.ultricies.adipiscing@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2006, '1207 Dui Rd.', 'Brynn Merritt', 'F', 760, '0501242711', 'litora.torquent.per@protonmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1956, '735-4239 Ad Road', 'Aurelia Atkins', 'F', 150, '0568063641', 'urna.nunc@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1973, '1365 Arcu. Road', 'Conan Spencer', 'F', 135, '0564733787', 'molestie.arcu@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1976, '868-5363 Donec St.', 'Justina Todd', 'F', 220, '0510833836', 'fermentum.fermentum@google.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1933, 'Ap #846-4907 Non Road', 'Lani Trujillo', 'M', 685, '0565641345', 'penatibus.et.magnis@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2001, 'Ap #850-1932 Ac St.', 'Evan Osborne', 'F', 444, '0565732785', 'maecenas.iaculis.aliquet@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1929, '756-3127 Sed St.', 'Carson Hartman', 'F', 828, '0555337963', 'eros.non.enim@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2005, '1495 Nisi. Street', 'Craig Kelley', 'M', 599, '0526186837', 'nibh@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1974, '663-3495 Primis Rd.', 'Odessa Mcmahon', 'F', 848, '0539671235', 'non.lorem@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2019, '779-1233 Sapien St.', 'Ciaran Frost', 'M', 759, '0543198517', 'a@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1968, '275-5328 Elit Ave', 'Chancellor Montgomery', 'M', 809, '0523478709', 'nunc.ullamcorper@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2006, '552-6760 Nec, St.', 'Reagan Franks', 'F', 618, '0595022534', 'enim.suspendisse@hotmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1976, '161-2363 Phasellus Rd.', 'Camille Hayes', 'M', 651, '0578285774', 'fusce.mi.lorem@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1952, 'Ap #758-9581 Sodales Rd.', 'Thaddeus Everett', 'F', 418, '0522226676', 'viverra.maecenas@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1994, 'Ap #377-189 Id, Road', 'Brady Duran', 'F', 588, '0547952767', 'ante.ipsum.primis@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2020, '254-4214 Aenean Ave', 'Demetrius Lott', 'M', 293, '0573252825', 'lectus.sit@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1943, '344-5668 Arcu. Road', 'Sandra Barrett', 'F', 475, '0510277447', 'a.facilisis@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1923, '398-8859 Pharetra Road', 'Cynthia Howe', 'M', 705, '0572311852', 'nulla.donec@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2012, '414 Gravida Rd.', 'Juliet Padilla', 'M', 745, '0535934563', 'facilisis@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1977, '698-1264 Tempus, Avenue', 'Tyler Madden', 'F', 895, '0574472946', 'lectus.nullam@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'Ap #774-8223 Pretium Ave', 'Donna Waters', 'M', 343, '0599349275', 'mattis.cras@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1949, 'Ap #286-9930 Semper, Avenue', 'Jerome Huff', 'F', 803, '0526177687', 'natoque.penatibus@google.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1930, 'Ap #636-1116 Ac Rd.', 'Basia Reid', 'M', 470, '0505532653', 'mi.tempor@icloud.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1965, 'Ap #620-625 Lacus. St.', 'Renee Jimenez', 'F', 842, '0583375410', 'imperdiet@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1999, '801-4125 Elit. St.', 'Benjamin Joyce', 'F', 624, '0578562258', 'magna.lorem.ipsum@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, 'Ap #587-4620 Eget Ave', 'Clare Molina', 'M', 878, '0591702841', 'nec.euismod@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, 'Ap #703-7034 Eu Ave', 'Micah Koch', 'F', 526, '0525405268', 'cras.eu@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1940, 'Ap #803-5954 Mauris Rd.', 'Miranda Raymond', 'M', 872, '0518211275', 'purus@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1968, '4347 Aliquet Av.', 'Demetrius Romero', 'F', 807, '0573046756', 'consectetuer@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2023, '9735 Pretium Rd.', 'Germane Floyd', 'F', 208, '0513968668', 'quisque.varius.nam@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1995, '171 Ut Avenue', 'Basil Weiss', 'F', 855, '0520233191', 'arcu.vestibulum@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1977, 'P.O. Box 878, 9543 Lectus. Street', 'Yuli Bullock', 'M', 178, '0596167859', 'nulla@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1979, 'P.O. Box 328, 4362 Tristique Rd.', 'Barrett Bentley', 'M', 700, '0585468446', 'sem.egestas@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1983, 'P.O. Box 871, 5782 Ornare Road', 'Ross Chapman', 'M', 881, '0502284436', 'rutrum.fusce@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '123-5818 Lacus. Ave', 'Cameron Leblanc', 'M', 338, '0548421496', 'sed.molestie@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1917, '260-8086 Amet Rd.', 'Gregory Odom', 'F', 835, '0509584088', 'euismod.et.commodo@hotmail.org');
commit;
prompt 200 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1962, 'Ap #188-9556 Cras Avenue', 'Naomi Paul', 'M', 567, '0507110270', 'mauris.morbi@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1923, '929-368 Neque Ave', 'Portia Foster', 'M', 971, '0562517208', 'enim.nisl.elementum@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1998, '2077 Mauris Ave', 'Edan Warren', 'F', 568, '0535444860', 'fames@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1959, 'Ap #905-980 Est Ave', 'Herrod Ingram', 'F', 322, '0575339523', 'auctor.mauris@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1996, 'Ap #220-2101 Egestas Av.', 'Whitney Holt', 'F', 249, '0580933718', 'eget@hotmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, '434-1217 Non Street', 'Hyatt Gay', 'F', 495, '0528533319', 'lacus.vestibulum@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2005, 'Ap #508-4203 Amet, Rd.', 'Mollie Nguyen', 'F', 221, '0590449083', 'sodales.nisi@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1916, 'Ap #204-7890 Neque. Road', 'Hop Wright', 'M', 919, '0556847954', 'eu.lacus@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1952, 'P.O. Box 394, 9604 Quis Rd.', 'David Sexton', 'F', 241, '0531781517', 'mattis.cras@protonmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1939, '401-1982 Erat. Street', 'Harrison Estrada', 'F', 524, '0581638292', 'vivamus.sit.amet@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2021, '875-4218 Aliquam St.', 'Martin Pacheco', 'M', 864, '0586515972', 'pede.cum@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1951, 'P.O. Box 288, 6324 Primis Rd.', 'Jordan Mathis', 'M', 833, '0583375862', 'arcu.iaculis@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1941, 'Ap #346-6650 Faucibus Road', 'Dahlia Reilly', 'F', 812, '0508338631', 'diam.pellentesque@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, 'P.O. Box 321, 9761 Arcu. Rd.', 'Thomas Mendez', 'M', 725, '0527817282', 'tristique.senectus@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1925, 'Ap #405-7497 Enim. Road', 'Isadora Monroe', 'M', 169, '0521215647', 'odio.etiam@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1943, '893-9162 Egestas. Av.', 'Marcia Arnold', 'F', 874, '0566075237', 'rutrum.eu@aol.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2000, 'Ap #671-8494 Eu, Ave', 'Simone Suarez', 'F', 713, '0571085153', 'posuere.at@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2005, '4712 Nec Rd.', 'Galvin Reeves', 'M', 448, '0576128443', 'vehicula.risus.nulla@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1983, '392-9303 Dui Road', 'Kenyon Hall', 'F', 841, '0566685505', 'elementum.dui@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1959, '205-4410 Fringilla Rd.', 'Charlotte Duffy', 'M', 690, '0582366338', 'nunc@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2018, 'P.O. Box 435, 2678 Sed Rd.', 'Brock Valenzuela', 'F', 281, '0500338368', 'et.ultrices.posuere@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1939, 'P.O. Box 124, 5624 Eget St.', 'Gannon Garza', 'M', 696, '0533315498', 'volutpat.nulla@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1942, 'Ap #110-4949 Nulla. St.', 'Cullen Greene', 'M', 952, '0586368553', 'tincidunt.donec@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2012, 'P.O. Box 145, 8216 Nascetur St.', 'Unity Ayala', 'M', 798, '0559037161', 'placerat@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, 'Ap #339-3186 Velit. Av.', 'Xander Richards', 'M', 616, '0511854727', 'ut.odio@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1997, 'P.O. Box 243, 784 Facilisis Street', 'Shea Shepherd', 'M', 707, '0588528867', 'pellentesque@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1947, '983-655 Lectus Rd.', 'Dominic Dorsey', 'M', 457, '0555922372', 'tellus.aenean.egestas@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1932, '252-2571 Purus, Rd.', 'Zeus Graham', 'M', 451, '0563453637', 'ipsum.primis.in@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '1327 Lorem, Road', 'Quamar Hughes', 'F', 689, '0538045781', 'turpis@protonmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1983, '899-2271 Arcu. Av.', 'Cairo Charles', 'M', 943, '0524371093', 'morbi.neque@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1980, '7677 Ornare. Avenue', 'Quamar Bradshaw', 'F', 539, '0582360258', 'arcu.vestibulum@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1951, 'Ap #980-5532 Nec Rd.', 'Keane Jackson', 'M', 216, '0598038843', 'rhoncus@protonmail.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2003, '510-2981 Vulputate St.', 'Shana Kent', 'F', 829, '0573914367', 'vitae.dolor@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1991, 'Ap #266-3776 Mus. St.', 'Armando Dillon', 'F', 183, '0571371101', 'eu.eleifend.nec@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1993, 'P.O. Box 272, 8267 Lorem Street', 'Vincent Cotton', 'F', 379, '0569139768', 'mauris@google.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, '456 Oak Ave', 'Bob Smith', 'M', 25670, '087654321', 'bob@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, 'Ap #958-7751 Viverra. Ave', 'Eleanor Jefferson', 'F', 577, '0582175221', 'ac.metus@outlook.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, 'P.O. Box 175, 6500 Quisque Av.', 'Ira Day', 'M', 838, '0524324167', 'et.nunc.quisque@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1934, '5479 Mi St.', 'Maisie Hampton', 'F', 502, '0512648528', 'penatibus.et@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1980, 'Ap #839-3424 Mauris Rd.', 'Malachi Sanders', 'F', 597, '0565425717', 'tellus@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1935, '886-9121 Augue Rd.', 'Marcia Mcknight', 'M', 648, '0542726797', 'mattis.semper@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, '4755 Curabitur Rd.', 'Ariana Macias', 'F', 131, '0504276541', 'mi.eleifend@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1918, '766-2061 Quam Street', 'Doris Martinez', 'F', 104, '0590863510', 'phasellus.libero@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1933, '274-2912 Morbi Rd.', 'Darryl Lewis', 'F', 377, '0583347324', 'ipsum@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, '897-649 In Rd.', 'Finn Henson', 'M', 134, '0532156133', 'eget@icloud.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2003, '161-1546 Mauris Rd.', 'Raven Shannon', 'F', 846, '0528119994', 'pellentesque.tincidunt@google.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1992, '482-163 Gravida Road', 'Lewis Mcclure', 'F', 584, '0544183372', 'et.rutrum@protonmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, 'P.O. Box 281, 7540 Fringilla St.', 'Madison Lott', 'M', 553, '0514296380', 'nec.tellus@outlook.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2015, '785-9518 Ipsum. Rd.', 'Maia Christensen', 'M', 897, '0537300363', 'nec.euismod@aol.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1957, 'P.O. Box 392, 213 Imperdiet Avenue', 'Regina Puckett', 'F', 890, '0585168343', 'ante@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, '367-2749 Suspendisse Ave', 'Daniel Hunt', 'M', 718, '0581680813', 'sem.nulla.interdum@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1985, 'P.O. Box 872, 3679 Augue. Avenue', 'Abraham Barlow', 'F', 162, '0538460423', 'aliquet.lobortis@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2001, 'Ap #358-8695 Tellus. Road', 'Connor Gardner', 'M', 314, '0526443117', 'facilisis.facilisis@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2022, '570-5673 Pede Ave', 'Ferris Frazier', 'M', 609, '0555021722', 'bibendum.ullamcorper@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2005, '3977 Ultricies Rd.', 'Elvis Levy', 'F', 204, '0582961986', 'consectetuer.rhoncus@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1998, 'Ap #430-5686 Luctus Av.', 'Wade Moody', 'M', 633, '0595886432', 'vestibulum@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '445-2329 Mauris Street', 'Armando Patterson', 'F', 207, '0511530072', 'nullam.velit.dui@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, 'Ap #449-9425 Cursus Rd.', 'Summer George', 'F', 453, '0590947426', 'suspendisse.commodo@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1945, '112-7838 Amet, Rd.', 'Kylie Rogers', 'F', 659, '0565830555', 'morbi.quis@outlook.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1973, '593-1560 Enim Av.', 'Athena Strong', 'M', 827, '0557706314', 'vestibulum@hotmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1983, 'Ap #233-3372 Nibh St.', 'Pearl Warner', 'M', 309, '0546323805', 'in.faucibus@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1918, '970-3570 Mi Rd.', 'Emi Figueroa', 'F', 632, '0528318840', 'varius.et@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1989, '262-6106 Semper St.', 'Hu Mays', 'F', 820, '0517032784', 'eros.nec.tellus@outlook.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1995, '651-6496 A, Ave', 'Jesse Pacheco', 'M', 109, '0573657210', 'vitae.aliquam@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1933, '124-4192 Erat. Road', 'Illiana Suarez', 'M', 218, '0583861577', 'ultrices.sit@outlook.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1930, 'Ap #269-7390 Sed Ave', 'Lee Nguyen', 'M', 991, '0539184201', 'tempor@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1991, '4353 Nonummy Rd.', 'Amaya Watson', 'F', 412, '0572695437', 'non.dapibus@hotmail.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1972, 'Ap #477-887 Orci Avenue', 'Harriet Pickett', 'M', 923, '0575619318', 'duis.dignissim@aol.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2016, 'Ap #665-3778 Et Road', 'Cole Bernard', 'F', 152, '0575217512', 'senectus.et@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1977, '712-2897 Praesent Rd.', 'Allistair Sheppard', 'F', 669, '0514337512', 'gravida@protonmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2009, '510-8367 Molestie Ave', 'Alyssa Lindsay', 'M', 564, '0511207573', 'vel@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1919, 'Ap #706-589 Accumsan Rd.', 'Hamish Villarreal', 'M', 751, '0561625915', 'ultricies.ligula@outlook.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1928, '102 Enim Road', 'Tatum Greene', 'M', 930, '0581823827', 'tincidunt.aliquam.arcu@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1929, '201-5882 Eros. Road', 'Idona Mckenzie', 'F', 779, '0537280664', 'enim.nunc@icloud.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, 'Ap #133-5930 Hendrerit. Rd.', 'Isabella Hampton', 'M', 313, '0538009324', 'lacus.cras@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1958, '985-4788 Ante Road', 'Acton Santana', 'M', 262, '0578025532', 'cursus.in@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1925, '243-5841 Risus. St.', 'Anika Hopper', 'F', 349, '0525324565', 'neque@icloud.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1975, '597-2559 A, Street', 'Acton Christian', 'F', 762, '0577816023', 'semper@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2015, 'P.O. Box 729, 1228 Praesent Street', 'Alika Garcia', 'F', 926, '0569664023', 'etiam.laoreet@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2002, 'Ap #840-5414 Sem Rd.', 'Henry Manning', 'F', 130, '0513806701', 'in.consequat.enim@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2018, 'P.O. Box 157, 8989 Nisi Street', 'Sheila Cortez', 'M', 674, '0514843167', 'eget.ipsum@aol.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2017, 'Ap #203-2755 Parturient St.', 'Hyacinth Bass', 'F', 793, '0517681888', 'dapibus.id.blandit@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1934, '238-5108 Posuere, Rd.', 'Beau Bailey', 'M', 543, '0597486069', 'cursus.nunc.mauris@google.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1932, '987-3703 Natoque St.', 'Maile Mcleod', 'F', 356, '0598141537', 'erat.vitae.risus@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1953, 'Ap #565-9273 Duis Road', 'Illiana Mcfadden', 'F', 525, '0511842432', 'suscipit.nonummy.fusce@outlook.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1963, '951-6601 Arcu St.', 'Nero Maldonado', 'M', 753, '0539454077', 'donec.porttitor@google.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2018, 'P.O. Box 837, 7068 Pellentesque Road', 'Yoko Buck', 'F', 552, '0548747473', 'nec.enim@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1954, 'P.O. Box 490, 5580 Elit. Avenue', 'Kaitlin Forbes', 'M', 653, '0574104204', 'tempus.non.lacinia@outlook.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1956, 'Ap #626-1553 Eu, Road', 'Noelle Underwood', 'F', 879, '0581020780', 'neque.vitae@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2019, 'Ap #273-2683 Cubilia Av.', 'Blythe Stephenson', 'F', 698, '0561852315', 'magnis@aol.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1971, 'Ap #729-7353 Purus Rd.', 'Tanisha Wolfe', 'M', 542, '0532636663', 'integer@icloud.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1949, 'Ap #738-2791 Tincidunt. Av.', 'Tanek Bauer', 'M', 459, '0598363862', 'aliquam@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2002, '657-2634 Non, Avenue', 'Julie Barr', 'F', 593, '0531478074', 'etiam.vestibulum@aol.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2004, 'P.O. Box 494, 3451 Urna. St.', 'Walter Church', 'F', 198, '0533015127', 'ut.nisi.a@yahoo.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1917, '111-9077 Consectetuer, Av.', 'Cheryl Carpenter', 'M', 863, '0575556476', 'lacus@hotmail.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1977, 'Ap #802-2802 Vitae St.', 'Graiden Cooley', 'F', 213, '0525842721', 'eget.metus@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1982, '8867 Sociis Ave', 'Odette Lucas', 'F', 799, '0541176882', 'ut@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1937, 'Ap #491-6854 Sapien Rd.', 'Althea Randolph', 'M', 569, '0586357536', 'dolor.dolor@hotmail.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1984, '929-347 Non Av.', 'Leo Palmer', 'M', 785, '0568868364', 'vivamus@yahoo.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1974, '882-7608 Gravida St.', 'Emerald Reynolds', 'M', 894, '0521851137', 'eros.turpis@hotmail.edu');
commit;
prompt 300 records committed...
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2008, 'P.O. Box 879, 5525 Duis Avenue', 'Sydnee Clay', 'F', 481, '0562543366', 'adipiscing.elit@aol.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1922, '673-6942 Sed Av.', 'Isadora Cortez', 'M', 181, '0595953493', 'et.commodo@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1984, '288-7365 Etiam Avenue', 'Ronan Moss', 'F', 504, '0516634785', 'lectus.a@google.org');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1980, '123 Main St', 'Alice Johnson', 'F', 20001, '023456789', 'alice@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1990, '456 Oak Ave', 'Bob Smith', 'M', 20002, '087654321', 'bob@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1985, '789 Elm St', 'Charlie Davis', 'M', 20003, '056789012', 'charlie@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1995, '321 Pine Rd', 'Danielle Wilson', 'F', 20004, '089012345', 'danielle@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1988, '654 Maple Ln', 'Evan Thompson', 'M', 20005, '045678901', 'evan@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1992, '987 Cedar Blvd', 'Fiona Anderson', 'F', 20006, '078901234', 'fiona@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1982, '246 Oak Ct', 'George Taylor', 'M', 20007, '001234567', 'george@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1998, '579 Elm Way', 'Hannah Brown', 'F', 20008, '034567890', 'hannah@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1991, '813 Pine Ave', 'Ian Garcia', 'M', 20009, '067890123', 'ian@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1987, '159 Maple St', 'Jill Roberts', 'F', 20010, '090123456', 'jill@email.com');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1987, '5429 Arcu. Street', 'Louis Harding', 'M', 783, '0576085009', 'commodo@yahoo.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1986, 'P.O. Box 643, 736 Mauris Rd.', 'Bruce Walton', 'F', 601, '0584338727', 'diam.duis.mi@yahoo.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1916, 'Ap #852-970 Neque. Street', 'Flynn Jensen', 'F', 871, '0582426580', 'ligula.aliquam@aol.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1977, '725-2292 Mauris Ave', 'Noelle James', 'F', 410, '0563243318', 'et@yahoo.net');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2003, '564-2259 Cras Ave', 'Kathleen Santana', 'M', 373, '0551339756', 'neque.non.quam@protonmail.edu');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1996, 'Ap #265-7286 Sollicitudin St.', 'Macey Tucker', 'M', 168, '0544411142', 'malesuada.fames.ac@google.couk');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (1991, '369-2700 Consectetuer Av.', 'Zephr Beach', 'F', 371, '0588485333', 'egestas.a.dui@hotmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2011, 'P.O. Box 640, 8387 Pulvinar Street', 'Amanda Mcmahon', 'F', 946, '0512426537', 'morbi.tristique@protonmail.ca');
insert into PATIENT (cbirthyear, caddress, cname, cgender, cid, cmobile, cmail)
values (2020, '5806 Euismod Rd.', 'Wylie Mcclure', 'F', 362, '0544515855', 'mauris.integer.sem@google.edu');
commit;
prompt 322 records loaded
prompt Loading APPOINTMENT...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('08-03-2026', 'dd-mm-yyyy'), 52254, 38187, 230);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-03-2026', 'dd-mm-yyyy'), 59864, 76380, 150);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('25-03-2026', 'dd-mm-yyyy'), 38929, 10007, 910);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('31-03-2029', 'dd-mm-yyyy'), 84576, 68229, 971);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-03-2028', 'dd-mm-yyyy'), 83531, 88571, 816);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-06-2027', 'dd-mm-yyyy'), 84988, 39663, 119);
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
values (to_date('19-10-2027', 'dd-mm-yyyy'), 61651, 21996, 418);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('07-03-2026', 'dd-mm-yyyy'), 84117, 13794, 309);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('22-10-2026', 'dd-mm-yyyy'), 37869, 31845, 778);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-01-2024', 'dd-mm-yyyy'), 71125, 68062, 676);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('29-11-2027', 'dd-mm-yyyy'), 76411, 48188, 488);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('30-12-2026', 'dd-mm-yyyy'), 13121, 79374, 764);
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
values (to_date('29-08-2028', 'dd-mm-yyyy'), 91912, 39663, 660);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('09-12-2025', 'dd-mm-yyyy'), 13831, 26135, 995);
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
commit;
prompt 100 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('28-09-2025', 'dd-mm-yyyy'), 88626, 27379, 569);
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
values (to_date('27-11-2025', 'dd-mm-yyyy'), 82439, 79374, 324);
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
commit;
prompt 200 records committed...
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('20-05-2024', 'dd-mm-yyyy'), 79322, 52769, 307);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('21-11-2027', 'dd-mm-yyyy'), 41561, 10004, 832);
insert into APPOINTMENT (adate, appointmentid, sid, cid)
values (to_date('04-09-2025', 'dd-mm-yyyy'), 55791, 64185, 572);
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
commit;
prompt 300 records committed...
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
commit;
prompt 400 records committed...
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
prompt 406 records loaded
prompt Loading MATERIAL...
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
commit;
prompt 100 records committed...
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
commit;
prompt 200 records committed...
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
commit;
prompt 100 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7421, 79892, 1);
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
commit;
prompt 200 records committed...
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
commit;
prompt 300 records committed...
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
commit;
prompt 100 records committed...
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
commit;
prompt 200 records committed...
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
prompt Loading PAYMENT...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88186, 296, to_date('18-10-2025', 'dd-mm-yyyy'), 37869);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91237, 2193, to_date('18-06-2024', 'dd-mm-yyyy'), 35784);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77746, 2259, to_date('30-12-2029', 'dd-mm-yyyy'), 45388);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55778, 1132, to_date('04-01-2024', 'dd-mm-yyyy'), 43748);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85115, 834, to_date('13-09-2025', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (78463, 2034, to_date('11-11-2026', 'dd-mm-yyyy'), 44344);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40001, 100, to_date('01-05-2023', 'dd-mm-yyyy'), 30001);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40002, 151, to_date('02-05-2023', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40003, 75, to_date('03-05-2023', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40004, 200, to_date('04-05-2023', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40005, 126, to_date('05-05-2023', 'dd-mm-yyyy'), 30005);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40006, 176, to_date('06-05-2023', 'dd-mm-yyyy'), 30006);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64674, 2131, to_date('27-08-2025', 'dd-mm-yyyy'), 83564);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48632, 2042, to_date('13-04-2026', 'dd-mm-yyyy'), 34432);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77195, 586, to_date('06-07-2025', 'dd-mm-yyyy'), 66153);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18447, 1631, to_date('05-01-2028', 'dd-mm-yyyy'), 32826);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99119, 1817, to_date('31-08-2029', 'dd-mm-yyyy'), 85315);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45981, 798, to_date('06-09-2024', 'dd-mm-yyyy'), 54111);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72412, 556, to_date('10-11-2026', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69791, 750, to_date('26-03-2028', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75485, 1853, to_date('04-02-2027', 'dd-mm-yyyy'), 65252);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41888, 1970, to_date('18-05-2029', 'dd-mm-yyyy'), 61135);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44216, 1442, to_date('12-06-2029', 'dd-mm-yyyy'), 15747);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93818, 571, to_date('01-08-2025', 'dd-mm-yyyy'), 14715);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14888, 985, to_date('08-04-2025', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58316, 221, to_date('18-04-2026', 'dd-mm-yyyy'), 57292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95454, 2226, to_date('04-07-2027', 'dd-mm-yyyy'), 76832);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49713, 174, to_date('12-06-2025', 'dd-mm-yyyy'), 49699);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69477, 1070, to_date('22-01-2024', 'dd-mm-yyyy'), 76744);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99222, 348, to_date('19-06-2028', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19487, 685, to_date('22-02-2027', 'dd-mm-yyyy'), 69154);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97299, 2180, to_date('25-06-2028', 'dd-mm-yyyy'), 59923);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35972, 1477, to_date('17-09-2025', 'dd-mm-yyyy'), 84937);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15939, 2217, to_date('13-03-2028', 'dd-mm-yyyy'), 37495);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45575, 1530, to_date('10-02-2027', 'dd-mm-yyyy'), 82256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95683, 1955, to_date('02-07-2027', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86862, 1752, to_date('09-09-2026', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82612, 1233, to_date('05-02-2029', 'dd-mm-yyyy'), 27367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79483, 1607, to_date('02-06-2025', 'dd-mm-yyyy'), 37638);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73147, 1020, to_date('24-02-2026', 'dd-mm-yyyy'), 84957);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48277, 1917, to_date('16-07-2029', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69529, 1507, to_date('15-11-2025', 'dd-mm-yyyy'), 78657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75556, 591, to_date('01-03-2026', 'dd-mm-yyyy'), 53274);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41167, 197, to_date('09-03-2025', 'dd-mm-yyyy'), 42978);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86562, 2475, to_date('29-11-2024', 'dd-mm-yyyy'), 84576);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25196, 1749, to_date('26-04-2028', 'dd-mm-yyyy'), 28734);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11126, 985, to_date('17-07-2027', 'dd-mm-yyyy'), 76832);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91169, 1962, to_date('13-06-2028', 'dd-mm-yyyy'), 47288);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85647, 2054, to_date('22-07-2027', 'dd-mm-yyyy'), 41656);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67266, 2323, to_date('27-04-2025', 'dd-mm-yyyy'), 99385);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15977, 1068, to_date('04-11-2027', 'dd-mm-yyyy'), 54365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11432, 1041, to_date('15-11-2024', 'dd-mm-yyyy'), 69358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26731, 2110, to_date('18-04-2028', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73836, 543, to_date('13-11-2026', 'dd-mm-yyyy'), 42917);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26844, 1947, to_date('11-06-2025', 'dd-mm-yyyy'), 38338);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82843, 863, to_date('30-06-2024', 'dd-mm-yyyy'), 39837);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47186, 2226, to_date('24-01-2024', 'dd-mm-yyyy'), 13927);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36662, 2430, to_date('13-01-2028', 'dd-mm-yyyy'), 26335);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55376, 507, to_date('27-10-2024', 'dd-mm-yyyy'), 78169);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59354, 1811, to_date('09-06-2028', 'dd-mm-yyyy'), 32922);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76395, 2462, to_date('20-11-2029', 'dd-mm-yyyy'), 86376);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66864, 1552, to_date('28-12-2026', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36549, 1159, to_date('21-07-2024', 'dd-mm-yyyy'), 54365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15176, 1218, to_date('30-11-2028', 'dd-mm-yyyy'), 73262);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71392, 1006, to_date('16-11-2024', 'dd-mm-yyyy'), 65183);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56651, 183, to_date('01-01-2025', 'dd-mm-yyyy'), 82256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69676, 1742, to_date('18-04-2029', 'dd-mm-yyyy'), 42733);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55664, 421, to_date('30-03-2027', 'dd-mm-yyyy'), 83316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58241, 1225, to_date('31-03-2024', 'dd-mm-yyyy'), 94296);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22885, 2249, to_date('07-06-2026', 'dd-mm-yyyy'), 23284);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29236, 573, to_date('21-10-2025', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47881, 2411, to_date('28-10-2027', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34332, 2259, to_date('19-04-2025', 'dd-mm-yyyy'), 37748);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98379, 1575, to_date('23-09-2026', 'dd-mm-yyyy'), 66449);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94973, 1146, to_date('08-12-2024', 'dd-mm-yyyy'), 76248);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98654, 2425, to_date('26-02-2026', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86571, 1380, to_date('07-06-2025', 'dd-mm-yyyy'), 55163);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99438, 693, to_date('08-06-2024', 'dd-mm-yyyy'), 24577);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68928, 380, to_date('19-08-2025', 'dd-mm-yyyy'), 30005);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24531, 2060, to_date('02-11-2026', 'dd-mm-yyyy'), 94727);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27548, 1033, to_date('20-02-2028', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38228, 1435, to_date('14-03-2027', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (78642, 376, to_date('06-12-2026', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11751, 2210, to_date('20-07-2025', 'dd-mm-yyyy'), 58911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26716, 1795, to_date('30-12-2024', 'dd-mm-yyyy'), 69358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88625, 235, to_date('30-09-2027', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77587, 1359, to_date('18-12-2027', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74463, 723, to_date('29-01-2027', 'dd-mm-yyyy'), 38457);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34526, 2367, to_date('11-09-2025', 'dd-mm-yyyy'), 45388);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43688, 2231, to_date('28-11-2027', 'dd-mm-yyyy'), 34639);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93494, 1682, to_date('16-12-2027', 'dd-mm-yyyy'), 67992);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58579, 1801, to_date('18-04-2027', 'dd-mm-yyyy'), 62424);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39613, 1927, to_date('02-01-2028', 'dd-mm-yyyy'), 59864);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73548, 2460, to_date('10-08-2026', 'dd-mm-yyyy'), 55427);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86512, 174, to_date('25-03-2026', 'dd-mm-yyyy'), 99859);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59685, 1897, to_date('01-03-2025', 'dd-mm-yyyy'), 47365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51173, 2484, to_date('14-10-2029', 'dd-mm-yyyy'), 36944);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51696, 2315, to_date('08-11-2025', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33213, 845, to_date('13-03-2028', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99184, 1465, to_date('02-10-2028', 'dd-mm-yyyy'), 45389);
commit;
prompt 100 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36149, 1820, to_date('01-01-2029', 'dd-mm-yyyy'), 69466);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28964, 2490, to_date('05-10-2024', 'dd-mm-yyyy'), 97122);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53997, 1129, to_date('14-05-2027', 'dd-mm-yyyy'), 13831);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64931, 263, to_date('20-03-2025', 'dd-mm-yyyy'), 71739);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95355, 546, to_date('16-09-2029', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16327, 631, to_date('12-07-2025', 'dd-mm-yyyy'), 92587);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33931, 1289, to_date('03-05-2029', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (54474, 2052, to_date('20-10-2028', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52417, 2104, to_date('20-01-2024', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (54221, 736, to_date('16-06-2027', 'dd-mm-yyyy'), 89358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61278, 2064, to_date('20-10-2027', 'dd-mm-yyyy'), 21632);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14942, 492, to_date('08-11-2026', 'dd-mm-yyyy'), 82439);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96427, 1006, to_date('10-04-2028', 'dd-mm-yyyy'), 19974);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73931, 1408, to_date('05-12-2026', 'dd-mm-yyyy'), 76744);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12257, 2322, to_date('20-07-2028', 'dd-mm-yyyy'), 76248);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35955, 299, to_date('22-10-2027', 'dd-mm-yyyy'), 84937);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33847, 1648, to_date('17-09-2028', 'dd-mm-yyyy'), 65183);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71758, 548, to_date('07-06-2029', 'dd-mm-yyyy'), 98965);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35795, 1407, to_date('20-06-2025', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39895, 791, to_date('12-03-2025', 'dd-mm-yyyy'), 65711);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39253, 1849, to_date('16-10-2029', 'dd-mm-yyyy'), 97354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57321, 2414, to_date('18-07-2025', 'dd-mm-yyyy'), 56368);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72612, 1491, to_date('11-07-2024', 'dd-mm-yyyy'), 29532);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87556, 586, to_date('21-08-2027', 'dd-mm-yyyy'), 37461);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68386, 2258, to_date('13-01-2024', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82321, 1161, to_date('08-12-2026', 'dd-mm-yyyy'), 21632);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82367, 522, to_date('18-10-2025', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81772, 2307, to_date('09-11-2028', 'dd-mm-yyyy'), 45659);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88378, 1649, to_date('23-01-2028', 'dd-mm-yyyy'), 51446);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51131, 2002, to_date('16-05-2024', 'dd-mm-yyyy'), 78759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87137, 1630, to_date('11-06-2029', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99937, 825, to_date('30-08-2025', 'dd-mm-yyyy'), 35487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52623, 1627, to_date('30-07-2028', 'dd-mm-yyyy'), 32614);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23724, 2398, to_date('17-09-2029', 'dd-mm-yyyy'), 41656);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93861, 1365, to_date('21-09-2029', 'dd-mm-yyyy'), 62424);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73531, 2070, to_date('17-12-2029', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83833, 1921, to_date('23-05-2024', 'dd-mm-yyyy'), 78657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35426, 1465, to_date('28-11-2027', 'dd-mm-yyyy'), 29134);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23686, 1461, to_date('26-12-2026', 'dd-mm-yyyy'), 29724);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61479, 1868, to_date('01-10-2026', 'dd-mm-yyyy'), 79234);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15146, 387, to_date('26-05-2026', 'dd-mm-yyyy'), 19487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23566, 2320, to_date('01-01-2025', 'dd-mm-yyyy'), 25893);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41649, 1775, to_date('04-09-2027', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (92476, 2402, to_date('15-02-2028', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53368, 2413, to_date('05-08-2027', 'dd-mm-yyyy'), 29118);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44659, 331, to_date('21-02-2024', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57689, 293, to_date('30-04-2026', 'dd-mm-yyyy'), 82615);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15211, 453, to_date('09-04-2025', 'dd-mm-yyyy'), 28113);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17981, 2108, to_date('21-01-2027', 'dd-mm-yyyy'), 28734);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93998, 1924, to_date('21-07-2025', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38443, 179, to_date('01-08-2029', 'dd-mm-yyyy'), 59864);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17126, 1509, to_date('20-06-2024', 'dd-mm-yyyy'), 11912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72979, 1112, to_date('20-12-2029', 'dd-mm-yyyy'), 35784);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95552, 1070, to_date('27-07-2026', 'dd-mm-yyyy'), 73524);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34944, 374, to_date('28-02-2026', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87256, 957, to_date('04-02-2029', 'dd-mm-yyyy'), 98965);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27291, 1543, to_date('09-08-2029', 'dd-mm-yyyy'), 72115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35984, 447, to_date('11-08-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96662, 294, to_date('18-11-2028', 'dd-mm-yyyy'), 52545);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52338, 538, to_date('13-08-2027', 'dd-mm-yyyy'), 41673);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35873, 1294, to_date('30-04-2025', 'dd-mm-yyyy'), 91912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98737, 2035, to_date('09-03-2026', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84214, 2187, to_date('29-08-2026', 'dd-mm-yyyy'), 82921);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66268, 1294, to_date('03-08-2029', 'dd-mm-yyyy'), 13184);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56655, 1087, to_date('07-08-2028', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67328, 2414, to_date('28-11-2028', 'dd-mm-yyyy'), 17117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12591, 1723, to_date('02-07-2026', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37244, 1221, to_date('04-09-2029', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42118, 2122, to_date('22-12-2026', 'dd-mm-yyyy'), 24984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15553, 2167, to_date('26-06-2027', 'dd-mm-yyyy'), 29966);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96733, 2104, to_date('05-07-2029', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61447, 2316, to_date('16-08-2025', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38453, 1372, to_date('06-02-2026', 'dd-mm-yyyy'), 36928);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56311, 1182, to_date('14-09-2028', 'dd-mm-yyyy'), 59923);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48396, 2306, to_date('15-11-2024', 'dd-mm-yyyy'), 14115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41818, 1178, to_date('10-04-2024', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41836, 993, to_date('19-09-2025', 'dd-mm-yyyy'), 38457);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72289, 997, to_date('16-06-2024', 'dd-mm-yyyy'), 43637);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57821, 1783, to_date('21-11-2025', 'dd-mm-yyyy'), 44782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84381, 760, to_date('27-07-2029', 'dd-mm-yyyy'), 34432);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93129, 1266, to_date('29-08-2025', 'dd-mm-yyyy'), 11395);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74421, 2453, to_date('26-09-2027', 'dd-mm-yyyy'), 35517);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22495, 469, to_date('07-12-2027', 'dd-mm-yyyy'), 97354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43997, 966, to_date('13-07-2024', 'dd-mm-yyyy'), 17911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16832, 597, to_date('10-11-2025', 'dd-mm-yyyy'), 19338);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15347, 991, to_date('08-08-2024', 'dd-mm-yyyy'), 52254);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99294, 1123, to_date('25-06-2026', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (92445, 1004, to_date('16-04-2025', 'dd-mm-yyyy'), 38161);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56318, 224, to_date('04-05-2026', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55583, 759, to_date('30-03-2028', 'dd-mm-yyyy'), 95217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69789, 2281, to_date('08-02-2029', 'dd-mm-yyyy'), 96463);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83491, 1732, to_date('24-01-2027', 'dd-mm-yyyy'), 96628);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23832, 1859, to_date('19-03-2027', 'dd-mm-yyyy'), 31554);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34752, 504, to_date('30-11-2024', 'dd-mm-yyyy'), 99859);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56617, 606, to_date('20-06-2025', 'dd-mm-yyyy'), 83776);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72752, 961, to_date('29-02-2028', 'dd-mm-yyyy'), 39953);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82199, 641, to_date('10-09-2028', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93433, 627, to_date('24-12-2027', 'dd-mm-yyyy'), 68537);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31273, 292, to_date('30-04-2029', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67157, 506, to_date('28-12-2029', 'dd-mm-yyyy'), 65252);
commit;
prompt 200 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11865, 1590, to_date('29-01-2025', 'dd-mm-yyyy'), 83316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71671, 829, to_date('20-11-2029', 'dd-mm-yyyy'), 62227);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15426, 1306, to_date('13-07-2024', 'dd-mm-yyyy'), 24577);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94532, 1484, to_date('18-01-2025', 'dd-mm-yyyy'), 44426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34582, 798, to_date('10-10-2028', 'dd-mm-yyyy'), 16719);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87447, 2466, to_date('08-03-2026', 'dd-mm-yyyy'), 96369);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27992, 1745, to_date('11-01-2025', 'dd-mm-yyyy'), 45389);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72294, 1962, to_date('06-12-2026', 'dd-mm-yyyy'), 86555);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19384, 1890, to_date('08-04-2028', 'dd-mm-yyyy'), 33315);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21373, 1494, to_date('05-07-2027', 'dd-mm-yyyy'), 42728);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63725, 181, to_date('08-11-2026', 'dd-mm-yyyy'), 34639);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22161, 1661, to_date('27-04-2028', 'dd-mm-yyyy'), 79322);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49118, 1914, to_date('23-02-2024', 'dd-mm-yyyy'), 77442);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89989, 223, to_date('06-08-2029', 'dd-mm-yyyy'), 35517);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36815, 366, to_date('21-02-2026', 'dd-mm-yyyy'), 34262);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85596, 1954, to_date('01-01-2025', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72713, 746, to_date('01-02-2029', 'dd-mm-yyyy'), 17979);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41461, 266, to_date('11-04-2025', 'dd-mm-yyyy'), 53332);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (32437, 1828, to_date('11-02-2025', 'dd-mm-yyyy'), 25675);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71187, 1167, to_date('07-11-2027', 'dd-mm-yyyy'), 16511);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98595, 1093, to_date('11-11-2025', 'dd-mm-yyyy'), 65772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12812, 187, to_date('21-06-2028', 'dd-mm-yyyy'), 58911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14394, 2222, to_date('05-02-2026', 'dd-mm-yyyy'), 73199);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38863, 1629, to_date('30-10-2026', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14928, 1434, to_date('05-05-2027', 'dd-mm-yyyy'), 24984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81879, 201, to_date('10-03-2026', 'dd-mm-yyyy'), 53751);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55313, 2031, to_date('01-07-2025', 'dd-mm-yyyy'), 94296);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47571, 268, to_date('02-01-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91841, 730, to_date('24-06-2028', 'dd-mm-yyyy'), 28354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72129, 2180, to_date('18-07-2026', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11551, 2215, to_date('29-10-2025', 'dd-mm-yyyy'), 66153);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27924, 368, to_date('11-07-2024', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34169, 766, to_date('02-05-2024', 'dd-mm-yyyy'), 54111);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82664, 240, to_date('26-09-2028', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21528, 1861, to_date('07-09-2029', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24515, 2165, to_date('25-08-2024', 'dd-mm-yyyy'), 69154);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73135, 1456, to_date('21-01-2028', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67723, 1911, to_date('23-01-2029', 'dd-mm-yyyy'), 83531);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19733, 534, to_date('06-10-2027', 'dd-mm-yyyy'), 17117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56416, 493, to_date('18-09-2029', 'dd-mm-yyyy'), 37512);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83428, 841, to_date('17-11-2028', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11296, 2264, to_date('30-11-2026', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15449, 628, to_date('07-11-2028', 'dd-mm-yyyy'), 13927);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42694, 1246, to_date('27-02-2027', 'dd-mm-yyyy'), 46912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81812, 2141, to_date('22-02-2028', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48569, 379, to_date('08-10-2024', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34568, 310, to_date('02-11-2029', 'dd-mm-yyyy'), 29532);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76795, 212, to_date('06-07-2025', 'dd-mm-yyyy'), 21575);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23558, 1999, to_date('11-04-2027', 'dd-mm-yyyy'), 93742);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43187, 1688, to_date('19-03-2028', 'dd-mm-yyyy'), 49699);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (62627, 579, to_date('09-09-2027', 'dd-mm-yyyy'), 92316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57366, 1888, to_date('25-05-2024', 'dd-mm-yyyy'), 82652);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94825, 2239, to_date('20-10-2027', 'dd-mm-yyyy'), 89616);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29916, 1522, to_date('30-11-2027', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93459, 558, to_date('24-06-2025', 'dd-mm-yyyy'), 59588);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48598, 668, to_date('16-07-2026', 'dd-mm-yyyy'), 73721);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49397, 460, to_date('02-05-2025', 'dd-mm-yyyy'), 38616);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29162, 1567, to_date('19-08-2029', 'dd-mm-yyyy'), 94727);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (13174, 2199, to_date('16-05-2026', 'dd-mm-yyyy'), 78281);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37582, 2005, to_date('27-09-2025', 'dd-mm-yyyy'), 61435);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35835, 1794, to_date('03-08-2027', 'dd-mm-yyyy'), 56515);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36256, 460, to_date('25-03-2024', 'dd-mm-yyyy'), 59487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75718, 879, to_date('16-08-2027', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56928, 1246, to_date('29-11-2024', 'dd-mm-yyyy'), 68537);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63784, 2442, to_date('12-05-2024', 'dd-mm-yyyy'), 96672);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82587, 843, to_date('30-08-2029', 'dd-mm-yyyy'), 48971);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45895, 1857, to_date('01-08-2026', 'dd-mm-yyyy'), 17642);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72553, 2448, to_date('19-01-2024', 'dd-mm-yyyy'), 87984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97359, 1437, to_date('23-07-2029', 'dd-mm-yyyy'), 96566);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37328, 2308, to_date('20-12-2024', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55543, 1465, to_date('12-09-2026', 'dd-mm-yyyy'), 57217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17421, 1915, to_date('03-04-2026', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21271, 640, to_date('02-03-2027', 'dd-mm-yyyy'), 18621);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94623, 1397, to_date('19-04-2028', 'dd-mm-yyyy'), 21759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48576, 1215, to_date('04-07-2025', 'dd-mm-yyyy'), 43552);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15756, 2306, to_date('13-09-2025', 'dd-mm-yyyy'), 96149);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68514, 2388, to_date('09-04-2025', 'dd-mm-yyyy'), 98428);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14935, 1009, to_date('16-11-2024', 'dd-mm-yyyy'), 44623);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (46339, 743, to_date('22-08-2026', 'dd-mm-yyyy'), 45835);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59368, 882, to_date('05-09-2025', 'dd-mm-yyyy'), 45686);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88362, 2445, to_date('19-01-2026', 'dd-mm-yyyy'), 37772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55971, 994, to_date('13-01-2027', 'dd-mm-yyyy'), 18621);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42529, 167, to_date('28-10-2027', 'dd-mm-yyyy'), 68462);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72747, 1256, to_date('24-07-2026', 'dd-mm-yyyy'), 37916);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17253, 1752, to_date('12-10-2025', 'dd-mm-yyyy'), 89217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58768, 503, to_date('12-03-2026', 'dd-mm-yyyy'), 79857);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66941, 2431, to_date('16-11-2026', 'dd-mm-yyyy'), 29966);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55553, 1643, to_date('24-10-2025', 'dd-mm-yyyy'), 39837);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52753, 1729, to_date('28-10-2026', 'dd-mm-yyyy'), 53336);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73486, 340, to_date('12-11-2028', 'dd-mm-yyyy'), 88626);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81876, 1551, to_date('18-09-2027', 'dd-mm-yyyy'), 19548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71678, 1912, to_date('30-12-2029', 'dd-mm-yyyy'), 88298);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26254, 1922, to_date('23-08-2025', 'dd-mm-yyyy'), 25165);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18724, 612, to_date('31-08-2026', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85591, 1428, to_date('04-05-2028', 'dd-mm-yyyy'), 59588);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88925, 1231, to_date('08-10-2024', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37785, 2356, to_date('15-10-2024', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11215, 727, to_date('15-04-2026', 'dd-mm-yyyy'), 35294);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42631, 1736, to_date('10-11-2026', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81431, 424, to_date('17-11-2028', 'dd-mm-yyyy'), 64612);
commit;
prompt 300 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49929, 1181, to_date('01-12-2026', 'dd-mm-yyyy'), 46594);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31191, 1747, to_date('13-07-2025', 'dd-mm-yyyy'), 17687);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96125, 277, to_date('19-06-2027', 'dd-mm-yyyy'), 66549);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86299, 1966, to_date('03-03-2028', 'dd-mm-yyyy'), 47365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67648, 1726, to_date('04-10-2028', 'dd-mm-yyyy'), 41847);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24517, 1684, to_date('16-04-2025', 'dd-mm-yyyy'), 31716);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12261, 2382, to_date('11-06-2028', 'dd-mm-yyyy'), 17698);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45529, 582, to_date('30-07-2029', 'dd-mm-yyyy'), 93739);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33779, 746, to_date('27-02-2027', 'dd-mm-yyyy'), 78169);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17359, 205, to_date('18-07-2029', 'dd-mm-yyyy'), 96657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14372, 2106, to_date('06-03-2028', 'dd-mm-yyyy'), 69782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66462, 2054, to_date('18-02-2025', 'dd-mm-yyyy'), 33732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14887, 174, to_date('13-01-2025', 'dd-mm-yyyy'), 97666);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17116, 978, to_date('15-05-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24297, 1034, to_date('22-02-2025', 'dd-mm-yyyy'), 30001);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98684, 2063, to_date('18-12-2027', 'dd-mm-yyyy'), 35294);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58463, 2424, to_date('03-06-2025', 'dd-mm-yyyy'), 37916);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41244, 2274, to_date('09-12-2028', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56933, 1229, to_date('30-11-2029', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11621, 292, to_date('12-04-2024', 'dd-mm-yyyy'), 39953);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83341, 979, to_date('05-06-2025', 'dd-mm-yyyy'), 39472);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83725, 1664, to_date('09-07-2029', 'dd-mm-yyyy'), 19487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12682, 529, to_date('24-02-2029', 'dd-mm-yyyy'), 54755);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21784, 429, to_date('26-05-2027', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25775, 1557, to_date('08-04-2028', 'dd-mm-yyyy'), 58994);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58669, 724, to_date('21-06-2027', 'dd-mm-yyyy'), 55791);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83912, 1951, to_date('10-08-2027', 'dd-mm-yyyy'), 11395);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85988, 763, to_date('22-09-2029', 'dd-mm-yyyy'), 31948);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72155, 950, to_date('29-03-2025', 'dd-mm-yyyy'), 65252);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12691, 333, to_date('27-03-2024', 'dd-mm-yyyy'), 32565);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51589, 1938, to_date('19-02-2024', 'dd-mm-yyyy'), 52192);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21991, 1234, to_date('05-10-2026', 'dd-mm-yyyy'), 66593);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69997, 1128, to_date('01-10-2025', 'dd-mm-yyyy'), 33634);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28934, 669, to_date('15-05-2024', 'dd-mm-yyyy'), 78212);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96535, 2111, to_date('06-09-2029', 'dd-mm-yyyy'), 16511);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34518, 1086, to_date('03-02-2029', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43574, 2189, to_date('14-04-2027', 'dd-mm-yyyy'), 28113);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39944, 1216, to_date('06-07-2029', 'dd-mm-yyyy'), 45349);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59397, 2219, to_date('14-04-2025', 'dd-mm-yyyy'), 71465);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12751, 1215, to_date('31-05-2026', 'dd-mm-yyyy'), 21367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28763, 2356, to_date('05-06-2027', 'dd-mm-yyyy'), 36499);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11598, 756, to_date('24-05-2026', 'dd-mm-yyyy'), 13184);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82461, 2488, to_date('29-01-2028', 'dd-mm-yyyy'), 66364);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67868, 1819, to_date('01-07-2029', 'dd-mm-yyyy'), 31448);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58291, 330, to_date('10-11-2029', 'dd-mm-yyyy'), 53947);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53546, 2079, to_date('03-11-2028', 'dd-mm-yyyy'), 95217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31645, 1269, to_date('13-04-2025', 'dd-mm-yyyy'), 22834);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48762, 2399, to_date('23-03-2028', 'dd-mm-yyyy'), 37772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89528, 2345, to_date('09-05-2026', 'dd-mm-yyyy'), 93442);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39217, 221, to_date('11-10-2029', 'dd-mm-yyyy'), 25798);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16279, 2096, to_date('21-03-2028', 'dd-mm-yyyy'), 41561);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57945, 1757, to_date('25-07-2027', 'dd-mm-yyyy'), 45686);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12923, 1276, to_date('20-03-2025', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36466, 1924, to_date('21-04-2024', 'dd-mm-yyyy'), 82652);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19894, 349, to_date('28-07-2029', 'dd-mm-yyyy'), 26335);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66359, 1139, to_date('01-02-2029', 'dd-mm-yyyy'), 59487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11896, 538, to_date('16-01-2025', 'dd-mm-yyyy'), 96149);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87783, 283, to_date('28-05-2027', 'dd-mm-yyyy'), 65711);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67639, 1015, to_date('05-05-2025', 'dd-mm-yyyy'), 37461);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27649, 2452, to_date('19-02-2029', 'dd-mm-yyyy'), 16719);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34635, 553, to_date('14-01-2024', 'dd-mm-yyyy'), 33634);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95349, 618, to_date('25-04-2029', 'dd-mm-yyyy'), 66527);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82458, 1721, to_date('07-09-2025', 'dd-mm-yyyy'), 14115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23892, 1866, to_date('11-02-2027', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76836, 357, to_date('24-12-2026', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84423, 2068, to_date('23-08-2028', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39842, 2470, to_date('12-05-2028', 'dd-mm-yyyy'), 26926);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (65777, 432, to_date('03-08-2028', 'dd-mm-yyyy'), 44484);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22839, 1168, to_date('29-08-2027', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47524, 2295, to_date('30-10-2027', 'dd-mm-yyyy'), 26256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84258, 607, to_date('14-09-2025', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36526, 754, to_date('19-01-2027', 'dd-mm-yyyy'), 37782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29569, 2330, to_date('16-12-2025', 'dd-mm-yyyy'), 12567);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76733, 617, to_date('26-05-2026', 'dd-mm-yyyy'), 13358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44265, 1003, to_date('22-02-2028', 'dd-mm-yyyy'), 69466);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43947, 2387, to_date('27-01-2025', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22698, 1314, to_date('09-11-2027', 'dd-mm-yyyy'), 23487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73144, 354, to_date('24-12-2026', 'dd-mm-yyyy'), 28593);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63494, 1955, to_date('14-03-2028', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55733, 1839, to_date('30-04-2028', 'dd-mm-yyyy'), 71253);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77665, 770, to_date('01-06-2027', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36312, 1778, to_date('15-04-2029', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96395, 2240, to_date('28-06-2024', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79165, 1970, to_date('01-08-2027', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97975, 1475, to_date('20-10-2024', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88982, 2112, to_date('20-02-2024', 'dd-mm-yyyy'), 55163);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18964, 1108, to_date('24-09-2027', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25397, 242, to_date('10-09-2028', 'dd-mm-yyyy'), 19974);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98338, 2333, to_date('12-04-2026', 'dd-mm-yyyy'), 21367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37382, 232, to_date('07-06-2029', 'dd-mm-yyyy'), 76595);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25392, 641, to_date('18-09-2024', 'dd-mm-yyyy'), 44833);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87386, 472, to_date('11-08-2028', 'dd-mm-yyyy'), 44344);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94834, 373, to_date('10-03-2026', 'dd-mm-yyyy'), 96369);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84339, 1368, to_date('03-03-2024', 'dd-mm-yyyy'), 37512);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66258, 1047, to_date('08-05-2026', 'dd-mm-yyyy'), 49749);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85648, 1077, to_date('20-05-2027', 'dd-mm-yyyy'), 84117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88714, 157, to_date('23-12-2024', 'dd-mm-yyyy'), 41673);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97995, 650, to_date('13-06-2026', 'dd-mm-yyyy'), 25556);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49627, 660, to_date('14-08-2025', 'dd-mm-yyyy'), 14715);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72982, 2125, to_date('24-02-2028', 'dd-mm-yyyy'), 85761);
commit;
prompt 400 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42742, 2019, to_date('11-03-2029', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74682, 1912, to_date('14-06-2027', 'dd-mm-yyyy'), 78759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64391, 641, to_date('13-08-2027', 'dd-mm-yyyy'), 30006);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45226, 639, to_date('21-02-2025', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49553, 2072, to_date('15-06-2027', 'dd-mm-yyyy'), 44578);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64731, 1239, to_date('17-06-2027', 'dd-mm-yyyy'), 39472);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34755, 281, to_date('06-07-2025', 'dd-mm-yyyy'), 29134);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19583, 2344, to_date('11-09-2027', 'dd-mm-yyyy'), 57292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41351, 1607, to_date('29-06-2026', 'dd-mm-yyyy'), 92587);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33596, 1070, to_date('05-11-2029', 'dd-mm-yyyy'), 53947);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19255, 1696, to_date('01-08-2024', 'dd-mm-yyyy'), 32614);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79675, 515, to_date('22-03-2024', 'dd-mm-yyyy'), 24676);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81344, 2393, to_date('16-02-2027', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89675, 795, to_date('29-01-2029', 'dd-mm-yyyy'), 57934);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74612, 430, to_date('14-03-2024', 'dd-mm-yyyy'), 69782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31115, 1834, to_date('29-03-2024', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (46391, 1974, to_date('09-04-2024', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18813, 1457, to_date('21-09-2028', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85672, 1906, to_date('25-10-2029', 'dd-mm-yyyy'), 13831);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34929, 530, to_date('12-05-2028', 'dd-mm-yyyy'), 66549);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11282, 722, to_date('07-12-2024', 'dd-mm-yyyy'), 28354);
commit;
prompt 421 records loaded
prompt Loading TPREFORMEDINA...
insert into TPREFORMEDINA (tid, appointmentid)
values (11153, 42728);
insert into TPREFORMEDINA (tid, appointmentid)
values (11355, 49699);
insert into TPREFORMEDINA (tid, appointmentid)
values (11536, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (12265, 71125);
insert into TPREFORMEDINA (tid, appointmentid)
values (12265, 85669);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 13713);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 37916);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 72942);
insert into TPREFORMEDINA (tid, appointmentid)
values (14355, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (14355, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (14543, 62759);
insert into TPREFORMEDINA (tid, appointmentid)
values (14543, 78281);
insert into TPREFORMEDINA (tid, appointmentid)
values (14552, 21759);
insert into TPREFORMEDINA (tid, appointmentid)
values (14552, 88645);
insert into TPREFORMEDINA (tid, appointmentid)
values (14675, 11416);
insert into TPREFORMEDINA (tid, appointmentid)
values (14675, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (14839, 36944);
insert into TPREFORMEDINA (tid, appointmentid)
values (15866, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (15973, 13944);
insert into TPREFORMEDINA (tid, appointmentid)
values (15973, 86627);
insert into TPREFORMEDINA (tid, appointmentid)
values (16211, 19137);
insert into TPREFORMEDINA (tid, appointmentid)
values (16211, 61435);
insert into TPREFORMEDINA (tid, appointmentid)
values (16365, 38729);
insert into TPREFORMEDINA (tid, appointmentid)
values (16754, 64388);
insert into TPREFORMEDINA (tid, appointmentid)
values (17119, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (17141, 86786);
insert into TPREFORMEDINA (tid, appointmentid)
values (18323, 65711);
insert into TPREFORMEDINA (tid, appointmentid)
values (18675, 83194);
insert into TPREFORMEDINA (tid, appointmentid)
values (18841, 49699);
insert into TPREFORMEDINA (tid, appointmentid)
values (19389, 84414);
insert into TPREFORMEDINA (tid, appointmentid)
values (19434, 53274);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 39772);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 45659);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 24399);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (22218, 74655);
insert into TPREFORMEDINA (tid, appointmentid)
values (22349, 59588);
insert into TPREFORMEDINA (tid, appointmentid)
values (22349, 97666);
insert into TPREFORMEDINA (tid, appointmentid)
values (22389, 84957);
insert into TPREFORMEDINA (tid, appointmentid)
values (23348, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (23348, 66449);
insert into TPREFORMEDINA (tid, appointmentid)
values (23661, 66527);
insert into TPREFORMEDINA (tid, appointmentid)
values (25155, 94296);
insert into TPREFORMEDINA (tid, appointmentid)
values (25522, 25893);
insert into TPREFORMEDINA (tid, appointmentid)
values (25522, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (26426, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (26551, 19776);
insert into TPREFORMEDINA (tid, appointmentid)
values (26691, 36345);
insert into TPREFORMEDINA (tid, appointmentid)
values (26847, 56328);
insert into TPREFORMEDINA (tid, appointmentid)
values (26847, 89616);
insert into TPREFORMEDINA (tid, appointmentid)
values (27147, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (27147, 39616);
insert into TPREFORMEDINA (tid, appointmentid)
values (27635, 87144);
insert into TPREFORMEDINA (tid, appointmentid)
values (29468, 73262);
insert into TPREFORMEDINA (tid, appointmentid)
values (31183, 68242);
insert into TPREFORMEDINA (tid, appointmentid)
values (31183, 76595);
insert into TPREFORMEDINA (tid, appointmentid)
values (31498, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (32426, 16511);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 26926);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 43748);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 53498);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 92587);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 66549);
insert into TPREFORMEDINA (tid, appointmentid)
values (33742, 27367);
insert into TPREFORMEDINA (tid, appointmentid)
values (34578, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (34644, 21759);
insert into TPREFORMEDINA (tid, appointmentid)
values (34718, 38161);
insert into TPREFORMEDINA (tid, appointmentid)
values (34794, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 17373);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 41673);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 59588);
insert into TPREFORMEDINA (tid, appointmentid)
values (35174, 82439);
insert into TPREFORMEDINA (tid, appointmentid)
values (35345, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 14235);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 26331);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 71125);
insert into TPREFORMEDINA (tid, appointmentid)
values (35732, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (35736, 22834);
insert into TPREFORMEDINA (tid, appointmentid)
values (35753, 14715);
insert into TPREFORMEDINA (tid, appointmentid)
values (35821, 58994);
insert into TPREFORMEDINA (tid, appointmentid)
values (35821, 93442);
insert into TPREFORMEDINA (tid, appointmentid)
values (36176, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (36526, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (36836, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (36999, 97354);
insert into TPREFORMEDINA (tid, appointmentid)
values (38646, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (38646, 98965);
insert into TPREFORMEDINA (tid, appointmentid)
values (39411, 17642);
insert into TPREFORMEDINA (tid, appointmentid)
values (39411, 55163);
insert into TPREFORMEDINA (tid, appointmentid)
values (39569, 13831);
insert into TPREFORMEDINA (tid, appointmentid)
values (41662, 96628);
insert into TPREFORMEDINA (tid, appointmentid)
values (41861, 35784);
insert into TPREFORMEDINA (tid, appointmentid)
values (42949, 69358);
insert into TPREFORMEDINA (tid, appointmentid)
values (43229, 98548);
insert into TPREFORMEDINA (tid, appointmentid)
values (43285, 76595);
commit;
prompt 100 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (43414, 41673);
insert into TPREFORMEDINA (tid, appointmentid)
values (43463, 53274);
insert into TPREFORMEDINA (tid, appointmentid)
values (43548, 39772);
insert into TPREFORMEDINA (tid, appointmentid)
values (43548, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (43562, 66364);
insert into TPREFORMEDINA (tid, appointmentid)
values (43562, 68789);
insert into TPREFORMEDINA (tid, appointmentid)
values (43564, 12777);
insert into TPREFORMEDINA (tid, appointmentid)
values (43564, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (43627, 44344);
insert into TPREFORMEDINA (tid, appointmentid)
values (44524, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (45115, 88645);
insert into TPREFORMEDINA (tid, appointmentid)
values (45358, 17373);
insert into TPREFORMEDINA (tid, appointmentid)
values (45394, 42733);
insert into TPREFORMEDINA (tid, appointmentid)
values (45421, 25675);
insert into TPREFORMEDINA (tid, appointmentid)
values (45421, 97935);
insert into TPREFORMEDINA (tid, appointmentid)
values (46212, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (46212, 17979);
insert into TPREFORMEDINA (tid, appointmentid)
values (46326, 39616);
insert into TPREFORMEDINA (tid, appointmentid)
values (46326, 91818);
insert into TPREFORMEDINA (tid, appointmentid)
values (46517, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (46755, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (46923, 36928);
insert into TPREFORMEDINA (tid, appointmentid)
values (46956, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (47955, 65772);
insert into TPREFORMEDINA (tid, appointmentid)
values (48123, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (48329, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (48329, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (48389, 65711);
insert into TPREFORMEDINA (tid, appointmentid)
values (48389, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (49126, 21367);
insert into TPREFORMEDINA (tid, appointmentid)
values (49126, 32565);
insert into TPREFORMEDINA (tid, appointmentid)
values (51563, 16437);
insert into TPREFORMEDINA (tid, appointmentid)
values (51682, 68462);
insert into TPREFORMEDINA (tid, appointmentid)
values (51917, 49174);
insert into TPREFORMEDINA (tid, appointmentid)
values (51917, 97579);
insert into TPREFORMEDINA (tid, appointmentid)
values (52125, 33634);
insert into TPREFORMEDINA (tid, appointmentid)
values (52748, 55427);
insert into TPREFORMEDINA (tid, appointmentid)
values (52941, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (52941, 97927);
insert into TPREFORMEDINA (tid, appointmentid)
values (53636, 76248);
insert into TPREFORMEDINA (tid, appointmentid)
values (53636, 96736);
insert into TPREFORMEDINA (tid, appointmentid)
values (54149, 34968);
insert into TPREFORMEDINA (tid, appointmentid)
values (54551, 19548);
insert into TPREFORMEDINA (tid, appointmentid)
values (54948, 14242);
insert into TPREFORMEDINA (tid, appointmentid)
values (54948, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (54973, 58911);
insert into TPREFORMEDINA (tid, appointmentid)
values (54973, 96463);
insert into TPREFORMEDINA (tid, appointmentid)
values (55128, 26256);
insert into TPREFORMEDINA (tid, appointmentid)
values (55383, 17979);
insert into TPREFORMEDINA (tid, appointmentid)
values (55383, 39257);
insert into TPREFORMEDINA (tid, appointmentid)
values (55476, 37223);
insert into TPREFORMEDINA (tid, appointmentid)
values (55476, 56368);
insert into TPREFORMEDINA (tid, appointmentid)
values (55534, 12567);
insert into TPREFORMEDINA (tid, appointmentid)
values (55534, 56388);
insert into TPREFORMEDINA (tid, appointmentid)
values (55856, 91912);
insert into TPREFORMEDINA (tid, appointmentid)
values (56151, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (56217, 17117);
insert into TPREFORMEDINA (tid, appointmentid)
values (56217, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (56679, 59487);
insert into TPREFORMEDINA (tid, appointmentid)
values (56844, 18689);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 24676);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 42733);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 69466);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 93742);
insert into TPREFORMEDINA (tid, appointmentid)
values (57256, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (57256, 69165);
insert into TPREFORMEDINA (tid, appointmentid)
values (57734, 82615);
insert into TPREFORMEDINA (tid, appointmentid)
values (57765, 47288);
insert into TPREFORMEDINA (tid, appointmentid)
values (58257, 49689);
insert into TPREFORMEDINA (tid, appointmentid)
values (58257, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (58261, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 25798);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 37495);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 65753);
insert into TPREFORMEDINA (tid, appointmentid)
values (58861, 96149);
insert into TPREFORMEDINA (tid, appointmentid)
values (58882, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (58882, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (59576, 14715);
insert into TPREFORMEDINA (tid, appointmentid)
values (59576, 24984);
insert into TPREFORMEDINA (tid, appointmentid)
values (59848, 55324);
insert into TPREFORMEDINA (tid, appointmentid)
values (59883, 95217);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 29966);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 57934);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 95217);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 65772);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 93442);
insert into TPREFORMEDINA (tid, appointmentid)
values (61571, 72625);
insert into TPREFORMEDINA (tid, appointmentid)
values (61725, 49174);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 43748);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 74732);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 79234);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 19338);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 31496);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 37916);
insert into TPREFORMEDINA (tid, appointmentid)
values (62262, 53751);
insert into TPREFORMEDINA (tid, appointmentid)
values (62262, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (62824, 63768);
insert into TPREFORMEDINA (tid, appointmentid)
values (63454, 33732);
insert into TPREFORMEDINA (tid, appointmentid)
values (63929, 59487);
commit;
prompt 200 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (64193, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (64193, 73262);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 42735);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 97927);
insert into TPREFORMEDINA (tid, appointmentid)
values (64259, 12777);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 34639);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 87984);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 89217);
insert into TPREFORMEDINA (tid, appointmentid)
values (64556, 65466);
insert into TPREFORMEDINA (tid, appointmentid)
values (64585, 48557);
insert into TPREFORMEDINA (tid, appointmentid)
values (64585, 58994);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 29532);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 69165);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 93739);
insert into TPREFORMEDINA (tid, appointmentid)
values (65894, 26335);
insert into TPREFORMEDINA (tid, appointmentid)
values (65959, 14235);
insert into TPREFORMEDINA (tid, appointmentid)
values (65959, 98371);
insert into TPREFORMEDINA (tid, appointmentid)
values (66121, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (66121, 43913);
insert into TPREFORMEDINA (tid, appointmentid)
values (66237, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (66237, 85761);
insert into TPREFORMEDINA (tid, appointmentid)
values (66786, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (66786, 62834);
insert into TPREFORMEDINA (tid, appointmentid)
values (66853, 69466);
insert into TPREFORMEDINA (tid, appointmentid)
values (67264, 24984);
insert into TPREFORMEDINA (tid, appointmentid)
values (67274, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (67319, 27341);
insert into TPREFORMEDINA (tid, appointmentid)
values (67922, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (68228, 62629);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 16511);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 35784);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 78212);
insert into TPREFORMEDINA (tid, appointmentid)
values (68449, 96672);
insert into TPREFORMEDINA (tid, appointmentid)
values (68541, 89358);
insert into TPREFORMEDINA (tid, appointmentid)
values (68541, 93739);
insert into TPREFORMEDINA (tid, appointmentid)
values (68654, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (68714, 29134);
insert into TPREFORMEDINA (tid, appointmentid)
values (69323, 78281);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 73199);
insert into TPREFORMEDINA (tid, appointmentid)
values (69888, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (69888, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (71249, 98428);
insert into TPREFORMEDINA (tid, appointmentid)
values (71465, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (71531, 96672);
insert into TPREFORMEDINA (tid, appointmentid)
values (72385, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 25675);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 25798);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 37748);
insert into TPREFORMEDINA (tid, appointmentid)
values (73447, 23487);
insert into TPREFORMEDINA (tid, appointmentid)
values (73772, 82439);
insert into TPREFORMEDINA (tid, appointmentid)
values (73797, 45949);
insert into TPREFORMEDINA (tid, appointmentid)
values (75129, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (75421, 71253);
insert into TPREFORMEDINA (tid, appointmentid)
values (75421, 99385);
insert into TPREFORMEDINA (tid, appointmentid)
values (75487, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (75494, 51446);
insert into TPREFORMEDINA (tid, appointmentid)
values (75819, 14242);
insert into TPREFORMEDINA (tid, appointmentid)
values (75819, 22834);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 65183);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 68462);
insert into TPREFORMEDINA (tid, appointmentid)
values (76278, 37772);
insert into TPREFORMEDINA (tid, appointmentid)
values (76324, 99822);
insert into TPREFORMEDINA (tid, appointmentid)
values (76614, 61435);
insert into TPREFORMEDINA (tid, appointmentid)
values (76614, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (76939, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 22473);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 41847);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 64612);
insert into TPREFORMEDINA (tid, appointmentid)
values (77591, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (78153, 21367);
insert into TPREFORMEDINA (tid, appointmentid)
values (78516, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 44484);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 78559);
insert into TPREFORMEDINA (tid, appointmentid)
values (79892, 57853);
insert into TPREFORMEDINA (tid, appointmentid)
values (79892, 72942);
insert into TPREFORMEDINA (tid, appointmentid)
values (81239, 33315);
insert into TPREFORMEDINA (tid, appointmentid)
values (81239, 78212);
insert into TPREFORMEDINA (tid, appointmentid)
values (81263, 18422);
insert into TPREFORMEDINA (tid, appointmentid)
values (81263, 64388);
insert into TPREFORMEDINA (tid, appointmentid)
values (81291, 17642);
insert into TPREFORMEDINA (tid, appointmentid)
values (81329, 83531);
insert into TPREFORMEDINA (tid, appointmentid)
values (81329, 83564);
insert into TPREFORMEDINA (tid, appointmentid)
values (81339, 31448);
insert into TPREFORMEDINA (tid, appointmentid)
values (81366, 97122);
insert into TPREFORMEDINA (tid, appointmentid)
values (81758, 92754);
insert into TPREFORMEDINA (tid, appointmentid)
values (82157, 19338);
insert into TPREFORMEDINA (tid, appointmentid)
values (82369, 73199);
insert into TPREFORMEDINA (tid, appointmentid)
values (82416, 30003);
insert into TPREFORMEDINA (tid, appointmentid)
values (83436, 36749);
insert into TPREFORMEDINA (tid, appointmentid)
values (83436, 65632);
insert into TPREFORMEDINA (tid, appointmentid)
values (83652, 31716);
insert into TPREFORMEDINA (tid, appointmentid)
values (83652, 99385);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 36944);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 44578);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 86786);
insert into TPREFORMEDINA (tid, appointmentid)
values (83824, 32565);
insert into TPREFORMEDINA (tid, appointmentid)
values (85577, 14235);
commit;
prompt 300 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (85577, 28354);
insert into TPREFORMEDINA (tid, appointmentid)
values (85642, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (85923, 59117);
insert into TPREFORMEDINA (tid, appointmentid)
values (85923, 98371);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 13121);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 39837);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 59487);
insert into TPREFORMEDINA (tid, appointmentid)
values (86759, 51688);
insert into TPREFORMEDINA (tid, appointmentid)
values (86775, 30006);
insert into TPREFORMEDINA (tid, appointmentid)
values (86933, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (87322, 29532);
insert into TPREFORMEDINA (tid, appointmentid)
values (87568, 34639);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 39953);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 54965);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 86376);
insert into TPREFORMEDINA (tid, appointmentid)
values (87874, 34432);
insert into TPREFORMEDINA (tid, appointmentid)
values (87874, 57853);
insert into TPREFORMEDINA (tid, appointmentid)
values (89584, 37638);
insert into TPREFORMEDINA (tid, appointmentid)
values (89584, 91912);
insert into TPREFORMEDINA (tid, appointmentid)
values (89622, 64847);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 37647);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 89616);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 96149);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 36165);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 76411);
insert into TPREFORMEDINA (tid, appointmentid)
values (89842, 83194);
insert into TPREFORMEDINA (tid, appointmentid)
values (89842, 94999);
insert into TPREFORMEDINA (tid, appointmentid)
values (89886, 51562);
insert into TPREFORMEDINA (tid, appointmentid)
values (89886, 66745);
insert into TPREFORMEDINA (tid, appointmentid)
values (91318, 66153);
insert into TPREFORMEDINA (tid, appointmentid)
values (91318, 78657);
insert into TPREFORMEDINA (tid, appointmentid)
values (91341, 64847);
insert into TPREFORMEDINA (tid, appointmentid)
values (91757, 18621);
insert into TPREFORMEDINA (tid, appointmentid)
values (91955, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 42728);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 76595);
insert into TPREFORMEDINA (tid, appointmentid)
values (92639, 92587);
insert into TPREFORMEDINA (tid, appointmentid)
values (92957, 37223);
insert into TPREFORMEDINA (tid, appointmentid)
values (92957, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 94296);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 96657);
insert into TPREFORMEDINA (tid, appointmentid)
values (93262, 44265);
insert into TPREFORMEDINA (tid, appointmentid)
values (93545, 30002);
insert into TPREFORMEDINA (tid, appointmentid)
values (93545, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (93974, 28354);
insert into TPREFORMEDINA (tid, appointmentid)
values (94324, 56328);
insert into TPREFORMEDINA (tid, appointmentid)
values (94324, 92499);
insert into TPREFORMEDINA (tid, appointmentid)
values (94371, 42978);
insert into TPREFORMEDINA (tid, appointmentid)
values (94421, 45349);
insert into TPREFORMEDINA (tid, appointmentid)
values (94421, 78169);
insert into TPREFORMEDINA (tid, appointmentid)
values (94471, 48827);
insert into TPREFORMEDINA (tid, appointmentid)
values (94471, 81399);
insert into TPREFORMEDINA (tid, appointmentid)
values (94556, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (94556, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (94664, 48827);
insert into TPREFORMEDINA (tid, appointmentid)
values (94664, 72115);
insert into TPREFORMEDINA (tid, appointmentid)
values (94996, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (95197, 55324);
insert into TPREFORMEDINA (tid, appointmentid)
values (95197, 96657);
insert into TPREFORMEDINA (tid, appointmentid)
values (95395, 55657);
insert into TPREFORMEDINA (tid, appointmentid)
values (95395, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 23487);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 32922);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 54399);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 46594);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (95993, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (96533, 54965);
insert into TPREFORMEDINA (tid, appointmentid)
values (96629, 78169);
insert into TPREFORMEDINA (tid, appointmentid)
values (96629, 99822);
insert into TPREFORMEDINA (tid, appointmentid)
values (97162, 28734);
insert into TPREFORMEDINA (tid, appointmentid)
values (97845, 51688);
insert into TPREFORMEDINA (tid, appointmentid)
values (97898, 31496);
commit;
prompt 378 records loaded
prompt Enabling foreign key constraints for DOCTOR...
alter table DOCTOR enable constraint SYS_C007299;
prompt Enabling foreign key constraints for APPOINTMENT...
alter table APPOINTMENT enable constraint SYS_C007313;
alter table APPOINTMENT enable constraint SYS_C007314;
prompt Enabling foreign key constraints for MUSEDINT...
alter table MUSEDINT enable constraint SYS_C007328;
alter table MUSEDINT enable constraint SYS_C007329;
prompt Enabling foreign key constraints for OFFICE...
alter table OFFICE enable constraint SYS_C007333;
prompt Enabling foreign key constraints for OMAKEA...
alter table OMAKEA enable constraint SYS_C007337;
alter table OMAKEA enable constraint SYS_C007338;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint SYS_C007344;
prompt Enabling foreign key constraints for TPREFORMEDINA...
alter table TPREFORMEDINA enable constraint SYS_C007348;
alter table TPREFORMEDINA enable constraint SYS_C007349;
prompt Enabling triggers for STAFF...
alter table STAFF enable all triggers;
prompt Enabling triggers for DOCTOR...
alter table DOCTOR enable all triggers;
prompt Enabling triggers for PATIENT...
alter table PATIENT enable all triggers;
prompt Enabling triggers for APPOINTMENT...
alter table APPOINTMENT enable all triggers;
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
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA enable all triggers;
set feedback on
set define on
prompt Done.

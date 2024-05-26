DROP TABLE IF EXISTS patient;

CREATE TABLE patient (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  'CNAME' varchar(255) default NULL,
  'CMOBILE' varchar(100) default NULL,
  'CMAIL' varchar(255) default NULL,
  'CBIRTHYEAR' varchar(255),
  'CGENDER' varchar(255) default NULL,
  'CID' mediumint default NULL,
  'CADDRESS' varchar(255) default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Dorian Le","0516846360","porttitor@protonmail.org","1929","F",238,"Ap #114-1154 Fermentum Rd."),
  ("Burke Gross","0534541398","aptent@icloud.couk","2019","F",888,"P.O. Box 618, 5164 Vitae Rd."),
  ("Ursa Hebert","0591300288","sem.pellentesque@hotmail.org","1939","M",828,"102-6291 Morbi St."),
  ("Kermit Mills","0540742563","purus.nullam@aol.com","1987","M",266,"P.O. Box 653, 9447 Integer Rd."),
  ("Dylan Alvarez","0537164552","nunc.ullamcorper@outlook.com","2004","F",632,"973-2617 Nam Rd."),
  ("Kimberley Jenkins","0577088029","a.magna@icloud.couk","1982","M",108,"5672 Massa. Av."),
  ("Laith Porter","0500358894","sapien.cursus@google.edu","1919","M",197,"9290 Magna Road"),
  ("Murphy Waters","0576437597","vulputate.nisi@icloud.couk","1984","F",794,"8151 Quisque Rd."),
  ("Jade Lancaster","0536140216","nulla.integer@outlook.org","1935","F",986,"635-6990 Dapibus St."),
  ("Eaton Kennedy","0543521648","sodales.elit@yahoo.ca","1929","F",344,"P.O. Box 604, 3827 Ad Road");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Oren Roberson","0574077510","ac.mattis.ornare@yahoo.ca","2015","F",647,"8272 Neque Rd."),
  ("Fulton Norton","0539260707","non.luctus@hotmail.ca","1980","M",111,"5329 Pellentesque Ave"),
  ("Jeanette Farmer","0542541391","eros.nam@aol.ca","1974","F",628,"Ap #227-4525 Feugiat Rd."),
  ("Cameron Stark","0582561293","et.magnis.dis@icloud.org","2008","F",883,"P.O. Box 272, 8928 Hendrerit. Rd."),
  ("Aurora Valentine","0512687887","dictum@icloud.com","1998","M",990,"632-2072 Urna Avenue"),
  ("Cherokee Bryant","0567067645","sit.amet@icloud.couk","1992","M",661,"P.O. Box 211, 824 Tortor. St."),
  ("Hedda Donaldson","0599592419","proin.velit.sed@outlook.com","1916","M",452,"Ap #749-5064 Nec Rd."),
  ("Guinevere Marshall","0545161371","molestie@outlook.net","2004","M",444,"P.O. Box 365, 6217 Magna. Avenue"),
  ("Venus Guerrero","0553831262","posuere.at@yahoo.net","1930","M",419,"4605 Vestibulum. Rd."),
  ("Baker Bishop","0543071152","elit@protonmail.com","1937","F",966,"Ap #686-6221 Rutrum Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Wing Romero","0564572615","donec.nibh@hotmail.couk","1927","F",601,"946-4863 Non, St."),
  ("Scarlett Wright","0556393777","donec.non@google.edu","1934","F",604,"245-3266 Sagittis St."),
  ("Abdul Lang","0551177210","ornare.lectus@yahoo.org","2008","M",967,"671 Velit. Street"),
  ("Len Freeman","0525517380","velit.justo@outlook.org","1959","F",942,"Ap #291-8046 Fringilla Rd."),
  ("Leandra Madden","0536435962","orci.phasellus.dapibus@icloud.edu","1985","M",752,"P.O. Box 615, 2954 Quam. Rd."),
  ("Dora Jennings","0505347525","nec@yahoo.ca","1917","M",860,"Ap #953-1471 Risus. St."),
  ("Virginia O'Neill","0524871462","nibh.quisque@icloud.org","2001","M",138,"258-5622 Magna Avenue"),
  ("Hope Swanson","0543875682","in.scelerisque@icloud.org","2013","F",200,"P.O. Box 950, 4016 Vel Ave"),
  ("Shellie Vega","0535859736","placerat@outlook.edu","2010","M",916,"Ap #484-8205 Diam St."),
  ("Basia Fischer","0541565814","feugiat.tellus@protonmail.net","1958","M",794,"9875 Penatibus Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Jonas Key","0501603486","viverra.donec@google.net","2002","M",479,"Ap #562-9939 Convallis Street"),
  ("Len Watts","0532141038","consectetuer.euismod.est@google.org","1962","M",978,"Ap #456-2963 Elit. St."),
  ("Samson Decker","0528356632","arcu@outlook.couk","1970","F",945,"Ap #926-1108 Euismod St."),
  ("Tate Holden","0518111493","odio.nam@icloud.ca","2021","M",532,"651-3556 Pede. Rd."),
  ("Marvin Ford","0598956717","libero@protonmail.edu","1985","M",585,"717-2011 Sem. Avenue"),
  ("Sybill Donovan","0576274706","tellus@hotmail.ca","1980","M",384,"6407 Imperdiet, Avenue"),
  ("Yeo Santos","0527467615","vitae.posuere.at@icloud.edu","1968","F",274,"Ap #516-5847 Nulla St."),
  ("Aline Cooley","0510445082","feugiat.tellus.lorem@google.couk","1951","F",295,"201-4945 Pede Avenue"),
  ("Justin Horn","0566620305","nisi.cum@google.ca","1963","F",769,"Ap #483-4833 Sagittis Av."),
  ("Camden Sawyer","0561696837","fusce.aliquam.enim@google.couk","1952","M",753,"916-7308 Fringilla Ave");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Quamar Parker","0561558678","interdum@outlook.edu","1924","F",492,"462-1832 Vehicula. Av."),
  ("Lucas Richards","0563378216","egestas.lacinia.sed@outlook.net","1920","F",708,"249-8251 Neque Rd."),
  ("Malcolm Woods","0564620483","accumsan@icloud.net","1948","F",561,"Ap #354-5901 Aliquam Rd."),
  ("Cullen Middleton","0560221861","accumsan.sed@hotmail.ca","1973","F",807,"455-6181 Vitae Rd."),
  ("Giselle Carey","0533628853","vel.nisl@hotmail.edu","1948","F",957,"Ap #855-4265 Etiam Ave"),
  ("Lucas Holloway","0534630494","turpis.vitae.purus@aol.ca","1950","M",254,"P.O. Box 302, 289 Blandit Rd."),
  ("Vincent Barton","0564457214","nascetur.ridiculus.mus@yahoo.edu","1984","M",655,"1806 Sed Avenue"),
  ("Baxter Salinas","0502868151","diam.duis@outlook.ca","1989","M",239,"470-2156 Non Rd."),
  ("Eleanor Ballard","0535236901","varius.orci@aol.org","1935","M",248,"723-5303 Eget Road"),
  ("Winter Wilkerson","0549675752","vel.turpis@outlook.ca","1930","F",691,"1068 Ultrices Ave");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Leslie Castillo","0570585820","velit.egestas@outlook.net","1923","M",394,"5357 Magna. Street"),
  ("Kelsey Cote","0563445103","nibh@hotmail.couk","1986","F",322,"841-1336 Dignissim Avenue"),
  ("Zachery Galloway","0564644767","fames.ac@outlook.edu","2016","F",670,"P.O. Box 366, 9135 Orci St."),
  ("Shelley Christian","0534847353","sed.hendrerit@hotmail.ca","1937","M",115,"8811 Integer Avenue"),
  ("Sheila Silva","0544338411","ultrices@hotmail.com","1991","F",621,"P.O. Box 240, 7429 Ligula. Road"),
  ("Juliet Bates","0569437977","eros@aol.couk","1977","F",273,"Ap #588-6661 Conubia Rd."),
  ("Ethan Payne","0594362761","taciti.sociosqu.ad@hotmail.net","2014","F",740,"229-7532 Sit Ave"),
  ("Talon Neal","0576007357","parturient.montes@google.ca","1981","F",526,"P.O. Box 890, 1139 Lobortis St."),
  ("Holly Sargent","0573141367","pulvinar.arcu@yahoo.couk","1976","M",585,"654-1320 Augue Rd."),
  ("Evan Medina","0517466963","tellus@hotmail.net","2020","F",772,"Ap #523-3837 Enim Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Scott Armstrong","0531075119","aliquet.odio.etiam@icloud.org","1945","F",279,"P.O. Box 666, 5707 Gravida. Ave"),
  ("Kay Weiss","0535449614","enim.consequat@icloud.org","1945","F",502,"334-9648 Nec, Rd."),
  ("Clio Daniels","0585107094","suspendisse.sagittis.nullam@google.org","1945","M",894,"600-103 At, Street"),
  ("Maisie Robinson","0521585771","pede.praesent@outlook.edu","1920","F",761,"451-7390 Morbi St."),
  ("Phillip Kennedy","0516318117","luctus@yahoo.org","1971","F",515,"2223 Amet, St."),
  ("Walter Medina","0555944889","mi.felis@icloud.edu","2022","F",341,"P.O. Box 784, 1568 Sed St."),
  ("Mona Rasmussen","0570378371","faucibus.morbi.vehicula@icloud.couk","2024","M",449,"Ap #181-5528 Hymenaeos. St."),
  ("Minerva Valentine","0546102481","amet.ultricies@protonmail.org","1994","M",367,"Ap #148-4693 Hendrerit Rd."),
  ("Imani Peters","0536107311","bibendum.fermentum@aol.org","2010","M",629,"759-623 Fringilla, Road"),
  ("Hyatt Wilson","0512648122","ut@yahoo.couk","2019","M",725,"Ap #500-6558 Justo St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Wang Johnson","0582545051","lorem.eu@yahoo.ca","1966","M",281,"Ap #935-2566 Feugiat. Av."),
  ("Katell Gibbs","0549730024","id.erat@hotmail.couk","2007","F",727,"4800 Eu Ave"),
  ("Oliver Calhoun","0571623483","pellentesque.a.facilisis@icloud.net","1934","M",824,"Ap #815-1956 Curabitur Road"),
  ("Wyatt Powers","0541626743","ullamcorper.magna@hotmail.org","2006","M",644,"P.O. Box 851, 6017 Nec Street"),
  ("Lisandra Lara","0581006252","non.justo.proin@aol.net","1972","M",449,"Ap #648-1941 Tempor Street"),
  ("Thane Solis","0503776041","aenean.sed.pede@icloud.couk","1931","F",469,"5218 Aliquam St."),
  ("Owen Mccullough","0540176843","sollicitudin.adipiscing@yahoo.net","2016","M",561,"584-7457 A Ave"),
  ("Kennedy Zimmerman","0593031335","tristique.aliquet@google.ca","2004","F",229,"P.O. Box 335, 1749 Magnis Av."),
  ("Blake Peck","0527386255","mauris.eu@aol.com","1983","M",119,"Ap #741-1081 Non St."),
  ("Rashad Baldwin","0593171317","semper.pretium@outlook.edu","1933","F",496,"Ap #809-3868 Molestie Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Murphy Schroeder","0559112118","curae.phasellus@icloud.net","2017","M",768,"Ap #855-8254 Vestibulum Street"),
  ("Wallace Weeks","0512011965","egestas.aliquam@yahoo.org","2001","F",927,"426-4146 Ut Road"),
  ("Dana Holder","0515721821","nam@google.com","1952","F",423,"Ap #556-1802 Etiam St."),
  ("Angela Wade","0575404731","eros.nec@protonmail.ca","2001","F",385,"Ap #812-9068 Eu Ave"),
  ("Leonard Pitts","0562849047","pulvinar@protonmail.org","1948","F",515,"462-4990 Neque Road"),
  ("Simone Villarreal","0584547667","nisi.sem.semper@icloud.com","2019","F",109,"7642 Sem, Ave"),
  ("Iona Mccormick","0581419405","dignissim.magna.a@yahoo.org","1928","M",357,"Ap #545-3138 Nullam Av."),
  ("Hakeem Delacruz","0551564486","parturient.montes.nascetur@aol.ca","1995","F",292,"523-2036 Praesent Street"),
  ("Phillip Salazar","0575783742","rutrum.urna@aol.org","2013","F",256,"4958 Sit St."),
  ("Omar Bridges","0523073354","tempus.eu@protonmail.edu","1987","F",599,"Ap #875-391 Quis Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Freya Love","0515116652","rutrum.justo@google.net","1979","F",690,"P.O. Box 646, 7207 Consectetuer Ave"),
  ("Ulla Delaney","0545474743","enim.consequat@hotmail.net","1965","F",655,"Ap #628-3136 Enim, Avenue"),
  ("Laura Bell","0536148652","mauris.eu.elit@outlook.ca","1974","M",788,"6486 Urna St."),
  ("Tamekah King","0548248016","ante.dictum@outlook.edu","1937","M",871,"Ap #982-4698 Nunc Av."),
  ("Marcia Phelps","0574156930","ut.sem@yahoo.net","1973","M",911,"Ap #574-1685 Tincidunt Street"),
  ("Carl Montoya","0585435690","donec.feugiat.metus@outlook.com","1944","M",280,"180-3425 Sodales St."),
  ("Mason Garrison","0561576624","ornare.tortor@icloud.org","2016","F",174,"278-5633 Turpis Ave"),
  ("Walter Fry","0564914177","risus.odio@protonmail.edu","2024","M",844,"Ap #415-2540 Sed Street"),
  ("Beatrice Matthews","0584863228","blandit.at.nisi@aol.couk","1929","F",901,"Ap #608-3697 Etiam Avenue"),
  ("Adena Rivers","0588548580","imperdiet@yahoo.org","2011","M",754,"Ap #123-7102 Sit St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Herman Sims","0573375545","non@icloud.org","1950","F",899,"1721 Donec St."),
  ("Rina Blanchard","0551372658","sapien.nunc@google.net","1979","F",313,"144-6778 Lectus Street"),
  ("Phelan Baird","0502138765","ante.dictum@outlook.net","1927","F",350,"Ap #788-3189 Dolor Rd."),
  ("Herman Hendricks","0567361791","mollis.dui@hotmail.edu","1968","F",534,"Ap #316-6296 Fermentum Street"),
  ("Tatiana Mcgowan","0563391975","auctor.quis@hotmail.com","1929","M",101,"922-9096 Lectus Ave"),
  ("Gemma Gamble","0528531351","interdum.sed@yahoo.couk","1950","M",196,"599-3810 Duis Road"),
  ("Jonah Rocha","0572703197","vivamus.nibh@yahoo.ca","1994","M",458,"Ap #984-4817 Commodo Avenue"),
  ("Steel Valentine","0566361723","pellentesque.ultricies@hotmail.org","1956","F",390,"Ap #727-4585 Lobortis Road"),
  ("Burke Fox","0576890365","neque@aol.net","1961","M",382,"927-2285 Dolor, Avenue"),
  ("Luke Delgado","0503658813","curabitur@outlook.edu","1974","F",549,"Ap #781-7823 Lorem St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Cody Hartman","0556198293","tincidunt.aliquam.arcu@yahoo.couk","1921","M",695,"Ap #543-5042 Dignissim. Av."),
  ("Megan Marshall","0553859098","rhoncus.nullam@outlook.org","1997","F",841,"513-140 Sit Road"),
  ("Knox Wade","0511505396","cum.sociis.natoque@icloud.org","1915","F",108,"746-5901 Fringilla Ave"),
  ("Imani Fox","0524571176","natoque.penatibus.et@icloud.ca","1917","M",428,"4822 Velit Ave"),
  ("Gray Ellison","0566209163","nulla.semper@outlook.org","1994","F",693,"594 Ipsum Avenue"),
  ("Ronan Zamora","0572098342","natoque.penatibus.et@outlook.net","2008","F",552,"P.O. Box 304, 3037 Pede Rd."),
  ("Kimberly Johns","0527571723","nullam.feugiat.placerat@aol.edu","1922","F",466,"906-9072 Vivamus Av."),
  ("Ivory Bennett","0524511752","nulla.facilisis@hotmail.com","2012","F",103,"8886 Tincidunt Rd."),
  ("Thaddeus Santana","0571827815","rutrum@outlook.net","1953","F",381,"P.O. Box 600, 9821 At Av."),
  ("Nehru Collins","0563258439","laoreet.libero.et@outlook.edu","2023","M",594,"236-4668 Arcu. Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Basia Holcomb","0534821613","at.pede@icloud.edu","1943","M",955,"P.O. Box 554, 2110 Dictum Ave"),
  ("Nell Evans","0535253646","tortor.integer.aliquam@google.org","2001","M",534,"839-351 Eu Avenue"),
  ("Macaulay Benton","0538514329","rutrum@protonmail.org","1949","F",858,"3827 Imperdiet, Avenue"),
  ("Leigh Ryan","0558342371","sodales.nisi@yahoo.couk","2020","F",262,"Ap #652-5283 Facilisis Street"),
  ("Melissa Levine","0578863246","vulputate.velit@icloud.couk","1922","M",370,"Ap #945-2865 Ante. Rd."),
  ("Edward Mcfarland","0579980322","orci.sem.eget@yahoo.couk","1964","F",239,"Ap #713-1882 Magna. St."),
  ("Paul Kent","0504812373","ut.tincidunt@icloud.couk","1926","M",958,"1290 Cursus St."),
  ("Angelica Cole","0591155897","turpis.egestas.aliquam@google.net","1962","M",625,"7311 Feugiat. Rd."),
  ("Nyssa Blankenship","0545884453","accumsan.neque.et@protonmail.edu","1944","M",764,"480-1666 A, Rd."),
  ("Warren George","0587641995","bibendum@protonmail.ca","1920","M",183,"P.O. Box 594, 563 Phasellus Road");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Edward Sawyer","0588534544","sodales.mauris@protonmail.net","1990","F",997,"P.O. Box 287, 6802 Rutrum. Rd."),
  ("Latifah Yang","0535194108","sed.neque@yahoo.ca","2011","M",442,"581-3057 Neque Av."),
  ("Levi Parker","0503124679","sociis.natoque.penatibus@protonmail.edu","1925","M",211,"4957 Libero St."),
  ("Palmer Rasmussen","0553786188","at@aol.ca","2005","F",410,"Ap #422-6966 Scelerisque, St."),
  ("Kimberley Britt","0521586865","et.commodo@outlook.com","2002","M",739,"P.O. Box 989, 2604 Purus, Road"),
  ("Mariam Mueller","0562114438","nunc.ullamcorper@aol.net","1952","F",836,"276-5815 Scelerisque, Ave"),
  ("Ariana Burgess","0587525490","ac@yahoo.net","1943","M",712,"Ap #295-6201 Tempor Av."),
  ("Ora Allen","0592527205","nunc.id.enim@yahoo.org","1944","F",901,"6192 Sit Av."),
  ("Chase Holland","0548832447","tellus.non.magna@aol.couk","1986","F",437,"Ap #645-714 Placerat St."),
  ("Kamal Johns","0595376443","donec.est@icloud.net","1940","F",460,"Ap #285-1214 Mollis Ave");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Brandon Farley","0534217496","suspendisse.sed@aol.couk","2015","F",185,"Ap #882-3280 Integer Road"),
  ("Nyssa Blake","0518324837","vitae.aliquam.eros@yahoo.net","1925","M",745,"P.O. Box 944, 6659 Ultrices Ave"),
  ("Baker Roman","0546162525","ac.nulla@icloud.net","2004","F",604,"Ap #454-7426 Lectus Avenue"),
  ("Jarrod Harmon","0575177980","eget.massa@yahoo.edu","1974","F",531,"8278 At Rd."),
  ("Axel Blankenship","0515168527","erat.eget@protonmail.couk","1946","F",963,"2285 Libero Rd."),
  ("Kevin Davis","0522926791","arcu.iaculis.enim@aol.couk","1938","M",389,"721-7328 Libero. Ave"),
  ("Joan Ball","0579552888","donec@google.ca","2019","M",571,"930-6544 Non, St."),
  ("Sybill Hess","0557522252","nunc@yahoo.edu","1951","F",615,"7331 Dapibus Rd."),
  ("Harrison Martinez","0529662572","fermentum.metus@outlook.ca","1980","F",636,"320-4421 Integer Av."),
  ("Karleigh Stanton","0538452745","pretium.et.rutrum@google.ca","1949","F",351,"Ap #933-6819 Per Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Deirdre Pacheco","0574384352","aliquam@hotmail.org","1973","M",531,"632-9470 Blandit Rd."),
  ("William Francis","0573755214","pede.blandit@outlook.edu","1954","F",138,"128-3621 Lectus Rd."),
  ("Vladimir Thomas","0525265867","mus.proin@protonmail.com","1961","F",237,"831-4172 Sapien St."),
  ("Ava Todd","0547345375","libero@icloud.net","1926","F",967,"Ap #114-8134 Sit St."),
  ("Amanda Gonzales","0552325173","vel.arcu.eu@google.couk","2024","M",379,"371-6060 Volutpat Road"),
  ("Keane Ayala","0583744133","fermentum.arcu@google.com","1996","M",628,"966-9773 Id Road"),
  ("Giacomo Fuller","0587889352","sodales.mauris.blandit@hotmail.net","1982","F",627,"Ap #339-2922 Nisi Ave"),
  ("Rudyard Noble","0543479461","neque@icloud.ca","1978","M",633,"Ap #109-7798 Imperdiet Road"),
  ("Ruth Wilkins","0562243617","gravida@google.edu","2020","M",305,"Ap #177-1597 Donec St."),
  ("Reece Irwin","0563586716","ante.lectus.convallis@icloud.couk","1942","F",527,"328-1221 Sed Av.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Zeus Blanchard","0547704412","urna.vivamus.molestie@icloud.ca","2019","F",804,"6152 Dictum Street"),
  ("Dominic Porter","0597552582","pede.nonummy@icloud.com","1969","F",563,"793-9227 Rutrum Street"),
  ("Lance Maxwell","0521482975","eu.nulla@outlook.edu","1994","F",791,"Ap #486-6707 Lacus. Av."),
  ("Kyra Nguyen","0577605582","fermentum.vel@yahoo.org","1940","F",424,"Ap #264-6585 Curabitur Ave"),
  ("Alec Medina","0570173081","libero.donec.consectetuer@outlook.com","1958","M",853,"Ap #398-8243 Vehicula. Road"),
  ("Karleigh Stanley","0555447352","suspendisse.sed.dolor@protonmail.com","1927","F",862,"6045 Sit St."),
  ("Megan Adams","0574034330","nullam.suscipit.est@hotmail.org","1927","F",960,"Ap #237-8532 Morbi St."),
  ("Stella Valdez","0587766721","dolor@hotmail.net","2022","F",524,"Ap #645-5060 Donec Rd."),
  ("Rhona Horton","0533536218","ac.mattis@google.couk","1936","F",354,"873-1422 Quis Street"),
  ("Maris Garrison","0535887886","eu.arcu.morbi@protonmail.couk","1994","M",349,"2543 Nibh. Ave");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Owen Everett","0545051187","diam.proin@icloud.ca","1916","F",533,"Ap #223-1544 Dolor St."),
  ("Buckminster Dorsey","0525788311","donec.porttitor@hotmail.ca","1973","M",828,"Ap #617-4375 Non Ave"),
  ("Orla Silva","0523186852","nibh.sit@aol.net","2023","F",393,"468-8208 Ac, Rd."),
  ("Boris Terrell","0597675220","parturient@google.couk","2021","M",796,"P.O. Box 880, 1690 Sagittis Road"),
  ("Deacon Riddle","0505832857","adipiscing.lacus@yahoo.org","1999","M",889,"Ap #909-2170 Eget, Ave"),
  ("Coby Hansen","0562467144","nulla@icloud.couk","1917","F",960,"Ap #809-168 Lorem St."),
  ("Caldwell Klein","0557175614","tincidunt.aliquam@icloud.net","1943","M",336,"213-6242 Ipsum Avenue"),
  ("MacKensie Cohen","0552278086","tempor.erat.neque@aol.org","1922","M",397,"209-2728 Libero. Ave"),
  ("Delilah Burch","0562051676","justo.praesent@yahoo.com","2018","M",274,"272-4559 In Rd."),
  ("Galvin Hess","0504185435","nisi.dictum@yahoo.ca","2010","M",606,"763-4071 A Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Justin Carver","0582167210","id.magna.et@hotmail.edu","1917","M",965,"P.O. Box 170, 4172 Amet Rd."),
  ("Caleb Hamilton","0528528506","convallis.in.cursus@outlook.com","1993","F",199,"7916 Augue Av."),
  ("Duncan Macias","0581638816","proin@icloud.edu","1989","F",254,"P.O. Box 896, 2239 Aliquam Ave"),
  ("Unity Sullivan","0565725666","augue.id@aol.ca","1984","F",251,"Ap #950-2204 Eu, Street"),
  ("Karina Castillo","0542524796","convallis.convallis.dolor@icloud.org","1948","F",578,"Ap #595-3694 Luctus Rd."),
  ("Noelle Baxter","0503383112","neque.vitae@hotmail.couk","1998","M",999,"P.O. Box 448, 3754 Elit Avenue"),
  ("Sean Sparks","0534719081","dolor.egestas.rhoncus@google.ca","1918","M",600,"P.O. Box 356, 9090 Luctus. Av."),
  ("Karen Mitchell","0553858479","a.odio@google.edu","1943","M",826,"P.O. Box 851, 2566 Eget, St."),
  ("Alea Charles","0549421842","et.ipsum@hotmail.couk","2009","F",273,"578-3979 Turpis. Rd."),
  ("Lee Randall","0516725374","tortor@icloud.couk","1954","M",459,"Ap #186-7862 Molestie Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Quemby Carson","0512438264","lacus.ut@hotmail.couk","1974","M",617,"Ap #165-2757 Nunc St."),
  ("Hadley Preston","0584742126","donec.tempus@yahoo.org","1922","F",921,"349-6625 Molestie St."),
  ("Kirby Dennis","0512387521","vestibulum.ante@hotmail.ca","1992","F",394,"735-9017 Arcu. St."),
  ("Winter Daniels","0577177256","magna.duis.dignissim@yahoo.edu","1929","M",972,"386-7094 Malesuada Av."),
  ("Shannon Booker","0556757854","neque.in@protonmail.edu","1955","M",854,"414-9017 Lectus St."),
  ("Jescie Shaw","0598205267","at.pretium@outlook.org","2021","F",615,"Ap #898-6897 Neque. St."),
  ("Caleb Graves","0556979721","non.sollicitudin@hotmail.edu","1933","F",864,"2877 Aliquet Avenue"),
  ("Suki Mclean","0568504265","neque.et@icloud.com","1936","F",104,"268-7813 Mi Avenue"),
  ("Lesley Cunningham","0552498712","lacus.ut@yahoo.couk","1936","M",831,"Ap #575-9562 Eu, Ave"),
  ("Lani Wade","0504877431","quisque.ornare@protonmail.couk","2000","F",971,"Ap #703-8341 Aliquam Road");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Dennis Brewer","0538712815","neque@hotmail.net","1977","F",458,"2668 Ut, Road"),
  ("Kaseem Peters","0529810327","risus.donec.egestas@yahoo.net","1969","M",676,"P.O. Box 106, 5884 Eu Street"),
  ("Scarlet Lucas","0561198464","sed@google.ca","1995","M",995,"265-6239 Parturient Ave"),
  ("Lee Pruitt","0524528532","orci.phasellus@icloud.edu","2003","F",104,"Ap #839-4890 Venenatis Rd."),
  ("Xanthus Morrison","0524716718","donec.dignissim@hotmail.com","1987","M",873,"Ap #325-3692 Quis Street"),
  ("Alice Guerrero","0573832868","adipiscing@hotmail.edu","1923","F",639,"2196 Dictum St."),
  ("Zelda Byrd","0548612480","faucibus@hotmail.ca","1982","M",621,"Ap #626-9096 Arcu. Street"),
  ("Hayes Miranda","0535273634","purus.ac@protonmail.edu","1989","M",677,"2782 Aliquam Road"),
  ("Thor Mejia","0586503173","metus.vivamus@protonmail.org","2010","M",398,"P.O. Box 503, 8944 Dui. Ave"),
  ("Zachery Sanchez","0541161187","eget@outlook.net","1978","M",277,"299-1696 Vulputate St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Phyllis Tillman","0557767984","donec.sollicitudin.adipiscing@yahoo.org","1918","F",162,"P.O. Box 858, 6923 Aliquam Ave"),
  ("Dana Black","0553882161","turpis.nec@google.edu","1942","F",696,"163-2487 Scelerisque St."),
  ("Samantha Mccall","0527984144","mollis@protonmail.org","1955","F",187,"Ap #705-737 Nunc Av."),
  ("Dolan Webb","0586534419","nullam.enim.sed@google.couk","1964","M",499,"583-6213 Vitae Avenue"),
  ("Galena Blake","0522460722","ante.ipsum.primis@hotmail.edu","1916","F",114,"Ap #911-2353 Ligula Rd."),
  ("Jacqueline Harvey","0572319657","enim.curabitur@aol.org","2025","F",582,"Ap #796-3086 Dictum Road"),
  ("Chava Mclean","0537288393","sagittis.augue@yahoo.org","2015","F",197,"214-1674 Semper, St."),
  ("Talon Mcdonald","0526784059","sed@google.edu","2000","M",337,"308-4844 Posuere, Ave"),
  ("Orson Armstrong","0544727889","ullamcorper.duis@yahoo.edu","1967","F",240,"Ap #921-3919 Vel Road"),
  ("Eliana Acevedo","0591356189","mauris@outlook.edu","2016","F",672,"8183 Dis Av.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Skyler Francis","0502479251","diam.eu@icloud.edu","1946","F",616,"550-4055 Libero. St."),
  ("Keith Witt","0544098111","integer.vulputate@outlook.ca","1932","F",695,"979-917 Nunc Av."),
  ("Geraldine Holland","0535270323","nunc@aol.ca","1949","M",879,"Ap #426-1221 Dignissim Road"),
  ("Idona Brooks","0535531514","libero.dui.nec@icloud.org","1961","F",778,"1898 Sem Rd."),
  ("Jakeem Dudley","0543568546","erat.sed.nunc@icloud.edu","2019","F",464,"P.O. Box 872, 5740 Nec St."),
  ("Gail Hurst","0522047719","eu.sem.pellentesque@protonmail.com","1921","F",985,"Ap #415-3886 Tempor Ave"),
  ("Zachary Combs","0509572780","fermentum@icloud.org","1995","M",620,"2300 Nonummy St."),
  ("Linus Knox","0571113681","pellentesque.a@yahoo.net","1982","M",670,"1065 Mi Ave"),
  ("Caldwell O'Neill","0573212089","orci.quis@icloud.couk","1917","F",196,"Ap #595-7722 Aliquam St."),
  ("Germane Byrd","0556757296","venenatis.a@icloud.ca","1995","F",281,"Ap #104-4713 Sed Street");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Hu Wallace","0569352722","nulla.tempor.augue@yahoo.net","1967","M",626,"572-716 Sollicitudin Av."),
  ("Lucius Talley","0551975289","nisi.mauris@protonmail.ca","2019","F",595,"2407 Magnis St."),
  ("Kato Weeks","0522103135","nullam.nisl.maecenas@yahoo.ca","2020","F",436,"5766 Cras Av."),
  ("Davis Green","0587680154","at.libero@google.com","1959","M",205,"3854 Dui. Av."),
  ("Kevyn Walls","0515138311","augue.eu.tellus@hotmail.couk","1961","M",233,"Ap #188-4620 Felis St."),
  ("Katelyn Hooper","0535727373","penatibus@yahoo.ca","2010","M",463,"260-7181 Pede. Av."),
  ("Chaim Le","0535691287","tincidunt@google.ca","1952","F",511,"179 Neque. Rd."),
  ("Mary Beach","0585687530","consequat.purus@google.com","1947","F",910,"5500 Natoque Rd."),
  ("Damon Gilmore","0500128134","quis@aol.com","1978","M",101,"Ap #969-2761 Ridiculus Rd."),
  ("Regan Leach","0571263967","urna.ut.tincidunt@google.edu","1984","M",533,"1033 Orci Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Bert Tucker","0564258946","arcu.vestibulum.ante@google.com","1999","F",418,"Ap #549-9305 Aliquet Rd."),
  ("Kathleen Hoffman","0571819291","orci@icloud.ca","2004","M",482,"P.O. Box 365, 8612 Molestie. St."),
  ("Sean Ellis","0542643100","sed.auctor@google.com","1937","M",237,"365-1362 Molestie St."),
  ("Rigel Powell","0579507186","nec@yahoo.couk","1997","F",186,"260-4739 Felis, Ave"),
  ("Ashton Foley","0556787242","in@google.ca","1955","F",762,"556-822 Nulla. Rd."),
  ("Garrett Gould","0545617668","nec.orci@icloud.org","1958","M",664,"Ap #758-8363 Nam St."),
  ("Constance Burgess","0523816270","placerat.augue@hotmail.couk","1938","F",577,"Ap #468-2966 Faucibus Road"),
  ("Eugenia Navarro","0508336826","aliquet.proin.velit@hotmail.net","2006","M",387,"Ap #152-9053 Facilisis. Rd."),
  ("Aladdin Bonner","0562865954","enim.gravida@protonmail.ca","1967","F",340,"Ap #798-9589 Nec Street"),
  ("Abbot Hendricks","0567163554","feugiat.sed@google.edu","1916","F",589,"955-1666 Mauris St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Raja Mayo","0540761570","scelerisque@icloud.org","2004","F",764,"P.O. Box 221, 5185 Eget Av."),
  ("Clarke Browning","0540068656","tincidunt.congue@google.net","1948","M",148,"6130 Sagittis Rd."),
  ("Rashad Bush","0563624281","velit.in@aol.ca","1948","F",815,"Ap #692-1256 Aenean Av."),
  ("Ignacia Rojas","0540385732","cras@aol.ca","2001","M",320,"878-9020 Nec Rd."),
  ("Stuart Morse","0563683892","rhoncus@hotmail.com","1937","F",920,"350-6625 Fringilla St."),
  ("Walker Reeves","0552863285","semper.auctor@google.couk","1995","M",683,"Ap #177-8105 Nascetur Rd."),
  ("Nelle Manning","0547544418","lobortis@icloud.edu","1922","F",465,"325-1111 Ut, Street"),
  ("Jael Briggs","0570789674","lectus@aol.couk","2020","F",358,"207 Parturient Road"),
  ("Patrick Wolfe","0559353143","pede.nunc@hotmail.com","2006","M",538,"406-4202 Fames Street"),
  ("Galena Cochran","0554845510","ipsum.curabitur@hotmail.ca","1986","M",750,"Ap #925-816 Lectus St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Ivan Kline","0597022449","quisque.varius@google.couk","1958","F",357,"P.O. Box 896, 1933 Magna. Avenue"),
  ("Katelyn Cabrera","0523021773","fermentum.arcu@icloud.ca","1978","F",311,"357-8541 Elit. Rd."),
  ("Pearl Finch","0555701561","scelerisque.lorem@hotmail.com","2008","M",885,"Ap #901-9968 Ac Road"),
  ("Karleigh Olson","0531546141","tincidunt@outlook.org","1932","F",569,"Ap #908-3881 Tincidunt, Rd."),
  ("Tobias Bird","0526562157","pellentesque@icloud.net","2009","M",443,"868-3154 Lobortis Street"),
  ("Alma Peck","0552362852","rutrum.magna@google.ca","1956","M",429,"Ap #633-5234 Elit, Road"),
  ("Reed Battle","0544357610","in@google.couk","1968","F",538,"Ap #159-6905 Magna Av."),
  ("Holmes Madden","0547037643","nunc.mauris@yahoo.com","2023","M",603,"Ap #660-6844 Vel Rd."),
  ("Mary Hernandez","0584675551","lorem@protonmail.net","1997","F",455,"278-626 Sagittis. Rd."),
  ("Gregory Bernard","0559899294","curae.donec@google.edu","1915","M",552,"8819 Diam Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Emerald Ballard","0512312891","tincidunt.adipiscing@outlook.org","1997","F",772,"468-9356 Quisque Street"),
  ("Orson Solis","0569652932","morbi@yahoo.org","1944","M",955,"752-479 Id, Avenue"),
  ("Bradley Lawrence","0524194164","vitae.purus.gravida@icloud.com","1928","F",885,"538-920 Sed St."),
  ("Leo Roberson","0506423818","mollis.vitae@protonmail.org","1983","M",394,"363-4655 Tempus Ave"),
  ("Travis Lee","0536234843","molestie.arcu@google.org","1918","F",630,"961-3950 Aliquam Rd."),
  ("Maris Knowles","0514861375","erat.vivamus.nisi@hotmail.net","1954","F",184,"Ap #374-8371 At Avenue"),
  ("Lillian Rodriguez","0542394933","neque.vitae@icloud.net","1930","F",603,"1960 Nisl. Road"),
  ("Wesley Bowers","0515567552","tortor@yahoo.couk","1958","F",157,"763-1832 Justo. Road"),
  ("Jelani Benjamin","0552654966","odio@hotmail.couk","1981","M",183,"Ap #655-6545 Scelerisque St."),
  ("Alana Burt","0515948241","in.consectetuer@yahoo.couk","1929","F",399,"Ap #307-9725 Risus St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Karina Stewart","0578563283","vulputate@google.edu","1994","M",996,"Ap #649-7058 Penatibus Ave"),
  ("Joy Harrison","0540358475","ridiculus.mus@google.edu","1959","M",451,"471-717 Viverra. Street"),
  ("Zephr Horton","0582323955","est.mauris.eu@yahoo.couk","2011","M",415,"P.O. Box 357, 7729 Dolor Rd."),
  ("Sawyer Cobb","0552776243","nonummy.fusce@icloud.net","1993","M",667,"1212 Et, Avenue"),
  ("Janna Alston","0538330181","eu.neque@protonmail.couk","2010","M",721,"934-2897 Velit. Street"),
  ("Igor Walker","0517167889","vel.arcu@yahoo.ca","1970","F",106,"P.O. Box 540, 2053 Mauris Ave"),
  ("Nola Giles","0575968714","augue.sed@protonmail.ca","1975","M",805,"4411 Commodo St."),
  ("Constance Payne","0530668130","duis.dignissim@yahoo.edu","1976","F",785,"Ap #276-3662 Donec Avenue"),
  ("Robin Cruz","0579398185","posuere.enim.nisl@protonmail.org","1999","F",346,"P.O. Box 712, 1146 Ut Road"),
  ("Aiko Matthews","0548512562","fringilla.purus@aol.net","1998","F",384,"9966 Metus. St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Marny Williamson","0560374266","vivamus@protonmail.couk","1967","F",513,"Ap #591-6398 Ornare Street"),
  ("Nina Rasmussen","0557523527","mauris.erat@yahoo.com","1965","M",941,"554-8854 Ipsum Road"),
  ("Kirestin Talley","0580584106","donec.fringilla@icloud.edu","2024","F",624,"Ap #185-4624 Fermentum Av."),
  ("Kaseem Holloway","0556246779","quisque@outlook.net","1946","M",495,"809-7969 Pede Avenue"),
  ("Norman Williams","0522968525","lobortis@yahoo.edu","1915","F",151,"Ap #541-1051 Leo. Rd."),
  ("Jacob Jennings","0578974716","amet@aol.edu","1916","F",508,"582-615 Dolor Rd."),
  ("Reuben Cherry","0587804344","ante.iaculis@aol.ca","1976","F",475,"1470 Sed St."),
  ("Juliet Mckee","0546158493","aliquam.tincidunt@google.edu","1947","F",549,"844-6686 Velit. St."),
  ("Zena Ware","0535692924","vulputate.posuere.vulputate@icloud.edu","1951","M",773,"513-4033 Sapien. Rd."),
  ("Tate Fry","0583928968","a@hotmail.couk","1922","M",844,"7142 Faucibus St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Ocean Oneal","0555495435","ac.orci.ut@yahoo.ca","2021","F",885,"P.O. Box 905, 1492 Turpis Rd."),
  ("Faith Little","0513317485","massa.suspendisse@aol.couk","1989","F",420,"194-4385 Semper Road"),
  ("Idola Thomas","0593768631","fusce.aliquam@yahoo.net","1944","F",994,"2318 Rutrum Av."),
  ("Jordan Myers","0538310731","ridiculus.mus@yahoo.net","1928","M",210,"P.O. Box 906, 5754 Magna St."),
  ("Adria Sandoval","0596472456","mollis.phasellus.libero@icloud.couk","1976","F",889,"282-2065 Nulla Avenue"),
  ("Wayne Foster","0526013889","sit@aol.edu","1984","F",940,"Ap #562-6355 Placerat, Rd."),
  ("Cole Good","0507824338","maecenas.mi.felis@google.com","1936","M",966,"2282 Pretium Street"),
  ("Joy Hunt","0553017485","fusce@google.ca","2012","M",454,"Ap #611-5892 Pede Av."),
  ("Hashim Kirk","0548787492","sem.molestie.sodales@google.ca","1998","M",719,"679-442 Amet Road"),
  ("Autumn Gordon","0522457725","ante.ipsum@hotmail.org","2011","F",743,"2571 Sit Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Roary Suarez","0544941573","primis@hotmail.couk","2014","F",770,"271-545 Suspendisse Rd."),
  ("Zeph Steele","0571194621","sem.eget@outlook.org","1976","F",927,"512-7085 Adipiscing Ave"),
  ("Sheila Thompson","0577877622","non@aol.ca","2001","F",202,"P.O. Box 366, 6689 Vitae Av."),
  ("Henry Mcclain","0571964671","arcu@aol.couk","1916","F",514,"Ap #774-3458 Aliquam, Avenue"),
  ("Levi Harrell","0578051681","sagittis.semper@icloud.ca","1924","F",353,"P.O. Box 448, 686 Nonummy St."),
  ("Quinn Riggs","0528487431","proin.sed.turpis@aol.org","1998","F",397,"300-6544 Lectus Rd."),
  ("Alexa Riddle","0531884415","donec.egestas.aliquam@protonmail.org","1987","M",967,"Ap #841-5323 Torquent Road"),
  ("Cody Blevins","0512223993","lorem.lorem@google.net","1929","M",226,"966-6634 Iaculis Rd."),
  ("Craig Boyd","0525255495","sit@aol.ca","1971","F",936,"455-620 Non St."),
  ("Buffy Barnett","0569773144","ridiculus.mus.donec@yahoo.org","1966","M",143,"349-1105 Orci Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Belle Pierce","0582248828","accumsan.laoreet@google.net","1986","F",239,"Ap #703-8341 Sociis St."),
  ("Indira Fleming","0569674077","adipiscing.elit@yahoo.couk","1945","M",306,"3444 Risus. Road"),
  ("Duncan Brewer","0593569015","phasellus.at.augue@aol.com","1997","F",316,"P.O. Box 743, 7441 Curae Av."),
  ("Tashya Bond","0572962943","id@hotmail.org","2023","M",775,"117 Dictum Rd."),
  ("Derek Brown","0575351521","scelerisque.lorem@google.net","1941","M",463,"865-4405 Diam Road"),
  ("Jacob Davenport","0509484281","sem.vitae.aliquam@google.com","1973","F",420,"Ap #866-8269 Felis Av."),
  ("Phelan Douglas","0583476606","ac.turpis@aol.ca","1941","F",223,"348-920 Lacus. Rd."),
  ("Edward Hendricks","0502118346","netus.et.malesuada@yahoo.net","1941","M",128,"484-4080 Elit. Street"),
  ("Julian Moody","0585779653","eu.tellus@outlook.org","1976","F",941,"669-9927 Faucibus St."),
  ("Dexter Hernandez","0558092574","lobortis@icloud.couk","1978","M",515,"365-9210 Nec Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("George Riggs","0513497872","posuere.enim@icloud.com","1927","M",948,"637-9124 Pellentesque Av."),
  ("Stewart Salas","0578807986","a@outlook.org","1919","F",463,"920-6948 Luctus, St."),
  ("Tarik Woodward","0564008522","eu@aol.com","1954","M",454,"Ap #626-845 Leo. Street"),
  ("Brenden Robinson","0506677628","maecenas.ornare@outlook.org","2007","M",280,"Ap #678-193 In Av."),
  ("Trevor Hoffman","0580948069","non.sollicitudin@outlook.edu","1966","M",765,"357-8073 In Avenue"),
  ("Micah Tanner","0558266384","diam.lorem@outlook.org","1972","M",160,"P.O. Box 510, 2563 Cursus St."),
  ("Jeanette Manning","0582253561","nec@aol.com","1979","F",708,"155-282 Nonummy Ave"),
  ("Calvin Welch","0555245473","eget@hotmail.ca","1920","F",739,"Ap #417-1554 Nec, Avenue"),
  ("Kyra Solis","0563612435","neque@outlook.com","1922","M",109,"Ap #517-5866 Magna. Avenue"),
  ("Deirdre Miles","0588982661","sodales.elit@google.ca","1954","F",744,"Ap #534-4486 Placerat Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Jameson Graham","0550397015","sed.sem@protonmail.net","1941","F",624,"Ap #852-8164 Velit. Av."),
  ("Hillary Mcdowell","0533564662","purus.duis.elementum@outlook.couk","1967","F",891,"4649 Risus. Avenue"),
  ("Tanya Jordan","0589181461","vestibulum.lorem.sit@aol.com","1929","M",191,"Ap #195-2885 Mauris Road"),
  ("Brianna Huber","0591164961","fusce.mi.lorem@google.net","2014","F",664,"725-4335 Duis Avenue"),
  ("Fletcher Hughes","0526746485","donec.est@icloud.couk","2017","M",168,"Ap #284-1885 Scelerisque, Street"),
  ("Cullen Miles","0597674211","phasellus.in@protonmail.com","1986","M",409,"5196 Justo St."),
  ("Lars Meyer","0520521621","arcu.iaculis@icloud.edu","1972","F",690,"834-1532 Quam. Rd."),
  ("Aristotle Vega","0563758243","lorem.semper.auctor@hotmail.com","2023","M",254,"Ap #101-7154 Curae Avenue"),
  ("Gareth Ashley","0524753607","nulla@icloud.couk","1942","M",400,"9769 In Rd."),
  ("Fuller Horn","0556805434","risus@icloud.ca","1926","F",639,"Ap #665-3351 Dui Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Brody Bruce","0565216650","tellus.phasellus.elit@protonmail.com","1948","F",869,"Ap #460-1683 Ac Road"),
  ("Kaitlin Curry","0572607868","lacus@protonmail.net","1979","M",366,"Ap #498-7781 Pede, Avenue"),
  ("Yoshi Hancock","0568488628","lectus@yahoo.couk","1947","M",201,"894-476 Lacinia Av."),
  ("Zena Chase","0545879631","amet@yahoo.net","1991","M",739,"Ap #853-6826 Parturient St."),
  ("Aiko Branch","0542393847","ut.aliquam@protonmail.net","2005","F",125,"140-6527 Cursus St."),
  ("Justin Wade","0565518105","urna@yahoo.edu","1948","F",629,"894-7095 Augue St."),
  ("McKenzie Sullivan","0531740533","faucibus.leo.in@protonmail.couk","1994","M",295,"Ap #912-2165 In Rd."),
  ("Colleen Duke","0551723059","taciti.sociosqu.ad@icloud.ca","2021","F",839,"Ap #681-8004 Ipsum Ave"),
  ("Lunea Hicks","0528287228","cras.eu.tellus@aol.net","1993","M",841,"455-8126 Suspendisse Rd."),
  ("Connor Faulkner","0575654428","hendrerit.donec@yahoo.net","2002","M",443,"P.O. Box 870, 1630 Eros Avenue");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Brittany Velasquez","0514630948","enim.condimentum.eget@google.org","1961","F",946,"479-6875 Vestibulum Street"),
  ("Fredericka Mcdonald","0579451725","mauris.eu@icloud.org","2010","M",945,"Ap #542-5253 Vel, Rd."),
  ("Kareem Cleveland","0554502827","vel.convallis@outlook.net","1987","M",460,"1886 Dui Street"),
  ("Judith Scott","0576385251","vitae.sodales@google.ca","1935","M",385,"Ap #141-262 Quis St."),
  ("Zelenia Sears","0512546237","nisi.cum.sociis@icloud.org","2002","F",103,"232-9203 Turpis. Ave"),
  ("Reece Keller","0511102717","sed.et.libero@icloud.net","1928","F",202,"2170 Nec, Avenue"),
  ("Lewis Reeves","0581968549","sem.magna.nec@aol.org","1990","M",107,"Ap #427-7023 Ante Ave"),
  ("Dolan Sanders","0585647313","libero.at@hotmail.couk","1951","M",785,"P.O. Box 423, 9145 Dictum Road"),
  ("Gail Ward","0511256742","ipsum.sodales@google.net","1918","M",413,"3779 Nec St."),
  ("Patience Mckee","0568877023","nunc.sollicitudin.commodo@outlook.org","2000","F",317,"460-8476 Scelerisque Rd.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Mechelle Sharpe","0544526647","sed.diam@hotmail.com","1973","F",166,"Ap #461-4919 Commodo Avenue"),
  ("Jerry Garrison","0533182335","sem@yahoo.net","1924","M",912,"P.O. Box 172, 3314 Sapien, Ave"),
  ("Brenna Weiss","0527629346","eleifend@google.couk","1949","F",168,"Ap #204-8245 A, St."),
  ("Quinn Malone","0562245225","dolor.quisque@protonmail.couk","1995","F",425,"8476 Suspendisse Avenue"),
  ("Nayda Sosa","0565625653","a.aliquet@yahoo.edu","1970","F",512,"P.O. Box 391, 5833 Aliquam Rd."),
  ("Blossom Santos","0577199423","lorem.ac@icloud.couk","2009","F",939,"P.O. Box 371, 1837 Cum Street"),
  ("James Gregory","0548201226","vehicula.risus.nulla@google.org","1928","F",791,"Ap #179-6737 Vulputate, Street"),
  ("Cedric Diaz","0546134828","nisl.arcu@hotmail.net","2006","M",557,"P.O. Box 756, 8054 Eu Road"),
  ("Zeph Lamb","0511212411","eu@outlook.couk","1915","F",434,"883-2990 Parturient Av."),
  ("Kay Beck","0570581836","malesuada.integer@protonmail.edu","1980","F",220,"P.O. Box 639, 2866 Consequat St.");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Palmer English","0516014134","rutrum.justo.praesent@icloud.couk","1927","F",294,"260-4646 Porttitor Ave"),
  ("Stella Maxwell","0512923642","phasellus.dolor@aol.edu","1935","F",461,"P.O. Box 888, 6904 Morbi Street"),
  ("Daquan Bird","0513222154","aliquam.enim@yahoo.couk","1971","M",348,"5412 Cursus Avenue"),
  ("Joel Phillips","0593221301","ipsum.curabitur@hotmail.couk","1923","F",425,"Ap #162-7873 Ipsum. St."),
  ("Carissa Medina","0534436813","sem.elit@protonmail.net","1951","F",921,"Ap #175-7422 Ipsum. Av."),
  ("Scott Landry","0525644722","ridiculus.mus.proin@yahoo.net","2015","F",901,"744-1793 Et St."),
  ("Carson Mcmillan","0561512345","consectetuer.cursus@protonmail.com","2023","F",259,"500-985 Commodo Road"),
  ("Kennan Cote","0504980707","adipiscing.fringilla.porttitor@icloud.org","1974","F",151,"4086 Nunc St."),
  ("Holmes Tyson","0510090537","risus@outlook.ca","1933","F",113,"299-4496 Lacus. Rd."),
  ("Joan Herman","0577372611","viverra.maecenas@yahoo.net","1938","M",839,"Ap #884-8726 Donec Ave");
INSERT INTO patient ('CNAME','CMOBILE','CMAIL','CBIRTHYEAR','CGENDER','CID','CADDRESS')
VALUES
  ("Audra Lopez","0542624833","tellus.lorem@aol.net","2012","M",410,"Ap #396-958 Tellus Avenue"),
  ("Renee Phillips","0522359136","cubilia@protonmail.edu","1928","M",515,"Ap #978-7305 Neque. St."),
  ("Gannon Buckner","0516263151","tempor.arcu@protonmail.net","1979","F",336,"6455 Imperdiet St."),
  ("Lev Atkinson","0559390055","sem.consequat@aol.ca","1965","M",875,"Ap #594-6342 Ipsum. Rd."),
  ("Quynn Ortiz","0571711687","aliquam@icloud.edu","1956","M",966,"Ap #111-4236 At, Av."),
  ("Serina Head","0575318547","mauris.suspendisse@protonmail.com","1943","F",929,"178-5114 Ligula. Av."),
  ("Bell Poole","0541840182","feugiat@outlook.edu","1990","F",204,"613-1100 Vivamus Av."),
  ("Aristotle Dale","0564134832","ligula.consectetuer@google.ca","2021","M",800,"8646 Rutrum Road"),
  ("Henry Wall","0524842086","varius.et@google.org","1989","M",706,"Ap #680-622 Justo Rd."),
  ("Clementine Macias","0578240681","enim.sed@hotmail.net","1999","M",397,"Ap #445-6970 Ullamcorper. Avenue");

DROP TABLE IF EXISTS `myTable`;

CREATE TABLE `myTable` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `SNAME` varchar(255) default NULL,
  `SMOBILE` varchar(100) default NULL,
  `SMAIL` varchar(255) default NULL,
  `SADDRESS` varchar(255) default NULL,
  `SID` mediumint default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Howard Koch","0563626472","howardkoch8313@google.org","529-8442 Turpis St.",18841),
  ("Britanni Conway","0552372888","britanniconway@gmail.edu","850-4102 Donec St.",16859),
  ("Pandora Villarreal","0527564315","pandoravillarreal@yahoo.net","Ap #888-9489 Convallis Street",65420),
  ("Carlos Mccullough","0513157619","carlosmccullough@icloud.couk","3054 Et St.",69095),
  ("Deacon Mathews","0533141788","deaconmathews@yahoo.edu","P.O. Box 191, 7256 Blandit. Av.",39692),
  ("Quentin Bradley","0536213519","quentinbradley@aol.net","Ap #591-3681 Eu, Av.",39406),
  ("Mary Spencer","0570083861","maryspencer6153@aol.edu","4712 Sit Street",70197),
  ("Amaya Slater","0531358854","amayaslater8552@gmail.edu","835-2049 Sed Rd.",18226),
  ("Shelly Hinton","0517152588","shellyhinton@yahoo.net","925-2426 Vitae Avenue",56756),
  ("Montana Baker","0567625748","montanabaker5432@yahoo.org","672-2325 Et Road",30049);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Ashton Barber","0564143422","ashtonbarber@aol.net","914-6898 Sagittis Street",54342),
  ("Claire Neal","0506215518","claireneal@gmail.edu","P.O. Box 208, 3903 Lectus. Av.",52040),
  ("Ronan Stokes","0532654551","ronanstokes@yahoo.org","P.O. Box 650, 2512 Aliquam St.",85269),
  ("Wynne Massey","0517531375","wynnemassey@icloud.net","574-7530 Orci St.",66046),
  ("Brendan Sanders","0539655828","brendansanders@yahoo.com","P.O. Box 153, 5420 Sapien St.",81903),
  ("Leroy Price","0529591127","leroyprice831@yahoo.couk","8401 Ut Road",94816),
  ("Zephania Foster","0521194151","zephaniafoster4046@yahoo.net","P.O. Box 256, 7303 Interdum. Rd.",10350),
  ("Uriah Willis","0548956072","uriahwillis5775@google.edu","238-8581 Posuere, St.",67365),
  ("Roth Kemp","0511446015","rothkemp@aol.net","P.O. Box 184, 9010 Dapibus St.",85491),
  ("Amber Rosario","0523755962","amberrosario9905@icloud.ca","Ap #916-4365 Erat Avenue",14728);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Bert Leach","0578220693","bertleach@gmail.couk","8610 In St.",38351),
  ("Tad Moody","0534079059","tadmoody@gmail.edu","Ap #524-4127 Donec St.",14874),
  ("Ezra Burgess","0565362791","ezraburgess@aol.com","415-3750 Nibh. St.",71524),
  ("Zahir Baird","0549871685","zahirbaird@icloud.edu","Ap #971-1341 Odio Street",83525),
  ("Forrest Larson","0577870947","forrestlarson6241@yahoo.ca","267-9530 Venenatis Avenue",52501),
  ("Damian Kemp","0557461359","damiankemp@aol.edu","248-847 Imperdiet, Avenue",52453),
  ("Laurel Thornton","0556332552","laurelthornton@icloud.couk","Ap #632-6781 Duis Ave",13749),
  ("Stone Brock","0541490828","stonebrock6915@yahoo.couk","P.O. Box 164, 7666 Fusce Ave",15632),
  ("Elvis Petersen","0595151312","elvispetersen@yahoo.couk","487-2768 In Road",44175),
  ("Rogan Mendoza","0547860460","roganmendoza4041@gmail.net","Ap #801-8538 Iaculis Avenue",42979);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Phoebe Strong","0586911136","phoebestrong@icloud.net","Ap #125-2122 Est Ave",46760),
  ("Rina Matthews","0511205387","rinamatthews@aol.com","9330 Aliquam Road",63413),
  ("Austin Maynard","0510227107","austinmaynard3754@google.couk","Ap #806-5874 Purus. Av.",33735),
  ("Brendan Armstrong","0532653463","brendanarmstrong@gmail.net","1801 Fusce Road",31754),
  ("Hilel Gilmore","0556468271","hilelgilmore@google.net","9424 Imperdiet Av.",88103),
  ("Kylie Brewer","0577218101","kyliebrewer@icloud.edu","Ap #943-3415 Risus, St.",85300),
  ("Callum Castro","0521642100","callumcastro5007@gmail.org","Ap #285-4436 Nisl. Av.",31268),
  ("Luke Osborne","0582044488","lukeosborne@icloud.org","Ap #104-8859 Suspendisse Avenue",35289),
  ("Dane Carr","0551152186","danecarr4577@yahoo.ca","525-9387 Arcu Av.",48244),
  ("Hammett Turner","0591863277","hammettturner@aol.ca","209-7909 Malesuada Road",83721);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Deirdre Parsons","0556114569","deirdreparsons@gmail.com","701-9465 Sed Avenue",94753),
  ("Shelley Stafford","0521072214","shelleystafford2079@aol.org","P.O. Box 144, 2378 Rhoncus St.",92395),
  ("Rhonda Sandoval","0542264434","rhondasandoval@yahoo.org","400-7553 Massa Av.",23935),
  ("Hall Cabrera","0568833858","hallcabrera6689@gmail.net","788-146 Nulla Ave",17738),
  ("Kelsie Riley","0530776535","kelsieriley@gmail.couk","3795 Arcu Avenue",59839),
  ("Patricia Stuart","0527855873","patriciastuart@yahoo.edu","280-8773 Pellentesque Rd.",19709),
  ("Herrod Poole","0583259948","herrodpoole781@aol.net","P.O. Box 116, 7157 Mi Avenue",48402),
  ("Amethyst Henson","0583258127","amethysthenson7752@icloud.ca","Ap #759-6236 Non Rd.",80244),
  ("Deirdre Cardenas","0528021015","deirdrecardenas2814@gmail.ca","Ap #748-144 Conubia St.",23202),
  ("Ivana Vega","0559538245","ivanavega4485@aol.ca","Ap #242-1666 Id, Rd.",23128);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Brent Atkinson","0553496559","brentatkinson8770@yahoo.ca","P.O. Box 938, 9369 Nisl St.",84778),
  ("Stacey Carey","0547679584","staceycarey4123@icloud.com","786-778 Dapibus Rd.",73341),
  ("Lance Lara","0576983686","lancelara@icloud.com","Ap #574-5224 Eu, Av.",93297),
  ("Hope Macias","0561894144","hopemacias@aol.net","Ap #268-9187 Turpis Av.",66010),
  ("Harlan Santiago","0517209964","harlansantiago8252@gmail.edu","P.O. Box 465, 9767 Sodales Rd.",40132),
  ("Kirestin Wheeler","0525235195","kirestinwheeler35@google.net","P.O. Box 427, 8327 Nunc Rd.",81806),
  ("Haley Alvarado","0558664068","haleyalvarado1679@icloud.org","P.O. Box 666, 8308 Fringilla Street",77836),
  ("Katell Wilkerson","0532222712","katellwilkerson@google.com","7907 Nulla Street",76669),
  ("Debra Travis","0588817036","debratravis4176@yahoo.net","Ap #382-2152 Faucibus Street",47440),
  ("Fuller Lawrence","0565416145","fullerlawrence@aol.org","1473 Consequat Ave",62963);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Amela Rosales","0531269154","amelarosales@aol.edu","Ap #608-7833 Aenean St.",32136),
  ("Jennifer Banks","0550673502","jenniferbanks8682@google.com","553-1290 Laoreet Av.",40765),
  ("Gloria Buckley","0503762701","gloriabuckley467@gmail.org","Ap #461-5342 Malesuada Avenue",75093),
  ("Amber Frye","0584657194","amberfrye@gmail.net","669-4081 Aliquet Avenue",58511),
  ("Ryan Simon","0541259473","ryansimon@google.org","Ap #535-6526 Sociosqu Ave",71114),
  ("Jermaine Jackson","0547202389","jermainejackson1156@aol.couk","831-2059 Commodo Road",61172),
  ("Tanisha Fox","0520275787","tanishafox9495@icloud.couk","852-5279 Mollis St.",36448),
  ("Madison Rose","0516482655","madisonrose@aol.couk","720-4949 Consectetuer, Ave",91110),
  ("Eric Maynard","0578242197","ericmaynard@icloud.net","341-6460 Ac St.",23881),
  ("Alan Nieves","0576232738","alannieves8050@icloud.net","Ap #351-6131 Pellentesque Avenue",42137);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Kalia Alston","0562365646","kaliaalston@aol.edu","352-5727 Tempus Av.",41255),
  ("Nora Lawrence","0534171875","noralawrence@yahoo.ca","Ap #218-2004 Ullamcorper. Ave",58949),
  ("Violet Beck","0587475119","violetbeck@google.edu","650-2976 Donec Avenue",26286),
  ("Germane Buck","0536742917","germanebuck@gmail.net","P.O. Box 396, 9225 Lacus Road",34639),
  ("Nehru Whitley","0562875133","nehruwhitley@icloud.ca","364-5136 Est Ave",91166),
  ("Quemby Whitehead","0550691425","quembywhitehead@yahoo.com","761-6275 Venenatis Av.",20418),
  ("Steel Puckett","0516255984","steelpuckett@google.couk","Ap #757-8544 Pellentesque Avenue",32318),
  ("Denton Ingram","0570358353","dentoningram354@aol.com","Ap #623-802 Sociis Rd.",30276),
  ("Quentin Rowe","0524321266","quentinrowe@google.com","Ap #138-2837 Vestibulum St.",60713),
  ("Velma Underwood","0588972727","velmaunderwood@google.org","P.O. Box 496, 7520 A, Ave",91734);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Erin Michael","0591340307","erinmichael@gmail.couk","P.O. Box 792, 8317 Nulla Av.",41233),
  ("Thor Stephenson","0563311245","thorstephenson8956@google.couk","854-8861 Arcu. Road",57651),
  ("Camille Todd","0584431425","camilletodd2680@gmail.couk","Ap #413-3531 Lectus St.",84828),
  ("Kessie Kaufman","0555789382","kessiekaufman6167@aol.net","Ap #236-5318 Integer Ave",18552),
  ("Lyle Hancock","0576125132","lylehancock2@google.ca","Ap #547-3112 Vel Rd.",38626),
  ("Cain England","0531837535","cainengland5674@google.net","888-873 Laoreet Rd.",72597),
  ("Dustin Jones","0532226754","dustinjones@aol.edu","743-3550 Neque. St.",94983),
  ("Arsenio Robertson","0575012133","arseniorobertson9611@gmail.org","597-7728 Augue, Road",92165),
  ("Lucy Moreno","0555043654","lucymoreno9829@icloud.net","Ap #853-3971 Libero. Ave",27129),
  ("Knox Winters","0598705718","knoxwinters6069@icloud.couk","Ap #746-8535 Non, Rd.",22249);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Chanda Alford","0574524772","chandaalford6064@icloud.net","949-5315 Facilisis Rd.",84867),
  ("Maxwell Russo","0525574914","maxwellrusso@icloud.couk","208-4361 Sed Rd.",70636),
  ("Kareem Lewis","0585052948","kareemlewis@icloud.net","923-3638 Libero. Av.",68902),
  ("Bert Barnett","0541714765","bertbarnett4596@icloud.com","Ap #401-531 Quis St.",37774),
  ("Rana Stark","0592421137","ranastark3212@icloud.org","P.O. Box 449, 1444 Posuere Rd.",87510),
  ("Margaret Wells","0511438895","margaretwells9793@gmail.org","720-1398 Cum Street",55054),
  ("Aspen Morgan","0517317423","aspenmorgan6141@gmail.net","Ap #417-7443 Donec Rd.",13287),
  ("Dara Zimmerman","0552663586","darazimmerman@aol.ca","327-2575 Adipiscing Rd.",54353),
  ("Amery Mcleod","0530120147","amerymcleod@aol.couk","611-1605 Enim Road",90305),
  ("Kamal Neal","0532298196","kamalneal9892@google.net","653-6364 Litora Rd.",68104);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Cain Perkins","0599619218","cainperkins@aol.com","508-7015 Nunc Av.",92729),
  ("Plato Randall","0545023806","platorandall4716@yahoo.edu","703-987 Proin Avenue",58653),
  ("Chloe James","0529881888","chloejames@yahoo.org","P.O. Box 114, 4380 Egestas Avenue",62241),
  ("Erich Bentley","0590173904","erichbentley@google.edu","Ap #924-6745 Ullamcorper. St.",60784),
  ("Victor Burton","0504852971","victorburton@aol.couk","Ap #616-4743 Mauris Avenue",13407),
  ("Idola Miller","0536373170","idolamiller@icloud.com","Ap #714-3932 Dui, Rd.",80831),
  ("Rylee Houston","0578416664","ryleehouston@yahoo.edu","7585 Sagittis. Av.",55263),
  ("Roanna Cross","0532727184","roannacross@gmail.org","Ap #337-2401 Ultricies Rd.",26492),
  ("Freya Carter","0542733254","freyacarter1563@gmail.net","Ap #479-8754 Nunc Avenue",86140),
  ("Prescott Massey","0529810970","prescottmassey9532@google.edu","Ap #443-7717 Nibh Street",96440);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Forrest Wilder","0599013540","forrestwilder@aol.ca","Ap #827-8056 Eu, Road",16813),
  ("Lee Vance","0554154515","leevance@gmail.ca","6206 Aliquet Road",72347),
  ("Colin Brewer","0518680049","colinbrewer3790@yahoo.net","P.O. Box 713, 6747 Accumsan Street",69331),
  ("Matthew Vang","0533427162","matthewvang@yahoo.ca","4737 Arcu Rd.",71563),
  ("Piper Rodriquez","0508319734","piperrodriquez4483@google.com","Ap #338-4038 Laoreet St.",40616),
  ("Christen Salas","0562850797","christensalas@google.couk","Ap #661-3503 Semper Rd.",97981),
  ("Renee Blackburn","0507168653","reneeblackburn@yahoo.edu","515-4236 Suspendisse Rd.",35937),
  ("Sacha Bush","0550322458","sachabush6494@yahoo.ca","827-7668 Mauris St.",39359),
  ("Abigail Bauer","0568945211","abigailbauer@gmail.org","Ap #393-6754 Quis St.",94748),
  ("Caesar Graves","0548463036","caesargraves9044@google.couk","P.O. Box 901, 4421 Dictum St.",62638);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Jasper Gutierrez","0536250899","jaspergutierrez@icloud.com","P.O. Box 279, 8261 Ut Rd.",13361),
  ("Leila Collier","0556114486","leilacollier9097@google.edu","9998 Amet Avenue",31663),
  ("Cairo Larson","0540574419","cairolarson6722@google.com","4614 Auctor Rd.",58702),
  ("Daryl Swanson","0587569774","darylswanson9698@aol.couk","471-7305 Sed Avenue",98716),
  ("Zena Salazar","0588424370","zenasalazar5583@aol.edu","946-5086 Natoque Street",12323),
  ("Kiona Oliver","0503613651","kionaoliver@yahoo.org","Ap #301-3210 Faucibus Av.",86887),
  ("Mark Atkinson","0526720665","markatkinson@aol.com","351-5400 Fusce Road",20348),
  ("Simon Hanson","0567385886","simonhanson@google.couk","4949 Hendrerit Avenue",92460),
  ("Thaddeus Mendoza","0596141752","thaddeusmendoza@gmail.org","Ap #616-2203 Nunc. Rd.",45176),
  ("Allistair Buckley","0542823150","allistairbuckley@gmail.com","412-8331 Aenean Rd.",25107);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Erica Goff","0594322233","ericagoff@gmail.edu","P.O. Box 495, 3508 Nulla Avenue",23221),
  ("Palmer Valentine","0564739563","palmervalentine9848@icloud.org","Ap #915-5118 Tempor Rd.",20969),
  ("Quail Cox","0524983067","quailcox@google.com","6818 Vitae Road",47896),
  ("Laurel Haney","0576873812","laurelhaney@gmail.net","Ap #549-9459 Justo Rd.",22397),
  ("Brenna Mooney","0583248323","brennamooney6536@google.couk","Ap #571-6237 Feugiat. Street",67600),
  ("Brooke Irwin","0563063367","brookeirwin@google.ca","371-3483 Et, Rd.",85859),
  ("Oren Ford","0534115345","orenford8637@yahoo.edu","904-7449 Vestibulum, Road",61349),
  ("Wallace Burt","0587783374","wallaceburt923@gmail.org","Ap #948-3260 Blandit St.",87715),
  ("Shelby Rivas","0525823431","shelbyrivas@gmail.edu","115-3804 Tellus. Avenue",31901),
  ("Ivory Mason","0580651180","ivorymason2414@gmail.org","539-8282 Arcu Rd.",47602);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Victoria Gates","0533407321","victoriagates@icloud.couk","294-7567 Massa. St.",30855),
  ("Amity Rios","0528146124","amityrios@yahoo.com","656-8944 Sagittis Rd.",67611),
  ("Denise Gibson","0565528753","denisegibson@google.net","Ap #246-1409 Quisque Rd.",71415),
  ("Cedric Little","0588725205","cedriclittle116@aol.org","841-8272 Magna. Rd.",90060),
  ("Phillip Rodriguez","0534954053","philliprodriguez@aol.org","Ap #715-7056 Et Road",53492),
  ("Serina Mcbride","0547894783","serinamcbride1035@yahoo.com","Ap #197-3176 Ridiculus Ave",31354),
  ("Hyacinth Olsen","0590583036","hyacintholsen849@gmail.couk","835-9120 Nibh Ave",49557),
  ("Lucian Owens","0524763744","lucianowens@yahoo.com","Ap #115-1651 Lobortis. Ave",73898),
  ("Yuli Grant","0549247182","yuligrant5773@yahoo.com","Ap #669-3009 Nec, Rd.",18727),
  ("Joelle Camacho","0533944565","joellecamacho@aol.net","Ap #420-3514 At, St.",23961);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Barclay Abbott","0501851352","barclayabbott7920@yahoo.ca","P.O. Box 568, 3511 Cras Road",53559),
  ("Harding Hines","0571536044","hardinghines3945@yahoo.com","606-2705 Orci Avenue",44292),
  ("Morgan Hyde","0562343335","morganhyde@icloud.org","Ap #152-4695 Pede Av.",93654),
  ("Orson Mcintyre","0509510743","orsonmcintyre@aol.com","Ap #981-1361 Vestibulum. Rd.",14071),
  ("Bruce Reese","0589654250","brucereese7228@icloud.net","312-7821 Mus. Av.",75381),
  ("Hilel Sloan","0526573187","hilelsloan8130@gmail.edu","731-1795 Mauris. Avenue",85950),
  ("Lillian Randolph","0505447818","lillianrandolph@aol.couk","Ap #780-5093 Quam Rd.",25590),
  ("Murphy Reese","0531086380","murphyreese4331@yahoo.couk","358-4217 Consequat, Av.",68450),
  ("Kermit Vang","0563594014","kermitvang556@gmail.couk","Ap #300-8558 Nulla Road",78720),
  ("Ocean Mcdaniel","0511434498","oceanmcdaniel@google.edu","Ap #329-5429 Duis Avenue",45481);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Conan Gray","0528946536","conangray2272@icloud.net","P.O. Box 778, 5198 Quisque Rd.",66594),
  ("Sara Kirk","0571589859","sarakirk6478@aol.couk","Ap #463-7927 Neque Rd.",95908),
  ("Joy Hardy","0562555918","joyhardy7449@icloud.edu","2791 Dis Street",76630),
  ("Joan Moore","0573759268","joanmoore@gmail.com","713-9383 Sollicitudin Rd.",72157),
  ("Clementine Marks","0530468140","clementinemarks@gmail.net","Ap #336-1728 Ornare Avenue",73945),
  ("Curran Burt","0557819575","curranburt@google.edu","Ap #160-8676 Lectus Road",32824),
  ("Cedric Johnson","0547485723","cedricjohnson@yahoo.org","8922 Vel, St.",77299),
  ("Kirk Irwin","0590521521","kirkirwin@aol.ca","Ap #943-6199 Duis St.",99043),
  ("Yardley Dorsey","0562258123","yardleydorsey4750@gmail.ca","127-8474 Sit Ave",79846),
  ("Miriam Mullen","0558747938","miriammullen4921@google.org","P.O. Box 589, 7774 Mus. St.",19009);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Hashim Kane","0541955125","hashimkane4091@yahoo.couk","730-3035 Orci. Road",29290),
  ("Amaya Wilkerson","0502464297","amayawilkerson@aol.ca","Ap #278-4991 Nibh. Road",66081),
  ("Solomon Schwartz","0577207737","solomonschwartz@icloud.net","501-2118 Fermentum Rd.",78894),
  ("Jasmine Hensley","0598339096","jasminehensley@icloud.edu","892-7769 Aliquet. Av.",65779),
  ("Zena Baldwin","0584218257","zenabaldwin1505@gmail.edu","152-2463 Tellus Avenue",35485),
  ("Mary Ortega","0562590636","maryortega5435@aol.edu","P.O. Box 239, 1352 Elit, St.",80769),
  ("Solomon Pruitt","0578684025","solomonpruitt9556@icloud.couk","P.O. Box 683, 4071 Ultrices, Avenue",45640),
  ("Lilah Guerrero","0590192252","lilahguerrero@google.com","252-8051 Metus. Rd.",54693),
  ("Emma Melton","0535211877","emmamelton@aol.org","904-6819 Dolor. Ave",28328),
  ("Rogan Pena","0571948628","roganpena8831@icloud.edu","P.O. Box 200, 6908 A, Ave",92982);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Benjamin Guthrie","0503684525","benjaminguthrie4682@yahoo.com","461-7319 Etiam St.",71923),
  ("Drake Buckner","0597514628","drakebuckner7747@yahoo.org","Ap #387-3458 Laoreet Av.",65249),
  ("Dolan Quinn","0509285614","dolanquinn8298@icloud.net","P.O. Box 676, 6608 Adipiscing Avenue",59142),
  ("Timothy Valenzuela","0591263918","timothyvalenzuela74@aol.net","P.O. Box 517, 6310 Ipsum St.",84293),
  ("Craig Walker","0586664155","craigwalker@aol.net","673-9254 Integer Avenue",65598),
  ("Curran Bowers","0577643413","curranbowers@gmail.com","P.O. Box 747, 9280 Dictum Ave",95618),
  ("Faith Ayers","0578891234","faithayers5540@gmail.com","Ap #769-6835 Semper Road",17246),
  ("Jerry Robbins","0553872866","jerryrobbins@icloud.org","510-5220 Auctor Rd.",46134),
  ("Claire Christian","0593905776","clairechristian4146@yahoo.net","Ap #755-5094 Volutpat Ave",42685),
  ("Isabella Glass","0592532427","isabellaglass1299@icloud.org","Ap #606-7951 Id Street",23078);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Lenore Wells","0523927252","lenorewells@yahoo.org","Ap #946-9252 Cursus Av.",85468),
  ("Galena Hendricks","0512817515","galenahendricks@aol.ca","7474 A, Avenue",59619),
  ("Devin May","0526187684","devinmay1646@google.couk","535-8938 Enim, Ave",82071),
  ("Madison Bonner","0532177171","madisonbonner@google.org","P.O. Box 424, 1883 Elit St.",25791),
  ("Moana Wiley","0534597339","moanawiley3706@yahoo.edu","145-4297 Phasellus St.",29403),
  ("Nell Moran","0587468281","nellmoran5679@gmail.com","8968 Aenean Avenue",96180),
  ("Orson Bird","0532360873","orsonbird@gmail.edu","Ap #545-9967 Sagittis. St.",27957),
  ("Erin Chandler","0578313871","erinchandler@google.couk","Ap #152-413 Leo. Ave",94822),
  ("Danielle Baxter","0562178639","daniellebaxter@google.org","529-9370 Mi Street",60386),
  ("Guinevere Flynn","0590697564","guinevereflynn7707@yahoo.org","624-1372 Velit Ave",66415);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Ann Sargent","0557874726","annsargent@yahoo.ca","891-1681 Vulputate, Avenue",17605),
  ("Ethan Ortega","0501412237","ethanortega8897@google.com","5252 Donec Ave",13224),
  ("Benjamin Mullen","0511147582","benjaminmullen1957@google.couk","600-7370 Nec, Street",82609),
  ("Mannix Osborn","0516565779","mannixosborn@aol.couk","Ap #573-1481 Libero St.",39439),
  ("Dolan Wynn","0569263422","dolanwynn@gmail.couk","986 Proin Avenue",15152),
  ("Eric Barr","0571710100","ericbarr@icloud.org","2856 Interdum Rd.",36159),
  ("Vincent Rosario","0582516272","vincentrosario403@aol.couk","P.O. Box 695, 4771 Vehicula Av.",46218),
  ("Daquan Reeves","0583843263","daquanreeves@gmail.com","994-3937 Mauris Road",68497),
  ("Idola Chan","0536133924","idolachan@icloud.couk","Ap #346-5702 Pellentesque Ave",84698),
  ("Lionel Wilcox","0510276944","lionelwilcox@icloud.org","314-1123 Nec St.",75223);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Octavius Smith","0510675743","octaviussmith@google.org","Ap #896-3932 Amet Ave",49119),
  ("Julian Figueroa","0591261529","julianfigueroa@icloud.ca","618 Orci Rd.",60816),
  ("Clare Morin","0582778413","claremorin2768@yahoo.edu","Ap #381-7351 Libero Rd.",45681),
  ("Wyoming Cherry","0571293376","wyomingcherry@google.couk","766-7136 Id Ave",22217),
  ("Dolan Mclaughlin","0572444437","dolanmclaughlin@icloud.ca","Ap #444-3785 Sit Ave",28208),
  ("Tanya Maldonado","0572207651","tanyamaldonado5829@yahoo.ca","Ap #612-7107 Tristique Av.",49885),
  ("Quinn Sykes","0598264382","quinnsykes@icloud.org","136-7340 Etiam Av.",46698),
  ("Abdul Travis","0551568554","abdultravis@yahoo.com","P.O. Box 576, 1081 Dolor Av.",41962),
  ("Hedy O'Neill","0538883217","hedyoneill7989@gmail.ca","691-6555 Aliquam St.",18814),
  ("Jordan Flowers","0563453632","jordanflowers8501@aol.ca","P.O. Box 401, 2679 Vel Av.",77961);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Cairo Bryant","0520244283","cairobryant4522@google.ca","Ap #194-7242 Montes, Av.",35331),
  ("Bell Freeman","0577731832","bellfreeman@icloud.net","225-4065 At Rd.",91819),
  ("Jonas Strickland","0584516736","jonasstrickland@google.net","5686 Ligula Av.",95661),
  ("Yuli Britt","0535452817","yulibritt@aol.ca","235-3230 Eros Street",56685),
  ("Grant Mercer","0545531624","grantmercer@yahoo.net","602-6427 Luctus Ave",74371),
  ("Maxwell Mullins","0538412112","maxwellmullins@aol.couk","683-8327 Ut Av.",65346),
  ("Laith Garrison","0501589651","laithgarrison2629@yahoo.edu","Ap #743-1110 Ligula. Street",49911),
  ("Caldwell Daniels","0569488735","caldwelldaniels@aol.couk","540-7400 Ultrices Street",44185),
  ("Griffith Logan","0551521586","griffithlogan@google.net","Ap #279-1839 Ut St.",90518),
  ("Talon Bell","0563133425","talonbell@gmail.com","217-8608 Ornare, St.",45597);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Xantha O'connor","0512511161","xanthaoconnor2878@yahoo.org","313-6734 Et Rd.",62628),
  ("Kirby Myers","0521257647","kirbymyers@google.net","250-3862 Ligula Ave",35666),
  ("Vaughan Giles","0577247792","vaughangiles2204@yahoo.org","3861 Elementum St.",60134),
  ("Vernon Marks","0552284114","vernonmarks8668@yahoo.net","P.O. Box 206, 8162 Nam St.",47659),
  ("Chelsea Ramos","0573322072","chelsearamos@gmail.com","272-859 Pharetra. St.",89781),
  ("Octavius Simmons","0554616476","octaviussimmons6926@gmail.com","Ap #602-9467 Proin St.",39956),
  ("Kasper Shields","0546312324","kaspershields@google.couk","P.O. Box 446, 4577 Sodales Street",90953),
  ("Stewart Alvarez","0558881826","stewartalvarez2456@yahoo.com","Ap #910-3246 Parturient St.",44116),
  ("Thomas Ferguson","0514225475","thomasferguson9414@gmail.edu","Ap #637-3620 Porttitor St.",41365),
  ("Elton Hurst","0518624781","eltonhurst@icloud.net","Ap #528-7866 Pretium Ave",23227);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("August Harrell","0567833618","augustharrell@icloud.ca","Ap #753-2060 Nullam Av.",87967),
  ("Mariam Guerra","0505735859","mariamguerra@aol.com","996-7912 Ac St.",34609),
  ("Conan Sargent","0562952117","conansargent@yahoo.net","Ap #359-827 Leo, Street",43400),
  ("Cassidy Gaines","0548708715","cassidygaines@gmail.couk","P.O. Box 762, 8016 Ut, Av.",48288),
  ("Lionel Evans","0527272229","lionelevans@aol.edu","5909 Nam Road",68253),
  ("Gage Banks","0560253158","gagebanks8182@icloud.edu","Ap #255-8764 Bibendum St.",10242),
  ("Chelsea Padilla","0546760134","chelseapadilla1799@aol.edu","953-1695 Luctus Avenue",20401),
  ("Ainsley Lamb","0525988669","ainsleylamb@aol.ca","Ap #559-4132 Auctor Ave",72206),
  ("Tamekah Carr","0508472656","tamekahcarr@google.ca","110 Id, Ave",90629),
  ("Tobias Russell","0532722393","tobiasrussell6498@icloud.net","Ap #696-7888 Posuere, Avenue",47496);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Mallory Banks","0510633564","mallorybanks3154@gmail.org","3162 Vestibulum Avenue",21461),
  ("Allegra Henry","0515316245","allegrahenry@google.couk","P.O. Box 145, 2349 Arcu. Av.",32056),
  ("Byron Mccarthy","0558532225","byronmccarthy5879@yahoo.couk","119-9032 Adipiscing Street",65306),
  ("Naomi Rivera","0572699132","naomirivera@google.ca","373-9804 Quisque Av.",75547),
  ("Sacha Carson","0526322567","sachacarson5821@google.org","P.O. Box 119, 7305 Egestas Road",85500),
  ("Rogan Terrell","0583082853","roganterrell6518@gmail.edu","Ap #655-6155 Ornare. Road",61248),
  ("Farrah Snider","0583353279","farrahsnider3219@icloud.ca","847-346 Diam Rd.",13851),
  ("Christian Mclean","0570346381","christianmclean3077@yahoo.ca","1234 Cras St.",27753),
  ("Colt Sargent","0517752275","coltsargent4705@gmail.org","1390 Tempor Rd.",45482),
  ("Kellie Hogan","0522775163","kelliehogan6070@aol.org","Ap #535-4165 Parturient Rd.",25698);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Veronica Conley","0504870415","veronicaconley8395@yahoo.ca","916-8644 Ornare, Road",79824),
  ("Amber Butler","0581445236","amberbutler@icloud.net","915-9588 Nisi Rd.",53688),
  ("Keiko Hanson","0520592368","keikohanson@icloud.couk","283-7522 Dictum Av.",92543),
  ("Lisandra Hogan","0527140097","lisandrahogan@icloud.ca","750-6636 Nullam Street",21310),
  ("Ray Dennis","0583415788","raydennis2315@google.net","296-8106 Mi. St.",92673),
  ("Lamar Riggs","0579262746","lamarriggs6728@yahoo.couk","P.O. Box 817, 9970 Auctor Avenue",65594),
  ("Imogene Kane","0521121444","imogenekane@aol.ca","P.O. Box 509, 4799 Aliquet Rd.",38612),
  ("Fletcher Franks","0564186516","fletcherfranks@aol.net","161-2304 Dictum Ave",87294),
  ("Clayton Gilmore","0555413662","claytongilmore@aol.com","Ap #197-5737 Mollis Rd.",85139),
  ("Freya Hobbs","0516462119","freyahobbs3538@google.couk","8335 Cursus Road",11962);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Malcolm Ballard","0536573623","malcolmballard@gmail.edu","P.O. Box 372, 6657 Ut, Rd.",67376),
  ("Melissa Landry","0546071238","melissalandry@icloud.ca","Ap #748-4295 Tincidunt Rd.",91828),
  ("Carissa Mccarthy","0510235727","carissamccarthy7137@aol.org","Ap #637-4267 Nunc Rd.",33173),
  ("Rhiannon Bolton","0555681374","rhiannonbolton@aol.ca","7082 Arcu. Street",68532),
  ("Edward Dale","0549820130","edwarddale2178@gmail.com","Ap #103-6140 Egestas St.",18214),
  ("Erich Mcintosh","0524216073","erichmcintosh@google.edu","Ap #396-9233 Eget, Av.",90194),
  ("Hedy Summers","0531254613","hedysummers4396@yahoo.edu","2548 Mauris. St.",52544),
  ("Sylvia Cobb","0521519886","sylviacobb3517@yahoo.com","603-5314 In Road",70051),
  ("Joshua Mcleod","0511666374","joshuamcleod1437@icloud.edu","P.O. Box 620, 2286 Nunc St.",54880),
  ("Sybil Shepard","0555994822","sybilshepard5670@yahoo.ca","489-2762 Ipsum. Ave",66212);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Brynne Vega","0501203285","brynnevega1776@gmail.com","265-5254 Sed Road",34151),
  ("Maite Duncan","0592533477","maiteduncan9375@icloud.couk","124-3869 Diam St.",44600),
  ("Andrew Galloway","0514815959","andrewgalloway6615@yahoo.net","131-2098 Mi Ave",30474),
  ("Abra Schmidt","0516647271","abraschmidt@google.couk","828-1653 At, Rd.",80141),
  ("Hammett Oneil","0544166458","hammettoneil3969@icloud.com","Ap #185-4155 Nunc Street",17064),
  ("Alden Price","0598769749","aldenprice@icloud.edu","Ap #827-960 Nec St.",46996),
  ("Vanna Fletcher","0521319121","vannafletcher7660@google.couk","1802 Et St.",97824),
  ("Zachery Sawyer","0587365807","zacherysawyer9740@google.net","Ap #517-1184 Viverra. Road",88986),
  ("Celeste Sampson","0534408907","celestesampson7745@google.org","Ap #991-9588 Tempus Road",72136),
  ("Aidan Mccray","0543837335","aidanmccray@icloud.com","Ap #217-767 Amet St.",18330);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Brock Gardner","0579237726","brockgardner3809@yahoo.ca","489-1464 Parturient Av.",59180),
  ("Maris Griffin","0532860115","marisgriffin@gmail.edu","P.O. Box 848, 2695 Non Road",32781),
  ("Jeremy Ortiz","0547157532","jeremyortiz7076@gmail.org","Ap #834-9029 Fringilla, St.",34732),
  ("Emmanuel Burks","0575238545","emmanuelburks@gmail.com","5060 Nam St.",85579),
  ("Chester Robertson","0589377162","chesterrobertson@yahoo.com","Ap #818-7180 Sem St.",82854),
  ("Hillary Carroll","0514778545","hillarycarroll@yahoo.ca","885-1968 Justo Avenue",41111),
  ("Whoopi Alexander","0536354285","whoopialexander1257@yahoo.com","Ap #325-253 Risus Rd.",57662),
  ("Elijah Underwood","0575779650","elijahunderwood@gmail.com","Ap #650-7983 Commodo Road",28463),
  ("Keith Goff","0533332196","keithgoff5989@google.edu","Ap #791-6220 Ut Rd.",15728),
  ("Maryam Wilkinson","0545542352","maryamwilkinson9240@yahoo.ca","Ap #465-5919 Dictum Av.",66611);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Destiny Waters","0594515653","destinywaters@yahoo.ca","Ap #424-5123 Sollicitudin Av.",40110),
  ("Hillary Dennis","0589234493","hillarydennis@google.ca","556-7204 Et Road",86235),
  ("Yael Cooper","0565215751","yaelcooper@yahoo.edu","P.O. Box 371, 6148 Interdum Road",32897),
  ("Leah Walker","0526526967","leahwalker@gmail.com","552-4166 Ridiculus Av.",11293),
  ("George Graves","0573506076","georgegraves3879@yahoo.com","Ap #693-2245 Enim Avenue",80497),
  ("Sonya West","0552439410","sonyawest8345@yahoo.edu","Ap #820-6715 Sed St.",55027),
  ("Hannah Fisher","0547553787","hannahfisher@icloud.com","674-2175 Suscipit, Avenue",76417),
  ("Whilemina Molina","0525474561","whileminamolina6731@aol.com","P.O. Box 488, 720 Sit St.",13999),
  ("Arden Estrada","0577705765","ardenestrada@google.couk","805-4224 Aliquet Rd.",63190),
  ("Aurelia Fitzgerald","0546351827","aureliafitzgerald6969@gmail.ca","Ap #975-2318 Feugiat St.",22348);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Hunter Quinn","0541018536","hunterquinn4804@yahoo.ca","P.O. Box 470, 8457 Mi. St.",34190),
  ("Donna Cooke","0527121796","donnacooke2583@aol.couk","481-6930 Neque St.",74805),
  ("Simon David","0505685878","simondavid3289@yahoo.net","434-2125 Sociis Road",64861),
  ("Francis Briggs","0535098143","francisbriggs@google.net","137-3980 Enim, Avenue",36075),
  ("Priscilla Mcintyre","0539447037","priscillamcintyre3713@gmail.com","P.O. Box 286, 9669 Ut, Av.",73803),
  ("Rigel Duke","0563504842","rigelduke@gmail.couk","Ap #323-7847 Pede, Avenue",32415),
  ("Ingrid Santiago","0585423684","ingridsantiago8822@google.ca","349-6266 Fermentum Rd.",61886),
  ("Clio Santos","0508746346","cliosantos@icloud.couk","P.O. Box 114, 5203 Risus. Road",43368),
  ("TaShya Hodges","0520844062","tashyahodges@icloud.org","Ap #432-4219 Nunc St.",81697),
  ("Colorado Shepherd","0541263121","coloradoshepherd@yahoo.com","848 Posuere Av.",84467);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Neville Howard","0501036544","nevillehoward@yahoo.ca","Ap #827-562 Cras Av.",90428),
  ("Venus Banks","0564291302","venusbanks5113@google.ca","348 Purus, Road",21762),
  ("Phoebe Mccarty","0567717338","phoebemccarty2949@yahoo.couk","Ap #976-7269 In Road",94438),
  ("Cade Daugherty","0551381572","cadedaugherty107@yahoo.couk","521-4853 Id Rd.",28552),
  ("Lawrence Wilcox","0584427126","lawrencewilcox3103@google.com","P.O. Box 222, 900 Nunc Rd.",10172),
  ("Dora Welch","0511813506","dorawelch@gmail.net","Ap #146-3783 Condimentum Rd.",11430),
  ("Geoffrey Thornton","0583032278","geoffreythornton67@gmail.com","Ap #520-135 Dui Av.",84817),
  ("Nolan Robbins","0551532813","nolanrobbins7067@google.couk","767-6067 Mauris Rd.",41927),
  ("Vladimir Christian","0536463437","vladimirchristian@yahoo.edu","Ap #536-2165 Diam. Av.",70036),
  ("Neville Wagner","0505546147","nevillewagner@aol.com","5302 In, Rd.",21445);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Ila Graves","0520878257","ilagraves@aol.edu","452-1445 Ullamcorper. Avenue",29206),
  ("Felicia Sellers","0567507364","feliciasellers2147@icloud.net","Ap #449-6407 A Avenue",53798),
  ("Laura Sosa","0586662421","laurasosa8701@google.net","Ap #839-6600 Rhoncus. Street",90942),
  ("Dai Lancaster","0525852624","dailancaster@icloud.org","533-4973 Elit St.",28835),
  ("Jasmine Ewing","0558012273","jasmineewing@yahoo.couk","455-8217 Donec Av.",99502),
  ("Arden Jarvis","0574476460","ardenjarvis@yahoo.com","P.O. Box 240, 1861 Fringilla Rd.",52880),
  ("Remedios Moss","0501851265","remediosmoss9408@aol.edu","Ap #808-8512 Ipsum Street",87871),
  ("Stuart Carver","0549230176","stuartcarver1369@gmail.edu","885-2676 Dui Street",96990),
  ("Clare Sloan","0575463438","claresloan@aol.com","P.O. Box 922, 504 Ut Road",34768),
  ("Mohammad Hood","0538782757","mohammadhood4883@google.couk","P.O. Box 684, 2933 At, Road",63996);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Shelly Dominguez","0520152134","shellydominguez9339@yahoo.edu","4158 Natoque Rd.",75678),
  ("Sonia Aguilar","0555473237","soniaaguilar@google.net","P.O. Box 576, 8731 Natoque Road",66947),
  ("Keegan Spencer","0548695114","keeganspencer1965@aol.com","970-6197 Cras St.",76663),
  ("Denise Holder","0505723816","deniseholder@aol.couk","Ap #905-624 Accumsan Av.",29466),
  ("Michelle Carpenter","0510838883","michellecarpenter@gmail.edu","Ap #178-2666 Pellentesque Road",69734),
  ("Melanie Mendez","0505225362","melaniemendez@gmail.com","P.O. Box 341, 4944 A Road",99032),
  ("Lisandra Contreras","0517505262","lisandracontreras@icloud.net","Ap #308-834 Adipiscing Av.",84694),
  ("Finn Langley","0541431044","finnlangley@yahoo.couk","800-917 Molestie St.",26507),
  ("Yael Head","0558630110","yaelhead@gmail.ca","355-1268 Malesuada Road",77393),
  ("Channing Day","0514687597","channingday@google.couk","353-1377 Consectetuer Road",21805);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Axel Jensen","0509155865","axeljensen@aol.edu","Ap #966-7518 Massa. Street",52861),
  ("Zephania Mejia","0585153723","zephaniamejia6508@aol.edu","Ap #954-1945 Est Rd.",56933),
  ("Kadeem Gonzales","0542783159","kadeemgonzales@icloud.com","Ap #743-9165 Tempor, Street",38717),
  ("Ursula Jarvis","0587625084","ursulajarvis@google.net","Ap #676-6244 Sed Road",90306),
  ("Basil Daniels","0562356817","basildaniels1176@aol.couk","313-5999 Semper Road",61082),
  ("Breanna Chen","0565447832","breannachen@google.com","P.O. Box 740, 7423 Interdum Street",76997),
  ("Paki Hall","0551477776","pakihall699@yahoo.ca","Ap #527-9900 Convallis, Rd.",80184),
  ("Lilah Mueller","0538562867","lilahmueller7076@aol.couk","242-4368 Justo Rd.",96559),
  ("Nyssa Fowler","0597351303","nyssafowler@gmail.com","5004 Ornare. St.",27306),
  ("Gregory Hancock","0574595082","gregoryhancock7962@gmail.net","P.O. Box 969, 5789 Amet, Road",99769);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Signe Good","0529214697","signegood6763@aol.org","4262 Lobortis Rd.",99027),
  ("Virginia Whitehead","0531551353","virginiawhitehead2368@aol.org","559-8600 Arcu. Rd.",88404),
  ("Martina Guerra","0537456311","martinaguerra4252@google.edu","P.O. Box 163, 2319 Neque. Rd.",57732),
  ("Kiara Dawson","0526200953","kiaradawson@yahoo.ca","928 Donec St.",91792),
  ("Rahim Allison","0502727920","rahimallison219@icloud.edu","P.O. Box 796, 9768 Nulla Rd.",46225),
  ("Erich Wells","0514441344","erichwells@google.couk","Ap #876-7831 Interdum Avenue",56674),
  ("Gary Perkins","0553295033","garyperkins@icloud.net","Ap #932-5571 Arcu Rd.",62956),
  ("Elaine Marquez","0502747672","elainemarquez1937@google.org","P.O. Box 505, 2224 Sapien. Road",74723),
  ("Lenore Hampton","0556845317","lenorehampton@icloud.net","9101 Primis Av.",11634),
  ("Oprah Pate","0569678833","oprahpate3005@google.edu","808-6714 Ornare Av.",12995);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Talon Ruiz","0549368686","talonruiz@gmail.ca","976-7058 Per Rd.",64246),
  ("Travis Austin","0583885925","travisaustin@aol.net","506-4967 Leo St.",88709),
  ("Beau Daugherty","0582694595","beaudaugherty6953@yahoo.org","P.O. Box 356, 4886 Lectus. Rd.",96816),
  ("James Henderson","0558682634","jameshenderson@yahoo.org","Ap #601-9126 Mi St.",79743),
  ("Fritz Hardin","0516537164","fritzhardin945@icloud.net","272-3017 Imperdiet Ave",55431),
  ("Coby Lucas","0577611301","cobylucas5020@icloud.org","563-3910 Lorem St.",12868),
  ("Martin Steele","0581511271","martinsteele@gmail.net","Ap #601-6713 Ultricies St.",59879),
  ("Aurelia Jones","0581645244","aureliajones@google.ca","6819 Suspendisse Rd.",76431),
  ("Gannon Fowler","0523780729","gannonfowler657@gmail.ca","P.O. Box 212, 5984 Facilisis Rd.",24074),
  ("Winifred Middleton","0521416012","winifredmiddleton7158@google.org","248-3480 Massa Av.",54388);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Ali Kinney","0527924428","alikinney@icloud.ca","P.O. Box 733, 7340 Pretium Rd.",29059),
  ("Derek Glenn","0567423135","derekglenn1767@yahoo.couk","Ap #915-4881 Vestibulum. Av.",81225),
  ("Dante Miller","0586543307","dantemiller9742@icloud.edu","Ap #712-9691 Mattis Street",71087),
  ("Orlando Snow","0525176883","orlandosnow@aol.com","491 Risus. Road",98092),
  ("Hayden O'brien","0504121848","haydenobrien@icloud.org","P.O. Box 911, 4205 Sem St.",39545),
  ("Demetria Kramer","0553527893","demetriakramer@yahoo.ca","P.O. Box 955, 6085 Tortor. Avenue",15467),
  ("Wayne Clements","0574209556","wayneclements8167@gmail.com","764-9511 Risus Road",44982),
  ("Austin Mays","0563208421","austinmays9567@gmail.org","Ap #881-9015 Erat Street",42001),
  ("Susan Clark","0579162086","susanclark7434@yahoo.couk","P.O. Box 393, 3209 Eu, Rd.",78331),
  ("Rajah Soto","0577018837","rajahsoto@google.net","P.O. Box 255, 4716 Tempus, Av.",98698);
INSERT INTO `myTable` (`SNAME`,`SMOBILE`,`SMAIL`,`SADDRESS`,`SID`)
VALUES
  ("Craig Finley","0594450237","craigfinley@yahoo.edu","Ap #914-2698 Integer Rd.",56068),
  ("Whitney Daniels","0576091154","whitneydaniels@yahoo.edu","Ap #654-2645 Penatibus Street",26605),
  ("Jaime Salas","0583882828","jaimesalas9814@gmail.com","Ap #237-775 Porta Av.",21121),
  ("Ria Olsen","0560858984","riaolsen8796@icloud.net","Ap #182-7316 Morbi Rd.",37421),
  ("Moses Britt","0536796921","mosesbritt@aol.net","Ap #351-5489 At, St.",60245),
  ("Shannon Harrell","0544986078","shannonharrell@aol.edu","P.O. Box 488, 1215 Ante Ave",84577),
  ("Kessie Murray","0511824487","kessiemurray9952@google.ca","Ap #451-163 Aliquam St.",77022),
  ("Garrison Rios","0554579757","garrisonrios6813@google.edu","255 Netus Avenue",25363),
  ("Maggie Nieves","0528582436","maggienieves7156@gmail.net","Ap #748-6164 Vel, Rd.",63601),
  ("Montana Tanner","0574097612","montanatanner570@aol.org","461-1605 Urna, Ave",29591);

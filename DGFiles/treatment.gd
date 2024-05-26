
[General]
Version=1

[Preferences]
Username=
Password=2532
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=MATERIAL
Count=400

[Record]
Name=MID
Type=NUMBER
Size=5
Data=[11111]
Master=

[Record]
Name=MNAME
Type=VARCHAR2
Size=15
Data=LIst('Antibiotic','Anestethic','Pills','Ointment','Septanest') +' '+ [ Aaaaaa]
Master=

[Record]
Name=AMOUNT
Type=NUMBER
Size=5
Data=Random(1,250)
Master=


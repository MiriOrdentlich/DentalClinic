
[General]
Version=1

[Preferences]
Username=
Password=2528
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=OMAKEA
Count=400

[Record]
Name=APPOINTMENTID
Type=NUMBER
Size=5
Data=List(select APPOINTMENTID from APPOINTMENT)
Master=

[Record]
Name=SID
Type=NUMBER
Size=5
Data=List(select SID from office)
Master=


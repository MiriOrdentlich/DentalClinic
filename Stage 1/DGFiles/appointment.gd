
[General]
Version=1

[Preferences]
Username=
Password=2593
Database=
DateFormat=dd.mm.yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=APPOINTMENT
Count=400

[Record]
Name=ADATE
Type=DATE
Size=
Data=Random(01/01/2024, 01/01/2030)
Master=

[Record]
Name=APPOINTMENTID
Type=NUMBER
Size=7
Data=[11111]
Master=

[Record]
Name=SID
Type=NUMBER
Size=5
Data=List(select SID from doctor)
Master=

[Record]
Name=CID
Type=NUMBER
Size=5
Data=List(select CID from patient)
Master=



[General]
Version=1

[Preferences]
Username=
Password=2293
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=TPREFORMEDINA
Count=400

[Record]
Name=TID
Type=NUMBER
Size=5
Data=List( Select TID from treatment)
Master=

[Record]
Name=APPOINTMENTID
Type=NUMBER
Size=5
Data=List(Select APPOINTMENTID from APPOINTMENT)
Master=


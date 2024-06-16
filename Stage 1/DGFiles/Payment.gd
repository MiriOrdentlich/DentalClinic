
[General]
Version=1

[Preferences]
Username=
Password=2072
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=PAYMENT
Count=10..20

[Record]
Name=ID
Type=NUMBER
Size=5
Data=[11111]
Master=

[Record]
Name=TOTALPRICE
Type=NUMBER
Size=10
Data=Random(150,2500)
Master=

[Record]
Name=PDATE
Type=DATE
Size=
Data=Random(01/01/2024, 01/01/2030)
Master=

[Record]
Name=APPOINTMENTID
Type=NUMBER
Size=5
Data=List(select APPOINTMENTID from APPOINTMENT)
Master=


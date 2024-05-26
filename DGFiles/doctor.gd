
[General]
Version=1

[Preferences]
Username=
Password=2951
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DOCTOR
Count=200

[Record]
Name=LICENSE
Type=VARCHAR2
Size=15
Data=[A000000]
Master=

[Record]
Name=SPECIALTIES
Type=VARCHAR2
Size=15
Data=List('Dentist','Cosmetic',Orthodontist')
Master=

[Record]
Name=SID
Type=NUMBER
Size=5
Data=List(select SID from STAFF)
Master=


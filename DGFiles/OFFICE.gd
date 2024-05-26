
[General]
Version=1

[Preferences]
Username=
Password=2549
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=OFFICE
Count=400

[Record]
Name=OTYPE
Type=VARCHAR2
Size=15
Data=LIst('Shift Manager','Sales Secretariat','Counter','Customer Service','IT')
Master=

[Record]
Name=SID
Type=NUMBER
Size=5
Data=List(Select SID from staff)
Master=



[General]
Version=1

[Preferences]
Username=
Password=2738
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=MUSEDINT
Count=400

[Record]
Name=TID
Type=NUMBER
Size=5
Data=List( Select TID from treatment)
Master=

[Record]
Name=MID
Type=NUMBER
Size=5
Data=List(Select Mid from Material)
Master=


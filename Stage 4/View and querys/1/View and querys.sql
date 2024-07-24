CREATE OR REPLACE VIEW ClassDetailedOverview AS
SELECT 
    l.Lesson_ID AS LessonNumber,
    subj.Subject_Name AS LessonName,
    l.Lesson_Day AS DayOfWeek,
    l.Lesson_Hour AS Time,
    lst.sname AS TeacherName,
    c.Class_ID,
    COUNT(s.cid) AS NumberStudents
FROM 
    Class_ c
LEFT JOIN Room r ON c.Room_ID = r.Room_ID
LEFT JOIN Lesson l ON c.Class_ID = l.Class_ID
LEFT JOIN Subject subj ON l.Subject_ID = subj.Subject_ID
LEFT JOIN Teacher lt ON l.Teacher_ID = lt.SID
LEFT JOIN Staff lst ON lt.SID = lst.sId
LEFT JOIN Student s ON c.Class_ID = s.Class_ID
GROUP BY 
    l.Lesson_ID,
    subj.Subject_Name,
    l.Lesson_Day,
    l.Lesson_Hour,
    lst.sname,
    c.Class_ID;

SELECT * FROM ClassDetailedOverview;


SELECT 
    TeacherName,
    COUNT(DISTINCT LessonNumber) AS NumOfLessonsPerWeek,
    COUNT(DISTINCT LessonName) AS NumOfDifferentSubjects,
    AVG(NumberStudents) AS AverageStudentsPerLesson
FROM 
    ClassDetailedOverview
GROUP BY 
    TeacherName
ORDER BY 
    NumOfLessonsPerWeek DESC, 
    NumOfDifferentSubjects DESC;


WITH RankedLessons AS (
    SELECT 
        LessonNumber,
        LessonName,
        DayOfWeek,
        Time,
        TeacherName,
        NumberStudents,
        ROW_NUMBER() OVER (PARTITION BY DayOfWeek ORDER BY NumberStudents DESC) AS rn
    FROM 
        ClassDetailedOverview
)
SELECT 
    DayOfWeek,
    LessonNumber,
    LessonName,
    Time,
    TeacherName,
    NumberStudents
FROM 
    RankedLessons
WHERE 
    rn = 1;

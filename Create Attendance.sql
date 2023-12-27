DECLARE @start_lessons_id BIGINT = 
(
SELECT MIN(lesson_id) 
FROM Schedule, Disciplines, Groups 
WHERE group_name = 'PD_212' 
AND discipline_name LIKE '%MySQL%'
AND discipline = discipline_id
AND spent = 1
)

DECLARE @end_lessons_id BIGINT = 
(
SELECT MAX(lesson_id) 
FROM Schedule, Disciplines, Groups 
WHERE group_name = 'PD_212' 
AND discipline_name LIKE '%MySQL%'
AND discipline = discipline_id
AND spent = 1
)

DECLARE @lesson_id BIGINT = @start_lessons_id
DECLARE @iterator INT = 1
WHILE (@lesson_id <= @end_lessons_id)
BEGIN
	WHILE (@iterator <= (SELECT COUNT (stud_id) FROM Students JOIN Groups ON [group] = group_id WHERE group_name = 'PD_212'))
	BEGIN
		DECLARE @id INT = (SELECT MAX(stud_id) FROM (SELECT TOP (@iterator) Students.stud_id FROM Students, Groups WHERE [group]=group_id AND group_name = 'PD_212') Students)
		INSERT INTO Attendance(stud_id, lessons_id, present)
		VALUES (@id, @lesson_id, (SELECT ROUND(RAND(@iterator+@lesson_id*1000000), 0)))
		SET @iterator += 1
	END
SET @iterator = 1
SET @lesson_id += 1
END
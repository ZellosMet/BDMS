USE PD_212

DECLARE @student			INT			= (SELECT ROUND(RAND()*(23-4)+4, 0))
DECLARE @lesson				BIGINT		= (SELECT ROUND(RAND()*(338271-338202)+338202, 0))
DECLARE @grade_1			TINYINT		= (SELECT ROUND(RAND()*(12-1)+1, 0))
DECLARE @grade_2			TINYINT		= (SELECT ROUND(RAND()*(12-1)+1, 0))
DECLARE @counter			TINYINT		= 0

WHILE(@counter<11)
BEGIN
	
	IF	(SELECT COUNT(*) FROM Grades WHERE stud_id = @student AND lesson_id = @lesson) = 0
	BEGIN
		INSERT INTO Grades(stud_id, lesson_id, grade_1, grade_2)
		VALUES (@student, @lesson, @grade_1, @grade_2);
	END
	SET @student = (SELECT ROUND(RAND()*(23-3)+3, 0))
	SET @lesson	= (SELECT ROUND(RAND()*(338271-338202)+338202, 0))
	SET @grade_1 = (SELECT ROUND(RAND()*(12-1)+1, 0))
	SET @grade_2 = (SELECT ROUND(RAND()*(12-1)+1, 0))

	SET @counter = @counter + 1;
	PRINT @lesson
	PRINT @student
END
--SELECT ROUND(RAND()*(338271-200)+200, 0)
SELECT 
		[Студент] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Дисциплина] = Grades.lesson_id,
		[Оценка 1] = Grades.grade_1,
		[Оценка 2] = Grades.grade_2
FROM Grades, Students, Schedule
WHERE 
	Grades.stud_id = Students.stud_id
AND Grades.lesson_id = Schedule.lesson_id
ORDER BY [Дисциплина]
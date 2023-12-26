USE PD_212

DECLARE @student			INT			= (SELECT ROUND(RAND()*(23-4)+4, 0))
DECLARE @lesson				BIGINT		= (SELECT ROUND(RAND()*(1257-1162)+1162, 0))
DECLARE @grade_1			TINYINT		= (SELECT ROUND(RAND()*(12-1)+1, 0))
DECLARE @grade_2			TINYINT		= (SELECT ROUND(RAND()*(12-1)+1, 0))
DECLARE @counter			TINYINT		= 0

WHILE(@counter < 48)
BEGIN	
	IF	(SELECT COUNT(*) FROM Grades WHERE stud_id = @student AND lesson_id = @lesson) = 0
	BEGIN
		INSERT INTO Grades(stud_id, lesson_id, grade_1, grade_2)
		VALUES (@student, @lesson, @grade_1, @grade_2);
	END
	SET @student = (SELECT ROUND(RAND()*(23-3)+3, 0))
	SET @lesson	= (SELECT ROUND(RAND()*(1257-1162)+1162, 0))
	SET @grade_1 = (SELECT ROUND(RAND()*(12-1)+1, 0))
	SET @grade_2 = (SELECT ROUND(RAND()*(12-1)+1, 0))

	SET @counter += 1;
	PRINT @lesson
	PRINT @student
END

SET @counter = 0;
SET @lesson	= (SELECT ROUND(RAND()*(1517-1494)+1494, 0))

WHILE(@counter<11)
BEGIN	
	IF	(SELECT COUNT(*) FROM Grades WHERE stud_id = @student AND lesson_id = @lesson) = 0
	BEGIN
		INSERT INTO Grades(stud_id, lesson_id, grade_1, grade_2)
		VALUES (@student, @lesson, @grade_1, @grade_2);
	END
	SET @student = (SELECT ROUND(RAND()*(23-3)+3, 0))
	SET @lesson	= (SELECT ROUND(RAND()*(1517-1494)+1494, 0))
	SET @grade_1 = (SELECT ROUND(RAND()*(12-1)+1, 0))
	SET @grade_2 = (SELECT ROUND(RAND()*(12-1)+1, 0))

	SET @counter += 1;
	PRINT @lesson
	PRINT @student
END

SET @counter = 0;
SET @lesson	= (SELECT ROUND(RAND()*(2769-2598)+2598, 0))

WHILE(@counter<82)
BEGIN	
	IF	(SELECT COUNT(*) FROM Grades WHERE stud_id = @student AND lesson_id = @lesson) = 0
	BEGIN
		INSERT INTO Grades(stud_id, lesson_id, grade_1, grade_2)
		VALUES (@student, @lesson, @grade_1, @grade_2);
	END
	SET @student = (SELECT ROUND(RAND()*(23-3)+3, 0))
	SET @lesson	= (SELECT ROUND(RAND()*(2769-2598)+2598, 0))
	SET @grade_1 = (SELECT ROUND(RAND()*(12-1)+1, 0))
	SET @grade_2 = (SELECT ROUND(RAND()*(12-1)+1, 0))

	SET @counter += 1;
	PRINT @lesson
	PRINT @student
END

SELECT 
		[Студент] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Дисциплина] = Disciplines.discipline_name,
		[Дата занятия] = Schedule.[date],
		[Оценка 1] = Grades.grade_1,
		[Оценка 2] = Grades.grade_2
FROM Grades, Students, Schedule, Disciplines
WHERE 
	Grades.stud_id = Students.stud_id
AND Grades.lesson_id = Schedule.lesson_id
AND Schedule.discipline = Disciplines.discipline_id
ORDER BY [Дисциплина]
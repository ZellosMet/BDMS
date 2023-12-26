USE PD_212

DECLARE @student			INT			= 3
DECLARE @lesson				BIGINT		= 335814
DECLARE @present			TINYINT		= (SELECT ROUND(RAND()*(1-0)+0, 0))

WHILE(@lesson<=338271)
BEGIN
	WHILE(@student<=23)
	BEGIN
			INSERT INTO Attendance(stud_id, lessons_id, present)
			VALUES (@student, @lesson, @present);
			SET @student += 1;
	END
	SET @student = 3;
	SET @lesson	+= 2
	SET @present = (SELECT ROUND(RAND()*(1-0)+0, 0))
END

SET @lesson	= 202
SET @student = 3;

WHILE(@lesson<=297)
BEGIN
	WHILE(@student<=23)
	BEGIN
			INSERT INTO Attendance(stud_id, lessons_id, present)
			VALUES (@student, @lesson, @present);
			SET @student += 1;
	END
	SET @student = 3;
	SET @lesson	+= 2
	SET @present = (SELECT ROUND(RAND()*(1-0)+0, 0))
END

SELECT 
		[Студент] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Дисциплина] = Attendance.lessons_id,
		[Посещение] = IIF(Attendance.present = 1, 'Присутствовал', 'Отсутствовал')
FROM Attendance, Students, Schedule
WHERE 
	Attendance.stud_id = Students.stud_id
AND Attendance.lessons_id = Schedule.lesson_id
ORDER BY [Дисциплина]
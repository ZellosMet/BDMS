USE PD_212

DECLARE @discipline			SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '3DS Max')
DECLARE @teacher			INT			= (SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Покидюк' AND first_name LIKE 'Марина' AND middle_name LIKE 'Олеговна')
DECLARE @start_date			DATE		= '2024-01-22'
DECLARE @date				DATE		= @start_date
DECLARE @time				TIME		= '14:30'
DECLARE @group				INT			= (SELECT group_id FROM Groups WHERE group_name LIKE '%PU_211%')
DECLARE @number_of_lessons	TINYINT		= (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Maya'))
DECLARE @counter			INT			= 0
DECLARE @even_week			BIT			= 0

WHILE(@counter < @number_of_lessons)
BEGIN

	IF(@counter % 6 = 0 AND @counter <> 0)
		SET @even_week = IIF(@even_week = 0, 1, 0)

	IF (DATEPART (dw, @date) = 2 AND @counter % 2 = 0  AND @counter < (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '3DS Max')))
	BEGIN
		SET @discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '3DS Max')
		SET @teacher = (SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Козовякина' AND first_name LIKE 'Елена' AND middle_name LIKE 'Анатольевна')
	END

	IF (DATEPART (dw, @date) = 4 AND @counter % 2 = 0 AND @even_week = 1 AND @counter < (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '3DS Max')))
	BEGIN		
		SET @discipline = IIF(@discipline = 
		(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Maya'), 
		(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '3DS Max'), 
		(SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Maya'));
		SET @teacher = IIF(@teacher = 
		(SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Козовякина' AND first_name LIKE 'Елена' AND middle_name LIKE 'Анатольевна'),
		(SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Покидюк' AND first_name LIKE 'Марина' AND middle_name LIKE 'Олеговна'),
		(SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Козовякина' AND first_name LIKE 'Елена' AND middle_name LIKE 'Анатольевна'))
	END

	IF (DATEPART (dw, @date) = 6 AND @counter % 2 = 0)
	BEGIN
		SET @discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Maya')
		SET @teacher = (SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Покидюк' AND first_name LIKE 'Марина' AND middle_name LIKE 'Олеговна')
	END

	INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
	VALUES				(@discipline, @teacher, @date, @time, IIF(@date < GETDATE(),  1, 0), @group);
	SET @counter = @counter + 1;

	IF  (@counter % 2 = 0)
		SET @date = IIF(DATEPART (dw, @date) = 6,  DATEADD(dd, 3, @date), DATEADD(dd, 2, @date));
	SET @time = IIF(@time='14:30', '16:00', '14:30')	

END;

SELECT
	Disciplines.discipline_name AS 'Дисциплина',
	Groups.group_name			AS 'Группа',
	Schedule.[date]				AS 'Дата',
	Schedule.[time]				AS 'Время',
	Teachers.last_name + ' ' + Teachers.first_name + ' ' + Teachers.middle_name	As 'Преподователь',
	IIF(Schedule.spent = 1, 'Проведено', 'Запланировано') AS 'Проведено'
FROM
	Schedule, Groups, Disciplines, Teachers
WHERE 
	Schedule.discipline = Disciplines.discipline_id
AND Schedule.[group] = Groups.group_id
AND	Schedule.techer = Teachers.teacher_id;
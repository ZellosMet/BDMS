USE PD_212

DECLARE @discipline			SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Теория баз данных, программирование MySQL')
DECLARE @teacher			INT			= (SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Ковтун' AND first_name LIKE 'Олег' AND middle_name LIKE 'Анатольевич')
DECLARE @start_date			DATE		= '2023-12-01'
DECLARE @date				DATE		= @start_date
DECLARE @time				TIME		= '14:30'
DECLARE @group				INT			= (SELECT group_id FROM Groups WHERE group_name LIKE '%PD_212%')
DECLARE @number_of_lessons	TINYINT		= (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline)
DECLARE @counter			INT			= 1
DECLARE @interval			INT

WHILE(@counter < @number_of_lessons+1)
BEGIN

	INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
	VALUES				(@discipline, @teacher, @date, @time, IIF(@date < GETDATE(),  1, 0), @group);

	IF  (@counter % 2 = 0)
		SET @date = IIF(DATEPART (dw, @date) = 6,  DATEADD(dd, 3, @date), DATEADD(dd, 2, @date))
	SET @time = IIF(@time='14:30', '16:00', '14:30')	
	SET @counter = @counter + 1;

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
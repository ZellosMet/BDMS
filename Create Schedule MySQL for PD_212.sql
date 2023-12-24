USE PD_212

DECLARE @discipline			SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Разработка Windows приложений C#')
DECLARE @teacher			INT			= (SELECT teacher_id FROM Teachers WHERE last_name LIKE 'Глазунов' AND first_name LIKE 'Антон' AND middle_name LIKE 'Александрович')
DECLARE @start_date			DATE		= '2023-05-01'
DECLARE @date				DATE		= @start_date
DECLARE @time				TIME		= '18:30'
DECLARE @group				INT			= (SELECT group_id FROM Groups WHERE group_name LIKE '%PV_211%')
DECLARE @number_of_lessons	TINYINT		= (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline)
DECLARE @counter			INT			= 0

WHILE(@counter < @number_of_lessons)
BEGIN

	INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
	VALUES				(@discipline, @teacher, @date, @time, IIF(@date < GETDATE(),  1, 0), @group);
	SET @counter = @counter + 1;

	IF  (@counter % 2 = 0 )
		SET @date = IIF(DATEPART (dw, @date) = 6,  DATEADD(dd, 3, @date), DATEADD(dd, 2, @date))
	SET @time = IIF(@time='18:30', '20:00', '18:30')	

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
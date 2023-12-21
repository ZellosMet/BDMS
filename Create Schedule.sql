
DECLARE @discipline			SMALLINT	= (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE '%Java')
DECLARE @teacher			INT			= 1
DECLARE @start_date			DATE		= '2023-06-27'
DECLARE @date				DATE		= @start_date
DECLARE @time				TIME		= '18:30'
DECLARE @group				INT			= (SELECT group_id FROM Groups WHERE group_name LIKE '%Java_326%')
DECLARE @number_of_lessons	TINYINT		= (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline)
DECLARE @counter			INT			= 0
DECLARE @interval			INT			= 2

WHILE(@counter < @number_of_lessons)
BEGIN

	INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
	VALUES				(@discipline, @teacher, @date, @time, IIF(@date < GETDATE(),  1, 0), @group);
	SET @counter = @counter + 1;

	INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
	VALUES				(@discipline, @teacher, @date, DATEADD(mi, 90, CONVERT(TIME, @time)), IIF(@date < GETDATE(),  1, 0), @group);
	SET @counter = @counter + 1;

	--SET	@date = @date + @interval
	SET @date = DATEADD(dd, @interval, @date)
	SET	@interval = IIF(@interval = 2, 5, 2)

END

--INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group] )
--VALUES 

SELECT
	Disciplines.discipline_name AS 'Дисциплина',
	Groups.group_name			AS 'Группа',
	Schedule.[date]				AS 'Дата',
	Schedule.[time]				AS 'Время',
	Teachers.last_name + ' ' + Teachers.first_name + ' ' + Teachers.middle_name	As 'Преподователь'
FROM
	Schedule, Groups, Disciplines, Teachers
WHERE 
	Schedule.discipline = Disciplines.discipline_id
AND Schedule.[group] = Groups.group_id
AND	Schedule.techer = Teachers.teacher_id;

--SELECT * FROM Disciplines WHERE discipline_name LIKE '%Java%';
--SELECT * FROM Disciplines WHERE CONTAINS(discipline_name, 'Java')
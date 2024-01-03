CREATE PROC dbo.AddAttendance
@group_name		NVARCHAR(50),
@disipline		NVARCHAR(50),
@teacher		INT,
@start_date		DATE,
@time			TIME
AS
BEGIN
	DECLARE @discipline_id		SMALLINT = (SELECT PD_212.dbo.Disciplines.discipline_id FROM PD_212.dbo.Disciplines WHERE discipline_name LIKE @disipline)
	DECLARE @teacher_id			INT		 = 1
	DECLARE @group_id			INT		 = (SELECT PD_212.dbo.Groups.group_id FROM PD_212.dbo.Groups WHERE group_name=@group_name)
	DECLARE @date				DATE	 = @start_date
	DECLARE @interval			INT		 = 2
	DECLARE @number_of_lessons	TINYINT	 = (SELECT PD_212.dbo.Disciplines.number_of_lessons FROM PD_212.dbo.Disciplines WHERE discipline_id = @discipline_id);

	DECLARE @counter			INT		 = 0

	WHILE @counter < @number_of_lessons
	BEGIN
		IF	(
		SELECT COUNT(*) 
		FROM PD_212.dbo.Schedule 
		WHERE [group] = @group_id AND discipline = @discipline_id AND [date] = @date AND [time] = @time
		) = 0
		BEGIN
			INSERT INTO PD_212.dbo.Schedule(discipline, techer, [date], [time], spent, [group])
			VALUES		(@discipline_id, @teacher_id, @date, @time, IIF(@date < GETDATE(), 1, 0), @group_id);
		END
		SET			@counter = @counter + 1;

		IF	(
		SELECT COUNT(*) 
		FROM PD_212.dbo.Schedule 
		WHERE [group] = @group_id AND discipline = @discipline_id AND [date] = @date AND [time] = DATEADD(mi, 90, CONVERT(TIME, @time))
		) = 0
		BEGIN
			INSERT INTO PD_212.dbo.Schedule(discipline, techer, [date], [time], spent, [group])
			VALUES				(@discipline_id, @teacher_id, @date, DATEADD(mi, 90, CONVERT(TIME, @time)), IIF(@date < GETDATE(), 1, 0), @group_id);
		END
		SET			@counter = @counter + 1;
		SET			@date = DATEADD(dd, @interval, @date);
		SET			@interval = IIF(@interval = 2, 5, 2)

	END
END
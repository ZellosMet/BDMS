USE [PD_212]
GO
/****** Object:  StoredProcedure [dbo].[FillAttendance]    Script Date: 28.12.2023 18:48:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FillAttendance] AS
BEGIN
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
	DECLARE @id INT
	DECLARE @is_present BIT = ROUND(RAND((@iterator+@lesson_id)*1000000),0)
	WHILE (@lesson_id <= @end_lessons_id)
	BEGIN
		WHILE (@iterator <= (SELECT COUNT (stud_id) FROM Students JOIN Groups ON [group] = group_id WHERE group_name = 'PD_212'))
		BEGIN
			SET @id = (SELECT MAX(stud_id) FROM (SELECT TOP (@iterator) Students.stud_id FROM Students, Groups WHERE [group]=group_id AND group_name = 'PD_212') Students)
			SET  @is_present = ROUND(RAND((@iterator+@lesson_id)*1000000),0)
			IF
			(
				@id = (SELECT Students.stud_id FROM Students WHERE last_name LIKE 'Сивков' AND first_name LIKE 'Никита' AND middle_name LIKE 'Сергеевич')
			OR	@id = (SELECT Students.stud_id FROM Students WHERE last_name LIKE 'Тарлавина' AND first_name LIKE 'Мария' AND middle_name LIKE 'Александровна')
			)
				SET  @is_present = 1
			IF(@id = (SELECT Students.stud_id FROM Students WHERE last_name LIKE 'Шуников' AND first_name LIKE 'Ярослав' AND middle_name LIKE 'Андреевич'))	
				SET @is_present = 0		
			INSERT INTO Attendance(stud_id, lessons_id, present)
			VALUES (@id, @lesson_id, @is_present)
			SET @iterator += 1
		END
	SET @iterator = 1
	SET @lesson_id += 1
	END
END;
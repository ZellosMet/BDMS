CREATE PROC dbo.AddGrades
@group_name		NVARCHAR(50),
@disipline		NVARCHAR(50),
@teacher		INT,
@start_date		DATE,
@time			TIME
AS
BEGIN
DECLARE @start_lessons_id BIGINT = 
	(
	SELECT MIN(lesson_id) 
	FROM Schedule, Disciplines, Groups 
	WHERE group_name = @group_name
	AND discipline_name LIKE @disipline
	AND discipline = discipline_id
	)
	
	DECLARE @end_lessons_id BIGINT = 
	(
	SELECT MAX(lesson_id) 
	FROM Schedule, Disciplines, Groups 
	WHERE group_name = @group_name 
	AND discipline_name LIKE @disipline
	AND discipline = discipline_id
	)
	
	DECLARE @lesson_id BIGINT = @start_lessons_id
	DECLARE @rand_stud_id INT
	DECLARE @id INT
	DECLARE @grade_1 TINYINT
	DECLARE @grade_2 TINYINT

	WHILE (@lesson_id <= @end_lessons_id)
	BEGIN		
		SET @id = (SELECT MAX(stud_id) FROM (SELECT TOP (CONVERT(INT, (SELECT ROUND(RAND()*(7-1)+1, 0)))) Students.stud_id FROM Students, Groups WHERE [group]=group_id AND group_name = @group_name) Students)
		SET @grade_1 = (SELECT ROUND(RAND()*(20-1)+1, 0))
		IF(@grade_1 > 12)
			SET @grade_1 = NULL
		IF(@grade_1 IS NOT NULL)
		BEGIN
			SET @grade_2 = (SELECT ROUND(RAND()*(20-1)+1, 0))
			IF(@grade_2 > 12)
				SET @grade_2 = NULL
		END
		INSERT INTO Grades(stud_id, lesson_id, grade_1, grade_2)
		VALUES (@id, @lesson_id, @grade_1, @grade_2)
	SET @lesson_id += 1
	SET @grade_2 = NULL
	END
END
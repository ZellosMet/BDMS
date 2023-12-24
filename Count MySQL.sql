USE PD_212

DECLARE @scheduled_lessons	SMALLINT;
DECLARE @conducted_lessons	SMALLINT =  
(SELECT COUNT(*) 
	FROM
		Schedule, Groups, Disciplines, Teachers
	WHERE
		Schedule.discipline = Disciplines.discipline_id
	AND Schedule.[group] = Groups.group_id
	AND Schedule.techer = Teachers.teacher_id
	AND Schedule.discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Теория баз данных, программирование MySQL')
	AND Schedule.spent = 1
)
DECLARE @all_lessons		SMALLINT =  
(SELECT COUNT(*) 
	FROM
		Schedule, Groups, Disciplines, Teachers
	WHERE
		Schedule.discipline = Disciplines.discipline_id
	AND Schedule.[group] = Groups.group_id
	AND Schedule.techer = Teachers.teacher_id
	AND Schedule.discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Теория баз данных, программирование MySQL')
)
SET @scheduled_lessons = @all_lessons - @conducted_lessons;

PRINT 'Занятия по MySQL за декабрь 2023:'
PRINT 'Всего занятий ' + CONVERT(varchar, @all_lessons);
PRINT 'Проведённых занятий ' + CONVERT(varchar, @conducted_lessons);
PRINT 'Запланированных занятий ' + CONVERT(varchar, @scheduled_lessons);
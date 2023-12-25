SELECT 
	[Преподаватель]							= FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[Среднее количество занятий в месяц]	= COUNT(Schedule.techer)/12.0
FROM Schedule, Teachers
WHERE	Schedule.techer = Teachers.teacher_id
AND		[date] BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY Teachers.last_name, Teachers.first_name, Teachers.middle_name;
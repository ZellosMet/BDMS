SELECT
		[Преподаватель]		= FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Ставка за пару]	= FORMAT(Teachers.rate, 'C'),
		[Количество пар]	= COUNT(techer),
		[Итого]				= FORMAT(COUNT(techer)*Teachers.rate, 'C')
FROM Schedule, Teachers
WHERE Schedule.techer = Teachers.teacher_id
AND [date] BETWEEN '2023-12-01' AND '2023-12-31'
GROUP BY last_name, first_name, middle_name, rate
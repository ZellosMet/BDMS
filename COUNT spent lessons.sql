SELECT 
	[Дисциплина]							= Disciplines.discipline_name,
	[Количество занятий]					= COUNT(discipline),
	[Количество проведённых занятий]		= SUM(CASE WHEN spent = 1 THEN 1 ELSE 0 END),
	[Количество запланированных занятий]	= SUM(CASE WHEN spent = 0 THEN 1 ELSE 0 END)
FROM Schedule, Disciplines
WHERE 
	Schedule.discipline = Disciplines.discipline_id
GROUP BY Disciplines.discipline_name;
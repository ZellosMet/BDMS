﻿SELECT 
	last_name AS 'Фамилия', 
	first_name AS 'Имя', 
	middle_name AS 'Отчество', 
	--DATEDIFF(yyyy, Students.birth_date, GETDATE()) AS 'Возраст',
	--GETDATE() - CONVERT(datetime, Students.birth_date) AS 'Возраст',
	group_name AS 'Группа'
	--direction_name AS 'Направление'
FROM Students, Groups, Directions
WHERE Students.[group] = Groups.group_id
--AND Groups.group_name = 'PD_212';
AND Groups.direction = Directions.direction_id
--AND Directions.direction_name = 'Java Development'
AND Directions.direction_name = 'Разработка программного обеспечения'
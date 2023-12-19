USE PD_212
DECLARE @age TINYINT;

SELECT 
	last_name AS 'Фамилия', 
	first_name AS 'Имя', 
	middle_name AS 'Отчество', 

	DATEDIFF(hour, Students.birth_date, GETDATE())/8766 AS 'Возраст',
	-- age = DATEDIFF(hour, Students.birth_date, GETDATE())/8766,

	-- GETDATE() - CONVERT(datetime, Students.birth_date) AS 'Возраст',
	group_name AS 'Группа'
	-- direction_name AS 'Направление'
FROM Students, Groups, Directions
WHERE Students.[group] = Groups.group_id
-- AND Groups.group_name = 'PD_212';
AND Groups.direction = Directions.direction_id
-- AND Directions.direction_name = 'Java Development'
AND Directions.direction_name = 'Разработка программного обеспечения'
-- ORDER BY last_name DESC;

ORDER BY DATEDIFF(hour, Students.birth_date, GETDATE())/8766 ASC;
-- ORDER BY age DESC;

-- ASC - Ascendin (в порядке возрастания)
-- DESC - Descrnding (в порядке убывания)
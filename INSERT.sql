--INSERT INTO Schedule VALUES (1, 1, '2022-12-12', '14:30', 1, 3)
--INSERT INTO Schedule VALUES (55, 3, '2022-12-14', '14:30', 1, 3)
INSERT INTO Schedule(discipline, techer, [date], [time], spent, [group]) 
VALUES (1, 1, '2022-12-19', '14:30', 1, 3)

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

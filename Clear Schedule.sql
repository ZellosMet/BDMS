USE PD_212

DELETE FROM Attendance
--DELETE FROM Grades
--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Объектно-ориентированное программирование')
--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Теория баз данных, программирование MySQL')
--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Процедурное программирование на языке C++')
--DELETE FROM Schedule WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Hardware-PC')

--SELECT
--	Disciplines.discipline_name AS 'Дисциплина',
--	Groups.group_name			AS 'Группа',
--	Schedule.[date]				AS 'Дата',
--	Schedule.[time]				AS 'Время',
--	Teachers.last_name + ' ' + Teachers.first_name + ' ' + Teachers.middle_name	As 'Преподователь'
--FROM
--	Schedule, Groups, Disciplines, Teachers
--WHERE 
--	Schedule.discipline = Disciplines.discipline_id
--AND Schedule.[group] = Groups.group_id
--AND	Schedule.techer = Teachers.teacher_id;

SELECT 
		[Студент] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		[Дисциплина] = Grades.lesson_id,
		[Оценка 1] = Grades.grade_1,
		[Оценка 2] = Grades.grade_2
FROM Grades, Students, Schedule
WHERE 
	Grades.stud_id = Students.stud_id
AND	Grades.lesson_id = Schedule.lesson_id
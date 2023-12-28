SELECT	FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name) AS 'Студент',
		[Средний балл] = ROUND(CONVERT(FLOAT, (SUM(grade_1)) + CONVERT(FLOAT, SUM(grade_2)))/(COUNT(grade_1) + COUNT(grade_2)), 2)
FROM	Grades, Students
WHERE Students.stud_id = Grades.stud_id
GROUP BY Students.last_name, Students.first_name, Students.middle_name
ORDER BY [Средний балл] DESC

SELECT	FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name) AS 'Студент',
		[Процент посещаемости] = (CONVERT(FLOAT, SUM(CASE WHEN present = 1 THEN 1 ELSE 0 END))/COUNT(present))*100
FROM	Attendance, Students
WHERE Students.stud_id = Attendance.stud_id
GROUP BY Students.last_name, Students.first_name, Students.middle_name
ORDER BY [Процент посещаемости] DESC
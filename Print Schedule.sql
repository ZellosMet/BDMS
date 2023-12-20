SELECT
	Disciplines.discipline_name AS '����������',
	Groups.group_name			AS '������',
	Schedule.[date]				AS '����',
	Schedule.[time]				AS '�����',
	Teachers.last_name + ' ' + Teachers.first_name + ' ' + Teachers.middle_name	As '�������������',
	Schedule.spent AS '���������'
FROM
	Schedule, Groups, Disciplines, Teachers
WHERE 
	Schedule.discipline = Disciplines.discipline_id
AND Schedule.[group] = Groups.group_id
AND	Schedule.techer = Teachers.teacher_id;
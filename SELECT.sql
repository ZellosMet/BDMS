SELECT 
	last_name AS '�������', 
	first_name AS '���', 
	middle_name AS '��������', 
	--DATEDIFF(yyyy, Students.birth_date, GETDATE()) AS '�������',
	--GETDATE() - CONVERT(datetime, Students.birth_date) AS '�������',
	group_name AS '������'
	--direction_name AS '�����������'
FROM Students, Groups, Directions
WHERE Students.[group] = Groups.group_id
--AND Groups.group_name = 'PD_212';
AND Groups.direction = Directions.direction_id
--AND Directions.direction_name = 'Java Development'
AND Directions.direction_name = '���������� ������������ �����������'
USE PD_212

UPDATE Schedule SET [group] = (SELECT group_id FROM Groups WHERE group_name LIKE '%Java_326%') 
				WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE 'Основы программирования на языке Java');
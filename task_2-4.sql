create database Alma_Mater;
use Alma_Mater;

CREATE TABLE Groups(
	id INT NOT NULL AUTO_INCREMENT,
	group_name VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE Students(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(200) NOT NULL,
	last_name VARCHAR(200) NOT NULL,
	fk_student_group_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(fk_student_group_id) REFERENCES Groups(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
); 

CREATE TABLE Teachers(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(200) NOT NULL,
	last_name VARCHAR(200) NOT NULL,
	email VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)	
);

CREATE TABLE Courses(
	id INT NOT NULL AUTO_INCREMENT,
	course_title VARCHAR(200),
	fk_course_teacher_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(fk_course_teacher_id) REFERENCES Teachers(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Marks(
	id INT NOT NULL AUTO_INCREMENT,
	fk_mark_student_id INT NOT NULL,
	fk_mark_course_id INT NOT NULL,
	mark INT NOT NULL CHECK (mark > 0 AND mark < 6),
	markdate DATETIME NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(fk_mark_student_id) REFERENCES Students(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY(fk_mark_course_id) REFERENCES Courses(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE	
);
/*---------------------------------------------------------------------------------------------------------------------
--Написать запрос для выборки студентов у которых по курсу
--Programming оценка > 4. Отсортировать их по имени.
---------------------------------------------------------------------------------------------------------------------	*/
SELECT CONCAT(S.first_name, " ", S.last_name) AS 'Sudent',
 C.course_title AS 'Course', AVG(M.mark) AS 'Mark'
	FROM Students AS S
	INNER JOIN Marks AS M ON M.fk_mark_student_id = S.id
	INNER JOIN Courses AS C ON C.id = M.fk_mark_course_id
	WHERE C.course_title = 'Programming'
	HAVING AVG(M.mark) > 4
	ORDER BY S.first_name;
/*---------------------------------------------------------------------------------------------------------------------
--Написать запрос для выборки всех преподавателей на курсах
--которых учатся больше 2000 студентов.	
---------------------------------------------------------------------------------------------------------------------*/
SELECT CONCAT (T.first_name, T.last_name) AS 'Teacher', C.course_title AS 'Course',
 COUNT(S.last_name) AS 'Students Quantity'
	FROM Teachers AS T
	INNER JOIN Courses AS C ON C.fk_course_teacher_id = T.id
	INNER JOIN Marks AS M ON M.fk_mark_course_id = C.id
	INNER JOIN Students AS S ON S.id = M.fk_mark_student_id
	GROUP BY C.course_title
	HAVING COUNT(S.id) > 2000;
/*---------------------------------------------------------------------------------------------------------------------
--Написать запрос, который выведет список отличников,
--сгруппированных по группам.	
---------------------------------------------------------------------------------------------------------------------*/
SELECT CONCAT(S.first_name, " ", S.last_name) AS 'Sudent', G.group_name AS 'Group',
 C.course_title AS 'Course', AVG(M.mark) AS 'Mark'
	FROM Students AS S
	INNER JOIN Groups AS G ON G.id = S.fk_student_group_id
	INNER JOIN Marks AS M ON M.fk_mark_student_id = S.id
	INNER JOIN Courses AS C ON C.id = M.fk_mark_course_id
	GROUP BY S.first_name
	HAVING AVG(M.mark) > 4.5
	ORDER BY G.group_name;

use master
go
if (exists (select * from sys.databases where NAME='Alma_Mater')) drop database Alma_Mater
create database Alma_Mater
go
use Alma_Mater
go



CREATE TABLE Groups(
	id INT NOT NULL AUTO_INCREMENT,
	group_name VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)
)

go
CREATE TABLE Students(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(200) NOT NULL,
	last_name VARCHAR(200) NOT NULL,
	group_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(group_id) REFERENCES Groups(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
go 

CREATE TABLE Teachers(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(200) NOT NULL,
	last_name VARCHAR(200) NOT NULL,
	email VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)	
)
go 

CREATE TABLE Courses(
	id INT NOT NULL AUTO_INCREMENT,
	course_title VARCHAR(200),
	teacher_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(teacher_id) REFERENCES Teachers(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
go

CREATE TABLE Students_Courses(
	id INT NOT NULL AUTO_INCREMENT,
	student_id INT NOT NULL,
	course_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(student_id) REFERENCES Students(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY(course_id) REFERENCES Courses(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
go

CREATE TABLE Marks(
	id INT NOT NULL AUTO_INCREMENT,
	student_course_id INT NOT NULL,
	mark INT NOT NULL CHECK (mark > 0 AND mark < 6),
	PRIMARY KEY(id),
	FOREIGN KEY(student_course_id) REFERENCES Students_Courses(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

--requests----------------------------------------------------------------

SELECT first_name, last_name, group_name, mark
	FROM Students, Groups, Courses, Students_Courses, Marks
	WHERE 
use master
go
if (exists (select * from sys.databases where NAME='Alma_Mater')) drop database Alma_Mater
create database Alma_Mater
go
use Alma_Mater
go

CREATE TABLE Courses(
	id INT NOT NULL AUTO_INCREMENT,
	course_title VARCHAR(200),
	PRIMARY KEY(id)
)
go

CREATE TABLE Groups(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
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
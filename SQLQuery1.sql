USE Academy_DDL; 
CREATE TABLE Students
(
	student_id BIGINT PRIMARY KEY,
	last_name   VARCHAR(50) NOT NULL,
	first_name  VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50),
	birth_day INT NOT NULL,
	"group"	INT NOT NULL,
	FOREIGN KEY ("group") REFERENCES Groups("group_id")
)
CREATE TABLE  Schedule
(
	lesson_id BIGINT PRIMARY KEY,
	"date" date NOT NULL,
	"time" time(0) NOT NULL,
	"group" int NOT NULL,
	discipline smallint NOT NULL,
	teacher int NOT NULL,
	subject nvarchar(255),
	spent bit NOT NULL,
	FOREIGN KEY ("group") REFERENCES Groups("group_id")

)
CREATE TABLE Grades
(
	grade_1 tinyint,
	grade_2 tinyint,
	student_id BIGINT,
	FOREIGN KEY (student_id) REFERENCES Students(student_id),
	lesson_id BIGINT,
	FOREIGN KEY (lesson_id) REFERENCES Schedule(lesson_id)
)
create table Teachers
(
	teacer_id int primary key,
	first_name varchar(50),
	last_name varchar(50),
	surname varchar(50),
	birth_day date,
	works_since date,
	rate money
)
create table RepotsType
(
	report_id tinyint PRIMARY KEY,
	report_rype nvarchar(150) NOT NULL
)
create table Disciplines
(
	disciplin_id smallint PRIMARY KEY,
	disciplin_name	nvarchar(150) NOT NULL,
	number_of_lesson int NOT NULL,
	report_type tinyint,
	FOREIGN KEY (report_type) REFERENCES RepotsType(report_id)
)
create table DisciplinesDirectionsRelations
(
    discipline smallint,
    direction smallint,
    PRIMARY KEY (discipline, direction),
    FOREIGN KEY (discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY (direction) REFERENCES Directions(direction_id)
);
create table TeachersDisciplinesRelations
(
    discipline smallint,
    teacher int,
    PRIMARY KEY (discipline, teacher),
    FOREIGN KEY (discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY (teacher) REFERENCES Teachers(teacer_id)
);

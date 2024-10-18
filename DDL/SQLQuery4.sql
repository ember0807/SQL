USE PD_311_DDL; 
/*CREATE TABLE RepotsTypes
(
	report_id	TINYINT	PRIMARY KEY,
	report_rype_name	NVARCHAR(50)	NOT NULL
);
CREATE TABLE Disciplines
(
	disciplin_id	SMALLINT	PRIMARY KEY,
	disciplin_name	NVARCHAR(256)	NOT NULL,
	number_of_lesson	SMALLINT	NOT NULL,
	report_type	TINYINT,
	FOREIGN KEY	(report_type)REFERENCES RepotsTypes(report_id)
);
CREATE TABLE DependetDisciplines
(
	target_discipline	SMALLINT,
	dependet_discipline	SMALLINT,
	PRIMARY KEY(target_discipline,dependet_discipline),
	FOREIGN KEY (target_discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY (dependet_discipline) REFERENCES Disciplines(disciplin_id)
);
CREATE TABLE RequiredDisciplines
(
	target_discipline	SMALLINT,
	required_discipline	SMALLINT,
	PRIMARY KEY(target_discipline,required_discipline),
	CONSTRAINT	FK_от_какой_зависит_дисциплины	FOREIGN KEY (target_discipline) REFERENCES Disciplines(disciplin_id),
    CONSTRAINT	FK_основная_дополнительная_дисциплины	FOREIGN KEY (required_discipline) REFERENCES Disciplines(disciplin_id)
);
CREATE TABLE DisciplinesDirectionsRelations
(
    discipline SMALLINT,
    direction SMALLINT,
    PRIMARY KEY (discipline, direction),
    FOREIGN KEY (discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY (direction) REFERENCES Directions(direction_id)
);
CREATE TABLE TeachersDisciplinesRelations
(
    discipline	SMALLINT,
    teacher	INT,
    PRIMARY KEY (discipline, teacher),
    FOREIGN KEY (discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY (teacher) REFERENCES Teachers(teacer_id)
);
CREATE TABLE	CompliteDisciplines
(
	"group"	INT,
	discipline	SMALLINT,
	PRIMARY KEY ("group", discipline),
	FOREIGN KEY (discipline) REFERENCES Disciplines(disciplin_id),
    FOREIGN KEY ("group") REFERENCES Groups(group_id)
);

CREATE TABLE	Schedule
(

	lesson_id BIGINT PRIMARY KEY IDENTITY(1,1),
	"date" DATE NOT NULL,
	"time" TIME(0) NOT NULL,
	"group" INT NOT NULL,
	discipline SMALLINT NOT NULL,
	teacher INT NOT NULL,
	"subject" NVARCHAR(256),
	spent BIT NOT NULL,
	FOREIGN KEY ("group") REFERENCES Groups("group_id"),
	FOREIGN KEY (discipline) REFERENCES Disciplines("disciplin_id"),
	FOREIGN KEY (teacher) REFERENCES Teachers("teacer_id")
)
CREATE TABLE Grades
(
	student		INT	NOT NULL,
	lesson		BIGINT	NOT NULL,
	PRIMARY KEY (student, lesson),
	CONSTRAINT FK_Grades_Students FOREIGN KEY (student) REFERENCES Stidents(student_id),
	CONSTRAINT FK_Grades_Schedule FOREIGN KEY (lesson) REFERENCES Schedule(lesson_id),
	grade_1		TINYINT
	CONSTRAINT CK_grade_1 CHECK (grade_1 > 0 AND grade_1 <= 12),
	grade_2		TINYINT
	CONSTRAINT CK_grade_2 CHECK (grade_2 > 0 AND grade_2 <= 12),
);
CREATE TABLE Exams
(
	student		INT	NOT NULL,
	lesson		BIGINT	NOT NULL,
	PRIMARY KEY (student, lesson),
	FOREIGN KEY (student)	REFERENCES Stidents(student_id),
	FOREIGN KEY (lesson)	REFERENCES Schedule(lesson_id),
	grade		TINYINT	CONSTRAINT CK_grade_Ex CHECK (grade > 0 AND grade <= 12)
);*/
-- заполнение базы


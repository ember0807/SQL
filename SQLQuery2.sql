USE Academy_DDL;
CREATE TABLE Grades
(
	student		BIGINT,
	lesson		BIGINT,
	PRIMARY KEY (student, lesson),
	CONSTRAINT FK_Grades_Students FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_Grades_Schedule FOREIGN KEY (lesson) REFERENCES Schedule(lesson_id),
	grade_1		TINYINT
	CONSTRAINT CK_grade_1 CHECK (grade_1 > 0 AND grade_1 <= 12),
	grade_2		TINYINT
	CONSTRAINT CK_grade_2 CHECK (grade_2 > 0 AND grade_2 <= 12),
);
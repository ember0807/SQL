USE PD_311_DDL;
GO

CREATE PROC sp_AddScheduleForBaseStacionar

@group_name				NVARCHAR(50),
@start_date				DATE,
@teacher_1_first_name	NVARCHAR(150),
@teacher_2_first_name	NVARCHAR(150)
AS
BEGIN
	DECLARE @group			INT			=	(SELECT group_id	FROM Groups WHERE group_name = @group_name);
	DECLARE @teacher_1		INT			=	(SELECT teacer_id FROM Teachers WHERE last_name = @teacher_1_first_name);
	DECLARE @teacher_2		INT			=	(SELECT teacer_id FROM Teachers WHERE last_name = @teacher_2_first_name);
	DECLARE @DATE			DATE		=	@start_date;
	DECLARE	@discipline_1	SMALLINT	=	(SELECT disciplin_id FROM Disciplines WHERE disciplin_name LIKE '%Hard%');
	DECLARE	@discipline_2	SMALLINT	=	(SELECT disciplin_id FROM Disciplines WHERE disciplin_name LIKE '%Процедурное програмирование %с++%');
	DECLARE	@num_of_les_1	SMALLINT	=	(SELECT	number_of_lesson FROM Disciplines WHERE disciplin_name LIKE '%Hard%');
	DECLARE	@num_of_les_2	SMALLINT	=	(SELECT	number_of_lesson FROM Disciplines WHERE disciplin_name LIKE '%Процедурное програмирование %с++%');

END
USE Academy_DDL; 
--������ ��� ���������� �������� ����� � ������� Schedule ���� teacher
-- �� ������� Teachers ������ ������� ���� teacer_id
ALTER TABLE Schedule
ADD CONSTRAINT teacher
FOREIGN KEY (teacher) REFERENCES Teachers(teacer_id);
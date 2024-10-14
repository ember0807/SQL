USE Academy_DDL; 
--запрос для добавления внешнего ключа в таблицу Schedule поле teacher
-- из таблицы Teachers строка внешний ключ teacer_id
ALTER TABLE Schedule
ADD CONSTRAINT teacher
FOREIGN KEY (teacher) REFERENCES Teachers(teacer_id);
-- Students_Schema.sql
--for ensa portfolio year 1

-- Create a table to store students info
CREATE TABLE students (
    id INT PRIMARY KEY , --a unique id for each student 
    name VARCHAR(100) ,
    major VARCHAR(100) ,
    year INT );

--inserting one student example
INSERT INTO students VALUES
(1 ,'Haytham' , ' Cybersecurity and AI ' , 1);


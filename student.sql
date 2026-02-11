create database collegeDb ;
use collegeDB ;
CREATE TABLE students(id int  ,
					  firstName varchar(10) ,
                      lastName varchar(10)  , 
                      city varchar(10) ,
                      email varchar(20) 
);
CREATE TABLE course(id int  ,
					  courseName varchar(10) ,
                      credt int    
);				
drop table students ;
drop table course ;
CREATE TABLE students(id int auto_increment primary key ,
					  firstName varchar(10) ,
                      lastName varchar(10)  , 
                      city varchar(10) ,
                      email varchar(50) 
);
alter table students modify email varchar(150);

CREATE TABLE course(id int auto_increment primary key ,
					  courseName varchar(10) ,
                      credt int    
);
alter table course change credt credit varchar(20);
create table enrolment( id int auto_increment primary key ,
				studentid int ,
				FOREIGN KEY (studentid) REFERENCES students(id),
                courseId int ,
                FOREIGN KEY (courseId) REFERENCES course(id)
                 
);

insert into students(firstName,lastName,city,email)values("sumit"," bhor" , "manchar", "sumitbhor227@gmail.com");
insert into students(firstName,lastName,city,email)values("parikshit"," shelorkar" , "akola", "parikshitshelorkar12@gmail.com");
insert into students(firstName,lastName,city,email)values("ashwin"," pawar" , "nashik", "pawarashwin12@gmail.com");

insert into course (id, coursename,credit)values(1,"os", 200);
insert into course (id, coursename,credit)values(2,"oop ", 200);
insert into course (id, coursename,credit)values(3,"ds", 200);


insert into enrolment ( studentid,courseId)values(1, 1);
insert into enrolment ( studentid,courseId)values(2, 1);
insert into enrolment ( studentid,courseId)values(2,2);


create database bookstore --creating database bookstore

execute sp_helpdb testdb


--execute sp_databases

--select * from sys.sysdatabases

use bookstore  --using database bookstore
------------------------------------------------------------


create table Book
(
	iBookId int primary key identity(1,1) not null,
	vcTitle varchar(30) not null,
	vcDescription varchar(50),
	smPrice smallmoney,
	ISBN varchar(13) unique,
	dPubicationDate date,
	vbImage varbinary(max)

)

execute sp_help 'Book'

-- Table book is created
------------------------------------------------------------


create table author
(
	iAuthorId int primary key identity(1,1) not null,
	vcAuthorName varchar(30),
	dDateofBirth date,
	vcCity varchar(15),
	vcState varchar(15),
	vcphone varchar(15) unique,
)

execute sp_help 'author'

-- Table author is created
-------------------------------------------------------------


create table publisher
(
	iPublishId int primary key identity(1,1) not null,
	vcPublishName varchar(20),
	dDateofBirth date,
	vcCity varchar(15),
	vcState varchar(15),
	vcphone varchar(15) unique,
)

execute sp_help 'publisher'

-- Table publisher is created
--------------------------------------------------------------


create table category
(
	iCategoryId int primary key identity(1,1) not null,
	vcCategoryname varchar(10),
	vcDescription varchar(50)
)

execute sp_help 'category'

-- Table category is created
---------------------------------------------------------------


create table Or_der
(
	iOrderId int primary key identity(1,1) not null,
	dDateofOrder date not null,
	iQuantity smallint default (1) not null ,
	vcShipAddress varchar(50) not null 
)

execute sp_help 'Or_der'


-- Table Or_der is created
----------------------------------------------------------------


create table aut_book
(
	ia_id int not null,
	ib_id int not null,
	constraint pk_aut_book primary key (ia_id,ib_id) 
)

execute sp_help 'aut_book'


-- A relational table to maintain a many to many relationship between book and author is created
-----------------------------------------------------------------

alter table aut_book
	add constraint fk_a_id foreign key(ia_id) references author(iAuthorId)
	on delete cascade on update cascade

alter table aut_book
	add constraint fk_b_id foreign key(ib_id) references Book(iBookId)
on delete cascade on update cascade
execute sp_help 'aut_book'

--Specifying integrity in table aut_book. One book can be written by many authors. One author can write many books
-------------------------------------------------------------------


alter table Or_der
	add ib_id int not null

alter table Or_der
	alter column smUnitPrice smallmoney


alter table Or_der
	add constraint fk_Or_der_b_id foreign key(ib_id) references Book(iBookId)
	on delete cascade on update cascade


--Specifying integrity between table Or_der and book. One book can be in many orders
-------------------------------------------------------------------


alter table Book
	add ibookCatId int

alter table Book
	add ibookPubId int

alter table book
add constraint f_Book_ibookCatId foreign key (ibookCatId) references category(iCategoryId)
on delete cascade on update cascade

alter table book
add constraint f_Book_ibookPubId foreign key (ibookPubId) references publisher(iPublishId)
on delete cascade on update cascade

--Specifying integrity betwwen tables Book and category, Book and publisher. Many books may belong to one category. A publisher can publish many books.
-------------------------------------------------------------------------


--exec sp_rename 'dbo.Book.bookCatId', 'ibookCatId', 'Column'

--exec sp_rename 'dbo.Book.bookPubId', 'ibookPubId', 'Column'

--------------------------------------------------------------------------

--insert into Book values('Blackberry Winter: My Earlier Years','An autobiography',500,'
--156836069',01-01-1995,

/*CREATE TABLE Employees
(
    Id int,
    Name varchar(50) not null,
    Photo varbinary(max) not null
)

INSERT INTO Employees (Id, Name, Photo) 
SELECT 10, 'John', BulkColumn 
FROM Openrowset( Bulk 'C:\Users\kalpeshbu\Pictures\photo.bmp', Single_Blob) as EmployeePicture
*/

------------------------------------------------------------------------------

insert into category
values
('Autoboigr','Life stories of famous people'),
('Fiction','based on imagination'),
('Adventure','exciting events'),
('Mystery','suspenseful events'),
('Folklores','culture of a country')

-------------------------------------------------------------------------------


insert into publisher(vcPublishName,dDateofBirth,vcCity,vcState,vcphone) 
values ('Mr.Right','19650712 10:34:09 AM','Phoenix','Arizona','(212) 514-7745'),
('Mr.Brown','19800228 10:34:09 AM','Denver','Colorado','(212) 396-9455'),
('Mr.Walson','19730910 10:34:09 AM','Chicago','Illinois','(212) 416-2555'),
('Mr.Bourne','19650305 10:34:09 AM','Boston','Massachusetts','(512) 256-2944'),
('Mr.Ronald','19810618 10:34:09 AM','New York City','New York','(662) 126-3112')

----------------------------------------------------------------------------------


insert into Book values('BlackberryWinter:Earlier Years','An autobiography',500,'
156836069','19950113 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 4, 1),

('ABC','Nice read',700,'
556376064','20000119 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 2, 3),

('XYZ','Good',300,'
131246069','20050513 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 1, 1),

('Black','story',450,'
198626069','20060824 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 3, 5),

('berry','graphical',500,'
156844449','20111020 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 5, 2),

('inter','Antony',600,'
156833655','20020216 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 2, 4),

('Winter','biological',350,'
152126069','20080125 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 3, 3),

('Earlier','Fiction',250,'
996568360','20010522 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 1, 2),

('Years','phase',600,'
226836069','19990113 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 5, 4),

('BerryWinter','An autobiography',199,'
681136069','19980413 12:55:22 AM',(select * from openrowset
(Bulk 'C:\Users\kalpeshbu\Downloads\th.jpg', Single_Blob) as book_cover) , 1, 3)


----------------------------------------------------------------------------------


insert into author(vcAuthorName,dDateofBirth,vcCity,vcState,vcphone) 
values ('Mr.Ronald','19650712 10:34:09 AM','Phoenix','Arizona','(212) 514-7745'),
('Mr.Bourne','19800228 10:34:09 AM','Denver','Colorado','(212) 396-9455'),
('Mr.Brown','19730910 10:34:09 AM','Chicago','Illinois','(212) 416-2555'),
('Mr.Walson','19650305 10:34:09 AM','Boston','Massachusetts','(512) 256-2944'),
('Mr.Right','19810618 10:34:09 AM','New York City','New York','(662) 126-3112')

----------------------------------------------------------------------------------

insert into aut_book(ia_id,ib_id)
values(1,1),(2,1),(3,2),(4,3),(2,3),(1,4),(5,5),(3,5),(4,5),(2,6),(3,7),(5,7),(1,8),(1,9),(2,9),(5,10)

----------------------------------------------------------------------------------

insert into Or_der(dDateofOrder,iQuantity,vcShipAddress,ib_id,smUnitPrice)
values('20140128 10:34:09 AM',3,'California',2,2100),
('20140818 10:34:09 AM',4,'Chicago',5,1800),
('20140612 10:34:09 AM',6,'Boston',8,1500)


-----------------------------------------------------------------------------------

select aub.ia_id,aub.ib_id,b.vcTitle
from Book as b,author as a,aut_book as aub
where aub.ia_id=1
group by b.iBookId
having aub.ib_id=b.iBookId

select b.vcTitle
from Book b
where b.iBookId in (select aub.ib_id
from aut_book as aub
where aub.ia_id = (select iAuthorId as x
from author
where vcAuthorName = 'Mr.Ronald'))



select * from aut_book
 delete from category
 where iCategoryId=5

select* from publisher
 execute sp_help Book

 delete from publisher
 where iBookId=3

 update category
 set iCategoryId=7
 where vcCategoryname='Autobiogr'
 

 DBCC CHECKIDENT (Or_der, RESEED, 0)

 select *from category
 
 delete from Or_der
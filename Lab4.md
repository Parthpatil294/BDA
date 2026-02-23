### Create a keyspace named Library
```
CREATE KEYSPACE Library
WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};
```

```
Use the keyspace:
```

```
USE Library;
```

### Create a column family (table) Library_Info
### Table 1: Student book details
```
CREATE TABLE Library_Info (
  Stud_Id int,
  Book_Id int,
  Stud_Name text,
  Book_Name text,
  Date_of_issue date,
  PRIMARY KEY (Stud_Id, Book_Id)
);
```
### Table 2: Counter table
```
CREATE TABLE Book_Counter (
  Stud_Id int,
  Book_Name text,
  issue_count counter,
  PRIMARY KEY (Stud_Id, Book_Name)
);
```

### Inserting values 
```
BEGIN BATCH
... INSERT INTO Library_Info (Stud_Id, Book_Id, Stud_Name, Book_Name, Date_of_issue)
... VALUES (112, 1, 'Rahul', 'BDA', '2026-02-10'); 
... INSERT INTO Library_Info (Stud_Id, Book_Id, Stud_Name, Book_Name, Date_of_issue)
... VALUES (112, 2, 'Rahul', 'BDA', '2026-02-12');
... APPLY BATCH;

```

```
UPDATE Book_Counter
            ... SET issue_count = issue_count + 1
            ... WHERE Stud_Id = 112 AND Book_Name = 'BDA';
UPDATE Book_Counter
            ... SET issue_count = issue_count + 1
            ... WHERE Stud_Id = 112 AND Book_Name = 'BDA';

```

### Display Table
```
SELECT * FROM Library_Info;
--------------------------output--------------------------------
stud_id | book_id | book_name | date_of_issue | stud_name
---------+---------+-----------+---------------+-----------
     112 |       1 |       BDA |    2026-02-10 |     Rahul
     112 |       2 |       BDA |    2026-02-12 |     Rahul
```

### Increase counter value:
```
UPDATE Book_Counter
SET issue_count = issue_count + 1
WHERE Stud_Id = 112 AND Book_Name = 'BDA';
```

### Display counter table:
```
SELECT * FROM Book_Counter;
```

### e). Show that student with id 112 has taken book "BDA" 2 times
```
SELECT Stud_Id, Book_Name, issue_count
            ... FROM Book_Counter
            ... WHERE Stud_Id = 112 AND Book_Name = 'BDA';
------------------------------output------------------------------------
 stud_id | book_name | issue_count
---------+-----------+-------------
     112 |       BDA |           2

```

### f) Export created column family to CSV file

```
COPY Library_Info TO 'library_info.csv';
---------------------------------------output---------------------------
Starting copy of library1.library_info with columns [stud_id, book_id, book_name, date_of_issue, stud_name].
Processed: 2 rows; Rate:      27 rows/s; Avg. rate:      27 rows/s
2 rows exported to 1 files in 0.098 seconds.


```
### g). Import CSV dataset into Cassandra column family
```
COPY Library_Info FROM 'library_info.csv';
-----------------------------------output--------------------------------------------
Starting copy of library1.library_info with columns [stud_id, book_id, book_name, date_of_issue, stud_name].
Processed: 2 rows; Rate:       4 rows/s; Avg. rate:       5 rows/s
2 rows imported from 1 files in 0.364 seconds (0 skipped).

```






















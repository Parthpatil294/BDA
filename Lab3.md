### 1. Insert 5 student documents into a collection named students with fields: rollNo, name,dept, marks, and city.
```
students> db.students.insertMany([
...   { rollNo: 101, name: "Amit", dept: "CSE", marks: 85, city: "Delhi" },
...   { rollNo: 102, name: "Neha", dept: "ECE", marks: 72, city: "Mumbai" },
...   { rollNo: 103, name: "Rahul", dept: "ISE", marks: 65, city: "Bangalore" },
...   { rollNo: 104, name: "Sneha", dept: "CSE", marks: 90, city: "Chennai" },
...   { rollNo: 105, name: "Karan", dept: "ME", marks: 35, city: "Hyderabad" }
... ])
```
### 2. Update the marks of a student whose rollNo is 101 and delete the student whose rollNo is 105.
```
db.students.updateOne(
...   { rollNo: 101 },
...   { $set: { marks: 95 } }
... )

```


### 3. Display all students from the collection and then delete all students who scored less than 40 marks
```
db.students.deleteMany({ marks: { $lt: 40 } })
{ acknowledged: true, deletedCount: 0 }
## printing them
Atlas atlas-ryqrm6-shard-0 [primary] students> db.students.find()
-------------------------output-----------------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253a"),
    rollNo: 102,
    name: 'Neha',
    dept: 'ECE',
    marks: 72,
    city: 'Mumbai'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253b"),
    rollNo: 103,
    name: 'Rahul',
    dept: 'ISE',
    marks: 65,
    city: 'Bangalore'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  }
]
```


### 4. Find students who belong to the "CSE" department and scored more than 80 marks.
```
db.students.find({
...   dept: "CSE",
...   marks: { $gt: 80 }
... })
-----------------Output-----------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  }
]

```
### 5. Find students who belong to either "CSE" or "ECE" department.
```
students> db.students.find({
...   dept: { $in: ["CSE", "ECE"] }
... })
-------------------------output---------------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253a"),
    rollNo: 102,
    name: 'Neha',
    dept: 'ECE',
    marks: 72,
    city: 'Mumbai'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  }
]
```
### 6. Display only name and marks of students whose marks are between 60 and 90.
```
db.students.find(
...   { marks: { $gte: 60, $lte: 90 } },
...   { _id: 0, name: 1, marks: 1 }
... )
-------------------output-------------------------
[
  { name: 'Neha', marks: 72 },
  { name: 'Rahul', marks: 65 },
  { name: 'Sneha', marks: 90 }
]
```
### 7. Insert a student document where the city field is null and retrieve that document.
```
db.students.insertOne({
...   rollNo: 106,
...   name: "Priya",
...   dept: "ISE",
...   marks: 78,
...   city: null
... })
{
  acknowledged: true,
  insertedId: ObjectId("6992e068894303fb2f93fb52")
}
Atlas atlas-ryqrm6-shard-0 [primary] students> db.students.find({ city: null })
[
  {
    _id: ObjectId("6992e068894303fb2f93fb52"),
    rollNo: 106,
    name: 'Priya',
    dept: 'ISE',
    marks: 78,
    city: null
  }
]
```
### 8. Find all students where the city field does not exist.
```
db.students.find({ city: { $exists: false } })
```
### 9. Update all students whose city is null and set it to "Unknown".
```
db.students.updateMany(
...   { city: null },
...   { $set: { city: "Unknown" } }
... )
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```
### 10. Count the total number of students in the collection.
```
db.students.countDocuments()
-----------------------output-------------------------------
5
```
### 11. Count the number of students in the "ISE" department.
```
db.students.countDocuments({dept:"ISE"})
-------------------output-----------------------------------
2
```
### 12. Count the number of students who scored more than 75 marks.
```
db.students.find({marks:{$gt:75}})
---------------------------------output-----------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  },
  {
    _id: ObjectId("6992e068894303fb2f93fb52"),
    rollNo: 106,
    name: 'Priya',
    dept: 'ISE',
    marks: 78,
    city: 'Unknown'
  }
]

```
### 13. Display students sorted by marks in descending order.
```
db.students.find().sort({ marks: -1 })
----------------------------output---------------------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  },
  {
    _id: ObjectId("6992e068894303fb2f93fb52"),
    rollNo: 106,
    name: 'Priya',
    dept: 'ISE',
    marks: 78,
    city: 'Unknown'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253a"),
    rollNo: 102,
    name: 'Neha',
    dept: 'ECE',
    marks: 72,
    city: 'Mumbai'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253b"),
    rollNo: 103,
    name: 'Rahul',
    dept: 'ISE',
    marks: 65,
    city: 'Bangalore'
  }
]

```
### 14. Display the top 3 students with highest marks.
```
db.students.find().sort({ marks: -1 }).limit(3)
-------------------------------output-----------------------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f192539"),
    rollNo: 101,
    name: 'Amit',
    dept: 'CSE',
    marks: 95,
    city: 'Delhi'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  },
  {
    _id: ObjectId("6992e068894303fb2f93fb52"),
    rollNo: 106,
    name: 'Priya',
    dept: 'ISE',
    marks: 78,
    city: 'Unknown'
  }
]

```
### 15. Skip the first 2 records and display the next 3 records.
```
db.students.find().skip(2).limit(3)
--------------------------------------output---------------------------------------
[
  {
    _id: ObjectId("6992db31f4cbed9d9f19253b"),
    rollNo: 103,
    name: 'Rahul',
    dept: 'ISE',
    marks: 65,
    city: 'Bangalore'
  },
  {
    _id: ObjectId("6992db31f4cbed9d9f19253c"),
    rollNo: 104,
    name: 'Sneha',
    dept: 'CSE',
    marks: 90,
    city: 'Chennai'
  },
  {
    _id: ObjectId("6992e068894303fb2f93fb52"),
    rollNo: 106,
    name: 'Priya',
    dept: 'ISE',
    marks: 78,
    city: 'Unknown'
  }
]

```
### 16. Find the average marks of all students.
```
db.students.aggregate([
...   { $group: { _id: null, averageMarks: { $avg: "$marks" } } }
... ])

-----------------------------output-----------------------------
[ { _id: null, averageMarks: 80 } ]

```
### 17. Calculate total marks department-wise.
```
db.students.aggregate([
...   { $group: { _id: "$dept", totalMarks: { $sum: "$marks" } } }
... ])
---------------------------------output---------------------------
[
  { _id: 'ECE', totalMarks: 72 },
  { _id: 'CSE', totalMarks: 185 },
  { _id: 'ISE', totalMarks: 143 }
]

```
### 18. Find the maximum marks in each department.
```
db.students.aggregate([ { $group: { _id: "$dept",maxMarks: { $max: "$marks" } } }])
----------------------------output---------------------------------
[
  { _id: 'ECE', maxMarks: 72 },
  { _id: 'CSE', maxMarks: 95 },
  { _id: 'ISE', maxMarks: 78 }
]
```

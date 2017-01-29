#!/usr/bin/python
from pymongo import Connection
from bson.objectid import ObjectId

databaseName = "locql"
connection = Connection()

db = connection[databaseName]
employees = db['employees']

#person2 = { "name" : "John Doe",
#		"age" : 30, "dept": 101, "languages":["English","German","Japanese"] }
#
person1 = { 
	"name" : "Tim",
	"age" : "27" 
}
#
#print "clearing"
##employees.remove()
#
#print "saving"
#employees.save(person1)
#employees.save(person2)

#person2 = { "name" : "Tester", "dob" : "12/03/1988",
#		"age" : 25, "dept": 101 }

db.employees.update(
	{ '_id':ObjectId("58020e4ad6f45f5cfe1ca0fa") }, 
	 person1
 )

#db.employees.save({"_id":"58020e4ad6f45f5cfe1ca0fa"}, person1)

#db.employees.remove({'_id':'58020e4ad6f45f5cfe1ca0fa' })
#db.employees.remove({'_id': ObjectId("58020e4ad6f45f5cfe1ca0fb")})

#db.employees.update({"name" : "John Doe" },{$set:{'name':'New MongoDB Tutorial'}})

print "searching"
for e in employees.find():
    print e #["_id"] , e["age"], e["name"], unicode(e["languages"])

#connection.close()
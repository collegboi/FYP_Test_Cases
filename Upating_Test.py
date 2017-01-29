#!/usr/bin/python

from pymongo import Connection
from bson.objectid import ObjectId

databaseName = "locql"
connection = Connection()

db = connection[databaseName]
cars = db['car']

car1 = {
	"make" : "BMW",
	"model" : "318"
}	
#
#print "clearing"
##cars.remove()
#
print "saving"
#cars.save(car1)

#db.cars.update(
#	{ '_id':ObjectId("580247fdd6f45fb757d67755") }, 
#	 car1
# )
cars.update(
	{ 'make':'Audi' }, 
	 car1, safe=True
)


#db.employees.save({"_id":"58020e4ad6f45f5cfe1ca0fa"}, person1)

#db.employees.remove({'_id':'58020e4ad6f45f5cfe1ca0fa' })
#db.employees.remove({'_id': ObjectId("58020e4ad6f45f5cfe1ca0fb")})

print "searching"
for e in cars.find():
    print e #["_id"] , e["age"], e["name"], unicode(e["languages"])

#connection.close()
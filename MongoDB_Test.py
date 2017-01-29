#!/usr/bin/python

#from mongoengine import register_connection
#
##models.py
#from mongoengine import Document, StringField
#
#class my_col(Document):
#	field_a = StringField() 

#in your app
from mongoengine import *
db = connect('local')

#db = connection[databaseName]
#employees = db['employees']
#
#person1 = { "name" : "John Doe",
#		"age" : 25, "dept": 101, "languages":["English","German","Japanese"] }
#
#person2 = { "name" : "Jane Doe",
#		"age" : 27, "languages":["English","Spanish","French"] }
#
#
#employees.save(person1)

class Employee(Document):
	name = StringField(max_length=50)
	age = IntField(required=False)
	dob = StringField(max_length=50)
	

#john = Employee(name="John Doe", age=25, dob="12/03/1988")
#john.save()

#jane = Employee(name="Jane Doe", age=27)
#jane.save()

for e in Employee.objects.all():
	print e["id"], e["name"], e["age"], e["dob"]
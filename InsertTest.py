#!/usr/bin/python

import json
from pprint import pprint
from pymongo import Connection
from bson.objectid import ObjectId

obj = {
	"name" : "car",
	"data" : {
		"_id" : "580247f6d6f45fb748369c3c",
		"make" : "BMW",
		"model" : "520d",
		"litre" : "2.0",
		"age" : "10"
	}	
}

collection = obj['data']

databaseName = "locql"
connection = Connection()

db = connection[databaseName]
collections = db[obj["name"]]


def read_database_struct(name):
	with open('structure.json') as data_file:    
		data = json.load(data_file)
	return_table = ''
	for table in data['structure']:
		if table['name'] == name:
			return_table = table
	return return_table

def update_database(collection):
	print("updating")
	collections.update(
		{ '_id': ObjectId(collection['_id']) }, 
	 	collection
 	)
	return ""

def insert_database(collection):
	print("inserting")
	del collection['_id']
	collections.save(collection)
	return ""


def manipulate_database():
	if obj["data"]["_id"] != "":
		update_database(collection)
	else:
		insert_database(collection)

def find_all_collections(collections):
	print "searching"
	for e in collections.find():
		print e


#insert_database(collection)

update_database(collection)

#pprint(read_database_struct("car"))

find_all_collections(collections)
#newObj = [ item for item in collection if '_id' ]
#print newObj
	
'''
#pprint(read_database_struct("car"))
for table in data['structure']:
	print( table['name'] )
	print( table['fields'] )
	#for field in table['fields']:
		#print(field)
'''

connection.close()
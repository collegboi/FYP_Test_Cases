#!/usr/bin/python

from pymongo import Connection
from pymongo.objectid import ObjectId

def _byid(id):
	return ObjectId(id)

class Account(object):
	collection = Connection().testdb.accounts

	def insert(self, data):
		return self.collection.insert(data)

	def byid(self, id):
		return self.collection.find({"_id": _byid(id)})

	def update(self, id, data):
		return self.collection.update({"_id": _byid(id)}, data)

acc_data = {
	"contact_name": "Mr. X",
	"company_name": "Awesome Inc.",
}

account = Account()

# INSERT
_id = account.insert(acc_data)
print 'ID:', _id

# RETRIVE
for ac in account.byid(_id):    
	print ac["company_name"]

# UPDATE
acc_data["company_name"] = acc_data["company_name"][::-1].upper()
print account.update(_id, acc_data)

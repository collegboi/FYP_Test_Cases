#!/usr/bin/python

import json
from pprint import pprint

with open('structure.json') as data_file:    
	data = json.load(data_file)

pprint(data)

for table in data['structure']:
	print( table['name'] )
	print( table['fields'] )
	#for field in table['fields']:
		#print(field)
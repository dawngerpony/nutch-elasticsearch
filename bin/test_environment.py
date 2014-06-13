#!/usr/bin/env python
# test_environment.py
import requests
import simplejson as json

esBaseUrl = "http://localhost:9200"

response = requests.get(esBaseUrl).json()
print json.dumps(response, indent=2)


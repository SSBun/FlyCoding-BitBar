#!/usr/local/python
# -*- coding: UTF-8 -*-

import requests
import json
from pathlib import Path
import os

# Weather API infomation.
WEATHER_API = "https://www.tianqiapi.com/api"
WEATHER_API_VERSION = "v1"
APP_ID = "51129718"
APP_SECRET = "3gy7VYVQ"


def getWeather():
	cacheFileName = "weather_cache.json"
	cacheFilePath = Path(os.getcwd() + "/" + cacheFileName)
	if cacheFilePath.is_file() and False:
		print("Exist cache file")
		with open(cacheFilePath) as cacheFile:
			try:				
				data = json.load(cacheFile)
				return data
			except:
				print("Parse cache file occuring erros.")
				return {}
	params = {"appid": APP_ID, "appsecret": APP_SECRET, "version": WEATHER_API_VERSION, "city": "北京"}
	res = requests.get(WEATHER_API, params=params)
	weatherData = res.json()
#	try:
#		with open(cacheFilePath, 'w') as cacheFile:
#			json.dump(weatherData, cacheFile)
#	except:
#		print("Cache weather data occuring erros.")
	return weatherData

def main():
	try:
		weatherData = getWeather()	
		weatherData = weatherData["data"][0]
		currentTemperature = weatherData["tem"]
		minTemperature = weatherData["tem2"]
		maxTemperature = weatherData["tem1"]
		weather = weatherData["wea"]
		result = weather + "," + currentTemperature + "," + minTemperature + "," + maxTemperature
		print(result)
		return result
	except:
		return ""

if __name__ == "__main__":
	main()
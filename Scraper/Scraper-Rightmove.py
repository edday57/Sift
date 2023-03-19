import requests
from bs4 import BeautifulSoup
import json
import simplejson
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import re
import pandas as pd
from datetime import date
from datetime import datetime
from datetime import timedelta
import MongoHelper 

""" 
Properties stored in following format:
Address - Str
Price - Int
Type - Str
Bedrooms - Int
Bathrooms - Int
Size - Int (O)
Latitude - Float 
Longitude - Float
Date Added - Str 
Description - Str
Features - List of Str (O)
Let Type - Str (O)
Deposit - Int (O) 
Furnish Type - Str (O)
Images - List of Str 
Link - Str
Agent ID - Object
Floorplan - List of Str (O)
 """
df = MongoHelper.getListings()

newProperty= {"address": None, "price": None, "property_type": None, "bedrooms": None, "bathrooms": None, "sizesqft": None, "latitude": None, "longitude": None, "date_added": None, "description": None, "features": None, "let_type": None, "deposit": None, "furnish_type": None, "images": None, "link": None, "agent": None, "floorplan": None}
sampleProperty= {"address": "123 Sample Street", "price": 3400, "property_type": "Flat", "bedrooms": 3, "bathrooms": 3, "sizesqft": 2000, "latitude": 50.0, "longitude": 10.1, "date_added": None, "description": "Description here", "features": None, "let_type": "Long term", "deposit": 2000, "furnish_type": "Furnished", "images": ["link2.com/img"], "link": "rightmove.com/example", "agent": None, "floorplan": None}
latest_link = "https://www.rightmove.co.uk/properties/130814711#/?channel=RES_LET"
alldata=[]

def processLinks(propertylist):
    for link in propertylist:
        data = scrapeData(link)
        if data != None:
            MongoHelper.addListing(data)

def scrapeData(link):
    response = requests.get(link)
    soup = BeautifulSoup(response.text, 'html.parser')
    #dictionary containing all of the property data
    property_data = {"address": None, "price": None, "property_type": None, "bedrooms": None, "bathrooms": None, "sizesqft": None, "latitude": None, "longitude": None, "date_added": None, "description": None, "features": None, "let_type": None, "deposit": None, "furnish_type": None, "images": None, "link": None, "agent": None, "floorplan": None}
    #Name
    name = soup.find('h1', itemprop = "streetAddress").get_text()
    property_data["address"] = name
    #Price
    price = soup.find('div', class_ = "_1gfnqJ3Vtd1z40MlC0MzXu").find("span").get_text()
    #Format Price
    price =int(''.join(filter(str.isdigit, price)))
    property_data["price"] = price
    #Date Added
    date_add = soup.find('div', class_ = "_2nk2x6QhNB1UrxdI5KpvaF").get_text()
    #Format today/yesterday to actual date
    if "yesterday" in date_add.lower():
        today = datetime.today()
        yesterday = today - timedelta(days = 1)
        property_data["date_added"] = yesterday
    elif "Added on " in date_add:
        date_add = date_add.replace("Added on ", "")
        property_data["date_added"] = datetime.strptime(date_add, "%d/%m/%Y")
    else:
        today = datetime.today()
        property_data["date_added"] = today
    #Specs
    specifications = {}
    specification = soup.find_all('dt', class_="ZBWaPR-rIda6ikyKpB_E2")
    for specs in specification:
        #Property Type
        if specs.get_text() == "PROPERTY TYPE":
            property_type = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("dd", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
            property_data["property_type"] = property_type\
        #Bedrooms
        if specs.get_text() == "BEDROOMS":
            bedrooms = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("dd", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
            bedrooms = int(''.join(filter(str.isdigit, bedrooms)))
            property_data["bedrooms"] = bedrooms
        if specs.get_text() == "BATHROOMS":
            bathrooms = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("dd", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
            bathrooms = int(''.join(filter(str.isdigit, bathrooms)))
            property_data["bathrooms"] = bathrooms
        if specs.get_text() == "SIZE":
            size = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("dd", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
            size = int(''.join(filter(str.isdigit, size)))
            property_data["sizesqft"] = size
    #Longitude and Latitude
    script = soup.find_all('script')
    lat = re.search('"latitude":(.*?),"longitude":', script[6].text)
    long = re.search('"longitude":(.*?),"circleRadiusOnMap"', script[6].text)
    if lat != None:
        property_data["latitude"] = float(lat.group(1))
    if long != None:
        property_data["longitude"] = float(long.group(1))
    #Description
    description = soup.find('div', class_ = "STw8udCxUaBUMfOOZu0iL _3nPVwR0HZYQah5tkVJHFh5").get_text()
    property_data["description"] = description     
    #Features
    key_feat = []
    key_features = soup.find_all('li', class_ ="lIhZ24u1NHMa5Y6gDH90A")
    for feature in key_features:
        key_feat.append(feature.get_text())
    property_data["features"] = key_feat
    #Rent Details
    details = soup.find_all('div', class_="_2RnXSVJcWbWv4IpBC1Sng6")
    for detail in details:
        if detail.find("dt").get_text() == "Let type: ":
            let_type = detail.find("dd").get_text()
            property_data["let_type"] = let_type 
        if detail.find("dt").get_text() == "Deposit: ":
            deposit = detail.find("dd").get_text()
            #Format
            deposit=''.join(filter(str.isdigit, deposit))
            if deposit!= '':
                deposit = int(deposit)
            if deposit != '':
                property_data["deposit"] = deposit
        if detail.find("dt").get_text() == "Furnish type: ":
            f_type = detail.find("dd").get_text()
            property_data["furnish_type"] = f_type
    #Images
    prop_images = []
    images = soup.find_all("meta", property="og:image")
    for image in images:
        prop_images.append(image.get('content'))
    property_data["images"] = prop_images
    #Link
    property_data["link"]=link
    #Floorplan
    #floorplan https://media.rightmove.co.uk/dir/40k/39872/130273124/39872_100783005616_FLP_00_0000_max_296x197.jpeg need to remove "_max_296x197" from the string
    floorplan = soup.find("img", alt ="Floorplan")
    if floorplan is None:
        floorplan = soup.find("img", alt ="Floorplan 1")   
    if floorplan is None:
        floorplan = soup.find("img", alt ="Floorplan 2")
    if floorplan is not None:
        property_data["floorplan"] = floorplan['src'].replace('_max_296x197', '')
    #Agent Details
    agent_name = soup.find('div', class_ = "RPNfwwZBarvBLs58-mdN8").find("a").get_text()
    agent_name = agent_name.split(',')[0]
    agentId = MongoHelper.getAgent(agent_name)
    if agentId == None:
        agent_img = soup.find("a", class_="_3uq285qlcTkSZrCuXYW-zQ").find("img")['src']
        agentId = MongoHelper.createAgent(agent_name, agent_img)
    property_data["agent"]= agentId
    #check we have all nonoptional data
    if None not in (property_data["address"], property_data["price"], property_data["description"], property_data["property_type"], property_data["bedrooms"], property_data["bathrooms"], property_data["latitude"], property_data["longitude"], property_data["date_added"], property_data["images"], property_data["link"], property_data["agent"]):
        print("Scraped "+property_data["address"])
        return property_data.copy()
    else:
        print("Insufficient data for "+property_data["address"])
        return None




def propertyLinks(latest_link, maxValues):
    index = -23
    property_links = []
    foundLatest=False
    while foundLatest == False and len(property_links) != maxValues:
        print("Getting more Property Links")
        index = index+24
        url = 'https://www.rightmove.co.uk/property-to-rent/find.html?locationIdentifier=REGION%5E87490&index='+ str(index)+'&minPrice=10000&propertyTypes=detached%2Csemi-detached%2Cterraced&includeLetAgreed=false&mustHave=&dontShow=&furnishTypes=&keywords='
        #url =  'https://www.rightmove.co.uk/property-to-rent/find.html?locationIdentifier=REGION%5E85282&index='+ str(index)+'&propertyTypes=&includeLetAgreed=false&mustHave=&dontShow=&furnishTypes=&keywords='
        print(url)
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        # Find the property listings
        listings = soup.select('.l-searchResult.is-list')
        # Extract the property page link from each listing        
        for listing in listings:
            link = listing.select_one('.propertyCard-link')['href']
            link = 'https://www.rightmove.co.uk' + link
            #Check we have not already got data (could modify this to update)
            #Case for new data file
            if len(property_links) != maxValues:
                if link not in df.link.values:
                    property_links.append(link)
            else:
                foundLatest=True
    print("Latest Links Scraped")
    return property_links

def saveJson(data):
    with open('data2.json', 'w', encoding='utf-8') as f:
        f.write(simplejson.dumps(data, ignore_nan=True, indent=4))
        #json.dump(data, f, ensure_ascii=False, indent=4)

def getNewProperties(link, count):
    links=propertyLinks(link, count)
    processLinks(links)


#saveJson(property_data(propertyLinks(latest_link)))
#test2(latest_link)
#link = "https://www.rightmove.co.uk/properties/130397504#/?channel=RES_LET"
#getNewProperties(latest_link)

#getNewProperties(df.iloc[-1].link)
#scrapeData(latest_link)
#GetAgent.addListing(scrapeData(latest_link))

getNewProperties(latest_link, 100)
#url = 'https://www.rightmove.co.uk/property-to-rent/find.html?locationIdentifier=REGION%5E87490&maxPrice=80000&minBedrooms=2&propertyTypes=&includeSharedAccommodation=false&mustHave=&dontShow=&furnishTypes=&keywords='
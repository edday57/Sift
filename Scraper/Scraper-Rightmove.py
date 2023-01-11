import requests
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import json
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import re
import pandas as pd
from datetime import date
from datetime import timedelta

# Use a service account.
cred = credentials.Certificate('homeless3-firebase-adminsdk-v6ud8-acc2b83791.json')
app = firebase_admin.initialize_app(cred)
db = firestore.client()

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use the private key file of the service account directly and initialise the firestore

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
Description - Str (O)
Features - List of Str (O)
Rent Details - Dict
    -> Let Type - Str (O)
    -> Deposit - Int (O) 
    -> Furnish Type - Str (O)
    -> Min Tenancy - (O) REMOVED
    -> Let Date - Str (O) REMOVED
Images - List of Str 
Link - Str
Agent Email - Str (O)(F)
Floorplan - List of Str (O)
 """
df = pd.read_json('data.json')

newProperty= {"address": None, "price": None, "property_type": None, "bedrooms": None, "bathrooms": None, "sizesqft": None, "latitude": None, "longitude": None, "date_added": None, "description": None, "features": None, "rent_details": {"let_type": None, "deposit": None, "furnish_type": None}, "images": None, "link": None, "agent_email": None, "floorplan": None}
sampleProperty= {"address": "123 Sample Street", "price": 3400, "property_type": "Flat", "bedrooms": 3, "bathrooms": 3, "sizesqft": 2000, "latitude": 50.0, "longitude": 10.1, "date_added": None, "description": "Description here", "features": None, "rent_details": {"let_type": "Long term", "deposit": 2000, "furnish_type": "Furnished"}, "images": ["link2.com/img"], "link": "rightmove.com/example", "agent_email": None, "floorplan": None}
latest_link = "https://www.rightmove.co.uk/properties/130433402#/?channel=RES_LET"
alldata=[]
#upload data with a time stamp to find the most recent propertys
def data_upload(property_data):
    doc_ref = db.collection(u'Test 3')
    doc_ref.add({
        u'Name': property_data["Name"],
        u'Price': property_data["Price"],
        u'Date Added': property_data["Date Added"],
        u'Specifications': property_data["Specfications"],
        u'Key Features': property_data["Key Features"],
        u'Details': property_data["Details"],
        u'Description': property_data["Description"],
        u'Images': property_data["Images"],
        u'Floorplan': property_data["Floorplan"],
        u'Agent Details': property_data["Agent Details"],
        u'created': firestore.Timestamp.now()
    })

def test(link):
        # instance of Options class allows
    # us to configure Headless Chrome
    options = Options()
    
    # this parameter tells Chrome that
    # it should be run without UI (Headless)
    options.headless = True
    driver = webdriver.Chrome(options=options)
    driver.get(link)

    html = driver.page_source
    soup = BeautifulSoup(html, "html.parser")
    maplink=soup.find("img", alt ="Property location on the map")
    print(maplink['src'])



def property_data(propertylist):
    for link in propertylist:
        response = requests.get(link)
        soup = BeautifulSoup(response.text, 'html.parser')
        #dictionary containing all of the property data
        property_data = {"address": None, "price": None, "property_type": None, "bedrooms": None, "bathrooms": None, "sizesqft": None, "latitude": None, "longitude": None, "date_added": None, "description": None, "features": None, "rent_details": {"let_type": None, "deposit": None, "furnish_type": None}, "images": None, "link": None, "agent_email": None, "floorplan": None}
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
            today = date.today()
            yesterday = today - timedelta(days = 1)
            property_data["date_added"] = yesterday.strftime("%d/%m/%Y")
        elif "Added on " in date_add:
            date_add.replace("Added on ", "")
            property_data["date_added"] = date_add
        else:
            today = date.today()
            property_data["date_added"] = today.strftime("%d/%m/%Y")
        #Specs
        specifications = {}
        specification = soup.find_all('div', class_="ZBWaPR-rIda6ikyKpB_E2")
        for specs in specification:
            #Property Type
            if specs.get_text() == "PROPERTY TYPE":
                property_type = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("p", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
                property_data["property_type"] = property_type\
            #Bedrooms
            if specs.get_text() == "BEDROOMS":
                bedrooms = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("p", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
                bedrooms = int(''.join(filter(str.isdigit, bedrooms)))
                property_data["bedrooms"] = bedrooms
            if specs.get_text() == "BATHROOMS":
                bathrooms = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("p", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
                bathrooms = int(''.join(filter(str.isdigit, bathrooms)))
                property_data["bathrooms"] = bathrooms
            if specs.get_text() == "SIZE":
                size = specs.parent.parent.find("div", class_="_3ZGPwl2N1mHAJH3cbltyWn").find("p", "_1hV1kqpVceE9m-QrX_hWDN").get_text()
                size = int(''.join(filter(str.isdigit, size)))
                property_data["sizesqft"] = size
        #Longitude and Latitude
        script = soup.find_all('script')
        lat = re.search('"latitude":(.*?),"longitude":', script[6].text)
        long = re.search('"longitude":(.*?),"circleRadiusOnMap"', script[6].text)
        if lat != None:
            property_data["latitude"] = lat.group(1)
        if long != None:
            property_data["longitude"] = long.group(1)
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
        rent_details = {}
        details = soup.find_all('div', class_="_2RnXSVJcWbWv4IpBC1Sng6")
        for detail in details:
            if detail.find("dt").get_text() == "Let type: ":
                let_type = detail.find("dd").get_text()
                property_data["rent_details"]["let_type"] = let_type 
            if detail.find("dt").get_text() == "Deposit: ":
                deposit = detail.find("dd").get_text()
                #Format
                deposit=''.join(filter(str.isdigit, deposit))
                if deposit!= '':
                    deposit = int(deposit)
                if deposit != '':
                    property_data["rent_details"]["deposit"] = deposit
            if detail.find("dt").get_text() == "Furnish type: ":
                f_type = detail.find("dd").get_text()
                property_data["rent_details"]["furnish_type"] = f_type
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
        # agent_details = {}
        # agent_name = soup.find('div', class_ = "RPNfwwZBarvBLs58-mdN8").find("a").get_text()
        # print("Agent Name: " + agent_name)
        # agent_details["Name"] = agent_name
        # agent_link = soup.find('div', class_ = "RPNfwwZBarvBLs58-mdN8").find("a")['href']
        # print("agent link: " + agent_link)
        # agent_details["Link"] = agent_link
        # agent_address = soup.find('div', class_ = "OojFk4MTxFDKIfqreGNt0").get_text()
        # print("agent link: " + agent_address)
        # agent_details["Agent Adress"] = agent_address
        # agent_email = soup.find('a', class_ = "_3RZrxRVj_9Dn-Ot3w1ZjcX _2h_CLrxx_xWQuAjkQU3S12")['href']
        # agent_details["Agent Email"] = agent_email
        # agent_number = soup.find('div', class_ = "_3E1fAHUmQ27HFUFIBdrW0u")['href'].replace("https://www.rightmove.co.uk/properties/tel:", "")
        # agent_details["Agent Number"] = agent_number
        # property_data["Agent Details"] = agent_details
        
        #check we have all nonoptional data
        if None not in (property_data["address"], property_data["price"], property_data["property_type"], property_data["bedrooms"], property_data["bathrooms"], property_data["latitude"], property_data["longitude"], property_data["date_added"], property_data["images"], property_data["link"]):
            print("Added "+property_data["address"])
            alldata.append(property_data.copy())
        else:
            print("Insufficient data for "+property_data["address"])
    return alldata




def propertyLinks(latest_link, maxValues):
    index = -23
    property_links = []
    foundLatest=False
    while foundLatest == False and len(property_links) != maxValues:
        print("Getting more Property Links")
        index = index+24
        url =  'https://www.rightmove.co.uk/property-to-rent/find.html?locationIdentifier=REGION%5E87490&minBedrooms=2&maxPrice=80000&index='+str(index)+'&propertyTypes=&mustHave=&dontShow=&furnishTypes=&keywords='
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
            if 'link' not in df.columns and len(property_links) != maxValues:
                property_links.append(link)
                if link == latest_link:
                    foundLatest = True
            elif link not in df.link.values and len(property_links) != maxValues:
                property_links.append(link)
            else:
                foundLatest=True
    print("Latest Links Scraped")
    return property_links

def saveJson(data):
    with open('data.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

def getNewProperties(link):
    data=property_data(propertyLinks(link, -1))
    df_new = pd.concat([df, pd.DataFrame(alldata)], ignore_index=True)
    out =df_new.to_dict('records')
    saveJson(out)

#saveJson(property_data(propertyLinks(latest_link)))
#test2(latest_link)
#link = "https://www.rightmove.co.uk/properties/130397504#/?channel=RES_LET"

getNewProperties(df.iloc[-1].link)


#url = 'https://www.rightmove.co.uk/property-to-rent/find.html?locationIdentifier=REGION%5E87490&maxPrice=80000&minBedrooms=2&propertyTypes=&includeSharedAccommodation=false&mustHave=&dontShow=&furnishTypes=&keywords='
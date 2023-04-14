from pymongo_start_client import start_client
import certifi
from pymongo import MongoClient
import uuid
import bcrypt
import pandas as pd

# Create a connection using MongoClient. You can import MongoClient or use pymongo.MongoClient
client = start_client()
db= client.db
#db = get_database()
users = db['users']
listings=db['listings']

def getAgent(name):
    agent = users.find_one({"name": name, "isAgent": True})
    if agent == None:
        return None
    else:
        return agent['_id']

def createAgent(name, pic):
    id = str(uuid.uuid4())
    password = str(bcrypt.hashpw(id.encode('utf-8'), bcrypt.gensalt()))
    agent={
        "email": id,
        "password": password,
        "name": name,
        "signedUp": True,
        "isAgent": True,
        "listings": [],
        "image": pic
    }
    users.insert_one(agent)
    return getAgent(name)

def addListing(data):
    agent = users.find_one({"_id": data["agent"]})
    with client.start_session() as session:
        with session.start_transaction():
            result = listings.insert_one(data)
            users.find_one_and_update({'_id': data['agent']},{'$push': {'listings': result.inserted_id}})
            print(result.inserted_id)

def getListings():
    return pd.DataFrame(list(listings.find()))
    print (listingdf.head())

#print(getAgent("Foxtons", True))

def addField(name, entry):
    listings.update_many({}, {'$set': {name: entry}})

#addField("property_status", "listed")
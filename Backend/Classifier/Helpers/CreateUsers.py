from pymongo_start_client import start_client
import certifi
from pymongo import MongoClient
import uuid
import pandas as pd

# Create a connection using MongoClient. You can import MongoClient or use pymongo.MongoClient
client = start_client()
db= client.db
#db = get_database()
users = db['users']
listings=db['listings']

def getUser(name):
    user = users.find_one({"name": name})
    if user == None:
        return None
    else:
        return user['_id']

def createUser(name):
    id = str(uuid.uuid4())
    user={
        "email": id,
        "name": name,
    }
    users.insert_one(user)
    return getUser(name)


with open("users.txt", "a") as f:
    for i in range(121, 151):
        name = "RatingTestUser " +str(i)

        f.write(str(createUser(name)))
        f.write("\n")
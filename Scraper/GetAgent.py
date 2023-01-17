from pymongo_get_database import get_database
import uuid
import bcrypt
db = get_database()
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
    result = listings.insert_one(data)
    print(result.inserted_id)


#print(getAgent("Foxtons", True))
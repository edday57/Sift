from pymongo import MongoClient
import certifi
def start_client():
 
   # Provide the mongodb atlas url to connect python to mongodb using pymongo
    CONNECTION_STRING = "mongodb+srv://admin:fltHUuMl1uLNnCC9@cluster0.vxxksfc.mongodb.net/?retryWrites=true&w=majority"
 
   # Create a connection using MongoClient. You can import MongoClient or use pymongo.MongoClient
    client = MongoClient(CONNECTION_STRING, tlsCAFile=certifi.where())
   # Create the database for our example (we will use the same database throughout the tutorial
    return client
  
# This is added so that many files can reuse the function get_database()

import pandas as pd
import numpy as np
from surprise import Reader, Dataset
from surprise import SVDpp
from surprise.model_selection import train_test_split
from surprise import accuracy
from surprise.model_selection import cross_validate
from collections import defaultdict
from surprise.model_selection import train_test_split
from surprise.model_selection import KFold
import sys
#Add function for user who does not have 20+ interactions

#Load ratings - CSV or from DB
ratings_filename = './Classifier/ratings.csv'
df_ratings = pd.read_csv( ratings_filename, usecols=['userId', 'propertyId', 'rating'], dtype={'userId': 'str', 'propertyId': 'str', 'rating': 'int32'})
ratings_dict = {'propertyID': list(df_ratings.propertyId),
                'userID': list(df_ratings.userId),
                'rating': list(df_ratings.rating)}
df = pd.DataFrame(ratings_dict)

#Set scale for ratings as ratings 1-5
reader = Reader(rating_scale=(1, 5))

#Train model
data = Dataset.load_from_df(df[['userID', 'propertyID', 'rating']], reader)
algo = SVDpp()
algo.fit(data.build_full_trainset())



#Sample ID for demo purposes
user_id = '64163b1cf069a1e2d396d448'
listing_id = '64162c3b4a54c62d647acc63'
# Predict rating for user/item
#pred = algo.predict(user_id, listing_id, r_ui=0.42, verbose=False)
#print(pred.est)

#Function to calculate top recommendations
def recommender(ratings_df_in, user_id_in, algo_in):
    #Get each unique listing ID
    unique_listings = set(ratings_df_in['propertyID'])
    #Also get current session viewed
    ####### TO BE ADDED ########

    #Only recommend listings that user has not seen
    unseen_listings = unique_listings - set(ratings_df_in[ratings_df_in['userID']==user_id_in]['propertyID'])
    unseen_listings = list(unseen_listings)
    predictions = []
    #Get predicted rating for each property
    for listing in unseen_listings:
        predictions.append(algo_in.predict(user_id_in, listing, verbose=False).est)

    preds_df = pd.DataFrame({'iid': unseen_listings, 'pred_score': predictions})
    preds_df.sort_values('pred_score', ascending=False,inplace=True)
    toprated=[]
    #Get top 10 items and rating to return
    for i in range(0,10):
        toprated.append([preds_df.iloc[i].iid,round(preds_df.iloc[i].pred_score,3)])
    return toprated
    #return preds_df

user_id=sys.argv[1]

##OVERRIDE FOR TESTING
#user_id = "641638d913e3af7e2e6d16ef"
print(recommender(ratings_df_in=df, user_id_in = user_id, algo_in=algo))

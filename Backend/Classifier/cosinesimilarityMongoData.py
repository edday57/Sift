import pandas as pd
import numpy as np
from random import sample
#from sklearn.metrics.pairwise import cosine_similarity
import MongoHelper
from operator import itemgetter
import sys
import pickle

def transformer(df, feature_name):
    '''
    Params:
        df -> pandas dataframe: the original dataframe containing the categorical feature
        feature_name -> str: the categorical feature to be transformed
    Returns:
        transformed_feature -> pandas dataframe: one hot encoded feature
    '''
    transformed_feature = pd.get_dummies(df[feature_name], prefix=feature_name)
    return transformed_feature

def join(df, transformed_df):
    '''
    Params:
        df -> pandas dataframe: the original dataframe containing the categorical feature
        transformed_df -> pandas dataframe: one hot encoded dataframe
    Returns:
        joined_df -> pandas dataframe: joined dataframe of original dataframe and 
                                       the transformed dataframe on the categorical feature
    '''
    joined_df = df.join(transformed_df)
    return joined_df

def drop(df, cat_feature):
    '''
    Params:
        df -> pandas dataframe: the joined dataframe containing the categorical feature
        cat_feature -> str: the categorical feature to be dropped
    Returns:
        dropped_df -> pandas dataframe: the dataframe with the categorical feature dropped
    '''
    dropped_df = df.drop(columns=cat_feature)
    return dropped_df

def normalize(df):
    '''
    Params:
        df -> pandas dataframe: the original dataframe for recommendation
    Returns:
        normalized_df -> pandas dataframe: the dataframe with normalized 
                                           features for recommendation
    '''
    try:
        columns = list(df.columns)
        normalized_df = df
        for column in columns:
            if column != 'artificial_listing_id':
                col = df[column]
                normalized_df[column] = (col-col.min())/(col.max()-col.min())
        return normalized_df
    except ZeroDivisionError:
        return df


def calculate_cosine_similarity(listingID, df):
    '''
    A method that returns the most similar listings to the current list

    Params:
        listingID -> int: artificial_listing_id of the dataset
        df -> pandas dataframe: the dataset containing the listing data

    Return:
        The listed homes with cosine similarity scores
    '''
    # index record
    idx = indices[listingID]
    # print(indices.shape)
    # print(idx)
    # print('again')

    # fill null values with 0
    df.fillna(0, inplace=True)

    # do not include artificial listing id as a feature
    new = df.drop(columns=['artificial_listing_id', 'correlation'], errors='ignore')
    # calculate the cosine similarity matrix
    similar = cosine_similarity(new.values)

    # put the correlation back into the original dataset
    df['correlation'] = similar[idx]
    # corr_similar = pd.DataFrame(df)

    # sort the rows by the correlation score
    result = df.sort_values(by='correlation', ascending=False)

    return result
    

# store the cosine similarities into a dictionary
indices = ""
cosine_similarity_matrix_dict = {}
df= pd.DataFrame()

def calculateSimilarityMatrix():
    df = MongoHelper.getListings()
    df = df.astype({"_id": str})
    df = df.astype({"latitude": float})
    df = df.astype({"longitude": float})
    artificial_listing_id = range(len(df))
    df['artificial_listing_id'] = artificial_listing_id
    selected_features=['price', 'property_type', 'sizesqft','bedrooms','bathrooms','latitude', 'longitude', 'artificial_listing_id']
    cat_features=['property_type']
    df_for_recom= df[selected_features]
    listings_data = df_for_recom
    # join the one-hot encoded features dataframe with original one
    for feature in cat_features:
        transformed_df = transformer(listings_data, feature)
        listings_data = join(listings_data, transformed_df)
    # drop the original categorical features
    for feature in cat_features:
        listings_data = drop(listings_data, feature)
    
    listings_data = normalize(listings_data)
    global indices
    indices = pd.Series(listings_data.index, index=listings_data['artificial_listing_id'])
    df_for_recom= df[selected_features]
    listings_data = df_for_recom
    # join the one-hot encoded features dataframe with original one
    for feature in cat_features:
        transformed_df = transformer(listings_data, feature)
        listings_data = join(listings_data, transformed_df)
    # drop the original categorical features
    for feature in cat_features:
        listings_data = drop(listings_data, feature)
    
    listings_data = normalize(listings_data)
    indices = pd.Series(listings_data.index, index=listings_data['artificial_listing_id'])
    for i in range(len(listings_data)):
        similarity_dict = calculate_cosine_similarity(i, listings_data)[['correlation', 'artificial_listing_id']].set_index('artificial_listing_id')['correlation'].to_dict()
        cosine_similarity_matrix_dict[i] = similarity_dict
    with open('Classifier/similarityDict.pickle', 'wb') as handle:
        pickle.dump(cosine_similarity_matrix_dict, handle, protocol=pickle.HIGHEST_PROTOCOL)
    with open('Classifier/listingsDF.pickle', 'wb') as handle:
        pickle.dump(df, handle, protocol=pickle.HIGHEST_PROTOCOL)



def applyFilters(filters, viewed, df):
    ##Apply filtering here
    results = set(df['artificial_listing_id'])
     # if there is no filtering or there is no satisfactory results
    if len(results) == 0:
        # number of listings is 2348
        return list(range(len(df)))
    return list(results)

def mergeIds(discover, extra):
    if len(discover) == 5:
        discover.insert(extra[0], 3)
        discover.insert(extra[1], 3)
        discover.insert(extra[2], 6)
        discover.insert(extra[3], 6)
        discover.insert(extra[4], 9)
        discover.insert(extra[5], 9)
    return discover

def recommender(df, filters, liked, viewed):

    #Later need to consder if user has liked a property which isnt in matrix
    #Get df ids of liked properties 
    liked_ids = df[df['_id'].isin(liked)]['artificial_listing_id'].tolist()
    #Apply filters to df (3 beds max etc)
    filter_results = applyFilters([], [], df)
    resultScores =[]
    for result in filter_results:
        scores=[]
        for liked_id in liked_ids[:5]:
            scores.append(cosine_similarity_matrix_dict[liked_id][result])
        averageScore = np.mean(np.array(scores))
        resultScores.append([result, averageScore])
    #Sorted list of [artifical listing id, cosine similarity score]
    resultScores= sorted(resultScores, key=itemgetter(1), reverse=True)
    discoverIds=[] #Actual IDs
    chosenArtificialIds=[]
    for result in resultScores:
        resultRow = df.loc[df['artificial_listing_id']==result[0]]
        if resultRow['_id'].values[0] not in liked and resultRow['_id'].values[0] not in viewed:
            discoverIds.append(resultRow['_id'].values[0])
            chosenArtificialIds.append(result)
            if len(discoverIds) == 5:
                break
    discoverIds.append("*")
    #Add extra properties
    extraIds = []
    for result in filter_results:
        if result not in chosenArtificialIds:
            resultRow = df.loc[df['artificial_listing_id']==result]
            if resultRow['_id'].values[0] not in liked and resultRow['_id'].values[0] not in viewed:
                extraIds.append(resultRow['_id'].values[0])
                if len(extraIds) == 6:
                    break
    discoverIds.extend(extraIds)
    #discoverIds.reverse()
    #Merge extra with discover properties
    #discoverIds = mergeIds(discoverIds, extraIds)
    return discoverIds




#user inputs loose filters (max price, beds etc)
##App loads, and queries backend which finds last 3 liked properties then sends to recommender. If a property is liked in session, this is sent with subsequent get recommender requests
#look at last 5 liked properties
#for each result in query see how similar it is to last 3/5 liked properties and see average similarity to previously liked properties
#return 5 similar properties (to previous 3), show 3 first then alternate between 2 random and 1 similar till all 5 are shown. 
#if one of these is liked then fetch more and replace current stack, if not then show random properties that fit filters


#liked = ["63c8279a5b061b24d6897c5d","63c926692b65a36fbf055241"]

# - - - Uncomment to recalculate similarity dictionary (Add API or timer later)
#calculateSimilarityMatrix()
# - - - - - - - - - - - - - - - - - - - - - -  

with open('Classifier/similarityDict.pickle', 'rb') as handle:
    cosine_similarity_matrix_dict = pickle.load(handle)
with open('Classifier/listingsDF.pickle', 'rb') as handle:
    df = pickle.load(handle)
liked = sys.argv[1].split(",")
viewed=sys.argv[2]
if len(viewed)>=2:
    viewed= viewed.split(",")
else:
    viewed = []
#print(viewed)
print(recommender(df, [], liked, viewed))

#print(recommender(df, [], sys.argv[1], []))

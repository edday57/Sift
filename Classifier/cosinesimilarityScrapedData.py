import pandas as pd
import numpy as np
import ast
import json
import warnings
from random import sample
from sklearn.metrics.pairwise import cosine_similarity
df = pd.read_json('../Scraper/data.json')

selected_features=['price', 'property_type', 'sizesqft','bedrooms','bathrooms','latitude', 'longitude']
cat_features=['property_type']

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

df_for_recom= df[selected_features]
listings_data = df_for_recom
# join the one-hot encoded features dataframe with original one
for feature in cat_features:
    transformed_df = transformer(listings_data, feature)
    listings_data = join(listings_data, transformed_df)
# drop the original categorical features
for feature in cat_features:
    listings_data = drop(listings_data, feature)

artificial_listing_id = range(len(listings_data))
listings_data['artificial_listing_id'] = artificial_listing_id


listings_data = normalize(listings_data)
indices = pd.Series(listings_data.index, index=listings_data['artificial_listing_id'])

def calculate_cosine_similarity(listingID, df=listings_data):
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
    new = df.drop(columns=['artificial_listing_id'])
    # calculate the cosine similarity matrix
    similar = cosine_similarity(new.values)

    # put the correlation back into the original dataset
    df['correlation'] = similar[idx]
    # corr_similar = pd.DataFrame(df)

    # sort the rows by the correlation score
    result = df.sort_values(by='correlation', ascending=False)

    return result
    
print(calculate_cosine_similarity(1, listings_data))

# store the cosine similarities into a dictionary
cosine_similarity_matrix_dict = {}
for i in range(10):
    similarity_dict = calculate_cosine_similarity(i, listings_data)[['correlation', 'artificial_listing_id']].set_index('artificial_listing_id')['correlation'].to_dict()
    cosine_similarity_matrix_dict[i] = similarity_dict
#print(cosine_similarity_matrix_dict[3][0])
print (df.iloc[1])
print (df.iloc[238])
import pandas as pd
import numpy as np
import ast
import json
import warnings
from random import sample
from sklearn.metrics.pairwise import cosine_similarity
fields =["Address", "Price", "Latitude", "Longitude", "Beds", "Baths", "Size"]

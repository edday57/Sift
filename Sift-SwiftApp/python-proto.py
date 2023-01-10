#enter user details
from cmath import sqrt


age = int(input("Enter Age"))
locationX = int(input("Enter Prefered Location (enter a number 2 digits)"))
locationY = int(input("Enter Prefered Location (enter a number 2 digits)"))
salary = int(input("Enter your salary"))
budget = int(input("Enter your budget"))
bedrooms = int(input("Enter number of Bedrooms"))
preferences = int(input("Select Preferences"))

#information of all the houses to loop through
houseData = [{"price": 4500,
  "locationX": 23,
  "locationY": 12,
  "bedrooms": 3},
  {"price": 3700,
  "locationX": 2,
  "locationY": 1,
  "bedrooms": 3},
  {"price": 3300,
  "locationX": 13,
  "locationY": 20,
  "bedrooms": 2}
]
print(houseData[1]['price'])





#calulate individual attribute score/weightings.
noHouses = len(houseData)
rankL = []


def rank():
    i = 0
    while i < noHouses:
        ageW = ageC(i)
        print(ageW)
        
        locationW = locationC(i)   
        print(locationW)
        val = ageW + locationW
        rankL.append(val)
        i += 1

    max_item = max(rankL)
    print(f'Max index is : {rankL.index(max_item)}')
    
#in the final it will be 

def ageC(x):
    #weighting determined by existing data
    return 0.02*houseData[x]['price']+1.1

def locationC(x):
    #weighting determined by existing data or closeness geographically
    return (sqrt(((houseData[x]['locationX']-locationX)**2) + ((houseData[x]['locationY']-locationY)**2))).real

rank()


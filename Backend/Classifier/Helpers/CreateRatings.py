import random

id1 = []
with open('persona1Ids.txt') as file:
    id1 = [line.strip() for line in file.readlines()]
id2 = []
with open('persona2Ids.txt') as file:
    id2 = [line.strip() for line in file.readlines()]
id3 = []
with open('persona3Ids.txt') as file:
    id3 = [line.strip() for line in file.readlines()]
id4 = []
with open('persona4Ids.txt') as file:
    id4 = [line.strip() for line in file.readlines()]
id51 = []
with open('persona5Ids1.txt') as file:
    id51 = [line.strip() for line in file.readlines()]
id52 = []
with open('persona5Ids2.txt') as file:
    id52 = [line.strip() for line in file.readlines()]
users = []
with open('users.txt') as file:
    users = [line.strip() for line in file.readlines()] 

chosen = id4
others = []
others.extend(id1)
others.extend(id2)
others.extend(id3)
others.extend(id51)
others.extend(id52)
#30 users for each persona
with open("ratings.csv", "a") as f:
    for user in range(0, 30):
        #20 properties liked
        nums = random.sample(range(len(chosen)), 20)
        print(nums)
        #for each property id1[i], generate a rating
        for i in nums:
            property = chosen[i]
            rating = random.randint(3,5)
            f.write(users[user]+","+property+","+str(rating)+"\n")
        #20 not interested
        nums = random.sample(range(len(others)), 20)
        for i in nums:
            property = others[i]
            rating = random.randint(1,2)
            f.write(users[user]+","+property+","+str(rating)+"\n")



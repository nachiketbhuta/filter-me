import csv
import numpy as np
from random import choice, randrange

skills = []
data = [] 

with open('words.txt', 'r') as f:
    for line in f:
        words = line.split(',')

        for word in words:
            skills.append(word.lstrip())

with open("association.csv", 'w', newline='') as csv_file:
    writer = csv.writer(csv_file, delimiter=',')  

    for i in range(len(skills)):
        row = skills
        writer.writerow(row)

with open('association.csv', 'r') as f:
    reader = csv.reader(f, delimiter=',')
    writer = csv.writer(f, delimiter=',')
    for row in reader:
        for i in range(8):
            row[int(randrange(len(skills)))] = ""    
            data.append(row)

with open("filter_association.csv", 'w', newline='') as csv_file:
    writer = csv.writer(csv_file, delimiter=',')  

    for d in data:
        writer.writerow(d)


import names
import csv
from random import choice
 
skills = [] 

with open('words.txt', 'r') as f:
    for line in f:
        words = line.split(',')

        for word in words:
            skills.append(word.lstrip())

with open('data.csv', 'w', newline='\n') as f:
    writer = csv.writer(f, delimiter=',')
    for i in range(100):
        name = names.get_full_name()
        skill = []
        for j in range(5):
            tech = choice(skills) 
            if tech not in skill:
                skill.append(tech)
        row = [name, ' ,'.join(skill).lstrip('\"')]
        writer.writerow(row)
        
     
print(skills)
        
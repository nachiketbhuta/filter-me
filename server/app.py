from flask import Flask, request, jsonify, render_template


# Utils Imports
import bs4
import requests
from random import randrange, choice
import csv

from constants import SCRAPE_URL, deEmojify, SKILLS, GOVT_URL
from classification import create_profile, classifier, recommendation
from mining import mine

app = Flask(__name__, template_folder="templates")


@app.route('/test')
def test():
    # print(mine())
    # return "HELLO"
    return jsonify({ 'data' : mine() })


@app.route('/')
def hello():
    data = []
    with open("./scripts/data.csv", 'r') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            person = dict()
            person['name'] = row[0]
            person['skills'] = row[1:]
            data.append(person)
    return render_template('index.html', data=data)

@app.route('/profiles')
def getProfiles():
    data = []
    id = 1
    with open("./scripts/data.csv", 'r') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            person = dict()
            person['id'] = id
            person['name'] = row[0]
            person['skills'] = row[1:]
            person['experience'] = randrange(10)
            data.append(person)

            id += 1
    return jsonify({ 'data': data })


@app.route('/jobs', methods=['GET'])
def getJobs():
    response = requests.get(SCRAPE_URL)
    html = response.text
    # print(html)
    data = []


    # converting the html string to soup object
    soup = bs4.BeautifulSoup(html, "html.parser")
    jobs_posts = soup.select('.job-post')
    jobs_desc = soup.select('.job-desc')

    id = 1

    for i in range(len(jobs_posts)):
        company_name = jobs_posts[i].select('.job-post-item-body>div')[0].text
        company_name = str.encode(company_name)
        position = jobs_posts[i].select('.job-post-item-header>h2')[0].text
        position = str.encode(position)
        time = jobs_posts[i].select('.job-post-item-body>div')[1].text
        place = deEmojify(jobs_posts[i].select('.job-post-item-body>div:nth-child(2)')[0].text)
        place = str.encode(place)
        experience = randrange(5)

        skills = []

        for i in range(4):
            tech = choice(SKILLS) 
            if tech not in skills:
                skills.append(tech)

        job = dict()
        

        job['id'] = id
        job['company_name'] = company_name.decode()
        job['position'] = position.decode()
        job['time'] = time
        job['skills'] = skills
        job['place'] = place.decode()
        job['experience'] = experience

        data.append(job)
        id += 1

    return jsonify({ 'data': data })

@app.route('/skills', methods=['GET'])
def getSkills():

    skills = []
    with open('./scripts/words.txt', 'r') as f:
        for line in f:
            words = line.split(',')

            for word in words:
                skills.append(word.lstrip())
    return jsonify({ 'skills': skills })

@app.route('/recommendations', methods=['GET'])
def getRecommendations():
    recommendations = request.args.get('skills')
    if recommendations != '':
        # print(recommendations)
        recommendations = recommendations.split(',')
        # recommendations = recommendations.lstrip('[').rstrip(']').split(', ')
        
        # print(recommendations)
        print("======STARTED======")
        classify = classifier()
        print("======CLASSIFICATION DONE======")
        # print(recommendations)
        recommendations.append('web')
        recommendations.append('python')
        # names=[]
        names = recommendation(classify, recommendations)
        print(names)
        # skills = []

        data = []
        # Read file for reading skills of a name    
        for name in names:
            skills = []
            with open("./scripts/data.csv", 'r') as f:
                reader = csv.reader(f, delimiter=',')
                for row in reader:
                    if row[0] == name:
                        skills = row[1:]
                        break
            person = dict()
            person['name'] = name
            person['skills'] = skills
            data.append(person)
        print(data)
        print(recommendations)
        # return  "HELLO"
        return jsonify({ 'data' : data })

if __name__ == '__main__':
    app.run(debug=True)
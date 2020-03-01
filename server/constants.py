SCRAPE_URL = 'https://flutterjobs.com/'
GOVT_URL = 'https://www.indgovtjobs.in/2014/04/it-fresher-jobs.html'

SKILLS = ['flask', 'django', 'nodejs', 'react', 'angular', 'regression', 'deep learning', 'neural networks', 'ANN', 'KNN', 'flutter', 'typescript', 'accounts', 'devops', 'android', 'web', 'ios', 'graphql']

def deEmojify(inputString):
    return inputString.encode('ascii', 'ignore').decode('ascii')

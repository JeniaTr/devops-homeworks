# * print the number of PRs each contributor has created with the labels
import sys
import config
from github import Github

g = Github(config.token)
repo = g.get_repo(config.user+"/"+config.reository)


def countFilesInPuls(e):
    return e['countFilesInPuls']

pulls = repo.get_pulls(state='open', sort='created')
infoArr = []

for pull in pulls:
    infoArr.append({'pullN': pull.number,
                    'user': pull.user.name,
                    'countFilesInPuls': pull.get_files().totalCount})

infoArr.sort(key=countFilesInPuls, reverse=True)

# print (*infoArr ,sep='\n')
# or
for p in infoArr: 
    print (p)
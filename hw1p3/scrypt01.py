# * print the number of PRs each contributor has created with the labels
import sys
import config
from github import Github
from sys import argv

g = Github(config.token)
repo = g.get_repo(config.user+"/"+config.reository)


def usersPRWithlabeles(pulls):
    contrib_labels = {}
    for pull in pulls:
        if pull.labels:
            if pull.user.login in contrib_labels:
                contrib_labels[pull.user.login] = contrib_labels[pull.user.login] + 1
            else:
                contrib_labels[pull.user.login] = 1
    return contrib_labels


def countFilesInPuls(e):
    return e['countChengedFilesInPull']


def filesСhangedInPullRequest(pulls):
    infoArr = []
    for pull in pulls:
        infoArr.append({'pullNumber': pull.number,
                        'userName': pull.user.name,
                        'countChengedFilesInPull': pull.get_files().totalCount})
    infoArr.sort(key=countFilesInPuls, reverse=True)
    return infoArr


def printUsersPRWithlabeles(arr):
    for k, v in arr.items():
        print(k, " - ", v, " PRs")


def printFilesСhangedInPullRequest(arr):
    for p in arr:
        print(p)
    # or
    # print (*arr ,sep='\n')


pulls = repo.get_pulls(state='open', sort='created')

script, first, second, third = argv

if argv[3] == "1":
    printUsersPRWithlabeles(usersPRWithlabeles(pulls))
elif argv[3] == "2":
    printFilesСhangedInPullRequest(filesСhangedInPullRequest(pulls))
else:
    print("Doesn't fit any of the options")

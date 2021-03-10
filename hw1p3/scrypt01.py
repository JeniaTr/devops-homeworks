# * print the number of PRs each contributor has created with the labels
import sys
import config
from github import Github
from sys import argv


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
    if len(arr) > 1:
        for k, v in arr.items():
            print(k, " - ", v, " PRs")
    else:
        print("No information available to submit.")


def printFilesСhangedInPullRequest(arr):
    for p in arr:
        print(p)
    # or
    # print (*arr ,sep='\n')


g = Github(config.token)

if len(sys.argv) > 1:
    repo = g.get_repo(argv[1]+"/"+argv[2])
    choiceScript = argv[3]
else:
    print("Default values")
    repo = g.get_repo(config.user+"/"+config.reository)
    choiceScript = config.choice


pulls = repo.get_pulls(state='open', sort='created')

print("\n")
if choiceScript == "1":
    printUsersPRWithlabeles(usersPRWithlabeles(pulls))
elif choiceScript == "2":
    printFilesСhangedInPullRequest(filesСhangedInPullRequest(pulls))
else:
    print("Doesn't fit any of the options")

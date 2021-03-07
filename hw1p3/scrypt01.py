# * print the number of PRs each contributor has created with the labels
import sys
import config

from github import Github

g = Github(config.token)
repo = g.get_repo(config.user+"/"+config.reository)


contrib_labels = {}
for pull in repo.get_pulls(state="open"):
    if pull.labels:
        if pull.user.login in contrib_labels:
            contrib_labels[pull.user.login] = contrib_labels[pull.user.login] + 1
        else:
            contrib_labels[pull.user.login] = 1

# print(contrib_labels, sep='\n', end='\n')

for k, v in contrib_labels.items():
    print(k, " - ", v, " PRs")

##
#
#
#
#
#
# contrib_labels = {}
# for pull in repo.get_pulls():
#     for label in pull.labels:
#         if pull.labels:
#             if pull.user.login in contrib_labels:
#                 contrib_labels[pull.user.login] = contrib_labels[pull.user.login] + 1
#             else:
#                 contrib_labels[pull.user.login] = 1
# print(contrib_labels)

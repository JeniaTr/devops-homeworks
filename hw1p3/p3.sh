#!/bin/bash
clear
# user="jeniatr"
# repo="devops-homeworks"

user="octocat"
repo="hello-world"

function if_open() {
    open=$(curl --silent "https://api.github.com/repos/$user/$repo/pulls" |
        grep '"state":' |
        sed -E 's/.*"([^"]+)".*/\1/')

    if [[ $open =~ "open" ]]; then
        echo true
    else
        echo false
    fi
}

function prodContributors() {
    curl --silent "https://api.github.com/repos/$user/$repo/pulls?state=all" |
        jq '.[] | {
  user:.user.login }' |
        grep -oP ':\K.*' |
        # sed "s/\"//g" |
        sort | uniq -c |
        awk '{if($1>1) print $2 " - made " $1 " Pull-Requests";}'
}

menu=(
    [1]='Open PR'
    [2]='Most productive contributors (PR>1)'
    [3]='tre'
)
select parr in "${menu[@]}"; do
    case $parr in
    "${menu[1]}")
        echo "There are open pull requests"
        if_open
        break
        ;;

    "${menu[2]}")
        prodContributors
        break
        ;;

    "${menu[3]}")
        break
        ;;

    *)
        echo "Invalid entry."
        exit
        ;;
    esac
done

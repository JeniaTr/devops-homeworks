#!/bin/bash
clear
url=$1

if [ -z "$url" ]; then
    url="https://github.com/PyGithub/PyGithub"
fi

# user="jeniatr"
# repo="devops-homeworks"
# user="octocat"
# repo="hello-world"

function pars_url() {
    user=$(echo "$url" | cut -d / -f4)
    repo=$(echo "$url" | cut -d / -f5)
}

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

pars_url

echo "User: $user"
echo "Repo: $repo"

menu=(
    [1]='If there are open pull requests for a repository.'
    [2]='Most productive contributors (PR>1)'
    [3]='Number of PRs each contributor has created with the labels'
    [4]='Print a list of pull requests sorted by - the number of changed files.'
    # (implement your own feature that you find the most attractive: anything from sorting to comment count or even fancy output format)'
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
        python3.8 scrypt01.py "$user" "$repo" "1" 
        break
        ;;

    "${menu[4]}")
        python3.8 scrypt01.py "$user" "$repo" "2" 
        break
        ;;

    *)
        echo "Invalid entry."
        exit
        ;;
    esac
done

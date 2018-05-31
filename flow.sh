#!/bin/bash

alias fl="flow"

flow(){
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "" ]
    then
        documentflow;
    fi

    if [ "$1" == "create" ]
    then
        echo "Executing command: 'git checkout -b feature/$2'";
        git checkout -b feature/$2;
        git push --set-upstream origin feature/$2;
    elif [ "$1" == "get" ]
    then
        echo "Executing command: 'git checkout -b feature/$2 --track origin/feature/$2'";
        git checkout -b feature/$2 --track origin/feature/$2
    elif [ "$1" == "sw" ]
    then
        echo "Executing command: 'git checkout feature/$2'";
        git checkout feature/$2
    elif [ "$1" == "s" ]
    then
        echo "Executing command: 'git status'";
        git status
    elif [ "$1" == "f" ]
    then
        echo "Executing command: 'git fetch'";
        git fetch
    elif [ "$1" == "d" ]
    then
        echo "Executing command: 'git diff'";
        git diff
    elif [ "$1" == "c" ]
    then
        echo "Executing command: 'git commit -m \"$2\"'";
        git commit -m "$2"
    elif [ "$1" == "develop" ]
    then
        echo "Executing command: 'git checkout develop'";
        git checkout develop
    elif [ "$1" == "delete" ]
    then
        echo "Executing command: 'git branch -d feature/$2'";
        git branch -d feature/$2
    elif [ "$1" == "delete-force" ]
    then
        echo "Executing command: 'git branch -D feature/$2'";
        git branch -D feature/$2
    elif [ "$1" == "delete-remote" ]
    then
        echo "Executing command: 'git push origin --delete feature/$2'";
        git push origin --delete feature/$2
    elif [ "$1" == "merge" ]
    then
        echo "Executing command: 'git merge origin/$2'";
        git merge origin/$2
    elif [ "$1" == "merge-feature" ]
    then
        echo "Executing command: 'git merge origin/feature/$2'";
        git merge origin/feature/$2
    elif [ "$1" == "log" ]
    then 
    	echo "Executing command: 'git log --graph --oneline --all'";
	    git log --graph --oneline --all;
    elif [ "$1" == "ref" ]
    then 
    	echo "Executing command: 'git fetch & git update-ref refs/heads/$2 origin/$2'";
        git fetch;
	    git update-ref refs/heads/$2 origin/$2;
    elif [ "$1" == "branchsave" ]
    then 
        for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
            git branch --track "${branch##*/}" "$branch"
        done
    elif [ "$1" == "freelock" ]
    then
        echo "Executing command: 'rm -f .\\.git\\index.lock'";
	    rm -f .\.git\index.lock;
    fi

}

function documentflow {
    echo "create        : creates a feature branch and pushes to set uptream to remote   : flow create <feature name>";
    echo "get           : checksout a remote branch tracking origin                      : flow get <remote feature name>";
    echo "sw            : switch or checks out a feature branch that is already local    : flow sw <feature name>";
    echo "c             : git commit -m <message>                                        : flow c <message>";
    echo "s             : git status                                                     : flow s";
    echo "f             : git fetch                                                      : flow f";
    echo "d             : git diff                                                       : flow d";
    echo "develop       : checks out develop                                             : flow develop";
    echo "merge         : merges in a remote branch                                      : flow merge <remote name>";
    echo "merge-feature : merges in a remote feature branch                              : flow merge <remote feature name>";
    echo "delete        : deletes local feature branch                                   : flow delete <feature name>";
    echo "delete-force  : deletes local feature branch, forcefully                       : flow delete-force <feature name>";
    echo "delete-remote : deletes remote feature branch                                  : flow delete-remote <feature name>";
	echo "log           : prints log with graph                                          : flow log";
    echo "ref           : Update branch without switching git update-ref command         : flow ref develop";
	echo "freelock      : removes index lock                                             : flow freelock";
}

# Checkout file
# git checkout origin/develop <file_name.txt>
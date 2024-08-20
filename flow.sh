#!/bin/bash

alias fl="flow"
alias gti="git";
alias igt="git";
alias gs="git status";
alias gp="git push";

gdd(){
  git diff --staged $1;
}

flow(){
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "" ]
    then
        documentflow;
    fi

    if [ "$1" == "ui" ] || [ "$1" == "UI" ]
    then
        gitk &
        git-gui;
    fi

    if [ "$1" == "create" ]
    then
        echo "Executing command: 'git checkout -b feature/$2'";
        git checkout -b feature/$2;
        git push --set-upstream origin feature/$2;
    elif [ "$1" == "cr" ]
    then
        echo "Executing command: 'git checkout -b feature/$2'";
        git checkout -b feature/$2;
    elif [ "$1" == "hotfix" ]
    then
        echo "Executing command: 'git checkout -b hotfix/$2'";
        git checkout -b hotfix/$2;
        git push --set-upstream origin hotfix/$2;
    elif [ "$1" == "get" ]
    then
        echo "Executing command: 'git checkout -b feature/$2 --track origin/feature/$2'";
        git checkout -b feature/$2 --track origin/feature/$2
    elif [ "$1" == "get-hotfix" ]
    then
        echo "Executing command: 'git checkout -b hotfix/$2 --track origin/hotfix/$2'";
        git checkout -b hotfix/$2 --track origin/hotfix/$2
    elif [ "$1" == "sw" ]
    then
        echo "Executing command: 'git checkout feature/$2'";
        git checkout feature/$2
    elif [ "$1" == "sw-hotfix" ]
    then
        echo "Executing command: 'git checkout hotfix/$2'";
        git checkout hotfix/$2
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
    elif [ "$1" == "uat" ]
    then
        echo "Executing command: 'git checkout uat'";
        git checkout uat
    elif [ "$1" == "master" ]
    then
        echo "Executing command: 'git checkout master'";
        git checkout master
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
    elif [ "$1" == "head" ]
    then
        git rev-parse HEAD;
    elif [ "$1" == "bundle" ]
    then
        # Stolen from https://github.com/pmaganti/git-bundler
        #Reading the git remote repo url
        echo -n 'Remote repo url: '
        read gitrepo

        #Cloning the git remote repo to a folder
        echo -n 'Project folder: '
        read projectfolder
        mkdir -p bundles
        mkdir $projectfolder && cd $projectfolder && git clone $gitrepo . &&
        for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
        git branch --track ${branch#remotes/origin/} $branch || git branch
        done && git bundle create ../bundles/$projectfolder.bundle --all && git bundle verify ../bundles/$projectfolder.bundle && echo "Done $projectfolder"
    elif [ "$1" == "freelock" ]
    then
        echo "Executing command: 'rm -f .\\.git\\index.lock'";
	    rm -f .\.git\index.lock;
    elif [ "$1" == "branch" ]
    then
      echo "Executing command: 'git branch -a'";
	    git branch -a;
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
    echo "master        : checks out master                                              : flow master";
    echo "merge         : merges in a remote branch                                      : flow merge <remote name>";
    echo "merge-feature : merges in a remote feature branch                              : flow merge <remote feature name>";
    echo "delete        : deletes local feature branch                                   : flow delete <feature name>";
    echo "delete-force  : deletes local feature branch, forcefully                       : flow delete-force <feature name>";
    echo "delete-remote : deletes remote feature branch                                  : flow delete-remote <feature name>";
	echo "log           : prints log with graph                                          : flow log";
    echo "ref           : Update branch without switching git update-ref command         : flow ref develop";
	echo "freelock      : removes index lock                                             : flow freelock";
    echo "head          : gets current SHA-1                                             : flow head";

    echo "
# git checkout origin/develop <file_name.txt> # Checkout file
# git submodule init
# git submodule update
# git cherry-pick -m 1 <SHA1> # -m flag used to determine parent when cherry-picking merge
# git cherry-pick --abort
# git fetch --all --tags --prune # fetch with tags
# git checkout tags/<tag name> -b release/<desired branch name> # create branch from tag
# git push --set-upstream origin release/<push new branch remotely>
# git tag -a <tag name e.g vxx.x> -m \"<Message for tag>\"
# git push origin <tag name e.g vxx.x> # push a new tag to remote
# git describe --match \"v[0-9]*\" --tags
# git tag -d <tag name> # delete tag
# git push origin :refs/tags/<tag name> # push tag delete to remote
# git log --author="" --pretty=tformat: --numstat
# git log --author="" --oneline --shortstat
# git shortlog -s -n --all --no-merges
# git rev-parse HEAD
";
}

# Checkout file
# git checkout origin/develop <file_name.txt>

# git submodule init
# git submodule update
# git cherry-pick -m 1 <SHA1> # -m flag used to determine parent when cherry-picking merge
# git cherry-pick --abort

# git fetch --all --tags --prune # fetch with tags
# git checkout tags/<tag name> -b release/<desired branch name> # create branch from tag
# git push --set-upstream origin release/<push new branch remotely>
# git tag -a <tag name e.g vxx.x> -m "<Message for tag>"
# git push origin <tag name e.g vxx.x> # push a new tag to remote

# https://git-scm.com/docs/git-describe
# git describe --match "v[0-9]*" --tags

# git tag -d <tag name> # delete tag
# git push origin :refs/tags/<tag name> # push tag delete to remote

# git branch --contains <SHA1>

# git log --author="" --pretty=tformat: --numstat
# git log --author="" --oneline --shortstat
# git shortlog -s -n --all --no-merges

# git push --follow-tags # push commits and tags at same time

# git remote
# git remote add origin https://github.com/repo.git
# git remote remove origin


# git merge --no-commit -q $REF --allow-unrelated-histories --strategy-option theirs  ## --strategy-option theirs is incomming branch and ours is current branch

# git commit --allow-empty -m "Some commit message"


## To stage all deleted files without having to git rm file
# git add -A  ## All
# git add -u ## Update

# git reset HEAD~ --hard ## undo last commit
# git reset HEAD~2 --hard ## undo last 2 commits


# git rev-parse HEAD -- review current commit

# Remove file from staging area
# git rm -r --cached <file>


# list branches and remotes
# git branch -a

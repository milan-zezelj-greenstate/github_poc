#!/bin/sh

cd git_repo;
git fetch;
# if [[ 'git status --porcelain' ]]; then
#     echo "No changes";
# else
#     git stash;
# fi
# git pull;
git rebase --autostash;
# if [[ 'git stash list' ]]; then
#     echo "Nothing stashed";
# else
#     git stash pop;
# fi
CONFLICTS=$(git ls-files -u | wc -l)
if [ "$CONFLICTS" -gt 0 ] ; then
    >&2 echo "There is a merge conflict. Aborting.";
    git merge --abort;
    exit 1;
fi
git add .;
git commit -m "New update";
git push;
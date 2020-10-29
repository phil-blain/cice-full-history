#!/bin/bash

set -x

CICE_SVN=${CICE_SVN:-../CICE-svn-trunk}

(
cd $CICE_SVN 
for ref in $(git for-each-ref 'refs/remotes/origin/svn' --format='%(refname)'); do 
  echo ===="$ref"=====
  matching_commits=$(git rev-list --all --grep "$(git log -1 --format=%B $ref |head -1)")
  num_commits=$(echo -e "$matching_commits" | wc -l)
  if [ $num_commits -eq 2 ]
  then
    commit_on_master=$(echo -e "$matching_commits" | tail -1)
    tag_name=$(basename $ref | sed 's/release-/CICE/')
    git tag $tag_name $commit_on_master
  fi
done
)


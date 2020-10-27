#!/bin/bash

CICE_SVN=${CICE_SVN:-../CICE-svn-trunk}

(
cd $CICE_SVN 
for ref in $(git for-each-ref 'refs/remotes/origin/svn' --format='%(refname)'); do 
  echo ===="$ref"=====
  git logo --all --grep "$(git log -1 --format=%B $ref |head -1)"
done
)


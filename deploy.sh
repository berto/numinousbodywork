#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="🚀 Deploying latest changes"
if [ $# -eq 1 ]
  then msg="$1"
fi

git_commit () {
  # Add changes to git.
  git add -A
  # Commit changes.
  git commit -m "$msg"
}

# Build the project.
hugo -t hugo-future-imperfect 

# Commit and push changes
git_commit

# Push source and build repos.
git push origin master

# Deploy to s3
s3cmd sync public/ s3://numinousbodywork.com/

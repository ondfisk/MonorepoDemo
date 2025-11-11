#!/bin/bash
GITHUB_USER=ondfisk
SOURCE1=AzureLandingZonesDemo
SOURCE2=GitHubDemo
TARGET=MonorepoDemo
brew install git-filter-repo
cd ..
git clone https://github.com/$GITHUB_USER/$SOURCE1.git
git clone https://github.com/$GITHUB_USER/$SOURCE2.git
cd $SOURCE1/
git filter-repo --to-subdirectory-filter $SOURCE1
cd ../$TARGET/
git remote add $SOURCE1 ../$SOURCE1/
git fetch $SOURCE1
git merge --allow-unrelated-histories $SOURCE1/main --message "Merge $SOURCE1"
git remote remove $SOURCE1
cd ../$SOURCE2/
git filter-repo --to-subdirectory-filter $SOURCE2
cd ../$TARGET/
git remote add $SOURCE2 ../$SOURCE2/
git fetch $SOURCE2
git merge --allow-unrelated-histories $SOURCE2/main --message "Merge $SOURCE2"
git remote remove $SOURCE2
git push
rm -rf ../$SOURCE1/
rm -rf ../$SOURCE2/
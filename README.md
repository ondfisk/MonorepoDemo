# Monorepo Demo

Demonstration of merging multiple git repositories into a monorepo

Inspired by [Merging Rubygems and Bundler](https://gist.github.com/x-yuri/9890ab1079cf4357d6f269d073fd9731).

## Process

Given two source repositories, and one target repository, run the following commands:

```bash
GITHUB_USER=...
SOURCE1=...
SOURCE2=...
TARGET=...
brew install git-filter-repo
cd ..
git clone https://github.com/$GITHUB_USER/$SOURCE1.git
git clone https://github.com/$GITHUB_USER/$SOURCE2.git
cd $SOURCE1/
git filter-repo --to-subdirectory-filter $SOURCE1
cd ../$TARGET/
git remote add alz ../$SOURCE1/
git fetch alz
git merge --allow-unrelated-histories alz/main --message "Merge $SOURCE1"
git remote remove alz
cd ../$SOURCE2/
git filter-repo --to-subdirectory-filter $SOURCE2
cd ../$TARGET/
git remote add ghd ../$SOURCE2/
git fetch ghd
git merge --allow-unrelated-histories ghd/main --message "Merge $SOURCE2"
git remote remove ghd
git push
rm -rf ../$SOURCE1/
rm -rf ../$SOURCE2/
```

## Complete

To complete the merge, you will need to manually reconfigure _GitHub Actions_, dev containers, secrets, variables, and environments.

## Reset

To reset repository, run the following commands:

```bash
find . -not -name '.' -not -name '..' -not -name '.git' -not -path './.git/*' -not -name '.gitignore' -not -name 'LICENSE' -not -name 'README.md' -not -name 'build.sh' -not -name 'destroy.sh' -print0 | xargs -0 rm -rf --
git reset $(git commit-tree "HEAD^{tree}" -m "Initial commit")
git add .
git commit --amend --no-edit
git push --force
```
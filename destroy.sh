#!/bin/bash
find . -not -name '.' -not -name '..' -not -name '.git' -not -path './.git/*' -not -name '.gitignore' -not -name 'LICENSE' -not -name 'README.md' -not -name 'build.sh' -not -name 'destroy.sh' -print0 | xargs -0 rm -rf --
git reset $(git commit-tree "HEAD^{tree}" -m "Initial commit")
git add .
git commit --amend --no-edit
git push --force
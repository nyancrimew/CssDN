#!/bin/sh -e

echo Preparing commit message
echo
if [ "$TRAVIS_EVENT_TYPE" = "cron" ]
then
echo "Daily build - $(date -u)">>commit_msg
else
git log -3 --oneline>>commit_msg
fi
echo "Commit message was set to:" && cat commit_msg

echo
echo Moving files into the right folders
mkdir build/out
mkdir build/out/js
mkdir build/out/css

find build -type f -name "*.js" -exec mv -t build/out/js {} +
find build -type f -name "*.css" -exec mv -t build/out/css {} +
find libs -type f -name "*.js" -exec cp -t build/out/js {} +
find libs -type f -name "*.css" -exec cp -t build/out/css {} +
echo

echo Minification
echo -- Minifying CSS
./node_modules/.bin/minify  build/out/css
echo
echo -- Minifying JS
./node_modules/.bin/minify  build/out/js
echo

echo Cloning this repository itself into a sub directory
git clone --depth=1 --branch=gh-pages https://${GITHUB_TOKEN}@github.com/Deletescape-Media/CssDN.git && cd CssDN

echo
echo Git config
git config user.name "deletescape"
git config user.email "deletescape@outlook.com"
git config --global push.default simple

echo
echo Delete old artifacts
rm -rf js
rm -rf css

echo
echo Copy new artifacts
cp -r ../build/out/js js
cp -r ../build/out/css css

echo
echo Check if jquery actually had any changes
if [ "$(git diff --numstat js/jquery.js | sed 's/ //g')" == "22jquery.js" ]
then
echo Only build date / time changed, checking out our last build
git checkout js/jquery.js
git checkout js/jquery.min.js
fi

echo
echo Commit with git
git add --all .
git commit -F ../commit_msg

echo
echo Deploy
git push --quiet
echo

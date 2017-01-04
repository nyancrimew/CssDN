#!/bin/sh

echo Preparing commit message
echo
if [${TRAVIS_EVENT_TYPE} = "cron"]
then
COMMIT_MSG="$(date -u)"
else
git log -${TRAVIS_COMMIT_RANGE} --oneline>>commit_msg
COMMIT_MSG="$(cat commit_msg)"
fi
echo "Commit message was set to: ${COMMIT_MSG}"

echo
echo Moving files into the right folders
mkdir build/out
mkdir build/out/js
mkdir build/out/css

mv build/*.js build/out/js
mv build/**/*.js build/out/js
mv build/*.css build/out/css
mv build/**/*.css build/out/css
cp libs/*.js build/out/js
cp libs/**/*.js build/out/js
cp libs/*.css build/out/css
cp libs/**/*.css build/out/css
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
echo Commit with git
git add --all .
git commit -m"${COMMIT_MSG}"

echo
echo Deploy
git push --quiet
echo

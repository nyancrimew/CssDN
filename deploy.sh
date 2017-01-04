#!/bin/sh

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

echo Copy new artifacts
cp -r ../build/out/js js
cp -r ../build/out/css css

echo Commit with git
git add .
git commit -m"$(date -u)"

echo Deploy
git push --quiet

#!/bin/sh

./clean.sh

echo Loading dependencies
echo
npm install

echo
echo Creating build folder
mkdir build/

echo
echo Cloning github-syntax-theme-generator
echo
git clone --depth=1 https://github.com/primer/github-syntax-theme-generator.git repos/github-syntax-theme-generator

echo
cd repos/github-syntax-theme-generator
echo Loading dependencies of github-syntax-theme-generator
echo
npm install
echo
echo Building github-syntax-theme-generator
echo
npm run build
echo
echo Copying artifacts to output directory
cp -r build/* ../../build
cd ../..

echo
echo Cloning normalize.css
echo
git clone --depth=1 https://github.com/necolas/normalize.css.git repos/normalize && cd repos/normalize
echo
echo Copying artifacts to output directory
cp normalize.css ../../build
cd ../..

echo
echo Deploying to gh-pages branch
./deploy.sh

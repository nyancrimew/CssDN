#!/bin/sh -e

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
git clone --depth=1 --branch=master https://github.com/primer/github-syntax-theme-generator.git repos/github-syntax-theme-generator && cd repos/github-syntax-theme-generator
echo
echo Building github-syntax-theme-generator
echo
npm install && npm run build
echo
echo Copying artifacts to output directory
cp build/css/github-light.css ../../build
cp build/css/github-dark.css ../../build
cd ../..

echo
echo Cloning normalize.css
echo
git clone --depth=1 --branch=master https://github.com/necolas/normalize.css.git repos/normalize && cd repos/normalize
echo
echo Copying artifacts to output directory
cp normalize.css ../../build
cd ../..

echo
echo Cloning jquery
echo
git clone --depth=1 --branch=master https://github.com/jquery/jquery.git repos/jquery && cd repos/jquery
echo
echo Building jquery
echo
npm run build
echo
echo Copying artifacts to output directory
cp dist/jquery.js ../../build
cd ../..

echo
echo Cloning spin.js
echo
git clone --depth=1 --branch=master https://github.com/fgnass/spin.js.git repos/spin && cd repos/spin
echo
echo Copying artifacts to output directory
cp spin.js ../../build
cp jquery.spin.js ../../build
cd ../..

echo
echo Cloning underscore.js
echo
git clone --depth=1 --branch=master https://github.com/jashkenas/underscore.git repos/underscore && cd repos/underscore
echo
echo Copying artifacts to output directory
cp underscore.js ../../build
cd ../..

echo
echo Cloning slick
echo
git clone --depth=1 --branch=master https://github.com/kenwheeler/slick.git repos/slick && cd repos/slick
echo
echo Copying artifacts to output directory
cp slick/slick.js ../../build
cp slick/slick.css ../../build
cp slick/slick-theme.css ../../build
cd ../..

echo
echo Cloning ramda
echo
git clone --depth=1 --branch=master https://github.com/ramda/ramda.git repos/ramda && cd repos/ramda
echo
echo Building ramda
echo
npm install && npm run build
echo
echo Copying artifacts to output directory
cp dist/ramda.js ../../build
cd ../..

echo
echo Cloning mousetrap
echo
git clone --depth=1 --branch=master https://github.com/ccampbell/mousetrap.git repos/mousetrap && cd repos/mousetrap
echo
echo Copying artifacts to output directory
cp mousetrap.js ../../build
cd ../..

echo
echo Cloning intro.js
echo
git clone --depth=1 --branch=master https://github.com/usablica/intro.js.git repos/intro && cd repos/intro
echo
echo Copying artifacts to output directory
cp intro.js ../../build
cp introjs.css ../../build
cp introjs-rtl.css ../../build
cd ../..

echo
echo Deploying to gh-pages branch
./deploy.sh

#!/bin/sh

echo Cleaning
cat .gitignore | xargs -I FILE rm -rf FILE
echo Finished cleaning
echo ---
echo

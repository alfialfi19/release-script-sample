#!/usr/bin/env bash
RED='\033[0;31m'
NOCOLOR='\033[0m'
GREEN='\033[0;32m'

TRUNK_BRANCH='master'
TAG_PREFIX='example'

bumpVersionAndTagCreation() {
  echo
  echo "================================="
  echo "💪 Bumping Version 💪"
  echo "=================================\n"

  read -r -p "Release Version (Using semantic versioning, i.e: 0.0.0): " releaseVersion

  sed -i "" "s/version:.*/version: $releaseVersion/" pubspec.yaml

  fvm flutter clean && fvm flutter pub get

  git add . && git commit -m "bump version to $releaseVersion" && git push -f origin $releaseBranchName

  echo "${GREEN}✓ Success Bump Version${NOCOLOR}"
  echo

  echo
  echo "================================="
  echo "💪 Creating Tag 💪"
  echo "=================================\n"

  git tag $TAG_PREFIX-$releaseVersion

  echo "${GREEN}✓ Success Creating Tag${NOCOLOR}"
  echo

  git checkout $TRUNK_BRANCH
}

branchCreation() {
  if [[ $releaseScenario == 'c' ]] ; then
    echo
    echo "================================="
    echo "💪 Creating Branch 💪"
    echo "=================================\n"

    read -r -p "Release Branch Name: " releaseBranchName

    git checkout $TRUNK_BRANCH

    git pull origin $TRUNK_BRANCH && git checkout -b $releaseBranchName

    echo "${GREEN}✓ Success Creating Branch${NOCOLOR}"
    echo

    echo
    echo "================================="
    echo "💪 Pushing Branch 💪"
    echo "=================================\n"

    git push -f origin $releaseBranchName

    echo "${GREEN}✓ Success Pushing Branch${NOCOLOR}"
    echo

  elif [[ $releaseScenario == 'u' ]] ; then
    read -r -p "Update from Branch: " releaseBranchName

    git switch $releaseBranchName

    if [ $? -ne 0 ] ; then
      echo "${RED}❌ Branch no exist. Please try again. ❌ ${NOCOLOR}"
      exit 1
    fi
  else
    echo "${RED}❌ Wrong operation. Please try again later. ❌ ${NOCOLOR}"
    exit 1
  fi
}

read -r -p "Create release branch (c) or Update from existing release branch (u)? " releaseScenario

branchCreation
bumpVersionAndTagCreation
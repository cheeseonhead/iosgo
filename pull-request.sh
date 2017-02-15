#!/bin/bash

# Colors
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# select branch
if [ $# -eq 0 ]
    then # no branch provided
        TARGET_BRANCH='develop'
    else # use first argument as branch
        TARGET_BRANCH="$1"
fi

# get current branch
CUR_BRANCH=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
CUR_BRANCH_LONG=$(git symbolic-ref HEAD | sed 's!refs\/heads\/!!')
TAR_BRANCH_SHORT=$(echo $TARGET_BRANCH | sed -e 's,.*/\(.*\),\1,')

echo -e "Open PR to merge ${CYAN}$CUR_BRANCH${NC} into ${CYAN}$TAR_BRANCH_SHORT${NC}"

echo -e "ISSUE #$CUR_BRANCH → $TAR_BRANCH_SHORT (Close #$CUR_BRANCH)
Item         | Status  | Build Status
------------ | ------- | ------------
[IOS-$CUR_BRANCH](https://github.com/cheeseonhead/iosgo/issues/$CUR_BRANCH) | Done    | [![ISSUE-$CUR_BRANCH](https://dashboard.buddybuild.com/api/statusImage?appID=5879f9377457550100e35017&branch=$CUR_BRANCH_LONG&build=latest)](https://dashboard.buddybuild.com/apps/5879f9377457550100e35017/build/latest?branch=$CUR_BRANCH_LONG)" > testfile

hub pull-request -F testFile -b cheeseonhead:$TARGET_BRANCH
rm testFile

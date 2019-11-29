#!/bin/bash

export TT_DWORK=${WORK_DIR}

alias dwork='cd ${WORK_DIR}'
echo ""
echo "command list"
echo "dwork: cd workspace dir"
echo ""

#fix wget http://commondatastorage.googleapis.com/git-repo-downloads/repo repo-temp fail
#unable to access 'https://gerrit.googlesource.com/git-repo/': Problem with the SSL CA cert
git config --global --add http.sslVerify false

#./build-core-sdk.sh dra7xx-evm
#Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

dwork

#!/usr/bin/env bash

# Fail immediately if any errors occur
set -e

CONDUCTOR_USAGE_URL="https://forms.gle/nZ2Erw7Cykfqim2Z9"
REPORT_NAME=conductor-report-$(whoami)-$(date +%F_%H-%M-%S)
REPORT_PATH=~/tmp/${REPORT_NAME}
REPORT_ZIP=~/tmp/${REPORT_NAME}.zip

echo "Conductor Usage Report"
echo "This script gathers information to submit as a usage report to the Conductor team."
echo $CONDUCTOR_USAGE_URL
echo

echo "This script should be run from the project directory in your computer's terminal (outside of any Docker containers)."
echo

echo "It will collect the following artifacts:"
echo "- project code"
echo "- project conductor configuration folder"
echo "- user conductor configuration folder"
echo

echo "If you want to include any changed project code in the report, it must be commited to the git repo first!"
echo

read -p "Begin Conductor Usage Report creation? (y/n) >" yn
case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer y or n." && exit;;
esac
echo

echo "exporting usage data in $REPORT_PATH"
mkdir -p $REPORT_PATH
echo

echo "creating git archive: project.zip"
git archive -o $REPORT_PATH/project.zip head
echo

echo "creating conductor project config archive: project.zip"
zip -ur $REPORT_PATH/project.zip ./.conductor
echo

echo "creating conductor user config archive: user_config.zip"
cd ~
zip -r $REPORT_PATH/user_config.zip ./.conductor
cd -
echo

echo "creating conductor report archive: ${REPORT_NAME}.zip"
cd ~/tmp
zip -r ${REPORT_NAME}.zip $REPORT_NAME
cd -
echo

echo "cleaning up.."
rm -rf $REPORT_PATH
echo

echo "exported usage data in ~/tmp:"
echo ${REPORT_ZIP}
echo

echo "Attach the Conductor report zip to the Conductor Usage report google form:"
echo $CONDUCTOR_USAGE_URL
echo

open ~/tmp

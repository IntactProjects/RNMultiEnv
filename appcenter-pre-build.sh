#!/usr/bin/env bash

PROJECT_NAME=RNMultiEnv
INFO_PLIST_FILE=$APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME/Info.plist

if [ "$APPCENTER_BRANCH" == "master" ];
then
    echo "Choosing devops.json"
    mv $APPCENTER_SOURCE_DIRECTORY/devops.staging.json $APPCENTER_SOURCE_DIRECTORY/devops.json

    echo "Updated devops.json"
    cat $APPCENTER_SOURCE_DIRECTORY/devops.json

    echo "Updating CFBundleDisplayName in Info.plist"
    plutil -replace CFBundleDisplayName -string "\$(PRODUCT_NAME) Staging" $INFO_PLIST_FILE

    echo "Updated Info.plist:"
    cat $INFO_PLIST_FILE

    echo "Updating Build configuration"
    sed -i -e 's/buildConfiguration = "Release"/buildConfiguration = "Staging"/g' $APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes/RNMultiEnv.xcscheme
fi

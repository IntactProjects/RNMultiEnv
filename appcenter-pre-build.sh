#!/usr/bin/env bash

PROJECT_NAME=RNMultiEnv
INFO_PLIST_FILE=$APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME/Info.plist

if [ "$APPCENTER_BRANCH" == "master" ];
then
    echo "Updating CFBundleDisplayName in Info.plist"
    plutil -replace CFBundleDisplayName -string "\$(PRODUCT_NAME) Staging" $INFO_PLIST_FILE

    echo "File content:"
    cat $INFO_PLIST_FILE

    echo "Updating Build configuration"
    sed -i -e 's/buildConfiguration = "Release"/buildConfiguration = "Staging"/g' $APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes/RNMultiEnv.xcscheme
fi

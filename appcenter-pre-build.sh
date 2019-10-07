#!/usr/bin/env bash

# Example: Change bundle name of an iOS app for non-production
if [ "$APPCENTER_BRANCH" == "master" ];
then
    plutil -replace CFBundleName -string "\$(PRODUCT_NAME) Staging" $APPCENTER_SOURCE_DIRECTORY/RNMultiEnv/ios/Info.plist
fi

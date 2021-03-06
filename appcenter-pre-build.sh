#!/usr/bin/env bash

PROJECT_NAME=RNMultiEnv
INFO_PLIST_FILE=$APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME/Info.plist

if [ "$APPCENTER_BRANCH" == "master" ];
then
    DEVOPS_SOURCE_FILENAME=devops.staging.json
    BUNDLE_DISPLAY_NAME_SUFFIX=Staging
    BUILD_CONFIGURATION_NAME=Staging
fi

if [ "$APPCENTER_BRANCH" == "production" ];
then
    DEVOPS_SOURCE_FILENAME=devops.production.json
    BUNDLE_DISPLAY_NAME_SUFFIX=
    BUILD_CONFIGURATION_NAME=Release
fi

# React Native: Choose the good devops.json file depending on the environment
echo "Choosing devops.json"
mv $APPCENTER_SOURCE_DIRECTORY/$DEVOPS_SOURCE_FILENAME $APPCENTER_SOURCE_DIRECTORY/devops.json

echo "Updated devops.json"
cat $APPCENTER_SOURCE_DIRECTORY/devops.json

# iOS: Update the iOS app name
echo "Updating CFBundleDisplayName in Info.plist"
plutil -replace CFBundleDisplayName -string "\$(PRODUCT_NAME) $BUNDLE_DISPLAY_NAME_SUFFIX" $INFO_PLIST_FILE

echo "Updated Info.plist:"
cat $INFO_PLIST_FILE

# iOS: Build with the good build configuration
echo "Updating Build configuration"
sed -i -e 's/buildConfiguration = "Release"/buildConfiguration = "'$BUILD_CONFIGURATION_NAME'"/g' $APPCENTER_SOURCE_DIRECTORY/ios/$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes/$PROJECT_NAME.xcscheme

# Android: The build type is chosen directly from MS App Center

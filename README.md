# Purpose

The purpose of the project is to be able to have multi-environment (dev, staging, preprod, production...) in a React Native project. It means:

1. Being able to have multiple Build configurations on iOS in order to have each configuration having it's own bundle id, team, provisioning profile, app name, etc.

2. Being able to have multiple build types on Android in order to have each build type having it's own package id, keystores, etc.

3. Being able to have variables accessible in the React Native code that are different for each environment (BACKEND_URL, API_KEY, if ENV == STAGING..., etc.)

# Constraints are

1. Work in local as well as in Microsoft App Center

2. Do not depend on unmaintained React Native librairies

3. Do not dependend on fastlane (because fastlane + MS AppCenter is too much)

# MS App Center

Each git branch is tied to an environment. For example:

develop = develop (if needed)
master = staging
production = production

# How to

## Add constants that depend of the environment:

1. Add a property into the devops.<env>.json file.
2. Access the property in the React Native code:

import devopsJson from './devops.json';

{devopsJson["BACKEND_URL"]}

## Edit build configurations in iOS:

1. GO to XCode and edit build configurations
2. Edit the appcenter-pre-build.sh script

## Edit build types in Android:

1. GO to Android Studio and edit app/build.gradle file
2. Edit the appcenter-pre-build.sh script
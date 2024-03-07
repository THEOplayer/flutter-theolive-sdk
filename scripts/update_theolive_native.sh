#!/bin/bash

update_theolive_android() {
  if [ -z "${ANDROID}" ]
  then
    echo "Android version not specified, skipping."
  else
    echo "Updating THEOlive Android SDK to: ${ANDROID}"

    sed -i '' "s/def theoliveVersion =.*/def theoliveVersion ='${ANDROID}'/g" flutter_theolive_sdk_android/android/build.gradle
  fi
  echo ""
}

update_theolive_ios() {
  if [ -z "${IOS}" ]
  then
    echo "iOS version not specified, skipping."
  else
    echo "Updating THEOlive iOS SDK to: ${IOS}"

    sed -i '' "s/s.dependency 'THEOliveSDK', '.*/s.dependency 'THEOliveSDK', '${IOS}'/g" flutter_theolive_sdk_ios/ios/theolive_ios.podspec
    pod update THEOliveSDK --project-directory=flutter_theolive_sdk/example/ios
    pod install --repo-update --project-directory=flutter_theolive_sdk/example/ios
  fi
  echo ""
}


while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -a|--android)
    # THEOlive Android SDK version
    ANDROID="$2"
    shift # past argument
    shift # past value
    ;;
    -i|--ios)
    # THEOlive iOS SDK version
    IOS="$2"
    shift # past argument
    shift # past value
    ;;
    --all)
    # THEOlive Android and iOS SDKs version
    ANDROID="$2"
    IOS="$2"
    shift # past argument
    shift # past value
    ;;
esac
done

echo "Updating THEOlive SDKs:"
echo "ANDROID   = ${ANDROID}"
echo "iOS       = ${IOS}"
echo ""

update_theolive_android
update_theolive_ios
exit 0

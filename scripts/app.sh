#!/bin/sh
OS="ios";
ENV='staging';
IOS_DEVICE="iPhone 13 mini";
IOS_UUID=""; # physical device

helpFunction()
{
   echo "Usage: yarn app -o [ios|android] -e [staging|production]"
   exit 1 # Exit script after printing help
}

while getopts "o:e:d:u:" opt
do
   case "$opt" in
      o ) OS="$OPTARG" ;;
      e ) ENV="$OPTARG" ;;
      d ) IOS_DEVICE="$OPTARG" ;;
      u ) IOS_UUID="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [[ $OS ]] && [[ $ENV ]]; then
    bundle exec fastlane ${OS} update_config --env ${ENV}
fi

if [[ $OS == "ios" ]] && [[ -z $IOS_UUID ]]; then
    ENVFILE=./fastlane/.env.${ENV} react-native run-ios --simulator="${IOS_DEVICE}"
fi

if [[ $OS == "ios" ]] && [[ $IOS_UUID ]]; then
    ENVFILE=./fastlane/.env.${ENV} react-native run-ios --udid="${IOS_UUID}"
fi

if [[ $OS == "android" ]]; then
    ENVFILE=./fastlane/.env.${ENV} react-native run-android
fi

#!/bin/bash

# Copyright (c) 2023. Open Mobile Platform LLC.
# License: Proprietary.

## Build example, sign rpm, upload/install/run rpm to device

## Usage
##
## chmod +x ./build_example.sh
##
## ./build_example.sh \
##   -p xdga_directories \
##   -d <ip>:<password> \
##   -s /home/user/sign/system_keys

## Flutter path
FLUTTER="$HOME/.local/opt/flutter-sdk/bin/flutter"

## https://developer.auroraos.ru/doc/software_development/psdk/setup
## Install Platform SDK path
## You may not have set the PSDK_DIR environment variable.
## export PSDK_DIR=$HOME/AuroraPlatformSDK/sdks/aurora_psdk

while getopts p:d:s: flag; do
  case "${flag}" in
  p) package=${OPTARG} ;;
  d) device=${OPTARG} ;;
  s) sign=${OPTARG} ;;
  *)
    echo "usage: $0 [-p] [-d] [-s]" >&2
    exit 1
    ;;
  esac
done

if [ -z "$package" ]; then
  echo "Specify a build package"
  exit
else
  cd "../packages/$package" 2>/dev/null || eval 'echo "Package \"$package\" not found." && exit'
  ## Update dependency
  $FLUTTER pub get
  ## Run ffigen if has
  $FLUTTER pub run ffigen --config ffigen.yaml  2>/dev/null
  ## Open example dir
  cd "example" || exit
  ## Build aurora example app
  {
      $FLUTTER build aurora --release
  } || {
    exit 1;
  }
fi

if [ -n "$sign" ]; then

  key=$(ls "$sign"/*key.pem)

  if [ -z "$key" ]; then
    echo "Key *key.pem not found."
    exit
  fi

  cert=$(ls "$sign"/*cert.pem)

  if [ -z "$cert" ]; then
    echo "Key *cert.pem not found."
    exit
  fi

  ## Sign rpm system key
  "$PSDK_DIR"/sdk-chroot rpmsign-external sign \
    --key "$key" \
    --cert "$cert" \
    build/aurora/arm/release/RPMS/*.rpm
fi

if [ -n "$device" ]; then

  IFS=':' read -ra ADDR <<< "$device"
  IFS='/' read -ra ADDP <<< "$package"

  D_IP="${ADDR[0]}"
  D_PASS="${ADDR[1]}"
  APP_KEY="${ADDP[-1]}"

  # shellcheck disable=SC2012
  rpm=$(ls "$PWD"/build/aurora/arm/release/RPMS/*.rpm | sort -r | head -n 1)

  # upload rpm
  scp "$rpm" defaultuser@"$D_IP:/home/defaultuser/Downloads"

  # install rpm
  ssh -t defaultuser@$D_IP "echo $D_PASS | devel-su pkcon -y install-local /home/defaultuser/Downloads/*$APP_KEY*.rpm" 

  # run application
  ssh -t defaultuser@$D_IP "/usr/bin/com.example.${APP_KEY}_example"
fi

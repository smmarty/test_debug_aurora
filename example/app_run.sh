#!/bin/bash

# Copyright (c) 2023. Open Mobile Platform LLC.
# License: Proprietary.

## Build example, sign rpm, upload/install/run rpm to device

## Usage
##
## chmod +x ./run.sh
##
## ./run.sh \
##   -d <ip>:<password> \
##   -s /home/user/sign/folder
##   -p ru.auroraos.flutter_example_packages

sudo echo 'Run...';

## Flutter path
FLUTTER="$HOME/.local/opt/flutter/bin/flutter"

## https://developer.auroraos.ru/doc/software_development/psdk/setup
## Install Platform SDK path
## You may not have set the PSDK_DIR environment variable.
## export PSDK_DIR=$HOME/AuroraPlatformSDK/sdks/aurora_psdk

while getopts d:s:p: flag; do
  case "${flag}" in
  d) device=${OPTARG} ;;
  s) sign=${OPTARG} ;;
  p) package=${OPTARG} ;;
  *)
    echo "usage: $0 [-d] [-s] [-p]" >&2
    exit 1
    ;;
  esac
done

if [ -z "$package" ]; then
  echo "Specify package"
  exit 1;
fi

## Update dependency
$FLUTTER pub get

## Generate internationalizing
$FLUTTER pub run build_runner build --delete-conflicting-outputs

## Build aurora example app
{
    $FLUTTER build aurora --release
} || {
  exit 1;
}

if [ -n "$sign" ]; then

  key=$(ls "$sign"/*key.pem)

  if [ -z "$key" ]; then
    echo "Key *key.pem not found."
    exit 1;
  fi

  cert=$(ls "$sign"/*cert.pem)

  if [ -z "$cert" ]; then
    echo "Key *cert.pem not found."
    exit 1;
  fi

  ## Sign rpm system key
  "$PSDK_DIR"/sdk-chroot rpmsign-external sign \
    --key "$key" \
    --cert "$cert" \
    build/aurora/arm/release/RPMS/*.rpm
fi

if [ -n "$device" ]; then

  IFS=':' read -ra ADDR <<< "$device"

  D_IP="${ADDR[0]}"
  D_PASS="${ADDR[1]}"

  # shellcheck disable=SC2012
  rpm=$(ls "$PWD"/build/aurora/arm/release/RPMS/*.rpm | sort -r | head -n 1)

  # upload rpm
  scp "$rpm" defaultuser@"$D_IP:/home/defaultuser/Downloads"

  # install rpm
  ssh -t defaultuser@"$D_IP" "echo $D_PASS | devel-su pkcon -y install-local /home/defaultuser/Downloads/$package*.rpm"

  # run application
  ssh -t defaultuser@"$D_IP" "/usr/bin/$package"
fi

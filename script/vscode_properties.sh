#!/bin/bash

# Copyright (c) 2023. Open Mobile Platform LLC.
# License: Proprietary.

## Script create c_cpp_properties.json with dependencies for flutter aurora

## Usage
##
## chmod +x ./vscode_properties.sh
## ./vscode_properties.sh

## https://developer.auroraos.ru/doc/software_development/psdk/setup
## Install Platform SDK path
## You may not have set the PSDK_DIR environment variable.
## export PSDK_DIR=$HOME/AuroraPlatformSDK/sdks/aurora_psdk

cd ../

## check file
[ -f .vscode/c_cpp_properties.json ] && { echo "File c_cpp_properties.json already exist!"; exit; }

## find target
TARGET=$($PSDK_DIR/sdk-chroot sdk-assistant list | grep armv | grep default | sed 's/^.*A/A/g' | sed 's/\s.*//g')

## mkdir .vscode if not exist
[ -d .vscode ] || mkdir .vscode

## find targets path
TARGETS_PATH=$(cd "$PSDK_DIR/../../" && pwd)/targets

## save file
tee -a .vscode/c_cpp_properties.json << END
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "\${workspaceFolder}/**",
                "$TARGETS_PATH/$TARGET/usr/include",
                "$TARGETS_PATH/$TARGET/usr/include/dconf",
                "$TARGETS_PATH/$TARGET/usr/include/flutter-embedder",
                "$TARGETS_PATH/$TARGET/usr/include/maliit",
                "$TARGETS_PATH/$TARGET/usr/include/appmanifest-cpp",
                "$TARGETS_PATH/$TARGET/usr/include/glib-2.0",
                "$TARGETS_PATH/$TARGET/usr/lib/glib-2.0/include",
                "$TARGETS_PATH/$TARGET/usr/include/sailfishapp",
                "$TARGETS_PATH/$TARGET/usr/include/qt5",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtConcurrent",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtCore",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtDBus",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtGui",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtMultimedia",
                "$TARGETS_PATH/$TARGET/usr/include/qt5/QtQuick"
            ],
            "defines": [
                "__ARM_PCS_VFP"
            ],
            "compilerPath": "/usr/bin/g++",
            "cStandard": "c17",
            "cppStandard": "c++17",
            "intelliSenseMode": "clang-x64"
        }
    ],
    "version": 4
}
END

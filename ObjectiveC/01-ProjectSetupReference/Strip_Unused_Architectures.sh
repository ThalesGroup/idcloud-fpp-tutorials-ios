#!/bin/bash

if [ -z $ARCHS ] ; then
    exit 0
fi


APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"
echo "App Path:"$APP_PATH

DYNAMIC_FRAMEWORKS='TrustDefender.framework'

# This script loops through the DYNAMIC_FRAMEWORKS embedded in the application and
# removes unused architectures.

for DYNAMIC_FRAMEWORK in $DYNAMIC_FRAMEWORKS
do
    find "$APP_PATH" -name $DYNAMIC_FRAMEWORK -type d | while read -r FRAMEWORK
    do
        FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
        FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"

        EXTRACTED_ARCHS=()

        for ARCH in $ARCHS
        do
            lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
            EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
        done

        lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
        rm "${EXTRACTED_ARCHS[@]}"

        rm "$FRAMEWORK_EXECUTABLE_PATH"
        mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

    done
done

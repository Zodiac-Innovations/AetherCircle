#!/bin/bash

set -euo pipefail

QUEST_ROOT="$(cd "$(dirname "$0")" && pwd)"
PACKAGE_ROOT="$QUEST_ROOT/SwiftPackage"
SHARED_SOURCE="$QUEST_ROOT/../Shared/Swift"
SHARED_DESTINATION="$PACKAGE_ROOT/Sources/QuestApplication/Shared"
JNI_LIBS="$QUEST_ROOT/app/src/main/jniLibs/arm64-v8a"

if [ ! -d "$SHARED_SOURCE" ]; then
    echo "Error: Shared/Swift was not found at $SHARED_SOURCE" >&2
    exit 1
fi

SWIFT_ANDROID_SDK="${AETHERCIRCLE_SWIFT_ANDROID_SDK:-}"
if [ -z "$SWIFT_ANDROID_SDK" ]; then
    SWIFT_ANDROID_SDK="$(
        swift sdk list |
            awk 'tolower($0) ~ /android/ { print $1; exit }'
    )"
fi

if [ -z "$SWIFT_ANDROID_SDK" ]; then
    echo "Error: Swift SDK for Android was not found." >&2
    echo "Install it with 'swift sdk install' or set AETHERCIRCLE_SWIFT_ANDROID_SDK." >&2
    exit 1
fi

rm -rf "$SHARED_DESTINATION"
mkdir -p "$SHARED_DESTINATION"
cp "$SHARED_SOURCE"/*.swift "$SHARED_DESTINATION/"

SWIFT_ANDROID_TRIPLE="${AETHERCIRCLE_SWIFT_ANDROID_TRIPLE:-aarch64-unknown-linux-android32}"

swift build     --package-path "$PACKAGE_ROOT"     --swift-sdk "$SWIFT_ANDROID_SDK"     --triple "$SWIFT_ANDROID_TRIPLE"     --configuration debug     --static-swift-stdlib

BIN_PATH="$(
    swift build         --package-path "$PACKAGE_ROOT"         --swift-sdk "$SWIFT_ANDROID_SDK"         --triple "$SWIFT_ANDROID_TRIPLE"         --configuration debug         --show-bin-path
)"

LIBRARY="$BIN_PATH/libAetherCircleQuestApp.so"
if [ ! -f "$LIBRARY" ]; then
    echo "Error: Swift Quest library was not produced at $LIBRARY" >&2
    exit 1
fi

mkdir -p "$JNI_LIBS"
cp "$LIBRARY" "$JNI_LIBS/"

printf '\033[0;32mBuilt the shared Swift Quest application.\033[0m\n'

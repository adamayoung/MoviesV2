#!/bin/sh

set -e

# SwiftLint on Analyze action

if [ $CI_XCODEBUILD_ACTION = 'analyze' ];
then
    echo "Linting..."
    brew install swiftlint

    cd $CI_WORKSPACE
    swiftlint --strict
fi

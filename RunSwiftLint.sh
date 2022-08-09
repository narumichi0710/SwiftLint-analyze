#!/bin/sh

# SwiftLintの実行スクリプト
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

# Analyzeの実行スクリプト
project="SwiftLint-analyze.xcodeproj"
scheme="SwiftLint-analyze"

xcodebuild clean -project ${project} -scheme ${scheme}

xcodebuild -project ${project} -scheme ${scheme} -sdk iphonesimulator -configuration Debug -destination "platform=iOS Simulator,name=iPhone 13" > xcodebuild.log

swiftlint analyze --autocorrect --compiler-log-path xcodebuild.log --fix


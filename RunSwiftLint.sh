#!/bin/sh

# SwiftLintの実行スクリプト
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

# Analyzeの実行スクリプト
project="SwiftLintAnalyze.xcodeproj"
scheme="SwiftLintAnalyze"

xcodebuild clean -project ${project} -scheme ${scheme}

xcodebuild -project ${project} -scheme ${scheme} -sdk iphonesimulator -configuration Debug -destination "platform=iOS Simulator,name=iPhone 13,OS=15" > xcodebuild.log

swiftlint analyze --autocorrect --compiler-log-path xcodebuild.log


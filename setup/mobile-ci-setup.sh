#!/bin/bash

# DO NOT RUN SCRIPT WITH SUDO!!! You can instead modify script to take password as input and pass it to sudo
# commands but consider security risks.

# Begin by installing Android studio and Xcode, you may skip installing android studio and only set up the SDK
# using brew, I recommend just setting up both as the process to install Xcode from CLI is rather tedious and
# BEAR IN MIND OFFICIAL SUPPORT HAS BEEN DISCONTINUED for android SDK on homebrew.
# if you so choose to install android SDK tools using homebrew, just uncomment the install sdk with brew on line #36.

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update Homebrew
brew update

# Install Flutter
brew install --cask flutter

# Add Flutter to the PATH
#echo '# Add Flutter to the PATH' >> ~/.zshrc
#echo 'export PATH="$PATH:/opt/homebrew/bin"' >> ~/.zshrc #should already be exported to path
#source ~/.zshrc

# Install Java (OpenJDK) and Rosetta 2
# This package requires Rosetta 2 to be installed
softwareupdate --install-rosetta --agree-to-license
brew install --cask adoptopenjdk/openjdk/adoptopenjdk11

# Export android path
echo -e "\n# Add Android tools to the PATH" >> ~/.zshrc
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

# brew install --cask android-sdk

### UNCOMMENT THE SINGLE # LINES BELOW, IF YOU SET UP ADROID SDK WITH BREW and comment the lines below '### Export android home path ###' ###
# Set ANDROID_HOME and add it to the PATH
# echo 'export ANDROID_HOME="/opt/homebrew/Caskroom/android-sdk/latest"' >> ~/.zshrc
# echo 'export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"' >> ~/.zshrc
# source ~/.zshrc

### Export android home path ###
echo -e "\n# Add Android tools to the PATH" >> ~/.zshrc
echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"' >> ~/.zshrc
echo 'export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/cmdline-tools/latest/:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"' >> ~/.zshrc
source ~/.zshrc

# Accept Android SDK licenses
flutter doctor --android-licenses

# Install Fastlane 
# I decided to use the project recommended way to install and manage fastlane, using a Gemfile
# brew install fastlane

## Set install path for gems to home directory and Install cocoa pods
# RUBY HOME
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

##Install cocoa pods
gem install cocoapods
# realised activesupport may have incompatible version, so the following checks for error and fixes it
if [ $? -ne 0 ]; then
    gem install activesupport -v 6.1.7.3
    gem install cocoapods
fi

# Install bundler to help manage ruby dependencies
gem install bundler

# Set up Xcode command line tools
sudo xcode-select --install
# sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer #REQUIRED if multiple versions of Xcode and CLI tools are installed

# Accept Xcode license agreement
sudo xcodebuild -license accept

# check everything is good on flutter front
flutter doctor
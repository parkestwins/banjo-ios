fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios bootstrap
```
fastlane ios bootstrap
```
Install dependencies
### ios spur
```
fastlane ios spur
```
Test lane for Spur demonstration
### ios test
```
fastlane ios test
```
Run tests
### ios certs
```
fastlane ios certs
```
Generate new certificates
### ios beta
```
fastlane ios beta
```
Deploy test build using Crashlytics Beta
### ios release
```
fastlane ios release
```
Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

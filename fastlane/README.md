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
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios certs
```
fastlane ios certs
```
Fetches the provisioning profiles so you can build locally and deploy to your device
### ios test
```
fastlane ios test
```
Runs all tests
### ios build
```
fastlane ios build
```
Build
### ios pr
```
fastlane ios pr
```
PR Build
### ios beta
```
fastlane ios beta
```
Upload to TestFlight

----

## Mac
### mac certs
```
fastlane mac certs
```
Fetches the provisioning profiles so you can build locally and deploy to your device
### mac test
```
fastlane mac test
```
Runs all tests
### mac build
```
fastlane mac build
```
Build
### mac ci
```
fastlane mac ci
```
CI Build

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

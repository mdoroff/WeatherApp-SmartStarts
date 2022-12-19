# Package Overview

Much of the functionality of the Smart Start is broken out into reusable modules. This is done in part, by leveraging [Swift Package Manager](https://developer.apple.com/documentation/xcode/swift-packages)
Go through the below list to determine what additional packages your app may want or need.

## Networking Stack
There are two common networking stacks in iOS applications, these are usually either RESTful or GraphQL based.
In the event your project requires both, you can include both

- Integrating with a RESTful API?
Please look into adding the [iOS-URLNetwork package](https://github.com/Deloitte/iOS-URLNetwork)
- Integrating with a GraphQL API?
Please look into adding the [iOS-Apollo package](https://github.com/Deloitte/iOS-Apollo)

## Analytics
- Analytics Kit is included by default. The default just simply logs analytic events to the console. It is easy to replace the actual underlying analytics back end with something else. The Template target by default has some boilerplate set up code for this.
[Apple-AnalyticsKit](https://github.com/Deloitte/Apple-AnalyticsKit)

### Analytics System Adapters
- Does your client use Adobe Analytics?
Include [Adobe Analytics Plugin](https://github.com/Deloitte/dd-adobe-analytics-apple)
- Does your client use google firebase analytics? 
Include [Google Firebase Analytics Plugin](https://github.com/Deloitte/dd-firebase-analytics-apple)

## Additional specific tools
- Working with webviews, or webviews that require authentication?
This is a SwiftUI compatibile view component
[iOS-AuthenticatedWebview package](https://github.com/Deloitte/iOS-AuthenticatedWebView)
- Needing a mechanism for recommending or forcing users to upgrade their app in the field?
This tool allows a client who releases an update to their app to force a pop up on previous versions of the app that require the user to update .
[ForceUpgrade package](https://github.com/Deloitte/ForceUpgrade)
- Need to work with the Keychain?
Simple keychain wrapper for iOS apps, very similar to many of the popular open source ones out there.
[SwiftKeychain package](https://github.com/Deloitte/Swift-Keychain)
- Some generic helpers (iOS-Utilities)
Please look through this package to see if anything might be helpful for your project. It's goal is to have some common helpers that may be beneficial on multiple different projects.
[iOS-Utilities package](https://github.com/Deloitte/iOS-Utilities)

## Unit testing support
- Quick and Nimble are frameworks that work on top of XCTest. These help clean up unit tests to be much more readable and easier to construct. They follow a "behavior driven model", see more at the links below. These are highly reccomended to use as opposed to vanilla XCTest and are also fairly popular in the iOS community.
- Quick https://github.com/Quick/Quick (A behavior driven test structure, similar to [rspec](https://rspec.info))
- Nimble https://github.com/Quick/Nimble (Matchers)

## Non Package support
Some code is included in this project under the "Common" folder, these are currently not included via packages but can be removed if they are not needed.
- A helpful Environment Manager can be found in ./Common/EnvironmentConfiguration - please see the documentation [here](./Common/EnvironmentConfiguration/EnvironmentConfiguration.md) on how to work with it.
- There are some semi reusable authentication SwiftUI view helpers which can be found in ./Common/MockLogin . Please feel free to modify these as needed, they are to provide a starting point for integrating a login or sign up type of view
- Logging support. There is a generic console logger, with support for your own custom logging outputs. The default one is using Apple's "os.Logger" underneath. This is located at ./Common/Logging
- A few generic helpers are located in ./Common/Utilities
- ./Common/Cleanse can be ignored, or deleted unless you are using the [Cleanse IOC container](https://github.com/square/Cleanse). Some of the example projects are currently using it

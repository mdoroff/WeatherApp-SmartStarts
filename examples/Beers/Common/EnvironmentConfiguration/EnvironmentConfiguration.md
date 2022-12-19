#  Environment Configuration

Environment Configurations let user to switch between environments like : DEV, QA, UAT, PROD. 
We can choose the environments from the Settings app. It incorporates multiple API's and endpoints.
Default environment has been set to "DEV" for each APIs in the Settings app.

# How it works

After a successful build , we can see our app name in the Settings. And from there we can select the API environment we need.
Settings.bundle lists the APIs and the corresponding environments. 
We have an Environment.plist listing the endpoints for each environments.
The key in the Environment.plist and the identifier in the Root.plist(Settings.bundle) should match for it to map and find the corresponding url.

# How to shift to a different API

In the Request.swift, we have instances for calling each API. So if we need to change the API, go to the "AppNetworkWrapper" and call an alternate one.

# Production deployment

Currently, the EnvironmentManager itself should not be used in a production (PROD / app store release) release builds. We generally do not want end users to see testing endpoints, or have the ability to change to testing endpoints. Currently, the best practice for handling this is to wrap your EnvironmentManager code in a `#if PROD #else #endif` block where the `#if PROD` portion should have your APi
s production URL hardcoded, and the `#else` code should use the EnvironmentManager to return the URL.
Additionally, for security reasons, it may make sense to not even ship the `Environment.plist` file to prod, you will need to set up a separate app target designed for prod resources only that ensure the Environment plist isn't included and the Settings bundle does not have references to environments or other debug settings.

Example code
```
#if !PROD
// Only initialize the EnvironmentManager when not in PROD (release / app store builds)
private let environmentManager: EnvironmentManager = EnvironmentManager(environmentFileName: "Environments", defaultEnv: .dev, apiKey: "primaryAPI")
#endif

var baseApiUrl: URL {
    #if PROD
    // Fill in your API's production URL here
    return URL(string: "some.api.com/v1/")!
    #else
    do {
        return try environmentManager.getHostUrl()
    } catch {
        // if we hit this case the developer has misconfigured the EnvironmentManager. check Settings bundle and the Environment.plist
        preconditionFailure()
    }
    #endif
}
```

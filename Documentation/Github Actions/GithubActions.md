# Github Actions
The smart start project currently has some basic continuous integration (CI) automation via github actions. This can be found here https://github.com/Deloitte/dd-smartstart-apple/actions

Every time a PR is opened or merged to `main`, a build will run that will attempt to build all of the targets. Currently it only builds them for simulator and there is no ipa file or archive generated. It is primarily used as a check to make sure code isn't broken within the project itself.

# Fastlane
Most of the build actions occur via [fastlane](https://fastlane.tools). There is a fastfile found within the template folder. 

The fastlane is responsible for running the actual `xcodebuild` scripts via the `gym` command. There is also some included support for `scan` (which will run unit or other automated tests) and swiftlint.

In a real app, you will most likely want to actually deploy test builds of your app for QA or client testing. You will need to do a lot more setup as you will need to make sure the CI system has access to the correct code signing cert, as well as any API keys necessary for your given distribution platform (testflight, hockey app, etc).

# Configuration
You can check out the details of the github action via the ios.yml file in the root of the project, or on github.com for details.

Here is a quick run down of what's going on.

1. It ensures we are running a Mac OS12 agent (Monterrey)
1. It ensures the working directory is the `default` template project directory
1. Currently, xocde 14.x is used, this can be updated but testing should be done to make sure the apps all still build
1. `actions/checkout` is performed which clones the repo
1. ruby is set up (needed for fastlane)
1. the next two [extractiosn/netrc](https://github.com/extractions/netrc) are used for properly configuring authentication for the build agent so that it  check out additional private deloitte swift packages. (more info on netrc can be found [here](https://everything.curl.dev/usingcurl/netrc))
    1. **Important Note** If using netrc to authenticate the project also must make sure that any private swift packages are added using `https` and not ssh (`git@`)
    1. it is possible github actions might use either github.com or api.github.com so both are configured
    1. A PAT (Personal access token) is needed to actually perform the authentication, currently the actions are using a PAT from Elle's deloitte github account. You will need to generate your own if you are using github actions on a new repo. It should have the following scopes (admin:public_key, repo, user, write:discussion)
    ![PAT](./images/netrc-PAT.p)
1. Finally, the fastlane lane `build_all` is ran, which will run swiftlint and build all of the apps in the project to ensure nothing is broken
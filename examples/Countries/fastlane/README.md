fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build_all

```sh
[bundle exec] fastlane ios build_all
```

Build and test all targets

### ios test_all

```sh
[bundle exec] fastlane ios test_all
```

Runs test scehemes

### ios build_scheme

```sh
[bundle exec] fastlane ios build_scheme
```

Builds the app for a given scheme

### ios test_app

```sh
[bundle exec] fastlane ios test_app
```



### ios lint

```sh
[bundle exec] fastlane ios lint
```

Runs unit tests

### ios beta

```sh
[bundle exec] fastlane ios beta
```



### ios release

```sh
[bundle exec] fastlane ios release
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

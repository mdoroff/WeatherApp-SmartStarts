# Build Configurations

The SmartStart includes the following [Build Configurations](https://www.kodeco.com/21441177-building-your-app-using-build-configurations-and-xcconfig) in addition to the in-built *Debug* and *Release* configurations:

* *Staging-Debug*: Derived from the in-built *Debug* config, this is intended to be used for builds used by the QA team for integration testing
* *Staging-Release*: Derived from the in-built *Release* config, this is intended to be used for builds used by the QA team for performance testing and for UAT
* *Production*: Derived from the in-built *Release* config, this is intended to be used for production builds 

Currently the only difference between these is that for Production, an Active Compilation Condition parameter called PROD has been added that enables us to distinguish a production build from others. Specifically, we can then ad conditional compilation for prod builds using:

```swift
#if PROD
// do something
#else 
// optionally do something else
#endif
```



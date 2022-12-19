# MetricKit

MetricKit is an iOS SDK provided by Apple to monitor App Performance and Battery Usage within your application.

It was first released with iOS 13 and received updates in iOS 14

The current version in MetricKit 2.0

# Background: 

Apple automatically collects metrics from apps installed on the App Store while your app is being used and presents it in graphical format in Xcode’s organiser. 

You can view them by following the below steps:

* Step 1: Select the App in the left top. 
* Step 2: Select the require Metric in the left pane to view the corresponding data. 
* Step 3: Apply the filters in the top to narrow down the data.

 ![](/api/attachments.redirect?id=e3685982-df08-4adb-876b-93768147b3cb)


Here are all the metrics that it provides. More details can be found [here](https://developer.apple.com/documentation/appstoreconnectapi/metriccategory)


1. **Battery Usage**: The amount of battery power the app uses over a 24 hour period when the device is disconnected from power.
2. **Disk Writes**: The amount of megabytes per day the app writes to long term storage.
3. **Hang Rate:** The number of seconds per hour that the main thread of the app is unresponsive for more than 250ms, which is the maximum amount of time an app can respond to a typical user event before the user perceives it as slow.
4. **Launch Time**: The average launch time, which is the time between the user tapping on your app icon and the time that the system draws a screen other than the launch screen. The launch time is measured in milliseconds.
5. **Memory**: The amount of memory the app uses, in megabytes.
6. **Scrolling**: The duration of pauses that occur while scrolling an app.
7. **Terminations**: The average amount of non-user-initiated app terminations, including background terminations, per day.

These metrics can be filtered by-

* Device model
* App Version

# Use cases


1. As a developer, we want to analyze the performance of an enterprise app. Then we can integrate MetricKit in our app and implement the MXMetricManagerSubscriber delegate methods that will receive the Metrics for processing. The Xcode’s Organizer metrics will be unavailable in this case.
2. It helps to uncover the issues that you might not have seen while testing locally, and allows you to track improvement\ deterioration across different versions of your app. For example if you see a issue in performance of the app after a new release. It means there is some piece of code that in last release that needs improvements. you can do in two ways: 

   
   1. You can see Metric data represented as bar chart  in Xcode’s organiser for the last few releases, which can be filtered and compared.
   2. If you are collecting data daily by sending it to your backend for processing, then this data also can be represented in graphical format for analysing.
3. You don’t get access to all the performance metrics in Xcode’s Organizer. For E.g: MXCellularConditionMetric is only accessible from MetricKit sdk.
4. Xcode’s organizer provides a set of predefined Metrics to track. But if you want to track custom events in your app, then organiser does not have any option. In this case you will need to integrate MetricKit SDK.

# Introduction

* Used to analyze and improve the performance of your app.
* It allows you to receive on-device app diagnostics, power and performance metrics that the system captures daily.
* It sends metric reports at most once per day, and diagnostic reports immediately in iOS 15+.
*  The data in reports can be converted in JSON format which can then be sent to your own server where it can be visualised and analysed.
* It complements the Xcode Organizer Metrics by providing a programmatic way to receive daily information about your app’s performance.
* With this information, you can collect, aggregate, and analyse the data on your own in greater detail than through Xcode’s Organizer. 
* Following are the [metrics](https://developer.apple.com/documentation/metrickit) available in the SDK:

### **Battery metrics**


1. **MXCellularConditionMetric**: An object representing metrics about the condition of the cellular network.
2. **MXCPUMetric**: An object representing metrics about the use of the CPU.
3. **MXDisplayMetric:** An object representing metrics about the power used to display the app on the screen.
4. **MXGPUMetric**: An object representing metrics about the use of the GPU.
5. **MXLocationActivityMetric**: An object representing metrics about the use of location-tracking features of a device.
6. **MXNetworkTransferMetric**: An object representing metrics about network transfers.
7. **MXCPUExceptionDiagnostic**: An object representing a diagnostic report for a fatal or nonfatal CPU exception.

### **Performance metrics**


1. **MXAppLaunchDiagnostic**: A diagnostic subclass that encapsulates app launch diagnostic reports.
2. **MXAppExitMetric**: An object representing metrics about the types of foreground and background app exits.
3. **MXAppRunTimeMetric:** An object representing metrics about the amount of time the app is active.
4. **MXMemoryMetric**: An object representing metrics about the app’s memory use.
5. **MXCrashDiagnostic**: An object representing a diagnostic report for an app crash.

### **Responsiveness metrics**


1. **MXAnimationMetric**: An object representing metrics about the responsiveness of animation in the app.
2. **MXAppLaunchMetric**: An object representing metrics about app launch time.
3. **MXAppResponsivenessMetric:** An object representing metrics about the responsiveness of the app to user interaction.
4. **MXHangDiagnostic**: An object representing a diagnostic report for an app that is too busy to handle user input responsively.

### **Disk access metrics**


1. **MXDiskIOMetric**: An object representing metrics about disk usage.
2. **MXDiskWriteExceptionDiagnostic**: An object representing a diagnostic report for a disk write exception.

### **Custom metrics**


1. **MXSignpostMetric**: An object representing a custom metric class

   \

# Implementation


1. Import the MetricKit framework at the top of the file.

   ```swift
   import MetricKit
   ```
2. Add below code into viewDidLoad() or init(). This accesses MetricManager provided by the framework. Then adds self, the container Instance, as a subscriber to metricManager, which enables it to listen for a metrics payload from the OS.

   \
   ```swift
   class MetricsManager: NSObject {
   
       override init() {
           super.init()
           MXMetricManager.shared.add(self)
       }
     ...
   }
   ```

   \
3. The Manager also has remove(_ :), which allows you to remove a subscriber at any point.

   ```swift
   class MetricsManager: NSObject {
       ...
       deinit {
           MXMetricManager.shared.remove(self)
       }
   }
   ```
4. Below is an extension on your Instance that conforms to MXMetricManagerSubscriber, which contains two methods that can receive payloads from MetricKit. In this case, when receiving the payload, you simply print it to the console. However, in your production version, you can send this data to your server for visualisation.

   \
   ```swift
   // MARK: MetricKit Manager subscriber implementation
   extension MetricsManager: MXMetricManagerSubscriber {
       func didReceive(_ payloads: [MXMetricPayload]) {
           guard let firstPayload = payloads.first else { return }
           if let jsonString = String(data: firstPayload.jsonRepresentation(), encoding: .utf8) {
               print(jsonString)
               // TODO: Save to disk or send to server for processing
           }
   
       }
   
         func didReceive(_ payloads: [MXDiagnosticPayload]) {
           guard let firstPayload = payloads.first else { return }
             if let jsonString = String(data: firstPayload.jsonRepresentation(), encoding: .utf8) {
                 print(jsonString)
                 // TODO: Save to disk or send to server for processing
             }
         }
   }
   ```

   \
5. You can add Custom metrics by adding a Log Handle which is like a bucket use to hold the custom metrics. The MetricsManager provides us with a method to create and return this logHandle.

   ```swift
   private let fruitsLogHandle = MetricsManager.logHandle(for: "Fruits")
   ```


6. Then using mxSignpost you can log a custom metric within the Fruits bucket for a particular event (tap on a fruit row) or for an event duration (start and end of an event).

   ```swift
   mxSignpost(.event, log: fruitsLogHandle, name: "Fruit Row Tapped")
   ```
7. User can trigger the `didReceive(_ payloads: [MXMetricPayload])` by going to Xcode → Debug → Simulate MetricKit Payloads for for debugging purpose.

# Sample MetricKit Payload:

```json
{
  "locationActivityMetrics" : {
    "cumulativeBestAccuracyForNavigationTime" : "20 sec",
    "cumulativeBestAccuracyTime" : "30 sec",
    "cumulativeHundredMetersAccuracyTime" : "30 sec",
    "cumulativeNearestTenMetersAccuracyTime" : "30 sec",
    "cumulativeKilometerAccuracyTime" : "20 sec",
    "cumulativeThreeKilometersAccuracyTime" : "20 sec"
  },
  "cellularConditionMetrics" : {
    "cellConditionTime" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 20,
          "bucketStart" : "1 bars",
          "bucketEnd" : "1 bars"
        },
        "1" : {
          "bucketCount" : 30,
          "bucketStart" : "2 bars",
          "bucketEnd" : "2 bars"
        },
        "2" : {
          "bucketCount" : 50,
          "bucketStart" : "3 bars",
          "bucketEnd" : "3 bars"
        }
      }
    }
  },
  "metaData" : {
    "appBuildVersion" : "1",
    "osVersion" : "iPhone OS 16.0.2 (20A380)",
    "regionFormat" : "IN",
    "platformArchitecture" : "arm64e",
    "bundleIdentifier" : "com.raywenderlich.ShoppingTrolley27",
    "deviceType" : "iPhone11,8"
  },
  "gpuMetrics" : {
    "cumulativeGPUTime" : "20 sec"
  },
  "memoryMetrics" : {
    "peakMemoryUsage" : "200000 kB",
    "averageSuspendedMemory" : {
      "averageValue" : "100000 kB",
      "standardDeviation" : 0,
      "sampleCount" : 500
    }
  },
  "applicationExitMetrics" : {
    "backgroundExitData" : {
      "cumulativeAppWatchdogExitCount" : 1,
      "cumulativeMemoryResourceLimitExitCount" : 1,
      "cumulativeBackgroundURLSessionCompletionTimeoutExitCount" : 1,
      "cumulativeBackgroundFetchCompletionTimeoutExitCount" : 1,
      "cumulativeAbnormalExitCount" : 1,
      "cumulativeSuspendedWithLockedFileExitCount" : 1,
      "cumulativeIllegalInstructionExitCount" : 1,
      "cumulativeMemoryPressureExitCount" : 1,
      "cumulativeBadAccessExitCount" : 1,
      "cumulativeCPUResourceLimitExitCount" : 1,
      "cumulativeBackgroundTaskAssertionTimeoutExitCount" : 1,
      "cumulativeNormalAppExitCount" : 1
    },
    "foregroundExitData" : {
      "cumulativeBadAccessExitCount" : 1,
      "cumulativeAbnormalExitCount" : 1,
      "cumulativeMemoryResourceLimitExitCount" : 1,
      "cumulativeNormalAppExitCount" : 1,
      "cumulativeCPUResourceLimitExitCount" : 1,
      "cumulativeIllegalInstructionExitCount" : 1,
      "cumulativeAppWatchdogExitCount" : 1
    }
  },
  "displayMetrics" : {
    "averagePixelLuminance" : {
      "averageValue" : "50 apl",
      "standardDeviation" : 0,
      "sampleCount" : 500
    }
  },
  "signpostMetrics" : [
    {
      "signpostIntervalData" : {
        "histogrammedSignpostDurations" : {
          "histogramNumBuckets" : 3,
          "histogramValue" : {
            "0" : {
              "bucketCount" : 50,
              "bucketStart" : "0 ms",
              "bucketEnd" : "100 ms"
            },
            "1" : {
              "bucketCount" : 60,
              "bucketStart" : "100 ms",
              "bucketEnd" : "400 ms"
            },
            "2" : {
              "bucketCount" : 30,
              "bucketStart" : "400 ms",
              "bucketEnd" : "700 ms"
            }
          }
        },
        "signpostCumulativeHitchTimeRatio" : "50 ms per s",
        "signpostCumulativeCPUTime" : "30000 ms",
        "signpostAverageMemory" : "100000 kB",
        "signpostCumulativeLogicalWrites" : "600 kB"
      },
      "signpostCategory" : "TestSignpostCategory1",
      "signpostName" : "TestSignpostName1",
      "totalSignpostCount" : 30
    },
    {
      "signpostIntervalData" : {
        "histogrammedSignpostDurations" : {
          "histogramNumBuckets" : 3,
          "histogramValue" : {
            "0" : {
              "bucketCount" : 60,
              "bucketStart" : "0 ms",
              "bucketEnd" : "200 ms"
            },
            "1" : {
              "bucketCount" : 70,
              "bucketStart" : "201 ms",
              "bucketEnd" : "300 ms"
            },
            "2" : {
              "bucketCount" : 80,
              "bucketStart" : "301 ms",
              "bucketEnd" : "500 ms"
            }
          }
        },
        "signpostCumulativeCPUTime" : "50000 ms",
        "signpostAverageMemory" : "60000 kB",
        "signpostCumulativeLogicalWrites" : "700 kB"
      },
      "signpostCategory" : "TestSignpostCategory2",
      "signpostName" : "TestSignpostName2",
      "totalSignpostCount" : 40
    }
  ],
  "cpuMetrics" : {
    "cumulativeCPUTime" : "100 sec",
    "cumulativeCPUInstructions" : "100 kiloinstructions"
  },
  "networkTransferMetrics" : {
    "cumulativeCellularDownload" : "80000 kB",
    "cumulativeWifiDownload" : "60000 kB",
    "cumulativeCellularUpload" : "70000 kB",
    "cumulativeWifiUpload" : "50000 kB"
  },
  "diskIOMetrics" : {
    "cumulativeLogicalWrites" : "1300 kB"
  },
  "applicationLaunchMetrics" : {
    "histogrammedTimeToFirstDrawKey" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 50,
          "bucketStart" : "1000 ms",
          "bucketEnd" : "1010 ms"
        },
        "1" : {
          "bucketCount" : 60,
          "bucketStart" : "2000 ms",
          "bucketEnd" : "2010 ms"
        },
        "2" : {
          "bucketCount" : 30,
          "bucketStart" : "3000 ms",
          "bucketEnd" : "3010 ms"
        }
      }
    },
    "histogrammedResumeTime" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 60,
          "bucketStart" : "200 ms",
          "bucketEnd" : "210 ms"
        },
        "1" : {
          "bucketCount" : 70,
          "bucketStart" : "300 ms",
          "bucketEnd" : "310 ms"
        },
        "2" : {
          "bucketCount" : 80,
          "bucketStart" : "500 ms",
          "bucketEnd" : "510 ms"
        }
      }
    },
    "histogrammedExtendedLaunch" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 50,
          "bucketStart" : "1000 ms",
          "bucketEnd" : "1010 ms"
        },
        "1" : {
          "bucketCount" : 60,
          "bucketStart" : "2000 ms",
          "bucketEnd" : "2010 ms"
        },
        "2" : {
          "bucketCount" : 30,
          "bucketStart" : "3000 ms",
          "bucketEnd" : "3010 ms"
        }
      }
    },
    "histogrammedOptimizedTimeToFirstDrawKey" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 50,
          "bucketStart" : "1000 ms",
          "bucketEnd" : "1010 ms"
        },
        "1" : {
          "bucketCount" : 60,
          "bucketStart" : "2000 ms",
          "bucketEnd" : "2010 ms"
        },
        "2" : {
          "bucketCount" : 30,
          "bucketStart" : "3000 ms",
          "bucketEnd" : "3010 ms"
        }
      }
    }
  },
  "applicationTimeMetrics" : {
    "cumulativeForegroundTime" : "700 sec",
    "cumulativeBackgroundTime" : "40 sec",
    "cumulativeBackgroundAudioTime" : "30 sec",
    "cumulativeBackgroundLocationTime" : "30 sec"
  },
  "timeStampEnd" : "2022-11-14 23:59:00",
  "animationMetrics" : {
    "scrollHitchTimeRatio" : "1000 ms per s"
  },
  "applicationResponsivenessMetrics" : {
    "histogrammedAppHangTime" : {
      "histogramNumBuckets" : 3,
      "histogramValue" : {
        "0" : {
          "bucketCount" : 50,
          "bucketStart" : "0 ms",
          "bucketEnd" : "100 ms"
        },
        "1" : {
          "bucketCount" : 60,
          "bucketStart" : "100 ms",
          "bucketEnd" : "400 ms"
        },
        "2" : {
          "bucketCount" : 30,
          "bucketStart" : "400 ms",
          "bucketEnd" : "700 ms"
        }
      }
    }
  },
  "appVersion" : "1.0",
  "timeStampBegin" : "2022-11-14 00:00:00"
}
```

# Limitations

* The organizer data will be available only when the app is available on Appstore or if it is distributed via TestFlight.
* MetricKit only works on a real iOS device and isn’t compatible with the simulator. 


# Conclusion

* In cases where the Organizer’s metrics is not available. The data provided by MetricKit can be sent to server and consolidated to represent and analyse the different metrics and the trends across multiple versions of the App.
* User can also add his custom metrics as per his requirements.
* Learn more about this sdk [here](https://www.kodeco.com/20952676-monitoring-for-ios-with-metrickit-getting-started)

  \
  \


\


//
//  MetricsManager.swift
//  URLSession-Example
//
//  Created by Prakash Khedekar, Harshad on 14/11/22.
//
import Foundation
import MetricKit

/*
 MetricsManager is a singleton class to initialize the MXMetricManager provided by the MetricKit framework.
 */
class MetricsManager: NSObject {

    static let shared = MetricsManager()

    private override init() {
        super.init()
        // Here we add MetricsManager as a subscriber to MXMetricManager, which enables it to listen for a metrics payload from the OS.
        MXMetricManager.shared.add(self)
    }

    deinit {
        // Removing self as subscriber on de-initialization.
        MXMetricManager.shared.remove(self)
    }

    // Create and returns a log handle for holding Custom Metrics
    class func logHandle(for category: String) -> OSLog {
        MXMetricManager.makeLogHandle(category: category)
    }
}

// MARK: MetricKit Manager subscriber implementation
/* MXMetricManagerSubscriber protocol is implemented by our MetricsManager in order to receive the MetricPayloads and DiagnosticPayloads respectively
 */
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

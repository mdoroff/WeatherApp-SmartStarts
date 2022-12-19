//
//  FruitsApp.swift
//  FruitsApp
//
//  Created by Prakash Khedekar, Harshad on 16/11/22.
//

import SwiftUI
import MetricKit

@main
struct FruitsApp: App {
    private let metricManager = MetricsManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

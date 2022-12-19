//
//  ContentViewModel.swift
//  MetricKit-Example
//
//  Created by Prakash Khedekar, Harshad on 16/11/22.
//

import Foundation
import MetricKit

struct ContentViewModel {
    let fruits = ["🍏 Apple", "🍌 Banana", "🍓 Strawberry"]
    private let fruitsLogHandle = MetricsManager.logHandle(for: "Fruits")

    func rowTapped(fruit: String) {
        print("\(fruit) tapped !!!")
        mxSignpost(.event,
                   log: fruitsLogHandle,
                   name: "Fruit Row Tapped")
    }
}

//
//  ForecastsAPIRequests.swift
//  Template
//
//  Created by Doroff, Mike on 12/15/22.
//

import Foundation
import iOS_URLNetwork

struct FetchForecasts: GETRequestOperation {
    
    typealias Model = ForecastModel
    
    var path: String
    var headers: [String : String]?

    init(path: String) {
        self.path = path
    }
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        items.append(.init(name: "apikey", value: "EC29nmHp0BuDAaApA7tgezJpl067gCN8"))
        return items
    }
}

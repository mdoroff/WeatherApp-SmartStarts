//
//  Requests.swift
//  GraphQL-Example
//
//  Created by Jackson Booth on 6/16/22.
//

import Foundation
import Apollo

struct EndPoints {
    #if DEBUG
    static let baseSpacexAPI = URL(string: "https://api.spacex.land/graphql/")!
    #else
    // This is for example purposes. this environment doesnt actually exist
    static let baseSpacexAPI = URL(string: "https://qa.api.spacex.land/graphql/")!
    #endif
}

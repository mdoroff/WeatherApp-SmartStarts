//
//  Launch.swift
//  GraphQL-Example
//
//  Created by Jackson Booth on 6/9/22.
//

import Foundation
import iOS_ApolloNetwork
import Apollo

struct FetchLaunches: ApolloQuery {
    
    typealias Query = LaunchesQuery
    typealias Model = Launches
    
    func generateRequest() throws -> LaunchesQuery {
        return LaunchesQuery()
    }
}

struct Launches: GraphQLFillable {
    
    typealias GQLData = LaunchesQuery.Data
    
    let launches: [Launch]
    
    init(data: GraphQLResult<LaunchesQuery.Data>) throws {
        guard let launchesData = data.data?.launches else {
            launches = [Launch]()
            return
        }
        
        let nonOptionalLaunches = launchesData.filter { $0 != nil}
        launches = nonOptionalLaunches.compactMap { Launch(from: $0!) }
    }
    
}

struct Launch: Identifiable {
    let id: String
    let missionName: String?
    let launchDate: Date?
    
    init(from launchData: LaunchesQuery.Data.Launch) {
        id = launchData.id ?? ""
        missionName = launchData.missionName
        
        guard let dateString = launchData.launchDateLocal else {
            launchDate = nil
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        
        launchDate = date
    }
}

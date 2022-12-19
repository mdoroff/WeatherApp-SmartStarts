import Foundation
import iOS_ApolloNetwork
import Apollo

struct FetchLaunch: ApolloQuery {
    
    typealias Query = LaunchQuery
    typealias Model = LaunchDetail
    
    let launchId: String
    
    func generateRequest() throws -> LaunchQuery {
        return LaunchQuery(launchId: launchId)
    }
    
}

struct LaunchQueryError: Error {}

struct LaunchDetail: GraphQLFillable {
    
    typealias GQLData = LaunchQuery.Data
    
    let missionName: String?
    let details: String?
    let launchDate: Date?
    let launchSite: String?
    let rocketType: String?
    
    init(data: GraphQLResult<LaunchQuery.Data>) throws {
        if let launchData = data.data?.launch {
            missionName = launchData.missionName
            details = launchData.details
            launchSite = launchData.launchSite?.siteName
            rocketType = launchData.rocket?.rocketType
            
            guard let dateString = launchData.launchDateLocal else {
                launchDate = nil
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            launchDate = dateFormatter.date(from: dateString)
        } else {
            throw LaunchQueryError()
        }
    }
}

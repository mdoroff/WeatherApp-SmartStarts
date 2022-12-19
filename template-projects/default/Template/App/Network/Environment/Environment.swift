import Foundation

/// Define your endpoints here.
class EndPoints {

    static let global = EndPoints()
    
    // Add additional environment managers per API / back end. An EnvironmentManager manages the environment of one API at a time
    #if !PROD
    private let environmentManager: EnvironmentManager = EnvironmentManager(environmentFileName: "Environments", defaultEnv: .dev, apiKey: "primaryAPI")
    #endif
    
    var baseApiUrl: URL {
        #if PROD
        // Fill in your API's production URL here
        return URL(string: "https://dataservice.accuweather.com")!
        #else
        do {
            return try environmentManager.getHostUrl()
        } catch {
            preconditionFailure("Failed to fetch base URL. Please ensure you have configured your Settings.bundle and your Environment.plist file properly.\nerror:\(error)")
        }
        #endif
    }
}

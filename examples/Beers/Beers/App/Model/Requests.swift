import iOS_URLNetwork
import Foundation

/// Use case example follows
/// EndPoints
class EndPoints {
    static let global = EndPoints()
    
    var beerApiMgr: EnvironmentManager
    var contentApiMgr: EnvironmentManager
    var productCatalogApiMgr: EnvironmentManager
    
    init() {
        beerApiMgr = EnvironmentManager(defaultEnv: EnvironmentTypes.dev, apiKey: "beerApi")
        contentApiMgr = EnvironmentManager(defaultEnv: EnvironmentTypes.dev, apiKey: "contentApi")
        productCatalogApiMgr = EnvironmentManager(defaultEnv: EnvironmentTypes.dev, apiKey: "productCatalogApi")
    }

    var beerApi: URL {
        #if PROD
        URL(string: "https://api.punkapi.com/v2")!
        #else
        // swiftlint:disable:next force_try
        try! beerApiMgr.getHostUrl()
        #endif
    }
    // swiftlint:disable:next force_try
    var contentApi: URL { try! contentApiMgr.getHostUrl() }
    // swiftlint:disable:next force_try
    var productCatalogApi: URL { try! productCatalogApiMgr.getHostUrl() }
}

/// Requests
/// Concrete "FetchBeers" request for fetching a list of beers
struct FetchBeers: GETRequestOperation {
    typealias Model = [Beer]
    let path: String = "/beers"
    
    var queryItems: [URLQueryItem]? {
        return [.init(name: "page", value: "1")]
    }
}

struct FetchSpecificBeer: GETRequestOperation {
    var path: String { return "/beers/\(beerId)" }
    typealias Model = Beer
    
    let beerId: String
    init(beerId: String) {
        self.beerId = beerId
    }
}

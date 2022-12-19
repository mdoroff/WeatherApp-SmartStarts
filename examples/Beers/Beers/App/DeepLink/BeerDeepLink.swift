import Foundation
// Concrete impl of a DeepLink for this app

// exampleApp.com://beers
// exampleApp.com://beers/123
// exampleApp.com://beers/random
enum BeerDeepLink: DeepLink {
    static let Host = "exampleapp.com"
    
    init(url: URL) throws {
        guard let urlcomps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw DeepLinkError.badURL(url)
        }
        
        guard urlcomps.host == Self.Host else {
            throw DeepLinkError.badHost(url.host)
        }
        
        switch urlcomps.path {
        case "beers", "beers/":
            self = .allBeer
        case "":
            // TODO: case starts with beers then pull off ID to create the link
            self = .beer(id: "1234")
        case "beers/random", "beers/random/":
            self = .random
        default:
            throw DeepLinkError.unknownPath(url.path)
        }
    }
    
    case allBeer
    case beer(id: String)
    case random
}

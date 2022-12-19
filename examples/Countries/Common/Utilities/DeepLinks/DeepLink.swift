import Foundation

extension URL {
    func asDeepLink<T: DeepLink>() throws -> T {
        return try T(url: self)
    }
}

/// Deep link stuff
protocol DeepLink {
    init(url: URL) throws
}

enum DeepLinkError: Error {
    case badHost(String?)
    case unknownPath(String?)
    case badURL(URL)
}

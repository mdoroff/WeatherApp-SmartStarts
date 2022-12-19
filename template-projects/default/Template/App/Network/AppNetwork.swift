import Foundation
import iOS_URLNetwork

/// This is an example of how to hold the pointer for the app's networking system. Your app most likely only wants to create one and reuse the same URLSessionNetworkType throughout your app (with some exceptions).
/// In a non Cleanse (or other DI framework) based app you would most likely store the AppNetwork as a singleton var somewhere and use it in your view models and services that way.
class AppNetwork {
    let network: URLSessionNetworkType

    /// - Parameter config: The `URLSessionNetworkConfiguration` to use
    init(config: URLSessionNetworkConfiguration) {
        do {
            network = try URLSessionNetworkFactory.buildNetwork(using: config)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }

    static let shared: AppNetwork = {
        let urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
        let endPointWrapper = BasicEndpointWrapper(url: EndPoints.global.baseApiUrl)
        let config = URLSessionNetworkConfiguration(session: urlSession, logLevel: .debug, endpoint: endPointWrapper)
        return AppNetwork(config: config)
    }()
}

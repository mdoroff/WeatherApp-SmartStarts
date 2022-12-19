import Foundation
import iOS_ApolloNetwork
import Apollo

/// The following is an example of how to consume the ApolloComponent in your app
/// If using cleanse you will need to also configure your own ApolloClientProtocol separately and bind it into the graph
struct AppNetworkWrapper {
    let network: ApolloNetworkType
    
    /// Standard initializer, used if you are setting up your network with Cleanse. The `ApolloComponent` should be installed as a component dependency somewhere in your graph and Cleanse will figure out the rest here.
    init(client: ApolloClientProtocol, factory: ComponentFactory<ApolloComponent>) {
        network = factory.build(client)
    }
    
    /// Using the ApolloNetworkFactory without cleanse
    init(client: ApolloClientProtocol) {
        do {
            network = try ApolloNetworkFactory.build(using: client)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
}

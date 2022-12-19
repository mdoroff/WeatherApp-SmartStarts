import Foundation
import iOS_ApolloNetwork
import Apollo

struct AppNetwork {
    static let shared = ApolloNetwork(client: ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!))
}

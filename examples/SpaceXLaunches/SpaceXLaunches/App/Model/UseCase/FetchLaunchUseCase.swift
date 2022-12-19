import Foundation
import Combine
import iOS_ApolloNetwork
import Apollo

protocol FetchLaunchUseCase {
    func fetchLaunch(id: String) -> AnyPublisher<LaunchDetail, Error>
}

class StandardLaunchUseCase: FetchLaunchUseCase {
    let networkWrapper: AppNetworkWrapper
    
    init(networkWrapper: AppNetworkWrapper) {
        self.networkWrapper = networkWrapper
    }
    
    func fetchLaunch(id: String) -> AnyPublisher<LaunchDetail, Error> {
        return networkWrapper.network.fetchPublisher(request: FetchLaunch(launchId: id))
            .eraseToAnyPublisher()
    }
}

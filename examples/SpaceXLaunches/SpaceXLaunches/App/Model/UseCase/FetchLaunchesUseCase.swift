import Foundation
import Combine
import iOS_ApolloNetwork
import Apollo

protocol FetchLaunchesUseCase {
    func fetchLaunches() -> AnyPublisher<[Launch], Error>
}

class StandardLaunchesUseCase: FetchLaunchesUseCase {
    let networkWrapper: AppNetworkWrapper
    
    init(networkWrapper: AppNetworkWrapper) {
        self.networkWrapper = networkWrapper
    }
    
    func fetchLaunches() -> AnyPublisher<[Launch], Error> {
        return networkWrapper.network.fetchPublisher(request: FetchLaunches())
            .compactMap { $0.launches }
            .eraseToAnyPublisher()
    }
}

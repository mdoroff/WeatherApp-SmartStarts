import Combine
import iOS_URLNetwork

protocol FetchBeerUseCase {
    func fetchBeer() -> AnyPublisher<[Beer], Error>
}

class StandardBeerUseCase: FetchBeerUseCase {
    let network: AppNetwork
    
    init(network: AppNetwork = AppNetwork.shared) {
        self.network = network
    }
    func fetchBeer() -> AnyPublisher<[Beer], Error> {
        return network.network.perform(request: FetchBeers())
            .eraseToAnyPublisher()
    }
}

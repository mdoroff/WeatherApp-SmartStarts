import Foundation
import Combine

class BeerListViewModel: ReducerViewModel, ObservableObject {
    private var cancellables: Set<AnyCancellable> = Set()
    private let input = PassthroughSubject<Event, Never>()
    @Published private(set) var state: State
        
    // Passed in Dependencies
    let useCase: FetchBeerUseCase
    
    init(useCase: FetchBeerUseCase = StandardBeerUseCase()) {
        self.useCase = useCase
        
        state = .idle
        
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                self.whenFetching(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: - ViewModel
    func send(_ event: Event) {
        input.send(event)
    }
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .fetching
            default:
                return state
            }
        case .fetching:
            switch event {
            case .onAppear:
                return .fetching
            case .onSuccess(let result):
                return .results(result)
            case .onFailed(let error):
                return .error(error)
            default:
                return state
            }
        case .results:
            return state
        case .error:
            switch event {
            case .fetch:
                return .fetching
            default:
                return state
            }
        }
    }
    
    private func whenFetching() -> Feedback<State, Event> {
        Feedback { [weak self] (state: State) -> AnyPublisher<Event, Never> in
            guard case .fetching = state else { return Empty().eraseToAnyPublisher() }
            guard let self = self else { return Empty().eraseToAnyPublisher() }
            return self.useCase.fetchBeer()
                .map { $0.map { beer in BeerViewModelFactory(beer: beer) } }
                .map(Event.onSuccess)
                .catch { Just(Event.onFailed($0)) }
                .eraseToAnyPublisher()
        }
    }
}

// Events and State
extension BeerListViewModel {
    enum Event {
        case onAppear
        case fetch
        case onSuccess([BeerViewModelFactory])
        case onFailed(Error)
    }
    
    enum State {
        case idle
        case fetching
        case results([BeerViewModelFactory])
        case error(Error)
    }
}

import Foundation
import Combine

class LaunchDetailViewModel: ReducerViewModel, ObservableObject {
    private var cancellables: Set<AnyCancellable> = Set()
    private let input = PassthroughSubject<Event, Never>()
    @Published private(set) var state: State
    
    let launchId: String
    let useCase: FetchLaunchUseCase
    let factory: LaunchDetailContentVMFactory
    
    init(launchId: AssistedInject<String>, useCase: FetchLaunchUseCase, factory: LaunchDetailContentVMFactory) {
        self.launchId = launchId.get()
        self.useCase = useCase
        self.factory = factory
        
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
            case .onSuccess(let launchDetail):
                return .result(launchDetail)
            case .onFailed(let error):
                return .error(error)
            default:
                return state
            }
        case .result:
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
            guard let self = self, case .fetching = state else { return Empty().eraseToAnyPublisher()}

            return self.useCase.fetchLaunch(id: self.launchId)
                .map { self.factory.build($0) }
                .map(Event.onSuccess)
                .catch { Just(Event.onFailed($0)) }
                .eraseToAnyPublisher()
        }
    }
}

// MARK: - Inner Types

extension LaunchDetailViewModel {
    enum Event {
        case onAppear
        case fetch
        case onSuccess(LaunchDetailContentViewModel)
        case onFailed(Error)
    }
    
    enum State {
        case idle
        case fetching
        case result(LaunchDetailContentViewModel)
        case error(Error)
    }
}

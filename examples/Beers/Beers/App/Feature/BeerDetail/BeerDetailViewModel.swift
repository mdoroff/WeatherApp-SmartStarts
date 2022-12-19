import Combine
import Foundation
import SwiftUI

class BeerDetailViewModel: ReducerViewModel, ObservableObject {
    private var cancellables: Set<AnyCancellable> = Set()
    private let input = PassthroughSubject<Event, Never>()
    @Published private(set) var state: State

    let beer: Beer
    let useCase: FavoriteBeerUseCaseType
    
    init(beer: Beer, useCase: FavoriteBeerUseCaseType = UserDefaultsFavoritedBeerUseCase()) {
        self.beer = beer
        self.useCase = useCase
        
        state = .idle(self.beer)
        
        Publishers.system(initial: state,
                          reduce: Self.reduce,
                          scheduler: RunLoop.main,
                          feedbacks: [Self.userInput(input: input.eraseToAnyPublisher()),
                                      toggleFavoriteFeedback(),
                                      currentFavoriteStatusFeedback()
                                     ])
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: - ReducerViewModel
    
    func send(_ event: Event) {
        input.send(event)
    }
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let beer):
            switch event {
            case .onAppear:
                return .fetchFavorite(beer: beer)
            default:
                return state
            }
        case .fetchFavorite:
            switch event {
            case .onFetchedFavorite(beer: let beer, favorited: let favorited):
                return .active(beer: beer, favorited: favorited)
            default:
                return state
            }
        case .active(beer: let beer, favorited: let favorited):
            switch event {
            case .toggleFavorite:
                return .toggling(beer: beer, favorited: favorited)
            default:
                return state
            }
        case .toggling:
            switch event {
            case .onToggled(beer: let beer, favorited: let favorited):
                return .active(beer: beer, favorited: favorited)
            default:
                return state
            }
        }
    }
    
    private func toggleFavoriteFeedback() -> Feedback<State, Event> {
        return Feedback { [weak self] (state: State) -> AnyPublisher<Event, Never> in
            guard let self = self else { return Empty().eraseToAnyPublisher() }
            guard case .toggling(beer: let beer, favorited: let favorited) = state else { return Empty().eraseToAnyPublisher() }
            if favorited {
                // removing
                return self.useCase
                    .removeFavorite(beer: beer.id)
                    .map { Event.onToggled(beer: beer, favorited: false) }
                    .catch { _ in return Empty() }
                    .eraseToAnyPublisher()
            } else {
                // adding
                return self.useCase
                    .addFavorite(beer: beer.id)
                    .map { Event.onToggled(beer: beer, favorited: true) }
                    .catch { _ in return Empty() }
                    .eraseToAnyPublisher()
            }
        }
    }
    
    private func currentFavoriteStatusFeedback() -> Feedback<State, Event> {
        return Feedback { [weak self] (state: State) -> AnyPublisher<Event, Never> in
            guard let self = self else { return Empty().eraseToAnyPublisher() }
            guard case .fetchFavorite(beer: let beer) = state else { return Empty().eraseToAnyPublisher() }
            return self.useCase
                .isBeerFavorite(beer: beer.id)
                .map { .onFetchedFavorite(beer: beer, favorited: $0) }
                .eraseToAnyPublisher()
        }
    }
}

extension BeerDetailViewModel {
    enum Event {
        case onAppear
        case onDisappear
        case onFetchedFavorite(beer: Beer, favorited: Bool)
        case onToggled(beer: Beer, favorited: Bool)
        
        // user input
        case toggleFavorite
    }
    
    enum State {
        case idle(Beer)
        case fetchFavorite(beer: Beer)
        case active(beer: Beer, favorited: Bool)
        case toggling(beer: Beer, favorited: Bool)
    }
}

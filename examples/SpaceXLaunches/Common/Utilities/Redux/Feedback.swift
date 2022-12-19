import Combine

/// Represents a side affect that will be ran given a certain state is met (i.e. fetching, user input, programatic navigation, analytics, etc)
/// You typically want to check for the specific State Event combination you care about and then return a publisher that will evaluate a new event.
///
/// For example, this could be used for handling a network call
/// ```
/// // Example
/// Feedback { [weak self] (state: State) -> AnyPublisher<Event, Never> in
/// guard let self = self else { return Empty().eraseToAnyPublisher() }
/// guard case .fetching = state else { return Empty().eraseToAnyPublisher() }
/// return self.useCase.performNetworkCall()
///    .map { $0.map(ViewModel.init) }
///    .map(Event.onSuccess)
///    .catch { Just(Event.onFailed($0)) }
///    .eraseToAnyPublisher()
/// }
/// ```
struct Feedback<State, Event> {
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

extension Feedback {
    init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
        self.run = { state -> AnyPublisher<Event, Never> in
            state
                .map { effects($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        }
    }
}

extension Publishers {
    
    /// Returns a publisher uses for the reducer state event model. You typically set this publisher up from the init function on your view model, the output should be binded to a `@Published var state: State` property
    /// See an overview of how this works here https://www.vadimbulavin.com/modern-mvvm-ios-app-architecture-with-combine-and-swiftui/
    /// ```
    /// // Example
    /// Publishers.system(
    ///   initial: state,
    ///   reduce: Self.reduce,
    ///   scheduler: RunLoop.main,
    ///   feedbacks: [
    ///     self.whenFetching(),
    ///     Self.userInput(input: input.eraseToAnyPublisher())
    ///   ]
    /// )
    /// .assign(to: \.state, on: self)
    /// .store(in: &cancellables)
    /// ```
    /// - Parameters:
    ///   - initial: The initial state to use
    ///   - reduce: The function that interprets a state event pair and indicates the next state
    ///   - scheduler: The scheduler to run on
    ///   - feedbacks: The feedbacks to use (see `Feedback` type for documentation)
    /// - Returns: A new publisher that you should bind to a `@Published var state: State` property
    static func system<State, Event, Scheduler: Combine.Scheduler>(
        initial: State,
        reduce: @escaping (State, Event) -> State,
        scheduler: Scheduler,
        feedbacks: [Feedback<State, Event>]) -> AnyPublisher<State, Never> {
    
            let state = CurrentValueSubject<State, Never>(initial)
            let events = feedbacks.map { feedback in feedback.run(state.eraseToAnyPublisher()) }
    
            return Deferred {
                Publishers.MergeMany(events)
                    .receive(on: scheduler)
                    .scan(initial, reduce)
                    .handleEvents(receiveOutput: state.send)
                    .receive(on: scheduler)
                    .prepend(initial)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        }
}

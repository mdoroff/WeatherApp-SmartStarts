import Foundation
import Combine

/// A redux style state machine view model type
protocol ReducerViewModel: ViewModel {
    associatedtype StateType
    associatedtype EventType
    
    /// Must be wrapped as `@Published` in the implementation file
    var state: StateType { get }
    
    /// Call this from your view or elsewhere when the ViewModel needs to handle an event (i.e. user input, view appearing, shake event, etc)
    /// - Parameter event: The event to handle
    func send(_ event: EventType)
    
    /// Implement this function as the state machine for your view. On a new event, the current state will be passed in with the new event, you must decide what new state to transition too.
    /// - Parameters:
    ///   - state: The previous state
    ///   - event: A new event
    /// - Returns: A new state given the previous state and a new event
    static func reduce(_ state: StateType, _ event: EventType) -> StateType
}

extension ReducerViewModel {
    /// Helper for consuming a `PassthroughSubject` used as an input to pass events externally (i.e. via view from user interaction). this converts a user input signal into a Feedback
    static func userInput(input: AnyPublisher<EventType, Never>) -> Feedback<StateType, EventType> {
        Feedback(run: { _ in
            return input
        })
    }
}

import Combine
import SwiftUI

/// Auto wraps a value into a CurrentValueSubject
@propertyWrapper
struct SubjectBinding<Value> {
    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue: Value) {
        subject = CurrentValueSubject<Value, Never>(wrappedValue)
    }

    func anyPublisher() -> AnyPublisher<Value, Never> {
        return subject.eraseToAnyPublisher()
    }

    var wrappedValue: Value {
        get {
            return subject.value
        }
        set {
            subject.value = newValue
        }
    }

    var projectedValue: Binding<Value> {
        return Binding<Value>(get: { () -> Value in
            return self.subject.value
        }, set: { value in
            self.subject.value = value
        })
    }
}

import SwiftUI
import Combine

/// Helpful wrapper allowing you to treat a protocol as an ObservableObject or Publisher type. Normally SwiftUI doesn't allow this without having to do some protocol `where` clause conformance on the actual view type
@propertyWrapper
public struct Store<Model>: DynamicProperty {

    // MARK: Nested types

    @dynamicMemberLookup
    public struct Wrapper {

        fileprivate var store: Store

        public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Model, Value>) -> Binding<Value> {
            Binding(get: { self.store.wrappedValue[keyPath: keyPath] },
                    set: { self.store.wrappedValue[keyPath: keyPath] = $0 })
        }

    }

    // MARK: Stored properties

    public let wrappedValue: Model

    @ObservedObject
    private var observableObject: ErasedObservableObject

    // MARK: Computed Properties

    public var projectedValue: Wrapper {
        Wrapper(store: self)
    }

    // MARK: Initialization

    public init(wrappedValue: Model) {
        self.wrappedValue = wrappedValue
        if let objectWillChange = (wrappedValue as? AnyObservableObject)?.objectWillChange {
            self.observableObject = .init(objectWillChange: objectWillChange.eraseToAnyPublisher())
        } else {
            assertionFailure("Only use the `Store` property wrapper with instances conforming to `AnyObservableObject`.")
            self.observableObject = .empty()
        }
    }

    // MARK: Methods

    public mutating func update() {
        _observableObject.update()
    }
}

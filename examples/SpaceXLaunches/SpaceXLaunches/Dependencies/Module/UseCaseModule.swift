import Cleanse

// Use Cases are like services. Something that connects a view model to data. A view model that needs to fetch or write data would have a UseCase as a dependency

class UseCaseModule: Cleanse.Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.include(module: StandardLaunchUseCase.Module.self)
        binder.include(module: StandardLaunchesUseCase.Module.self)
    }
}

extension StandardLaunchUseCase {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FetchLaunchUseCase.self)
                .to(factory: StandardLaunchUseCase.init)
        }
    }
}

extension StandardLaunchesUseCase {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FetchLaunchesUseCase.self)
                .to(factory: StandardLaunchesUseCase.init)
        }
    }
}

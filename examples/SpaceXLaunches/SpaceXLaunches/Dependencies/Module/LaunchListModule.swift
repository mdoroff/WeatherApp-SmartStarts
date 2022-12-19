import Cleanse
import Foundation

class LaunchListModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.include(module: LaunchViewModelFactory.Module.self)
        binder.include(module: LaunchDetailContentViewModel.Module.self)
        binder.include(module: LaunchListItemViewModel.Module.self)
        binder.include(module: LaunchListViewModel.Module.self)
        binder.include(module: LaunchDetailViewModel.Module.self)
    }
}

// MARK: - LaunchListItemViewModel

typealias LaunchListItemVMFactory = Factory<LaunchListItemViewModel.AssistedFactory>
extension LaunchListItemViewModel {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bindFactory(AssistedFactory.Element.self)
                .with(AssistedFactory.self)
                .to(factory: LaunchListItemViewModel.init)
        }
    }
    
    class AssistedFactory: Cleanse.AssistedFactory {
        typealias Seed = Launch
        typealias Element = LaunchListItemViewModel
    }
}

// MARK: - LaunchDetailContentViewModel

typealias LaunchDetailContentVMFactory = Factory<LaunchDetailContentViewModel.AssistedFactory>
extension LaunchDetailContentViewModel {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bindFactory(AssistedFactory.Element.self)
                .with(AssistedFactory.self)
                .to(factory: LaunchDetailContentViewModel.init)
        }
    }
    
    class AssistedFactory: Cleanse.AssistedFactory {
        typealias Seed = LaunchDetail
        typealias Element = LaunchDetailContentViewModel
    }
}

// MARK: - LaunchListViewModel

extension LaunchListViewModel {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(LaunchListViewModel.self)
                .to(factory: LaunchListViewModel.init)
        }
    }
}

// MARK: - LaunchDetailViewModel

typealias LaunchDetailVMFactory = Factory<LaunchDetailViewModel.AssistedFactory>
extension LaunchDetailViewModel {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bindFactory(LaunchDetailViewModel.self)
                .with(AssistedFactory.self)
                .to(factory: LaunchDetailViewModel.init)
        }
    }
    
    class AssistedFactory: Cleanse.AssistedFactory {
        typealias Seed = String
        typealias Element = LaunchDetailViewModel
    }
}

// MARK: - LaunchViewModelFactory

typealias LaunchVMFactory = Factory<LaunchViewModelFactory.AssistedFactory>
extension LaunchViewModelFactory {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bindFactory(LaunchViewModelFactory.self)
                .with(AssistedFactory.self)
                .to(factory: LaunchViewModelFactory.init)
        }
    }
    
    class AssistedFactory: Cleanse.AssistedFactory {
        typealias Seed = Launch
        typealias Element = LaunchViewModelFactory
    }
}

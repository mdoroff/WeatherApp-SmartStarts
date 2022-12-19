import Foundation
import Cleanse

struct AppScope: Scope { }

class FoundationModule: Module {
    static func configure(binder: Binder<AppScope>) {
        binder.include(module: URLSession.Module.self)
        binder.include(module: DispatchQueue.Module.self)
        binder.include(module: UserDefaults.Module.self)
    }
}

extension URLSession {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<AppScope>) {
            binder
                .bind(URLSession.self)
                .sharedInScope()
                .to {
                    let config = URLSessionConfiguration.default
                    return URLSession(configuration: config)
                }
        }
    }
}

extension DispatchQueue {
    // Tags
    class GlobalTag: Cleanse.Tag {
        typealias Element = DispatchQueue
    }
    class MainTag: Cleanse.Tag {
        typealias Element = DispatchQueue
    }
    
    class Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(DispatchQueue.self)
                .tagged(with: GlobalTag.self)
                .to { DispatchQueue.global() }
            
            binder.bind(DispatchQueue.self)
                .tagged(with: MainTag.self)
                .to { DispatchQueue.main }
        }
    }
}

extension UserDefaults {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<AppScope>) {
            binder.bind(UserDefaults.self)
                .sharedInScope()
                .to(value: UserDefaults.standard)
        }
    }
}

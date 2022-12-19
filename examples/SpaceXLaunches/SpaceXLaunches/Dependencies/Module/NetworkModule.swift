import Foundation
import Cleanse
import iOS_ApolloNetwork
import Apollo

class NetworkModule: Cleanse.Module {
    static func configure(binder: Binder<AppScope>) {
        binder.include(module: AppNetworkWrapper.Module.self)
    }
}

extension AppNetworkWrapper {
    class Module: Cleanse.Module {
        static func configure(binder: Binder<AppScope>) {
            binder
                .bind(ApolloClientProtocol.self)
                .sharedInScope()
                .to {
                    ApolloClient(url: EndPoints.baseSpacexAPI)
                }
            
            binder
                .bind(AppNetworkWrapper.self)
                .sharedInScope()
                .to(factory: AppNetworkWrapper.init)
        }
    }
}

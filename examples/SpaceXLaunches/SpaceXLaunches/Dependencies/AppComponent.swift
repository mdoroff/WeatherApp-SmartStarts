import Foundation
import Cleanse

class AppComponent: RootComponent {
    typealias Root = PropertyInjector<SpaceExLaunchApp>
    
    static func configure(binder: Binder<AppScope>) {
        binder.include(module: LaunchListModule.self)
        binder.include(module: UseCaseModule.self)
        binder.include(module: NetworkModule.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<SpaceExLaunchApp>>) -> BindingReceipt<PropertyInjector<SpaceExLaunchApp>> {
        bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<SpaceExLaunchApp>> in
            return bind.to(injector: SpaceExLaunchApp.injectProperties)
        }
    }
}

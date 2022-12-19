import SwiftUI

@main
class SpaceExLaunchApp: App {
    
    private(set) var viewModel: LaunchListViewModel!
    
    required init() {
        do {
            let propertyInjector = try ComponentFactory.of(AppComponent.self).build(())
            propertyInjector.injectProperties(into: self)
            precondition(viewModel != nil)
        } catch {
            print(error)
            preconditionFailure("Unable to initialize object graph: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

extension SpaceExLaunchApp {
    func injectProperties(_ viewModel: LaunchListViewModel) {
        self.viewModel = viewModel
    }
}

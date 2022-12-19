import SwiftUI
import iOS_URLNetwork

@main
class BeerApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    private let appCoordinator: AppCoordinator = StandardAppCoordinator()
    private let viewModel: BeerListViewModel = BeerListViewModel()
    
    required init() {
        UINavigationBar.appearance().tintColor = .orange
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: appCoordinator, viewModel: viewModel)
                .onOpenURL { url in
                    do {
                        let deepLink: BeerDeepLink = try url.asDeepLink()
                        switch deepLink {
                        case .allBeer:
                            // Set var to make us go to all beer category
                            self.appCoordinator.tab = .beerList
                        default:
                            return // dont care
                        }
                    } catch {
                        print("unhandled: \(url)")
                    }
                }
        }.onChange(of: scenePhase) { newValue in
            switch newValue {
            case .active:
                return
            case .background:
                return
            case .inactive:
                return
            @unknown default:
                return
            }
        }
    }
}

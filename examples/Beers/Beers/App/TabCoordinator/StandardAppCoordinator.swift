import SwiftUI
import Combine

class StandardAppCoordinator: ObservableObject, AppCoordinator {
    @Published var tab: Tab = .beerList
    
    @Published var beerId: Int?
}

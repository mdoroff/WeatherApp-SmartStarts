import SwiftUI

protocol AppCoordinator: ViewModel {
    var tab: Tab { get set }
}

enum Tab {
    case beerList
    case favorites
}

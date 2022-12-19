import SwiftUI
import iOS_Utilities

struct AppCoordinatorView: View {
    @Store var coordinator: AppCoordinator
    let viewModel: BeerListViewModel
    
    var body: some View {
        TabView(selection: $coordinator.tab) {
            BeerList(viewModel: viewModel)
                .tabItem { Label("Beers", systemImage: "cloud.fill") }
                .tag(Tab.beerList)
            Text("Favorites (TBD)")
                .tabItem { Label("Favorites", systemImage: "star.fill") }
                .tag(Tab.favorites)

        }
    }
}

import SwiftUI

struct BeerList: View {
    @ObservedObject var viewModel: BeerListViewModel
    
    var body: some View {
        NavigationStack {
            VStack { // NOTE: NavigationStack root view doesn't seem to ever update so we must box it
                content
            }
            .navigationTitle(Text("Beers"))

        }
        .onAppear { self.viewModel.send(.onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return EmptyView()
                .eraseToAnyView()
        case .results(let beers):
            return List(beers) { item in
                NavigationLink(value: item) {
                    BeerListItemView(viewModel: item.buildBeerItemViewModel())
                }
            }
            .navigationDestination(for: BeerViewModelFactory.self) { factory in
                BeerDetailView(viewModel: factory.buildBeerDetailViewModel())
            }
            .eraseToAnyView()
        case .error(let error):
            return VStack {
                Text("Error Occurred Fetching: \(error.localizedDescription)").padding()
                Text("Please try again").padding()
                Button("Retry") { viewModel.send(.fetch) }
            }.eraseToAnyView()
        case .fetching:
            return Spinner(isAnimating: true, style: .large)
                .eraseToAnyView()
        }
    }
}

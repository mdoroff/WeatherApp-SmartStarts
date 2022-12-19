import SwiftUI

// NOTE: There is a bug with SwiftUI where changing tabs and coming back causes the beer detail view to end up in a broken state. see this for info.
// https://developer.apple.com/forums/thread/124749
// NOTE: this is fixed with `NavigationStack` on iOS 16 and up
struct BeerDetailView: View {
    @ObservedObject var viewModel: BeerDetailViewModel
    
    var body: some View {
        VStack {
            contentView
                .navigationTitle(viewModel.beer.name)
        }
        .onAppear { self.viewModel.send(.onAppear) }
    }
    
    private var contentView: some View {
        switch viewModel.state {
        case .active(beer: let beer, favorited: let favorited):
            return VStack {
                HStack {
                    AsyncImage(url: beer.imageUrl, content: { $0.resizable() }, placeholder: { Color.gray })
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                        .padding()
                    VStack {
                        Text("ABV: \(viewModel.beer.abv)%")
                            .padding()
                        Text("Volume: \(viewModel.beer.volume.description)")
                            .padding()
                    }
                }
                Text(beer.description)
                    .padding()
                Spacer()
            }.toolbar(content: {
                Button {
                    viewModel.send(.toggleFavorite)
                } label: {
                    if favorited {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(.orange)
                    }
                }
                
            })
            .eraseToAnyView()
        case .fetchFavorite:
            // If needed, you'd put a loading spinner or some indicaton here, but this will never show as we are only hitting UserDefaults to see if the beer is favorited or not.
            return Text("fetching favorite TBI")
                .eraseToAnyView()
        case .idle:
            // Inactive state, should not be visible
            return Text("Idle TBI")
                .eraseToAnyView()
        case .toggling:
            // If needed, you'd put a loading spinner here or something
            return Text("Toggling TBI")
                .eraseToAnyView()
        }
    }
}

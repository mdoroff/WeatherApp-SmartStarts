import SwiftUI

struct LaunchListView: View {
    @ObservedObject var viewModel: LaunchListViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(Text("Launches"))
        }
        .onAppear { self.viewModel.send(.onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return EmptyView()
                .eraseToAnyView()
        case .results(let launches):
            return List {
                ForEach(launches) { (item: LaunchViewModelFactory) in
                    NavigationLink(destination: LaunchDetailView(viewModel: item.buildLaunchDetailViewModel())) {
                        LaunchListItemView(viewModel: item.buildLaunchListItemViewModel())
                    }
                }
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

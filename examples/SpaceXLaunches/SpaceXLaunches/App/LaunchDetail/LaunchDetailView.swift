import SwiftUI

struct LaunchDetailView: View {
    @ObservedObject var viewModel: LaunchDetailViewModel
    
    var body: some View {
        VStack {
            content
        }
        .onAppear { self.viewModel.send(.onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return EmptyView()
                .eraseToAnyView()
        case .result(let launchDetailContentVM):
            return LaunchDetailContentView(viewModel: launchDetailContentVM)
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

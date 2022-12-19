import SwiftUI

struct ContentView: View {
    let viewModel: LaunchListViewModel
    
    var body: some View {
        LaunchListView(viewModel: viewModel)
    }
}

import SwiftUI

struct BeerListItemView: View {
    @ObservedObject var viewModel: BeerListItemViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    AsyncImage(url: viewModel.beer.imageUrl, content: { $0.resizable() }, placeholder: { Color.gray })
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35, alignment: .center)
                    Text(viewModel.name).font(.headline)
                    Spacer()
                    Text(viewModel.formattedAbv).font(.caption).foregroundColor(Color(UIColor.brown.cgColor))
                }
                Text(viewModel.tagline).font(.body)
            }
            Image(systemName: viewModel.starName)
                .foregroundColor(.orange)
                .frame(width: 35, height: 35, alignment: .center)
        }
    }
}

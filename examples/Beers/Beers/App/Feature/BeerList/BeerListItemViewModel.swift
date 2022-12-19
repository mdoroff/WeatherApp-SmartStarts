import Foundation
import Combine

class BeerListItemViewModel: ViewModel, ObservableObject {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    let beer: Beer
    let favoriteUseCase: FavoriteBeerUseCaseType

    private var cancellables: Set<AnyCancellable> = Set()
    @Published var starName: String = "star"

    init(beer: Beer, favoriteUseCase: FavoriteBeerUseCaseType = UserDefaultsFavoritedBeerUseCase()) {
        self.beer = beer
        self.favoriteUseCase = favoriteUseCase
        
        favoriteUseCase.isBeerFavorite(beer: self.beer.id)
            .map {
                if $0 {
                    return "star.fill"
                } else {
                    return "star"
                }
            }
            .assign(to: \.starName, on: self)
            .store(in: &cancellables)
    }
    
    var name: String {
        return beer.name
    }
    
    var tagline: String {
        return beer.tagline
    }
    
    var formattedAbv: String {
        let numABV = NSNumber(value: beer.abv)
        return "abv: \(Self.formatter.string(from: numABV) ?? "--") %"
    }
}

extension BeerListItemViewModel: Identifiable {
    var id: Int {
        return beer.id
    }
}

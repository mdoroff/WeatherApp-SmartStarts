class BeerViewModelFactory {
    private let seed: Beer
    
    init(beer: Beer) {
        self.seed = beer
    }
    
    func buildBeerItemViewModel() -> BeerListItemViewModel {
        BeerListItemViewModel(beer: seed)
    }
    
    func buildBeerDetailViewModel() -> BeerDetailViewModel {
        BeerDetailViewModel(beer: seed)
    }
}

extension BeerViewModelFactory: Identifiable {
    var id: Int {
        return seed.id
    }
}

extension BeerViewModelFactory: Hashable {
    static func == (lhs: BeerViewModelFactory, rhs: BeerViewModelFactory) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

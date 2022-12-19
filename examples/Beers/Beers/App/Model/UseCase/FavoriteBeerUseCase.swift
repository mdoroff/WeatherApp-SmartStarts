import Foundation
import Combine

protocol FavoriteBeerUseCaseType {
    func addFavorite(beer: Int) -> AnyPublisher<Void, Error>
    func removeFavorite(beer: Int) -> AnyPublisher<Void, Error>
    func isBeerFavorite(beer: Int) -> AnyPublisher<Bool, Never>
}

class UserDefaultsFavoritedBeerUseCase: FavoriteBeerUseCaseType {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func addFavorite(beer: Int) -> AnyPublisher<Void, Error> {
        var beers = Set(userDefaults.favoriteBeerList)
        beers.insert(beer)
        userDefaults.favoriteBeerList = Array(beers)
        
        // Note, these return publisher as you might want to have this talk to a back end or database some day, i.e. something that can fail or throw errors
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    func removeFavorite(beer: Int) -> AnyPublisher<Void, Error> {
        var beers = Set(userDefaults.favoriteBeerList)
        beers.remove(beer)
        userDefaults.favoriteBeerList = Array(beers)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func isBeerFavorite(beer: Int) -> AnyPublisher<Bool, Never> {
        userDefaults
            .publisher(for: \.favoriteBeerList)
            .map { value in
                return value.contains(beer)
            }
            .eraseToAnyPublisher()
    }
}

extension UserDefaults {
    @objc dynamic var favoriteBeerList: [Int] {
        get {
            guard let result = array(forKey: "favoriteBeers"),
                  let typed = result as? [Int] else {
                return []
            }
            return typed
        }
         set { self.setValue(newValue, forKey: "favoriteBeers") }
    }
}

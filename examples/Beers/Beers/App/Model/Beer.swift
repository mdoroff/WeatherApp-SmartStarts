import Foundation

enum Unit: String, Codable {
    case litres
    case grams
    case kilograms
}

/// Model
struct Beer: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
//        case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
        case abv
        case ibu
        case volume
        case boilVolume = "boil_volume"
    }
    
    struct Volume: Codable {
        let value: Int
        let unit: Unit
    }
    
    let id: Int
    let name: String
    let tagline: String
//    let firstBrewed: Date
    let description: String
    let imageUrl: URL
    let abv: Float
    let ibu: Float?
    let volume: Volume
    let boilVolume: Volume
}

extension Beer.Volume: CustomStringConvertible {
    var description: String {
        return "\(value) " + "\(unit)"
    }
}

extension Unit: CustomStringConvertible {
    var description: String {
        switch self {
        case .grams:
            return "g"
        case .kilograms:
            return "kg"
        case .litres:
            return "l"
        }
    }
}

extension Beer: Hashable, Equatable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

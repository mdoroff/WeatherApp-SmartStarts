//
//  PlanetModels.swift
//  PlanetModels
//
//  Created by Mark Wells on 11/29/22.
//

import Foundation

/// Country
struct Country: Codable, Identifiable {

    let code: String
    let name: String
    let wikiDataId: String

    var id: String {
        return code
    }
}

/// LinkRef
struct LinkRef: Codable {

    let rel: String
    let href: String
}

/// PlanetList Response
struct CountriesListResponse: Codable, Identifiable {

    private enum CodingKeys: CodingKey {
        case data, links
    }

    let id: UUID = UUID()
    let data: [Country]
    let links: [LinkRef]?
}

extension Country: Hashable, Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.code == rhs.code
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

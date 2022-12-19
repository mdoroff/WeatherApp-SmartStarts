//
//  CountriesAPIRequests.swift
//  Countries
//
//  Created by Mark Wells on 11/29/22.
//

import Foundation
import iOS_URLNetwork

struct FetchCountries: GETRequestOperation {
    typealias Model = CountriesListResponse
    let path: String = "v1/geo/countries"
    let offset: Int
    let limit: Int
    let languageCode: String?

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        items.append(.init(name: "offset", value: String(offset)))
        items.append(.init(name: "limit", value: String(limit)))
        if let language = languageCode {
            items.append(.init(name: "languageCode", value: language))
        }
        return items
    }
    
    var headers: [String: String]? {
        return ["X-RapidAPI-Key": "8e76adef62mshc85a6bc7d031718p1d3f0djsn8bf259f6e201", "X-RapidAPI-Host": EndPoints.global.baseApiUrl.host!]
    }

    init(offset: Int = 0, limit: Int = 10, languageCode: String? = Locale.current.language.languageCode?.identifier) {
        self.offset = offset
        self.limit = limit
        self.languageCode = languageCode
    }

    init(fullURL: URL) {
        var offsetS: String?
        var limitS: String?
        var lang: String?
        let components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        components?.queryItems?.forEach({ queryItem in
            switch queryItem.name {
            case "offset":
                offsetS = queryItem.value
            case "limit":
                limitS = queryItem.value
            case "languageCode":
                lang = queryItem.value
            default:
                break
            }
        })
        guard let off = offsetS, let offI = Int(off),
              let lim = limitS, let limI = Int(lim) else {
            self.init()
            return
        }
        self.init(offset: offI, limit: limI, languageCode: lang)
    }
}
